targetScope = 'resourceGroup'
param location string = 'westus'

resource hostingPlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: 'bicep-tutorial-plan'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'biceptutorialstore'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: 'bicep-tutorial-adora-app'
  location: location
  properties: {
    serverFarmId: hostingPlan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.0'
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}

// bicep-tutorial-adora-app.azurewebsites.net
