package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformSecretManager(t *testing.T) {
	t.Parallel()
	terraformPreOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/root",
		NoColor:      true,
		Targets:      []string{"module.service_accounts"},
	})

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/root",
		NoColor:      true,
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndValidate(t, terraformOptions)
	terraform.InitAndApplyAndIdempotent(t, terraformPreOptions)
	terraform.InitAndApplyAndIdempotent(t, terraformOptions)
}
