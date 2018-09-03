#!/bin/zsh

RELEASE_NAME=$1

helm delete --purge ${RELEASE_NAME}
kubectl delete role ${RELEASE_NAME}-anchore-policy-validator-init-ca
kubectl delete rolebinding extension-${RELEASE_NAME}-anchore-policy-validator-init-ca-admin
kubectl delete configmap ${RELEASE_NAME}-init-ca ${RELEASE_NAME}-default-policy ${RELEASE_NAME}-validatingwebhook
kubectl delete jobs ${RELEASE_NAME}-init-ca ${RELEASE_NAME}-default-policy ${RELEASE_NAME}-create-validatingwebhook
kubectl delete clusterrolebinding extension-${RELEASE_NAME}-anchore-policy-validator-init-ca-cluster
kubectl delete clusterroles ${RELEASE_NAME}-anchore-policy-validator-init-ca-cluster
kubectl delete validatingwebhookconfiguration ${RELEASE_NAME}-anchore-policy-validator.admission.anchore.io
kubectl delete serviceaccount ${RELEASE_NAME}-anchore-policy-validator-init-ca
kubectl delete apiservice v1beta1.admission.example.com
kubectl delete clusterrolebinding ${RELEASE_NAME}-anchore-policy-validator-validator-binding
kubectl delete serviceaccount ${RELEASE_NAME}-anchore-policy-validator-validator
