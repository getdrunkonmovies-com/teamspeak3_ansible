# teamspeak3_ansible
Ansible Playbook(s) to manage a teamspeak3 server instance running under Ubuntu 18.04 and Docker.

## Used Software

- This (set of) playbooks requires [geerlingguy.docker](https://github.com/geerlingguy/ansible-role-docker) - tested with version 2.5.1.
- The Dockerfile is from [icedream's docker image repository](https://github.com/icedream/docker-ts3server)

## Usage

### Setup Inventory

1. Go to `inventories/teamspeak3/hosts.yml` and adjust the ips of the host according to your requirements.
2. Put your root ssh key under `ssh_keys/root_rsa`.

### Install requiements

0. Install ansible. Tested with 2.8.5: `pip3 install --user ansible==2.8.5`
1. Run `ansible-galaxy install -r requirements.yml` to install all required roles.

### Run base setup

0. remove existing ssh keys of you machines into your known hosts (**only run this if you have rebuilt your machines and the ssh key has changed**):

    For each relevant node run:

    ```bash
    mkdir -p ~/.ssh/ && ssh-keygen -f ~/.ssh/known_hosts <ip>
    ```

1. put the ssh keys of your machines into your known hosts:

    For each node run:

    ```bash
    mkdir -p ~/.ssh/ && ssh-keyscan <ip> >> ~/.ssh/known_hosts
    ```
    
2. Copy your ssh key to the server (**if you only have a password**):

    ```bash
    ssh-copy-id -i ~/ssh_keys/root_rsa root@<ip>
    ```

3. Run the actual base_setup playbook

    ```bash
    ansible-playbook -i inventories/teamspeak3/hosts.yml base_setup.yml
    ```

### Run the actual setup

```bash
ansible-playbook -i inventories/teamspeak3/hosts.yml teamspeak3_servers.yml
```

On a new setup, you can get the privilege key from the docker logs via `docker logs teamspeak3_master`

### Upgrading

1. Globally replace all Teamspeak3 server version strings in this repository with the newest version
2. Replace the SHA hash of the Teamspeak3 server to the one from https://www.teamspeak.com/de/downloads/#server
3. Simply run the actual setup again

### Backup:

```bash
cd backups
bash manual_backup.sh <your-ip> root
```
