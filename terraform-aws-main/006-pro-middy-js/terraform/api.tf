resource "aws_apigatewayv2_api" "this" {
  name          = "${local.namespaced_service_name}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "functions" {
  for_each = local.lambdas

  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  payload_format_version = "2.0"
  integration_uri        = aws_lambda_function.functions[each.key].invoke_arn
}

resource "aws_apigatewayv2_route" "functions" {
  for_each = local.lambdas

  api_id    = aws_apigatewayv2_api.this.id
  route_key = "${upper(each.key)} /v1/functions"
  target    = "integrations/${aws_apigatewayv2_integration.functions[each.key].id}"
}

resource "aws_apigatewayv2_route" "functions_get" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "GET /v1/functions/{todoId}"
  target    = "integrations/${aws_apigatewayv2_integration.functions["get"].id}"
}
