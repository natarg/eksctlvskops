
Name of the cluster: kubesight-aws-cni:
=======================================
The policy is AWSManaged and the below one creates AWS role:


eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster kubesight-aws-cni \
    --role-name kubesight-aws-cni-amazoneks_ebs_csi_driverrole \
    --role-only \
    --region us-west-2 \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --approve

eksctl create addon --name aws-ebs-csi-driver --cluster kubesight-aws-cni --service-account-role-arn arn:aws:iam::798234419462:role/kubesight-aws-cni-amazoneks_ebs_csi_driverrole --region us-west-2 --force

