
## Requirements
   terraform 0.11.14

# cisco-task
 
In that repository, the terraform code results in an AWS ELB in front of an EC2 instance running Ubuntu Linux.
The infrastructure code sets up the environment, and configure an nginx web server,
with a static home page that says, “Cisco SPL”.

To be able use that code for different environments, you need to change the tfvars file and customize it.

**A - THE STEPS OF CONFIGURATION:**

1. Clone the repository from GitHub

```
`cd cisco-task`
```


Run the following commands: 
```
a) `terraform init`

b) `terraform apply -var-file task.tfvars`
```

 