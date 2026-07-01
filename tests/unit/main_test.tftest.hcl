# Unit Tests for tf-atom-vpc-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# All assertions target plan-KNOWN values (the tf-label id, input pass-throughs,
# and the enabled flag) so they do not depend on computed attributes (arn, real
# vpc id, route-table/security-group ids) which are unknown under a mock provider.
#
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose
# Run specific:     terraform test -test-directory=tests/unit -run "creates_when_enabled"

mock_provider "aws" {}

# Shared inputs for every run block: tf-label identity + the module's own
# required variables with valid sample values.
variables {
  namespace  = "eg"
  stage      = "test"
  name       = "thing"
  cidr_block = "10.0.0.0/16"
}

# ---------------------------------------------------------------------------
# Test: module creates the VPC when enabled (default)
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "enabled output should be true when the module is enabled"
  }

  assert {
    condition     = length(aws_vpc.this) == 1
    error_message = "exactly one aws_vpc should be planned when the module is enabled"
  }

  assert {
    condition     = aws_vpc.this[0].cidr_block == "10.0.0.0/16"
    error_message = "the planned VPC should use the provided cidr_block"
  }

  assert {
    condition     = aws_vpc.this[0].tags["Name"] == "eg-test-thing"
    error_message = "the VPC Name tag should be the tf-label id 'eg-test-thing'"
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "enabled output should be false when the module is disabled"
  }

  assert {
    condition     = output.id == null
    error_message = "id output should be null when the module is disabled (no VPC created)"
  }
}
