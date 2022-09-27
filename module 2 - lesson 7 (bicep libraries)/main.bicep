targetScope = 'resourceGroup'

param location string = 'westus'
param resourceBaseName string = 'adora-bicep-tutorial'
param storageAccountName string = 'adorastoreiac'

module webApp 'modules/webApp.bicep' = {
  name: 'app-service-deployment-bicep'
  params: {
    appServiceAppName: '${resourceBaseName}-app'
    appServicePlanName: '${resourceBaseName}-plan'
    appServicePlanSkuName: 'F1'
    appServicePlanTier: 'Free'
    location: location
    minTlsVersion: '1.2'
    identityType: 'SystemAssigned'
    storageAccountName: storageAccountName
    storageAccountSkuName: 'Standard_LRS'
    storageAccountKind: 'StorageV2'
  }
}

module networking 'modules/networking.bicep' = {
  name: 'networking-deployment-bicep'
  params: {
    location: location
    trafficManagerName: '${resourceBaseName}-tm'
    trafficManagerMonitorInterval: 30
    trafficManagerMonitorTimeout: 5
    trafficManagerMonitorToleratedNumberOfFailures: 3
    trafficManagerTargetIp: '9.9.9.9'
    trafficManagerTtl: 30
  }
}
