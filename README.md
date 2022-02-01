# app-analytics-delivery-config-kickstart
The app-analytics-delivery-config-kickstart is a Terraform template used to create your partner-side infrastructure for the AppExchange App Analytics Delivery (AADC) feature.

AppAnalyticsDeliveryConfig is currently only available as a closed pilot to invited partners.

# Usage
This Terraform script was tested with Terraform v1.0.

# Prerequisites
This Terraform template requires that you have these items:
* An Amazon Web Services (AWS) account
* A set of AWS IAM credentials, including an Access key ID and a Secret Access Key, for CLI and API access
* An existing Simple Storage Service (S3) bucket to store the Terraform state file
* Terraform installed on your machine


## Update the Backend
This script is configured to store its Terraform state in your existing S3 bucket. 

Modify the `backend.tf` file to specify the AWS `region` and `bucket` name of your existing bucket where the state will be stored. For example:

        backend "s3" {
            region = "us-west-2"
            bucket = "my_bucket_name"
            key    = "byob-kickstart.tfstate"
        } 

We recommended that you add versioning to this bucket.

## Configure Your Settings
The `settings.auto.tfvars` file defines variables that you must set according to your environment. Specifically, you must set:
* The AWS region where your new S3 bucket(s) for App Analytics will live
* The Salesforce Org ID of your License Management Org (LMO), which secures your delegated IAM role
* The names of the bucket to create

## Execute the Script
To run the script, follow standard Terraform deployment steps.

1. Make your AWS credentials available to Terraform.

        $ export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID_HERE>
        $ export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY_HERE>

2. Initialize the backend.

        $ terraform init

3. Create the plan.

        $ terraform plan -out plan.out

4. Apply the plan.

        $ terraform apply plan.out

## Get Your Information
After the plan is applied, Terraform outputs the values that you must supply when creating an AppAnalyticsDeliveryConfig object in Salesforce.
Specifically for each AppAnalyticsDeliveryConfig object, you must set the `BucketName` field as the ARN of your delegated IAM role.

You can also retrieve these values at any time by running:

        $ terraform output
