# Compile remotely for an armv8 architecture with Android and Ansible

[download termux](https://docs.andronix.app/termux/migrating-to-f-droid#manual-method)

## Issue

We encourage you to contribute by submitting issues on GitHub. Your involvement will help us progress and evolve.

## Requirement

init termux: 
```bash
termux-change-repo #choose github link error pkg update
```

Termux: 
```bash
pkg update
pkg install python3 termux-auth openssh
```

## Introduction

Android is a Linux subsystem. We're going to using OpenSSH to start by generating encryption keys. I am creating an interface to integrate our Automation Server and our target (android/linux/armv8) into the network. This new network created and isolated from the internet allows the two devices to exchange secrets. So I retrieve the public encryption key from my smartphone and send it to the Server. I generate a password for my termux user using the `termux-auth` packet, I try to connect using ssh, ... SUCCESS

## Open ssh server

```bash
sshd #running on port 8022
```

## Complete inventory.yml

Configure SSH on Termux (Android):

1. generate ssh key:
```bash
ssh-keygen -o -t rsa -C "your@email.com" # replace by your email
# Two files are generated: your private key (your_key) and your public key (your_key.pub). By default, these keys are typically stored in the following location: ~/.ssh, unless you specify a different path.
```

2. active ssh:
```bash
eval $(ssh-agent -s)
ssh-add your_key # add private key
```

2. cat pubkey: 
```bash
cat $(pwd)/your_key.pub
# Copy pub key. You will need to add the public key to the Git server (Gitlab, Github, Bitbucket, ...)
# Gitlab: Home > navbar on the left > your user icon in top-right > Preference > SSH Keys
```

3. generate a password to connect on ssh via termux-auth
```bash
passwd # tap your password
```

On ure automation server

```bash
ssh-copy-id -p 8022 anyuser@your_android_ip
# You can now run ansible whenever you want
```

# Run Ansible Script

```bash
ansible-playbook playbook.yml -i inventory.yml
```
