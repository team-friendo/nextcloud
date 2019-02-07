# Nextcloud + OnlyOffice infra code

This repo contains the devops dust necessary to provision and deploy a nextcloud instance on eclips.is running onlyiffice. Most of the guts are in /roles/deploy/files.

# Dependencies

You need ansible and ansible playbook:

``` shell
$ sudo apt-add-repository --yes --update ppa:ansible/ansible
$ sudo apt-get install ansible
```

# Team Friendo Usage

**(1) Unlock and export secrets:**

``` shell
$ ./bin/load-secrets
```

Note: assumes you have [blackbox](https://github.com/StackExchange/blackbox) installed.

**(2) Get a machine:**

``` shell
$ ./bin/get-machine
```
Note: this will create an eclipsis droplet and write an inventory file to project root that includes the droplet's iIP. You can futz with default values in `get-machine` if you want different stuff.

**(3) Provision the machine and deploy nextcloud on it:**

``` shell
$ ansible-playbook -i inventory playbooks/main.yml
```
Note: the hardening step takes roughly 2 hours. It's last! You can do other stuff while it's running!

# Friendos Once Removed Usage

The above assumes that you are on the team that made this repo. But maybe you are not and still would like to use this code. YAAAYYY! We want that! Here's how...

**(1) Provide some secrets:**

You will need a file called `.env` located in the root directory of this repo that looks like the sample provided in `.env.example`, only with the values inside the {{ TEMPLATE STRINGS }} filled in with real values. Your values! (This file should be gitignored.)

Now load the secrets into your environment with:

``` shell
$ ./bin/load-secrets
```

**(2) Procure a server running debian:**

You might try MayFirst.org, GreenHost.org, 1984.is, your local colo, or Armagedon Web Services EC2000 instances (or whatever they're called). Once you have a server, find its IP address.

Now find the `inventory.example` file. Replace the `{{ IP ADDRESS OF YOUR REMOTE HOST }}` template string with the IP address of your server. Replace the other template strings with appropriate values and store the result in a file called `inventory` in the root directory of this repo.

You're almost ready to go!!!!!! (You're doing great so far. :))

**(3) Provision the machine and deploy nextcloud on it:**

``` shell
$ ansible-playbook -i inventory playbooks/main.yml
```

Note: this step consists of 4 playbooks: `provision`, `deploy`, `configure`, and `harden`. The last one, `harden`, takes roughly 2 hours to complete. Don't worry, you can still log into the box and use it while the hardening is running. You just probably want to keep your computer open to monitor the playbook and make sure it completes successfully, so keep that in mind when you start.

## Notes

@ziggy the following to setup encryption but it failed due to permission errors.

(docker + apache + encfs + eclipis clusterfuck.)

``` sh
sudo apt install encfs
sudo mkdir -p /srv/nextcloud /srv/nextcloud/data /srv/nextcloud/.encrypted
sudo encfs /srv/nextcloud/.encrypted /srv/nextcloud/data
# (enter password)

chown -R www-data:root /srv/nextcloud/data
```
