#!/bin/bash

set -eu

# Set up ssh key
echo "$INPUT_SSH_PRIVATEKEY" > id_ssh
chmod 600 id_ssh

# Set up client authorization
if [[ -n "$INPUT_ONION_CLIENT_AUTH_PRIVATEKEY" ]]; then
  authdir=/var/lib/tor/onion_auth
  echo "ClientOnionAuthDir $authdir" >> /etc/tor/torrc
  mkdir -p $authdir
  echo "$INPUT_ONION_HOST:descriptor:x25519:$INPUT_ONION_CLIENT_AUTH_PRIVATEKEY" \
    > $authdir/key.auth_private
  chown -R debian-tor $authdir
fi

# Start Tor
service tor start

# Actual file synchronisation
destination="$INPUT_SSH_USER@$INPUT_ONION_HOST.onion:$INPUT_DESTINATION_DIR"
torsocks rsync -rlptvz -e 'ssh -i id_ssh -o "StrictHostKeyChecking=accept-new"' --delete "$INPUT_SOURCE_DIR" "$destination"
