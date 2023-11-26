import json
def lambda_handler(event, context):
 # Extract input values
 x = int(event["X"])
 y = int(event["Y"])

 # Perform the operation based on the function
 result = x-y

 # a Python object (dict):
 response = {
 "X": x,
 "Y": y,
 "result": result
 }

 return (response)