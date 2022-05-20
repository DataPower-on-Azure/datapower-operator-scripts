# datapower-operator-scripts

Home of utility scripts for automating datapower-operator tasks.

## Instuctions

**Pre-Reqs**

1. Config the git pre-commit hook to run scripts in this repo.
```
git config core.hooksPath .githooks
```
  - Then depending on your OS:
    - Mac
      ```
      chmod ug+x .githooks/pre-commit migrate-backup-dps.sh migrate-backup-route.sh migrate-backup-service.sh
      ```
    - Windows
      ```
      icacls .githooks/pre-commit migrate-backup-dps.sh migrate-backup-route.sh migrate-backup-service.sh /grant *S-1-1-0:F
      ```
      _Note: You may have to use the full path on Windows to correctly authorize the hook to run. We haven't had the ability to test this yet._
2. If planning on deploying with GitOps at any stage, clone the [multi-tenancy-gitops-apps](https://github.com/DataPower-on-Azure/multi-tenancy-gitops-apps) repo into the parent directory of where this repo is currently located on your local machine.

**Checking in/out DataPower backup zip files**
1. Write git commits after adding or removing DataPower backup zip files into the root of this repo.

**Please do not rename any zip files to ensure the git hook works correctly.**
Instead:
1. Move the zip file out of this repo's directory
2. Add & commit the changes
3. Rename the moved zip file
4. Move the renamed zip file back to this repo's directory
5. Add & commit the changes.

### Instructions for deploying DataPower manually on OCS

**Pre-reqs**

1. Login to the OpenShift Web Console.
  - Use the provided url, username and password from either the OpenShift installer, or an admin who holds the credentials.
2. Once logged in the the OpenShift Web Console, log in to the OpenShift CLI.
  - In the upper right corner of the OpenShift Web Console select the IAM user and click "Copy login command" in the drop down menu.
  - In the window that opens, copy the first CLI input and paste it into your CLI of choice.

**Instructions**

1. Install the IBM DataPower catalog source to expose the operator using the CLI.
```
oc apply -f ibm-datapower-operator-catalog.yaml
```
2. Install the DataPower operator on all namespaces using the Web Console.
  - Under the "Administrator" tab select "Operators" and then "OperatorHub".
  - In the search bar provided search for `datapower`.
  - Select "IBM DataPower GateWay".
  - Select "Install" and keep all defaults
    - Make sure you are installing on all namespaces  
3. Create a new project namespace to deploy your instance to using the CLI.
  - The namespace needs to be the name of your zip file then "-migration".
```
oc new-project <"zip-file-name"-migration>
```

### Instructions for deploying DataPower on OCS with GitOps

**Pre-reqs**

1. Clone the [multi-tenancy-gitops-apps](https://github.com/DataPower-on-Azure/multi-tenancy-gitops-apps) repo into the parent directory of where this repo is currently located on your local machine.
  - If you have already commited a zip file that you wish to use before cloning the above repo for the first time, please:
    - Move the zip file out of this repo's directory
    - Add & commit the changes
    - Rename the moved zip file
    - Move the renamed zip file back to this repo's directory
    - Add & commit the changes.
2. Login to the OpenShift Web Console.
  - Use the provided url, username and password from either the OpenShift installer, or an admin who holds the credentials.
3. Once logged in the the OpenShift Web Console, log in to the OpenShift CLI.
  - In the upper right corner of the OpenShift Web Console select the IAM user and click "Copy login command" in the drop down menu.
  - In the window that opens, copy the first CLI input and paste it into your CLI of choice.

**Instructions**

1. Add and commit a DataPower backup zip to this repository if you have not already done so.
2. Refer to the instructions in [multi-tenancy-gitops-apps](https://github.com/DataPower-on-Azure/multi-tenancy-gitops-apps)

## Debugging

### `must-gather.sh`

Use this script to gather all DataPower Operator related resources from your Kubernetes/OpenShift cluster.

For usage:

```
./must-gather.sh -h
```


Reference:

- [Guide: Domain configuration](https://ibm.github.io/datapower-operator-doc/guides/domain-configuration)
- [DataPowerService API docs](https://ibm.github.io/datapower-operator-doc/apis/datapowerservice/v1beta3)

