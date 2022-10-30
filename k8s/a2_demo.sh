RED="31"
GREEN="32"
YELLOW="33"
BOLDGREEN="\033[1;${GREEN}m"
ITALICRED="\033[3;${RED}m"
U_YELLOW="\033[4;${YELLOW}m"
ENDCOLOR="\033[0m"

cname="otot-a2-demo"
ctx="kind-otot-a2"
#########################################################################

echo "\nRunning A2 demo script\n"

echo "${ITALICRED}Creating clusters${ENDCOLOR}"
kind create cluster --name $cname --config ./kind/cluster-config.yaml
echo ""

kubectl cluster-info

echo "\n${U_YELLOW}Verifying if the cluster is up${ENDCOLOR}"
kubectl get nodes --watch
sleep 1m


echo "\n${BOLDGREEN}Will start with deployment.yaml.${ENDCOLOR}"
sleep 10s

echo "\n${ITALICRED}Creating deployment as in the yaml file:${ENDCOLOR}"
kubectl apply -f ./manifests/backend-deployment.yaml

echo "\n${U_YELLOW}Waiting for deployment to be ready...${ENDCOLOR}"
kubectl get deployment.apps/backend --watch
sleep 40s
echo "\n${U_YELLOW}Checking the pods${ENDCOLOR}"
kubectl get po -l app=backend -w
sleep 1m


echo "\n${BOLDGREEN}Will create the service soon.${ENDCOLOR}"
sleep 10s

echo "\n${ITALICRED}Creating service:${ENDCOLOR}"

kubectl apply -f ./manifests/backend-service.yaml

echo "\n${U_YELLOW}Printing service details...${ENDCOLOR}"
kubectl describe svc backend
echo
kubectl get svc -l app=backend
sleep 5

echo "\n${BOLDGREEN}Start creating the NGINX ingress controller.${ENDCOLOR}"
sleep 10

echo "\n${ITALICRED}Creating NGINX ingress controller${ENDCOLOR}"
kubectl apply -f "https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml" 

echo "\n${U_YELLOW}Waiting for NGINX ingress controller to be ready...${ENDCOLOR}"
sr="app.kubernetes.io/component=controller"
kubectl --namespace ingress-nginx get po -l $sr 
kubectl -n ingress-nginx get deploy -w
sleep 1min

echo "\n${BOLDGREEN}Will create the ingress object.${ENDCOLOR}"
sleep 10

echo "\n${ITALICRED}Creating ingress object${ENDCOLOR}"
kubectl apply -f ./manifests/backend-ingress.yaml 

echo "\n${U_YELLOW}Waiting for nodejs-ingress-obj to be ready...${ENDCOLOR}"
sleep 45
kubectl get ingress -l app=backend 

echo "\n${U_YELLOW}Yayyyyy you should be able to see the webpage on localhost/.${ENDCOLOR}"
