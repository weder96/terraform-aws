locals {
  namespaced_service_name = "${var.service_name}-${var.env}"

  lambdas_path = "${path.module}/../lambdas"
  layers_path  = "${local.lambdas_path}/layers"

  lambda_layers = {
    utils       = "Utils for response and event normalization",
    middy       = "Middy core 2.5.1",
    middlewares = "Custom middy middlewares"
  }

  lambdas = {
    get = {
      description = "Get function"
      memory      = 256
      timeout     = 10
    }
    delete = {
      description = "Delete given function"
      memory      = 128
      timeout     = 5
    }
    put = {
      description = "Update given function"
      memory      = 128
      timeout     = 5
    }
    post = {
      description = "Create new function"
      memory      = 128
      timeout     = 5
    }
  }
}
