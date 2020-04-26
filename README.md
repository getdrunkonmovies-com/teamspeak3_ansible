# teamspeak3_ansible
Ansible Playbook(s) to manage a teamspeak3 server instance running under Ubuntu 18.04 and Docker.

## Used Software

- This (set of) playbooks requires geerlingguy.docker [geerlingguy's work](https://github.com/geerlingguy/ansible-role-docker) - tested with version 2.5.1.
- The Dockerfile is from [icedream's docker image repository](https://github.com/icedream/docker-ts3server)

## Usage

### Setup Inventory

1. Go to `inventories/teamspeak3/hosts.yml` and adjust the ips of the host according to your requirements.
2. Put your root ssh key under `ssh_keys/root_rsa`.

### Install requiements

1. Run `ansible-galaxy install -r requirements.yml` to install all required roles.

### Run base setup

0. remove existing ssh keys of you machines into your known hosts (only run this if you have rebuilt your machines and the ssh key has changed):

    For each relevant node run:

    ```bash
    ssh-keygen -f ~/.ssh/known_hosts <ip>
    ```

1. put the ssh keys of your machines into your known hosts:

    For each node run:

    ```bash
    ssh-keyscan <ip> >> ~/.ssh/known_hosts
    ```

2. Run the actual base_setup playbook

    ```bash
    ansible-playbook -i inventories/teamspeak3/hosts.yml base_setup.yml
    ```

### Run the actual setup

```bash
ansible-playbook -i inventories/teamspeak3/hosts.yml teamspeak3_servers.yml
```

### Backup:

```bash
cd backups
bash manual_backup.sh <your-ip> root
```