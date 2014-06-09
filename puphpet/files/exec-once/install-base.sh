#!/bin/bash

NODE_VERSION="v0.10.28"
PROJECT_ROOT="/var/rialto-parse"

SANDBOX_APP_NAME='rialto-parse'
SANDBOX_APP_URL='https://mobjob-russell.parseapp.com'
SANDBOX_APP_ID='UkSc8stjdF1ZZCNWkiQHFVVjQb4qH1YL4ZwKL0u7'
SANDBOX_MASTER_KEY='WKlmbHPOUrzYxU9BCoKmNLAEuyB3AxkUkKxAELDY'
SANDBOX_JS_KEY='301A9ruPpL01Dh4mTBVyRvT1w5oHLrtGigT8vpSW'
SANDBOX_REST_KEY='3GywSAu1bVFzzmzVL6441H9r96om37tUXvmF1fBM'
SANDBOX_CLIENT_KEY='IrWc8zEPng6SHiY3tJvBJJR4VI4pWhhpqzhs59KO'
SANDBOX_ADMIN_PASSWORD='P@ssw0rd'
SANDBOX_ADMIN_EMAIL='sgtpooki@gmail.com'
SANDBOX_HEROKU_APP='mobjob-russell'


#install rvm
curl -sSL https://get.rvm.io | sudo -u vagrant bash -s $1

source /home/vagrant/.rvm/scripts/rvm

rvm use --install 2.1.2
rvm alias create default 2.1.2
rvm use 2.1.2

#install gems
#gem install compass


#install nvm
wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sudo -u vagrant sh

#Ensure ENV vars are loaded
find /home/vagrant/.bash_profile -type f -exec sed -i 's/-e//g' {} \;
source /home/vagrant/.bash_profile

nvm install $NODE_VERSION
nvm use $NODE_VERSION
nvm alias default $NODE_VERSION
echo nvm use $NODE_VERSION >> ~/.bash_profile

#install node packages
npm install -g grunt-cli
cd $PROJECT_ROOT
npm install
bundle install



#install heroku
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

#cache login authentication with heroku
expect /var/vagrant/heroku_auto_login.exp
heroku keys:add ~/.ssh/id_rsa.pub

cp "$PROJECT_ROOT/etc/write-configs.conf.example" "$PROJECT_ROOT/etc/write-configs.conf"
sed -i "s/'Example-App'/'$SANDBOX_APP_NAME'/g" "$PROJECT_ROOT/etc/write-configs.conf"
sed -i "s/'https://example-app.parseapp.com'/'$SANDBOX_APP_URL'/g" "$PROJECT_ROOT/etc/write-configs.conf"
sed -i "s/'APP_ID'/'$SANDBOX_APP_ID'/g" "$PROJECT_ROOT/etc/write-configs.conf"
sed -i "s/'MASTER_KEY'/'$SANDBOX_MASTER_KEY'/g" "$PROJECT_ROOT/etc/write-configs.conf"
sed -i "s/'JS_KEY'/'$SANDBOX_JS_KEY'/g" "$PROJECT_ROOT/etc/write-configs.conf"
sed -i "s/'REST_KEY'/'$SANDBOX_REST_KEY'/g" "$PROJECT_ROOT/etc/write-configs.conf"
sed -i "s/'CLIENT_KEY'/'$SANDBOX_CLIENT_KEY'/g" "$PROJECT_ROOT/etc/write-configs.conf"
sed -i "s/'example'/'$SANDBOX_ADMIN_PASSWORD'/g" "$PROJECT_ROOT/etc/write-configs.conf"
sed -i "s/'you@example.com'/'$SANDBOX_ADMIN_EMAIL'/g" "$PROJECT_ROOT/etc/write-configs.conf"
sed -i "s/'HEROKU_APP_NAME'/'$SANDBOX_HEROKU_APP'/g" "$PROJECT_ROOT/etc/write-configs.conf"
