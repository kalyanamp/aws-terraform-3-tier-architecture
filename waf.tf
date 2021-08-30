resource "aws_wafv2_web_acl" "WAF_ACL" {
    name = "web-WAF"
    description = "web-WAF"
    scope = "REGIONAL"

    default_action {
      allow {}
    }

    rule {
        name = "rule-1"
        priority = 1

        override_action {
          count {}
        }

        statement {
            managed_rule_group_statement {
              name = "AWSManagedRulesCommonRuleSet"
              vendor_name = "AWS"
            }
          
        }

        visibility_config {
            cloudwatch_metrics_enabled = false
            metric_name = "web-rule-1"
            sampled_requests_enabled = false
        }
    }

    visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name = "web-WAF"
        sampled_requests_enabled = false
    }
}

resource "aws_wafv2_web_acl_association" "WAF_ACL_association" {
    resource_arn = aws_lb.external-elb.arn
    web_acl_arn = aws_wafv2_web_acl.WAF_ACL.arn
}
