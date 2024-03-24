LAMBDA SETUP
============
aws >> lambda >> create lambda funtion >> 
Author from scratch
  Basic information: 
    Function name: gabby-dev-lmambda
    Runtime: python 3:12
    Architecture: x86_64 >> create function

CREATE BASIC LAMBDA FUNCTION
============================
 aws >> lambda >> functions >> gabby-dev-lmambda:
   code >> lambda_function.py
```
import json

def lambda_handler(event, context):
    print("Hello!, Lambda Basic Function is working!") ####here!
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }

```
Deploy >> Test >> Configure test event:
    Test event action: Create new event
    Event name :  gabby-dev-lambda-event
    Event sharing settings : Private
    Template: hello-world
        Event JSON = (Parameters to execute at the time of Lambda function execution)    
```
#no parameters  
{
  "": ""
}
  >> save 
```
Test >> We can see the expected response & function logs in ""function results""
