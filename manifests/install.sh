helm install -f values/redis-values.yaml rediscart charts/redis

helm install -f values/adservice-values.yaml adservice charts/shopping-ms
helm install -f values/cartservice-values.yaml cartservice charts/shopping-ms
helm install -f values/checkoutservice-values.yaml checkoutservice charts/shopping-ms
helm install -f values/currencyservice-values.yaml currencyservice charts/shopping-ms
helm install -f values/emailservice-values.yaml emailservice charts/shopping-ms
helm install -f values/frontend-values.yaml frontend charts/shopping-ms
helm install -f values/paymentservice-values.yaml paymentservice charts/shopping-ms
helm install -f values/productcatalogservice-values.yaml productcatalogservice charts/shopping-ms
helm install -f values/recommendationservice-values.yaml recommendationservice charts/shopping-ms
helm install -f values/shippingservice-values.yaml shippingservice charts/shopping-ms