rialto-parse-vagrant
====================

The vagrant setup to start up a rialto-parse environment in a VM using virtualbox


1. make sure you have a key pair id_rsa and id_rsa.pub that is added to both your github and your heroku account. This key will be copied to the VM and used for authentication to the virtual machine, and also to github and heroku from the vm.
2. Update the shared_ssh['host']['dir'] section of puphpet/config.yaml to point to the directory containing your id_rsa key pair.
3. Update the puphpet/files/exec-once/install-base.sh with the correct NODE_VERSION, PROJECT_ROOT, and SANDBOX_VARS.
4. Copy heroku_auto_login.exp-dist to heroku_auto_login.exp and update HEROKU_EMAIL and HEROKU_PASS to reflect your correct heroku credentials.
5. There will be a section in the puphpet/puppet/manifest.pp file that has the git information for the main repo, be sure you set the source property to your repo.
6. vagrant up
7. set up your IDE to access the VM at 192.168.56.101, or type vagrant ssh to ssh into the VM.
8. You will need to update the /var/rialto-parse/etc/write-configs.conf file with the correct KISSMETRICS, DENIZEN, and ZENDESK api keys.
9. It is at this point you can run the bin/build commands.
