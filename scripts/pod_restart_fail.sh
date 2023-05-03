#!/bin/bash
#Namespace to be used
NAMESPACE="default"
count=0

#Retrieve all the pods in a given namespace
PODS=$(kubectl get pods -n $NAMESPACE -o=jsonpath='{.items[*].metadata.name}')
echo "The pods in the namespace $NAMESPACE are : $PODS"

#Retrive the pods whose restart count is greater than zero or whose status is failed
for pod in $PODS
    do 
        POD_STATUS=$(kubectl get pod $pod -n $NAMESPACE -o jsonpath='{.status.phase}') 
        POD_RESTART_COUNT=$(expr $(kubectl get pod $pod -n $NAMESPACE -o jsonpath='{.status.containerStatuses[*].restartCount}') + 0)
        if  [ "$POD_STATUS" = "Failed" ] || [ $POD_RESTART_COUNT -gt 0 ]; then
            count=$((count+1))
            printf "Failed Pod name: $pod \n Pod status: $POD_STATUS \n Pod restart count: $POD_RESTART_COUNT\n"
        fi        
    done
if [ $count -eq 0 ]; then
  printf "No Pods in failed/restart status"
fi    







