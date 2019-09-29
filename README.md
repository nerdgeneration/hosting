# hosting
@author Mark Griffin <mark.griffin@linux.com>
@copyright nerdgeneration 2019

### What is this?

This is a simple (in features, not usability) multi-tenant hosting platform for "Amazon Linux 2". This exists because I'm annoyed with cPanel for their new pricing strategy.

**THIS IS CURRENTLY IN DEVELOPMENT - DO NOT USE**

### Install
1. Get an EC2 machine with "Amazon Linux 2"
2. `yum install git make`
2. `git clone https://github.com/nerdgeneration/hosting.git`
3. `cd hosting && make install`
4. `hosting setup`

### Host
1. `hosting add <username> <static|php|node|docker> <domain-name> [<domain-name>]`
2. Upload your content to `/home/<username>/public`
3. For Node or Docker, listen on the port you were assigned
4. `systemctl start hosting-<username>`

### Test
1. `make test`

### Contribute
Pull requests are welcomed. This is quite a complicated project and I'm happy for the help.
