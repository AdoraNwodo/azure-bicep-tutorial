targetScope = 'resourceGroup'

param location string = 'westus'

@minLength(6)
@maxLength(20)
@description('Storage account name for our bicep storage account')
param storageAccountName string = 'mystore'

resource hostingPlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: 'bicep-tutorial-plan'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

// Create storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
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
