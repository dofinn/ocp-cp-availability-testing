#!/bin/bash

for i in {1..3000}; do
    date -u +"%Y:%m:%d %H:%M:%S"
    oc create ns openshift-resource-test-$i
    date -u +"%Y:%m:%d %H:%M:%S"
    NAMESPACE_COUNT=$(oc get namespaces -o name | wc -l)
    printf "namespace count: $NAMESPACE_COUNT\n"
    date -u +"%Y:%m:%d %H:%M:%S"
    printf "etcd objects by instance\n"
    oc -n openshift-monitoring exec prometheus-k8s-0 -- curl http://127.0.0.1:9090/api/v1/query\? --data-urlencode 'query=instance:etcd_object_counts:sum' 2>/dev/null | jq '.data.result[] | .metric.instance, .value[1]'
done
