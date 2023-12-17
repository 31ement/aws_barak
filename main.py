import boto3
from botocore.exceptions import NoCredentialsError, ClientError
import argparse


def check_aws_credentials(region_name):
    try:
        # Create an STS client
        sts_client = boto3.client('sts')
        # Retrieve the AWS account ID and other details
        account_id = sts_client.get_caller_identity()["Account"]
        return True
    except NoCredentialsError:
        return False
    except ClientError as e:
        return False


def get_ec2_instances(region_name):
    """Returns a list of EC2 instances with their ID, name, and region."""
    ec2 = boto3.client('ec2', region_name=region_name)

    instances = ec2.describe_instances()
    instance_info = []

    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            instance_type = instance['InstanceType']
            instance_zone = instance['Placement']['AvailabilityZone']
            instance_name = next((tag['Value'] for tag in instance.get('Tags', []) if tag['Key'] == 'Name'), None)
            instance_info.append({'ID': instance_id,
                                  'Name': instance_name,
                                  'Zone': instance_zone,
                                  'Type': instance_type
                                  })

    return instance_info


def display_ec2_instances(region_name):

    ec2_instances = get_ec2_instances(region_name)

    if len(ec2_instances) == 0:
        print(f"\nEC2 Instances in {region_name}: None")
    else:
        print(f"\nEC2 Instances in {region_name}:")
        for instance in ec2_instances:
            print(f" Name: {instance['Name']}\n"
                  f" ID: {instance['ID']}\n"
                  f" Zone: {instance['Zone']}",
                  f" Type: {instance['Type']}")


def get_vpc(region_name):
    """Returns a list of VPC components with their ID, name, and region."""
    ec2 = boto3.client('ec2', region_name=region_name)

    vpcs = ec2.describe_vpcs()
    vpc_info = []

    for vpc in vpcs['Vpcs']:
        vpc_id = vpc['VpcId']
        vpc_cidr = vpc['CidrBlock']
        # vpc_name = next((tag['Value'] for tag in vpc.get('Tags', []) if tag['Key'] == 'Name'), None)
        vpc_info.append({'ID': vpc_id, 'CidrBlock': vpc_cidr})

    return vpc_info


def display_vpc(region_name):

    vpc = get_vpc(region_name)

    if len(vpc) == 0:
        print(f"\nVPCs in {region_name}: None")
    else:
        print(f"\nVPCs in {region_name}:")
        for each_vpc in vpc:
            print(f" ID: {each_vpc['ID']}\n",
                  f"CIDR: {each_vpc['CidrBlock']}\n")


def get_s3_buckets(region_name):
    """Returns a list of S3 buckets with their name."""
    s3 = boto3.client('s3', region_name=region_name)
    buckets = s3.list_buckets()
    return [{'Name': bucket['Name']} for bucket in buckets.get('Buckets', [])]


def display_s3_buckets(region_name):
    s3_buckets = get_s3_buckets(region_name)

    if len(s3_buckets) == 0:
        print(f"\nS3 Buckets in {region_name}: None")
    else:
        print(f"\nS3 Buckets in {region_name}:")
        for bucket in s3_buckets:
            print(f"- {bucket['Name']}")


def get_rds_instances(region_name):
    """Returns a list of RDS instances with their ID, name, and region."""
    rds = boto3.client('rds', region_name=region_name)

    instances = rds.describe_db_instances()
    instance_info = []

    for instance in instances['DBInstances']:
        instance_id = instance['DBInstanceIdentifier']
        instance_type = instance['DBInstanceClass']
        instance_engine = instance['Engine']
        instance_zone = instance['AvailabilityZone']
        instance_info.append({'ID': instance_id,
                              'Type': instance_type,
                              'Engine': instance_engine,
                             'Zone': instance_zone
                              })
    return instance_info


def display_rds_instances(region_name):

    rds_instances = get_rds_instances(region_name)

    if len(rds_instances) == 0:
        print(f"\nRDS Instances in {region_name}: None")
    else:
        print(f"\nRDS Instances in {region_name}:")
        for instance in rds_instances:
            print(f" ID: {instance['ID']}\n",
                  f"Type: {instance['Type']}\n",
                  f"DB Engine: {instance['Engine']}\n",
                  f"Zone: {instance['Zone']}\n")


def parse_arguments():
    """Parse command line arguments. The default region is 'us-east-1'."""
    parser = argparse.ArgumentParser(description="AWS Resources List Script")

    # Default region is set to 'us-east-1'
    parser.add_argument("--region", default="us-east-1", help="AWS region name (default: us-east-1)")

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_arguments()

    if check_aws_credentials(args.region) is True:
        display_ec2_instances(args.region)
        display_s3_buckets(args.region)
        display_rds_instances(args.region)
        display_vpc(args.region)
    else:
        print(f"Authentication Error.")
