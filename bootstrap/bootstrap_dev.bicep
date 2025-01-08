targetScope = 'subscription'

var varRgName = 'rg-rbcz-tfstateaicoe-dev-weu-001'
var varTags = {
  Application: 'Terraform State File Storage'
  ContactPerson: 'filip.vagner@orbit.com'
  CreatedBy: 'filip.vagner@orbit.com'
  Owner: 'filip.vagner@orbit.com'
  Importance: 'high'
}
var varStAccounts = [
  {
    name: 'statninfradev001'
    skuName: 'Standard_GRS'
    tags: varTags
    containers: [
      {
        name: 'aicoeragdev001'
        publicAccess: 'None'
      }
      {
        name: 'aicoeportaldev001'
        publicAccess: 'None'
      }
      {
        name: 'aicoeapimdev001'
        publicAccess: 'None'
      }
    ]
  }
  {
    name: 'statnappsdev001'
    skuName: 'Standard_GRS'
    tags: varTags
    containers: [
    ]
  }
]

module modTfStateRg 'br/public:avm/res/resources/resource-group:0.4.0' = {
  name: 'modTfStateRg'
  params: {
    name: varRgName
    location: deployment().location
    tags: varTags
  }
}

module modTfStateSt 'br/public:avm/res/storage/storage-account:0.13.2' = [for st in varStAccounts: {
  scope: resourceGroup(varRgName)
  name: 'mod${st.name}'
  dependsOn: [
    modTfStateRg
  ]
  params: {
    name: st.name
    location: deployment().location
    skuName: st.skuName
    tags: varTags
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
    }
    allowBlobPublicAccess: false
    blobServices: {
      automaticSnapshotPolicyEnabled: true
      deleteRetentionPolicyDays: 100
      deleteRetentionPolicyEnabled: true
      containerDeleteRetentionPolicyDays: 60
      containerDeleteRetentionPolicyEnabled: true
      isVersioningEnabled: true
      lastAccessTimeTrackingPolicyEnabled: false
      containers: [for container in st.containers: {
          name: '${container.name}'
          publicAccess: 'None'
        }
      ]
    }
  }
}]
