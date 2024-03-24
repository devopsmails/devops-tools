LAMBDA SETUP
============
aws >> lambda >> create lambda funtion >> 
Author from scratch
  Basic information: 
    Function name: gabby-dev-lmambda-2
    Runtime: python 3:12
    Architecture: x86_64 >> create function

CREATE BASIC LAMBDA FUNCTION USING ENV VARIABLES
============================================
Create env variables
=====================
aws >> lambda >> functions >> gabby-dev-lmambda-2:
  Configuraion >> Environment variables >> edit:
    key: env_var_value
    value : suresh >> save
Code:
 aws >> lambda >> functions >> gabby-dev-lmambda:
   code >> lambda_function.py
```
import json
import os

def lambda_handler(event, context):
    my_var_value = os.environ.get('env_var_value')
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('This is the example for env var and env var value is =' +my_var_value)
    }

```
Deploy >> Test >> Configure test event:
    Test event action: Create new event
    Event name :  gabby-dev-lambda-event-2
    Event sharing settings : Private
    Template: hello-world
        Event JSON = (Parameters to execute at the time of Lambda function execution)    
```
#no parameters  
{}
  >> save >> Deploy
```
Test >> We can see the expected response as:
    This is the example for env var and env var value is =suresh
& function logs in ""function results""