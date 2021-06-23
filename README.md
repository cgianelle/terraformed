# terraformed
Projects created to learn Terraform. Both AWS and GCP were used. 

| Folder | Description |
| ------ | ----------- |
| my_first_aws_project | Launch an EC2 micro instance in AWS and setup firewall rules to allow SSH |
| aws_web_server | Simple hello world web server in AWS using a micro instance. Firewall rules allow HTTP, HTTPS, and SSH. Bootstrap is embedded in user_data |
| aws_web_server2 | Builds off the _aws_web_server_ project, but this time includes bootstrap as a shell script. |
| aws_web_server3 | Builds off the _aws_web_server2_ project, but this time uses a templating file. |
| gcp_web_server | Same web server, but for GCP. Firewall rules for HTTP, HTTPS, and SSH. |