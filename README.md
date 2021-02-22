# Running a Qortal Node on DigitalOcean

[Qortal](https://qortal.org) is a blockchain network that is designed to help create a more distributed internet. It does have a coin that is created via minting rather using a Proof of Work system like BitCoin.

This repository helps set up a cloud server on DigitalOcean for running the qortal "core" server. Qortal Core is how someone is able to participate in the network and mint coin if desired.

## Getting Started

The essence of the setup is in the `qortal_bootstrap.sh`. This script handles the following:

1. Ensures the system has a working Java runtime for running Qortal Core.
1. Downloads Qortal Core
1. Downloads a bootstrap file (this helps the Qortal Core get synced with the rest of the network much faster).
1. Creates a `qortal` user.

The script will put all the necessary files in `/opt/qortal`.

You can create a droplet via the DigitalOcean control panel and add this script to get set up. You just need to copy the file to your server, make it executable and run it.

```
# To copy the script replace $SERVER_IP with your servers IP address.
$ scp qortal_bootstrap.sh root@$SERVER_IP
```

Once the script is on the server, you can run it.

```
# ssh to your server and run these commands
$ chmod +x qortal_bootstrap.sh
$ ./qortal_bootstrap.sh
```

When the script is done, you'll have Qortal Core running. You can look at the logs by ssh'ing to your server and running:

```
$ tail -f /opt/qortal/log.txt.1
```

### Using Terraform

You can use [Terraform](https://www.terraform.io/) to automate spinning up the cloud server and running the `qortal_bootstrap.sh`. Once you install Terraform you can get started by running:

```
$ terraform init
```

That ensures you have the DigitalOcean provider so you can create a VM (Droplet).

```
$ terraform apply
```

This will prompt you for two values.

1. do_token - This is your API token you can create in the DigitalOcean Admin Panel
2. pvt_key - The path to your ssh key that would be used to log into your Droplet.

Currently this assumes you have a ssh key called `main` you've added to your account. You can edit `provider.tf` and change the respective `digitalocean_ssh_key` settings.

When it is finished you should have a Droplet up with Qortal Core running. You can ssh into the Droplet and verify things are running as expected.
