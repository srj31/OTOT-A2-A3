RED="31"
GREEN="32"
YELLOW="33"
BOLDGREEN="\033[1;${GREEN}m"
ITALICRED="\033[3;${RED}m"
U_YELLOW="\033[4;${YELLOW}m"
ENDCOLOR="\033[0m"


########################################################

echo "\n${ITALICRED}Appy the HPA yaml file${ENDCOLOR}"
kubectl apply -f ./manifests/backend-horizontalpodautoscaler.yaml
