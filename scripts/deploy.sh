eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 .travis/id_rsa # Allow read access to the private key
ssh-add .travis/id_rsa # Add the private key to SSH

git config --global push.default matching
git remote add deploy ssh://agent@$IP:$PORT$DEPLOY_DIR
git push deploy master

# Skip this command if you don't need to execute any additional commands after deploying.
ssh agent@$IP -p $PORT <<EOF
  echo DEPLOY_DIR
  cd $DEPLOY_DIR
  pm2 restart shop
EOF