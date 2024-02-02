WHAT IS HELM TEST?

```
helm test is a command used to run any tests defined within a Helm chart. 
These tests help validate the functionality and correctness of your chart, ensuring it behaves as expected when deployed. 
like a safety check for your charts before releasing them into production.
```
*** HELM CHARTS SHOULD BE INSTALLED BEFORE USE """HELM TEST""" *******
*** BASIC  DEFAULT HELM test-connection.yaml FILE WILL BE CREATED IN TEMPLATES FILE at the HELM CHART CREATION ****

helm install myrelease-dev-gabby helloworld
helm test myrelease-dev-gabby       - Test & shows: phase succeeded if it's successful
