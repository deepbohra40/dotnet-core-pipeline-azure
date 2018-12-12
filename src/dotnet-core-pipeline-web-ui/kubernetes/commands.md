These are the commands to do it all manually.

Log into the azure cli:
 
 az login

Manually create a service principal:

    az ad sp create-for-rbac --skip-assignment

Grab the appId and password out of the JSON that is displayed:

Get the credentials and merge them into the current context:
    
    az aks get-credentials --resource-group [resource group] --name [cluster name] --overwrite-existing

Clone the repo and navigate to it.

Build the image:
    
    docker build -t dotnet-core-pipeline .

Look at the images and copy the Image Id of the one tagged 'latest'
    
    docker images

Tag the image using that Image Id and the next version:

    docker tag 7caf46f93c9a dcurrotto/dotnet-core-pipeline:9

Push that image to Docker Hub:

    docker push dcurrotto/dotnet-core-pipeline:9

Delete the configMap (assuming it's already there):

    kubectl delete configmap config-map-appsettings

Create the configMap:

    kubectl create configmap config-map-appsettings --from-file=./configuration/ConfigMaps/appsettings.configmaps.json

Apply the deployment:
    
    kubectl apply -f kubernetes/dotnet-core-pipeline.yml

Take a look at the services and wait until you see the EXTERNAL-IP come up on the LoadBalancer service
    
    kubectl get service --watch

Grab the external IP and pop it in the browser.  The app should come up and you should see your Environment.

Grab a pod:
    
    kubectl get pod

and:

Using that pod ssh into a node using Kubectl to look around:
    
    kubectl exec -it dotnet-core-pipeline-549cbb9855-lsldk -- /bin/bash

Now make changes to your values in your appsettings.configmaps.json.

Run through again:  
    
    Delete the configMap.
    
    Create the configMap.
    
    Increment the CONFIG_VERSION value by one in the dotnet-core-pipeline.yml file.  This will cause the 
    deployment to run and reload, updating the configMap.
    
    Apply the deployment.
    
    You should see the updated values in the web ui.
    