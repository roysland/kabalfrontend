serviceName: container-service-1
containers:
  node:
    command: []
    environment:
      test: test
    image: ${LATEST_NODE_IMAGE}
    ports:
      "3000": HTTP
publicEndpoint:
  containerName: nodejs
  containerPort: 3000
  healthCheck:
    healthyThreshold: 2
    intervalSeconds: 20
    path: /
    successCodes: 200-499
    timeoutSeconds: 4
    unhealthyThreshold: 2