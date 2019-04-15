#!/usr/bin/env bash

function set_password() {
  local password="$1"

  echo "root:$password" | chpasswd
  echo "root login password: $password"

  # Make the password accessible for root
  echo "$password" > /root/.password
  chmod 400 /root/.password
}

# Setup up SSH key
if [[ -n "${SSH_PUBLIC_KEY:-}" ]]; then
  echo "${SSH_PUBLIC_KEY}" > /root/.ssh/authorized_keys
elif [[ -n "${SSH_PUBLIC_KEY_FILE:-}" ]]; then
  cat $SSH_PUBLIC_KEY_FILE > /root/.ssh/authorized_keys
elif [[ -n "${ROOT_PASSWORD:-}" ]]; then
  set_password "${ROOT_PASSWORD}"
else
  set_password "$( pwgen -c -n -1 12 )"
fi
