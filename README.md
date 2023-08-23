---

# Terraform AWS Setup

Terraform AWS Setup is a Terraform module collection for deploying foundational AWS resources like VPC, EC2 key pair, and an EC2 bastion instance.

## Prerequisites

- Terraform installed on your machine.
- AWS CLI configured with appropriate credentials.

## Installation

Start by cloning the repository or downloading the Terraform files. Navigate to the directory containing the Terraform files.

```bash
git clone https://github.com/acarir/bastion-host-terraform-template.git
cd bastion-host-terraform-template
```

Then, initialize Terraform:

```bash
terraform init
```

## Usage

1. **Planning**: This step will show you the changes that will be made in your AWS environment.

    ```bash
    terraform plan -var-file=<YOUR_TFVARS_FILE>.tfvars
    ```

    Replace `<YOUR_TFVARS_FILE>` with the name of your variable file.

2. **Applying**: Once you've reviewed and are satisfied with the plan, apply the changes.

    ```bash
    terraform apply -var-file=<YOUR_TFVARS_FILE>.tfvars
    ```

3. **Destroying**: To remove the resources:

    ```bash
    terraform destroy -var-file=<YOUR_TFVARS_FILE>.tfvars
    ```


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./modules/ec2 | n/a |
| <a name="module_keypair"></a> [keypair](#module\_keypair) | ./modules/keypair | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ec2_name"></a> [ec2\_name](#input\_ec2\_name) | n/a | `string` | `"bastion_host"` | no |
| <a name="input_ec2_type"></a> [ec2\_type](#input\_ec2\_type) | n/a | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `string` | `"terraform-test-key"` | no |
| <a name="input_private_subnet_cidr_blocks"></a> [private\_subnet\_cidr\_blocks](#input\_private\_subnet\_cidr\_blocks) | n/a | `list(string)` | <pre>[<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| <a name="input_public_subnet_cidr_block"></a> [public\_subnet\_cidr\_block](#input\_public\_subnet\_cidr\_block) | n/a | `string` | `"10.0.1.0/24"` | no |
| <a name="input_ssh_cidr_blocks"></a> [ssh\_cidr\_blocks](#input\_ssh\_cidr\_blocks) | n/a | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | `"terraform-subnet"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `"terraform-test"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_name"></a> [key\_name](#output\_key\_name) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_id"></a> [public\_id](#output\_public\_id) | n/a |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->