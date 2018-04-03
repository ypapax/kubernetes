My notes and playing around with kubernetes.

## Installation
I used this resources:\
https://www.youtube.com/watch?v=6xJwQgDnMFE

https://blog.alexellis.io/kubernetes-in-10-minutes/


https://www.youtube.com/watch?v=b_fOIELGMDY

## Issues
Had error
```
sudo kubectl get nodes
```
Unable to connect to the server: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "kubernetes")


this helped: https://github.com/kubernetes/kubernetes/issues/48378#issuecomment-374412266
