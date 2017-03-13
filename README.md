
## Prerequisites
 
 1. MacOS or linux with docker >= 1.11.2
 2. An environment variable called `WORKSPACE` that
 references the root of where this project has been cloned.
 In the future this will be enhanced to support multiple
 instances of this project for managing GCP separate clusters.

## Running the CLI for the first time

Upon first running the CLI the Google Cloud SDK will 
be initialized and the default authentication for `kubectl` 
will be created. This process requires two sets of permissions
to be approved. The CLI will pause each time and ask for the 
authentication code that will be given after visiting the 
presented URLs.

Configuration files will be placed in the current user's home
directory at `~/.config/gcloud`. All containers are run with the 
userid and groupid of the current user so permissions are set
properly.

## Running the CLI

To start the CLI run the shell script in the `cli` directory:

`./cli.sh`

## Creating a cluster

A cluster can be created as usual with a command like:

`gcloud container clusters create <cluster name> --num-nodes 1`

Once a cluster is created a `kubectl` config file will be available
in `~/.kube`. The `kubectl` command in this project is 
setup to automatically use this file.

## Kubernetes management

The `kubectl` command is configured to treat the `config` folder 
as the root of all kubernetes configurations. All configuration 
files for the cluster should be placed within this folder.

## Deleting a cluster

`gcloud container clusters delete <cluster name>`

## Resetting the cli environment

```
docker rm gcloud-config
rm -rf ~/.config/gcloud
```


