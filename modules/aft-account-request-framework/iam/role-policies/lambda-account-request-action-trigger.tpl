{
	"Version": "2012-10-17",
	"Statement": [{
			"Effect": "Allow",
			"Action": [
				"dynamodb:PutItem",
				"dynamodb:Query"
			],
			"Resource": "arn:aws:dynamodb:${data_aws_region_aft-management_name}:${data_aws_caller_identity_aft-management_account_id}:table/${aws_dynamodb_table_aft-request-audit_name}"
		},
		{
			"Effect": "Allow",
			"Action": [
				"lambda:InvokeFunction",
				"dynamodb:GetShardIterator",
				"dynamodb:DescribeStream",
				"dynamodb:GetRecords",
				"dynamodb:ListShards",
				"dynamodb:ListStreams",
				"sqs:SendMessage"
			],
			"Resource": [
				"arn:aws:dynamodb:${data_aws_region_aft-management_name}:${data_aws_caller_identity_aft-management_account_id}:table/${aws_dynamodb_table_aft-request_name}/stream/*",
				"${aws_lambda_function_invoke_aft_account_provisioning_framework_arn}",
                "${aws_sqs_queue_aft_account_request_arn}"
			]
		},
		{
			"Effect": "Allow",
			"Action": "dynamodb:ListStreams",
			"Resource": "*"
		},
		{
			"Effect": "Allow",
			"Action": "ssm:GetParameter",
			"Resource": [
				"arn:aws:ssm:${data_aws_region_aft-management_name}:${data_aws_caller_identity_aft-management_account_id}:parameter/aft/*"
			]
		},
      {
        "Effect" : "Allow",
        "Action" : [
          "sns:Publish"
        ],
        "Resource" : [
          "${aws_sns_topic_aft_notifications_arn}",
		  "${aws_sns_topic_aft_failure_notifications_arn}"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kms:GenerateDataKey",
          "kms:Encrypt",
          "kms:Decrypt"
        ],
        "Resource" : [
			"${aws_kms_key_aft_arn}",
			"arn:aws:kms:${data_aws_region_aft-management_name}:${data_aws_caller_identity_aft-management_account_id}:alias/aws/sns"
		]
      }
	]
}
