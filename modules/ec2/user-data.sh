#!/bin/bash
# Run updates
amazon-linux-extras install epel
yum update -y
yum install ansible git -y
echo "--------------------------- UPDATES COMPLETED ---------------------------"

# Install SSM Agent
cd /tmp
echo "--------------------------- INSTALLING SSM AGENT ---------------------------"
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

# Enable SSM Agent
echo "--------------------------- ENABLING SSM AGENT ---------------------------"
sudo systemctl enable amazon-ssm-agent
echo "--------------------------- SSM AGENT ENABLED ---------------------------"

# Start SSM Agent
echo "--------------------------- STARTING SSM AGENT ---------------------------"
sudo systemctl start amazon-ssm-agent
echo "--------------------------- SSM AGENT STARTED ---------------------------"
cd -