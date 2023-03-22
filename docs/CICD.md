# CI/CD

Given the repository structure described in the [Design Decisions](DESIGN.md) document, the CI/CD pipeline would be executed against each subdirectory of the `infra-live` directory.

A typical CI/CD pipeline for a Terraform project would be:

1. Run `terraform validate` to validate the Terraform code.
2. Run `tflint` to lint the Terraform code.
3. Run `terraform fmt -check -diff -recursive` to format the Terraform code.
4. Run security checks.
5. Run `terraform plan` to create an execution plan.
6. Run `terraform apply` to apply the changes.

However, in our case we have three environments to take into account: `dev`, `staging` and `production`. We want to be able to deploy the infrastructure to each environment independently.

Given that scenario, the pipeline should now have the following structure:

1. Run `terraform validate` to validate the Terraform code.
2. Run `tflint` to lint the Terraform code.
3. Run `terraform fmt -check -diff -recursive` to format the Terraform code.
4. Run security checks.
5. Run `terraform plan` to create an execution plan for the `dev` environment.
6. Run `terraform apply` to apply the changes to the `dev` environment.
7. Run `terraform plan` to create an execution plan for the `staging` environment.
8. Run `terraform apply` to apply the changes to the `staging` environment.
9. Run `terraform plan` to create an execution plan for the `production` environment.
10. Run `terraform apply` to apply the changes to the `production` environment.

The advantage of having a declarative infrastructure is that we can change one environment without affecting the others. If no changes are made to a specific environment, the pipeline will not apply any changes to it and proceed to the next environment.

## Additional Improvements

The pipeline should also be able to run the tests for each microservice in order to validate if the infrastructure was properly deployed. This is not implemented in this project, but it would be a nice addition.

Moreover, *precommit hooks* should be added to the repository to run the same checks as the pipeline. This would allow to catch errors before pushing the code to the repository.

Finally, an estimation of the cost of the infrastructure should be added to the pipeline. This would allow to have a better understanding of the cost of the infrastructure and to be able to estimate the cost of any changes that are made to the infrastructure. Here tools like [Infracost](https://www.infracost.io/) can become very useful.
