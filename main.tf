

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}


# sub lambda function
data "archive_file" "sub" {
  type        = "zip"
  source_file = "functions/sub.py"
  output_path = "functionsOutput/lambda_function_payload_sub.zip"
}
resource "aws_lambda_function" "sub" {
  filename         = data.archive_file.sub.output_path
  function_name    = "sub"
  role             = aws_iam_role.lambda_role.arn
  handler          = "sub.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.sub.output_base64sha256
}

resource "aws_lambda_permission" "sub" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sub.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}
# end sub lambda function









# add lambda function
data "archive_file" "add" {
  type        = "zip"
  source_file = "functions/add.py"
  output_path = "functionsOutput/lambda_function_payload_add.zip"
}
resource "aws_lambda_function" "add" {
  filename         = data.archive_file.add.output_path
  function_name    = "add"
  role             = aws_iam_role.lambda_role.arn
  handler          = "add.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.add.output_base64sha256
}

resource "aws_lambda_permission" "add" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.add.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}
# end add lambda function









# mul lambda function
data "archive_file" "mul" {
  type        = "zip"
  source_file = "functions/mul.py"
  output_path = "functionsOutput/lambda_function_payload_mul.zip"
}
resource "aws_lambda_function" "mul" {
  filename         = data.archive_file.mul.output_path
  function_name    = "mul"
  role             = aws_iam_role.lambda_role.arn
  handler          = "mul.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.mul.output_base64sha256
}

resource "aws_lambda_permission" "mul" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.mul.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}
# end mul lambda function









# div lambda function
data "archive_file" "div" {
  type        = "zip"
  source_file = "functions/div.py"
  output_path = "functionsOutput/lambda_function_payload_div.zip"
}
resource "aws_lambda_function" "div" {
  filename         = data.archive_file.div.output_path
  function_name    = "div"
  role             = aws_iam_role.lambda_role.arn
  handler          = "div.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.div.output_base64sha256
}

resource "aws_lambda_permission" "div" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.div.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}
# end div lambda function