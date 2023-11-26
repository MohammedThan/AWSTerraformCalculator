// API Gateway
resource "aws_api_gateway_rest_api" "my_api" {
  name        = "myCalcsApi"
  description = "My Calculator API Gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# sub lambda function
resource "aws_api_gateway_resource" "sub" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "sub"
}

resource "aws_api_gateway_method" "sub" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.sub.id
  http_method = "POST"

  authorization = "NONE"
}

resource "aws_api_gateway_integration" "sub" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.sub.id
  http_method             = aws_api_gateway_method.sub.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.sub.invoke_arn
}

resource "aws_api_gateway_method_response" "sub_proxy" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.sub.id
  http_method = aws_api_gateway_method.sub.http_method
  status_code = "200"

  //cors section
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

}

resource "aws_api_gateway_integration_response" "sub_proxy" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.sub.id
  http_method = aws_api_gateway_method.sub.http_method
  status_code = aws_api_gateway_method_response.sub_proxy.status_code


  //cors
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.sub,
    aws_api_gateway_integration.sub
  ]
}

//options
resource "aws_api_gateway_method" "sub_options" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.sub.id
  http_method   = "OPTIONS"
  authorization = "NONE"


}

resource "aws_api_gateway_integration" "sub_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.sub.id
  http_method             = aws_api_gateway_method.sub_options.http_method
  integration_http_method = "OPTIONS"
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "sub_options_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.sub.id
  http_method = aws_api_gateway_method.sub_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "sub_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.sub.id
  http_method = aws_api_gateway_method.sub_options.http_method
  status_code = aws_api_gateway_method_response.sub_options_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.sub_options,
    aws_api_gateway_integration.sub_options_integration,
  ]
}
# end sub lambda function













# add lambda function
resource "aws_api_gateway_resource" "add" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "add"
}

resource "aws_api_gateway_method" "add" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.add.id
  http_method = "POST"

  authorization = "NONE"
}

resource "aws_api_gateway_integration" "add" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.add.id
  http_method             = aws_api_gateway_method.add.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.add.invoke_arn
}

resource "aws_api_gateway_method_response" "add_proxy" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.add.id
  http_method = aws_api_gateway_method.add.http_method
  status_code = "200"

  //cors section
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

}

resource "aws_api_gateway_integration_response" "add_proxy" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.add.id
  http_method = aws_api_gateway_method.add.http_method
  status_code = aws_api_gateway_method_response.add_proxy.status_code


  //cors
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.add,
    aws_api_gateway_integration.add
  ]
}

//options
resource "aws_api_gateway_method" "add_options" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.add.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "add_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.add.id
  http_method             = aws_api_gateway_method.add_options.http_method
  integration_http_method = "OPTIONS"
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "add_options_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.add.id
  http_method = aws_api_gateway_method.add_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "add_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.add.id
  http_method = aws_api_gateway_method.add_options.http_method
  status_code = aws_api_gateway_method_response.add_options_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.add_options,
    aws_api_gateway_integration.add_options_integration,
  ]
}
# end add lambda function













# mul lambda function
resource "aws_api_gateway_resource" "mul" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "mul"
}

resource "aws_api_gateway_method" "mul" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.mul.id
  http_method = "POST"

  authorization = "NONE"
}

resource "aws_api_gateway_integration" "mul" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.mul.id
  http_method             = aws_api_gateway_method.mul.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.mul.invoke_arn
}

resource "aws_api_gateway_method_response" "mul_proxy" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.mul.id
  http_method = aws_api_gateway_method.mul.http_method
  status_code = "200"

  //cors section
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

}

resource "aws_api_gateway_integration_response" "mul_proxy" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.mul.id
  http_method = aws_api_gateway_method.mul.http_method
  status_code = aws_api_gateway_method_response.mul_proxy.status_code


  //cors
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.mul,
    aws_api_gateway_integration.mul
  ]
}

//options
resource "aws_api_gateway_method" "mul_options" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.mul.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "mul_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.mul.id
  http_method             = aws_api_gateway_method.mul_options.http_method
  integration_http_method = "OPTIONS"
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "mul_options_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.mul.id
  http_method = aws_api_gateway_method.mul_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "mul_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.mul.id
  http_method = aws_api_gateway_method.mul_options.http_method
  status_code = aws_api_gateway_method_response.mul_options_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.mul_options,
    aws_api_gateway_integration.mul_options_integration,
  ]
}
# end mul lambda function






















# div lambda function
resource "aws_api_gateway_resource" "div" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "div"
}

resource "aws_api_gateway_method" "div" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.div.id
  http_method = "POST"

  authorization = "NONE"
}

resource "aws_api_gateway_integration" "div" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.div.id
  http_method             = aws_api_gateway_method.div.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.div.invoke_arn
}

resource "aws_api_gateway_method_response" "div_proxy" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.div.id
  http_method = aws_api_gateway_method.div.http_method
  status_code = "200"

  //cors section
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

}

resource "aws_api_gateway_integration_response" "div_proxy" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.div.id
  http_method = aws_api_gateway_method.div.http_method
  status_code = aws_api_gateway_method_response.div_proxy.status_code


  //cors
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.div,
    aws_api_gateway_integration.div
  ]
}

//options
resource "aws_api_gateway_method" "div_options" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.div.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "div_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.div.id
  http_method             = aws_api_gateway_method.div_options.http_method
  integration_http_method = "OPTIONS"
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "div_options_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.div.id
  http_method = aws_api_gateway_method.div_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "div_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.div.id
  http_method = aws_api_gateway_method.div_options.http_method
  status_code = aws_api_gateway_method_response.div_options_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.div_options,
    aws_api_gateway_integration.div_options_integration,
  ]
}
# end div lambda function










resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.sub,
    aws_api_gateway_integration.sub_options_integration,
    aws_api_gateway_integration.add,
    aws_api_gateway_integration.add_options_integration,
     aws_api_gateway_integration.mul,
    aws_api_gateway_integration.mul_options_integration,
     aws_api_gateway_integration.div,
    aws_api_gateway_integration.div_options_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = "calcs"
}
