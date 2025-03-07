provider "aws" {
  alias  = "ct_management"
  region = var.ct_home_region
  # The default profile or environment variables should authenticate to the Control Tower Management Account as Administrator
  assume_role {
    role_arn     = "arn:aws:iam::${var.ct_management_account_id}:role/aws-cicd-masteraccount-role"
    session_name = local.aft_session_name
  }
  default_tags {
    tags = {
      managed_by = "AFT"
    }
  }
}

provider "aws" {
  alias  = "aft_management"
  region = var.ct_home_region
  assume_role {
    role_arn     = "arn:aws:iam::${var.aft_management_account_id}:role/AWSControlTowerExecution"
    session_name = local.aft_session_name
  }
  default_tags {
    tags = {
      managed_by = "AFT"
    }
  }
}
provider "aws" {
  alias  = "tf_backend_secondary_region"
  region = var.tf_backend_secondary_region
  assume_role {
    role_arn     = "arn:aws:iam::${var.aft_management_account_id}:role/AWSControlTowerExecution"
    session_name = local.aft_session_name
  }
  default_tags {
    tags = {
      managed_by = "AFT"
    }
  }
}
provider "aws" {
  alias  = "audit"
  region = var.ct_home_region
  assume_role {
    role_arn     = "arn:aws:iam::${var.audit_account_id}:role/AWSControlTowerExecution"
    session_name = local.aft_session_name
  }
  default_tags {
    tags = {
      managed_by = "AFT"
    }
  }
}
provider "aws" {
  alias  = "log_archive"
  region = var.ct_home_region
  assume_role {
    role_arn     = "arn:aws:iam::${var.log_archive_account_id}:role/AWSControlTowerExecution"
    session_name = local.aft_session_name
  }
  default_tags {
    tags = {
      managed_by = "AFT"
    }
  }
}
