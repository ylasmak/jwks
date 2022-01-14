curl -L https://istio.io/downloadIstio | sh -
sudo cp ./istio-1.12.1/bin/istioctl /usr/local/bin 
kubectl create istio-poc
kubectl label namespace istio-poc istio-injection=enabled
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.12/security/tools/jwt/samples/demo.jwt -s) && echo "$TOKEN" | cut -d '.' -f2 - | base64 --decode -

kubectl exec "$(kubectl get pod -l app=sleep -n istio-poc -o jsonpath={.items..metadata.name})" -c sleep -n istio-poc -- curl "http://httpbin.istio-poc:8000/headers" -sS -o /dev/null -H "Authorization: Bearer $TOKEN" -w "%{http_code}\n"

TOKEN2=$(cat token.jwt) && echo "$TOKEN2" | cut -d '.' -f2 - | base64 --decode -

kubectl exec "$(kubectl get pod -l app=sleep -n istio-poc -o jsonpath={.items..metadata.name})" -c sleep -n istio-poc -- curl "http://httpbin.istio-poc:8000/headers" -sS -o /dev/null -H "Authorization: Bearer $TOKEN2" -w "%{http_code}\n"


#jwt.gateway.k8s.local
https://github.com/istio/istio/release-1.12/security/tools/jwt/samples/jwks.json

https://raw.githubusercontent.com/ylasmak/jwks/main/jwks.mini.json


