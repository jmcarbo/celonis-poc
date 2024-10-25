cluster-up:
	k3d registry create registry.127.0.0.1.nip.io --port 12345
	k3d cluster create --k3s-arg "--disable=traefik@server:0" --api-port 6550 -p "8081:80@loadbalancer" -p "8443:443@loadbalancer" --registry-use k3d-registry.127.0.0.1.nip.io:12345 -a 6
	flux install

cluster-down:
	k3d cluster delete
	k3d registry delete k3d-registry.127.0.0.1.nip.io

infra-up: 
	helmfile apply

