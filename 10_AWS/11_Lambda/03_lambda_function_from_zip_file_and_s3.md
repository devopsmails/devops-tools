UPLOAD LAMBDA FUNCTION FROM ZIP FILES
====================================
```
**** Create 2 blow files in pycharm IDE

1.""test_lambda.py"" 
====================
#test_lambda.py
--------------
import json

def lambda_handler(event, context):
    print("hello! It's test code from the zip file")

    return {
        'statusCode' : 200,
        'body': json.dumps('Hello Lambda from my code from zip format')
    }

2.requirments.txt
================

requests==2.31.0
boto3==1.34.69

RUN:
===
pip3 install -r ./requirements.txt


*** it download all the requirements listed along with venv files
*** right click on directory on IDE >> "" open in "" >> path popup >> you can go to file loacted path. 
*** go to >> files list in the directory. 
*** Select all the files except ".idea "file
*** right click >> compress it to zip

3.LAMBDA SETUP
============
aws >> lambda >> create lambda funtion >> 
Author from scratch
  Basic information: 
    Function name: gabby-dev-lambda
    Runtime: python 3:12
    Architecture: x86_64 >> create function

upload from ZIP FILE
====================
code >> upload from >> .zipfile >> upload >>
    select the zip file: venv.zip >> save

upload from AMAZON S3 LOCATION
===========================
aws >> s3 >> create bucket >> 
  aws region: ap-south-1(same as lambda region)  
  Bucket name: gabby-dev-suresh(unique) >> Create bucket

gabby-dev-suresh >> upload >> upload >> addfiles >> select the same venv.zip file >> upload
  s3 >> gabby-dev-suresh >> venv.zip >> ""copy uri link: s3://gabby-dev-suresh/venv.zip""

Same lambda >> code >> upload from >> amazon s3 location >> 
  amazon s3 url link: paste : s3://gabby-dev-suresh/venv.zip >> save

4.Add the correct code file name to lambda handler
=================================================
*** lambda handler is mandaory 
Runtime settings >> edit >>
  Handler: test_lambda.lambda_handler >> save

5.TEST THE CODE
==============
test >> test >> Executing function: succeeded >> Details >> 
We can see all the detials of the code like retun code & code execution
========================================================================
```
HOW TO CREATE A LAMBDA FUNCTION URL
===================================
```
AWS >> lambda >> functions >> gabby-dev-lambda(same like above) >> configurations >>
  function url >> create  function url >>

  Type 1: WITH AUTH NONE
  ====================
  Auth type: None (Even it creates default auth policy) >> save
  copy function URL on browser & search : https://z335dd2a623vzdfxnl2ukvvepy0ogijs.lambda-url.ap-south-1.on.aws/
  **** we can see successfully code retun on browser

  Type 2 : WITH IAM AUTH
  ====================
  edit >> Switch auth type : IAM AUTH & save
  copy function URL on browser & search : https://z335dd2a623vzdfxnl2ukvvepy0ogijs.lambda-url.ap-south-1.on.aws/
  **** we can see forbidden error as it's requires proper auth creds

  TEST THE FUNCTION URL USING """POSTMAN""" CREDS AUTH PARAMETES
  =============================================================
postman URL: 
https://warped-trinity-116084.postman.co/workspace/My-Workspace~6e4c6bc9-59b3-4eb9-84fa-34ded2d9cf27/request/create?requestId=201fd279-25b1-4890-a734-e1bb9855a7b1

Collections >> get >> 
  enter lambda function url: https://z335dd2a623vzdfxnl2ukvvepy0ogijs.lambda-url.ap-south-1.on.aws/

  Authorization: 
    type: aws signature >>
      access key : AKIAQ3EGPNVG7VVDQON7
      secret key : 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
      AWS Region: ap-south-1
      service name: lambda (like ec2, lambda ..) >> send >>
        Now we are able view the successful api testing
    


