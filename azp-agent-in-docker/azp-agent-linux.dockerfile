FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl unzip wget apt-transport-https software-properties-common

# Install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_amd64.zip && \
    unzip terraform_1.9.0_linux_amd64.zip && \
    mv terraform /usr/local/bin && \
    rm terraform_1.9.0_linux_amd64.zip

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Download Micrsoft repository key
RUN wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

# System tasks
RUN mkdir /home/GitHubOnLocal
RUN chmod -R 777 /home/GitHubOnLocal

WORKDIR /azp/

COPY ./start.sh ./
RUN chmod +x ./start.sh

# Create agent user and set up home directory
RUN useradd -m -d /home/agent agent
RUN chown -R agent:agent /azp /home/agent

USER agent
# Another option is to run the agent as root.
# ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT [ "./start.sh" ]