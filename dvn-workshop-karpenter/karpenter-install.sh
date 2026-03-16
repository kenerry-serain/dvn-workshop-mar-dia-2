set -e

KARPENTER_VERSION="1.9.0"
CLUSTER_NAME="workshop-march-eks-cluster"
AWS_PARTITION="aws"
AWS_ACCOUNT_ID="654654554686"
KARPENTER_NAMESPACE="kube-system"

function helmTemplate(){
    helm template karpenter oci://public.ecr.aws/karpenter/karpenter --version "${KARPENTER_VERSION}" --namespace "${KARPENTER_NAMESPACE}" \
        --set "settings.clusterName=${CLUSTER_NAME}" \
        --set "settings.interruptionQueue=${CLUSTER_NAME}" \
        --set "serviceAccount.annotations.eks\.amazonaws\.com/role-arn=arn:${AWS_PARTITION}:iam::${AWS_ACCOUNT_ID}:role/KarpenterControllerRole" \
        --set controller.resources.requests.cpu=1 \
        --set controller.resources.requests.memory=1Gi \
        --set controller.resources.limits.cpu=1 \
        --set controller.resources.limits.memory=1Gi > karpenter.yml
}

function installCRDs(){
    kubectl create -f \
        "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.sh_nodepools.yaml"

    kubectl create -f \
        "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.k8s.aws_ec2nodeclasses.yaml"

    kubectl create -f \
        "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.sh_nodeclaims.yaml"
}

function installKarpenter(){
    kubectl apply -f karpenter.yml
}

# helmTemplate
# installCRDs
installKarpenter