targetScope = 'resourceGroup'

param location string = 'westus'
param resourceBaseName string = 'adora-ts-bicep-tutorial'
param storageAccountName string = 'adorastoretsiac'

module webApp 'ts:9dcdcac6-58e7-4cda-8db2-e9a418f6798e/adora-test-rg/WebApplication:1.0' = {
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
