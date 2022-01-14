# app-analytics-delivery-config-kickstart
Template Terraform for managing the partner side infrastructure of App Analytics Bring Your Own Bucket feature.

This repository is designed to be shared with ISV partners who want to use Bring Your Own Bucket, ideally by
way of a public Github repository.

# Usage
This Terraform script was tested with Terraform v1.0.

## Update the Backend
This script is configured to store its Terraform state in S3. Modify the file `backend.tf` to specify the
AWS region and bucket where the state should be stored, and optionally set the name of the key. It is
recommended that this bucket be versioned.

## Configure Your Settings
The `settings.auto.tfvars` file defines variables that you will need to set according to your environment.
Specifically, you need to set the AWS region where you would like your bucket to live, the Salesforce Org ID
of your License Management Org (used to secure your delegated IAM role), and the names of the buckets you
would like to create.

## Execute the Script
Running the script is like any other Terraform deployment:
* Make your AWS credentials available to terraform

        $ export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID_HERE>
        $ export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY_HERE>

* Initialize the backend

        $ terraform init

* Create the plan

        $ terraform plan -out byob.out

* Apply the plan

        $ terraform apply byob.out

## Get Your Information
After the plan is applied, Terraform will output the values that you need to supply to Salesforce, namely the name(s) of your bucket(s) and the ARN of your delegated IAM role. You can also retrieve these values at any time by running:

        $ terraform output
