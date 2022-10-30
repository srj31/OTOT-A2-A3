
RED="31"
GREEN="32"
YELLOW="33"
BOLDGREEN="\033[1;${GREEN}m"
ITALICRED="\033[3;${RED}m"
U_YELLOW="\033[4;${YELLOW}m"
ENDCOLOR="\033[0m"


########################################################

kubectl apply -f ./manifests/backend-zoneaware.yaml

echo "\n${GR1}Showing workers and their zones. ${NC}"
kubectl get nodes -L topology.kubernetes.io/zone

echo "\n${GR1}Showing their distribution. ${NC}"
kubectl get po -lapp=backend-zone-aware -owide --sort-by='.spec.nodeName'