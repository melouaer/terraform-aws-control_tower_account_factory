output "state_machine_arn" {
  value = aws_sfn_state_machine.aft_account_provisioning_framework_sfn.arn
}

output "validate_request_function_arn" {
  value = aws_lambda_function.validate_request.arn
}
output "get_account_info_function_arn" {
  value = aws_lambda_function.get_account_info.arn
}
output "create_role_function_arn" {
  value = aws_lambda_function.create_role.arn
}
output "tag_account_function_arn" {
  value = aws_lambda_function.tag_account.arn
}
output "persist_metadata_function_arn" {
  value = aws_lambda_function.persist_metadata.arn
}
