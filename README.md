 The following payload will trigger cluster creation:

{
	"clusterInfo": {
		"sshAccess": 1,
		"fullyManaged": 0,
		"kops": 0,
		"autoscaler": 1,
		"cni": "default"
	},
	"applications": [{
			"name": "DB",
			"count": "1"
		},
		{
			"name": "MLapps",
			"count": "1"
		},
		{
			"name": "VideoStreaming",
			"count": "1"
		},
		{
			"name": "Educational",
			"count": "1"
		},
		{
			"name": "e-commerce",
			"count": "1"
		}

	]
}

Truth table:
SSH	Fully Managed	Type
0	0	EKS
1	0	EKS
0	1	EKS -Fargate
1	1	KOPS
