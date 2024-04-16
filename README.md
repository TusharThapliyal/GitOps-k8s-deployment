# GitOps-k8s-deployment

``GitOps`` is a methodology for implementing ``continuous deployment (CD)`` and ``infrastructure as code (IaC)`` using ``Git repositories`` as the single source of truth for defining and managing infrastructure and application configurations.  
This repository demonstrates how we can use ``ArgoCD`` to implement GitOps methodology in our workflow to automate the deployment of our application on the ``Kubernetes cluster``.

## Architecture diagram of workflow
![gitops-project-diagram](https://github.com/TusharThapliyal/GitOps-k8s-deployment/assets/75366942/32dbf48e-9d28-4305-9688-65887e039095)


## Installation steps

1. Installing Docker

```bash
# update package list and install docker 
sudo apt-get update
sudo apt-get install docker.io

# Start and enable Docker as a service
sudo systemctl start docker
sudo systemctl enable docker

# Verify docker installation
docker --version
```
2. Install Jenkins
```bash
# installing java
yes | sudo apt install openjdk-11-jdk-headless

# installing Jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
yes | sudo apt-get install jenkins
```
3. Install Kubernetes.  
Follow these instructions according to your OS: 
[kubernetes.io/releases/download/](https://kubernetes.io/releases/download/)

## Usage
1. The source code for the Python application is stored in the ``./python-app`` dir. You can change the source code and push the changes to GitHub. 
2. The ``Jenkinsfile`` will get triggered using ``webhooks`` to create a new ``docker image`` and push it to the docker hub registry.
3. This will then trigger a different Jenkins job that will change the ``Kubernetes manifest YAML file`` in the repository that ``ArgoCD`` monitors.
4. Finally ``ArgoCD`` picks up the new changes and deploys the latest version of our application on the ``Kubernetes cluster``. 
