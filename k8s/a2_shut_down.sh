kubectl delete ingress backend
kubectl delete -n ingress-nginx deploy ingress-nginx-controller
kubectl delete service backend
kubectl delete deploy backend
kind delete cluster --name otot-a2-demo
