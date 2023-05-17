module "cloudtrail" {
      source                        = "clouddrove/cloudtrail/aws"
      version                       = "1.3.0"

      name                          = "test"
      environment                   = "poc"
      label_order                   = ["name", "environment"]
      s3_bucket_name                = "test-poc-mgmt-trail"
      enable_logging                = true
      enable_log_file_validation    = true
      include_global_service_events = true
      is_multi_region_trail         = false
      log_retention_days            = 90
    }