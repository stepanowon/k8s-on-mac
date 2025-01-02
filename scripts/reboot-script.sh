kubectl rollout restart deployment coredns -n kube-system
kubectl rollout restart deployment calico-apiserver -n calico-apiserver
kubectl rollout restart daemonset kube-proxy -n kube-system

kubectl rollout restart deployment calico-kube-controllers -n calico-system 
kubectl rollout restart daemonset calico-node -n calico-system
kubectl rollout restart daemonset csi-node-driver -n calico-system 
kubectl rollout restart deployment calico-typha -n calico-system  

kubectl rollout restart daemonset speaker -n metallb-system 
kubectl rollout restart deployment controller -n metallb-system  

kubectl rollout restart deployment tigera-operator -n tigera-operator

kubectl rollout restart deployment ingress-nginx-controller -n ingress-nginx