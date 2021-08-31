# 1. Installation Linux Ubuntu/Debian/Fedora/Centos/RHEL and MacOS

Perform the following steps in order to install VSCode on local machine and all the tools needed by a generic project VSCode, Docker, Docker-compose, SSH Keys, Git, AWS S3 credentials and Doker as not root.

```sh
export SDK_PATH="/home/${SUDO_USER:-$USER}/fch-chile-sdk"
mkdir -p $SDK_PATH
cd $SDK_PATH
git clone https://gitlab.com/pmerinodiaz/vscode-local.git
cd vscode-local
./install.sh <gitusername> <group>
```

## 1.1 Explanation of each variable

### gitusername (Required)

The Gitlab user account.

### group (Required)

The group name of Gitlab of your project.

## 1.2 Explanation of tasks in the installer

Those are the taks of this installer:

1. Install VSCode
2. Install Docker Engine
3. Install Compose on Linux systems
4. Install Python3 and Pip3
5. Configure GitLab SSH Keys
6. Install Git
7. Store Git credentials
8. Install AWS CLI and credentials of AWS S3
9. Manage Docker as a non-root user
10. Install Nodejs, Npm, Yarn and create_react_app
11. Install Kubectl
12. Clone the repositories