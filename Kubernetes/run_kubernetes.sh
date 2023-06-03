#create namespace petclinic 

kubectl create ns petclinic
helm upgrade --install config-server ./Kubernetes/config-server --values=./Kubernetes/config-server/values.yaml 
helm upgrade --install discovery-server ./Kubernetes/discovery-server --values=./Kubernetes/discovery-server/values.yaml
 helm upgrade --install customers-server ./Kubernetes/customers-server --values=./Kubernetes/customers-server/values.yaml
 helm upgrade --install visits-service ./Kubernetes/visits-service --values=./Kubernetes/visits-service/values.yaml
 helm upgrade --install vets-service ./Kubernetes/vets-service --values=./Kubernetes/vets-service/values.yaml
 helm upgrade --install api-gateway ./Kubernetes/api-gateway --values=./Kubernetes/api-gateway/values.yaml
 helm upgrade --install tracing-server ./Kubernetes/tracing-server --values=./Kubernetes/tracing-server/values.yaml
 helm upgrade --install admin-server ./Kubernetes/admin-server --values=./Kubernetes/admin-server/values.yaml
helm upgrade --install grafana-server ./Kubernetes/grafana-server --values=./Kubernetes/grafana-server/values.yaml
helm upgrade --install prometheus-server ./Kubernetes/prometheus-server --values=./Kubernetes/prometheus-server/values.yaml
#kubectl create namespace petclinic 
# kunens petclinic 
# helm install config-server config-server/ --values=./config-server/values.yaml
# helm install config-server discovery-server/ --values=./discovery-server/values.yaml
# helm install customers-service customers-service/ --values=./customers-service/values.yaml
# helm install visits-service visits-service/ --values=./visits-service/values.yaml
# helm install vets-service vets-service/ --values=./vets-service/values.yaml
# helm install api-gateway api-gateway/ --values=./api-gateway/values.yaml
# helm install tracing-server tracing-server/ --values=./tracing-server/values.yaml
# helm install admin-server admin-server/ --values=./admin-server/values.yaml
# helm install grafana-server grafana-server/ --values=./grafana-server/values.yaml
# helm install prometheus-server prometheus-server/ --values=./prometheus-server/values.yaml
# for ingress 
## kubectl apply -f ingress.yaml 
#verifer le cmd 
# kubectl get crd
