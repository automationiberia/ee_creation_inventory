#!/usr/bin/env bash

## OCP Cluster registry - expose and login
# https://docs.openshift.com/container-platform/4.8/registry/securing-exposing-registry.html
# oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge
# HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
# podman login -u kubeadmin -p $(oc whoami -t) --tls-verify=false $HOST
# podman login -u adminocp -p sha256~oSosaiusGPLLysKmVZXAhKvDWplstJL8L6cllPtaxzU --tls-verify=false default-route-openshift-image-registry.apps.cluster-7987.sandbox19.opentlc.com
# podman tag automationhub.bcnconsulting.com/ee-iac2 default-route-openshift-image-registry.apps.cluster-7987.sandbox19.opentlc.com/ansible-automation-platform/ee-casc
# podman push default-route-openshift-image-registry.apps.cluster-7987.sandbox19.opentlc.com/ansible-automation-platform/ee-casc --tls-verify=false

if [ $# -ne 1 ]; then
  echo "usage: ${0} <tag>"
  exit 1
fi

AAH=automationhub.bcnconsulting.com

ansible-builder build --tag ${AAH}/${1}
podman login ${AAH} --username admin --password redhat00 --tls-verify=false
podman push ${AAH}/${1} --tls-verify=false




