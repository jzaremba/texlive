#!/bin/bash

USER=${USER:-user}
USER_ID=${USER_ID:-9001}
GROUP_ID=${GROUP_ID:-9001}

echo "${USER}:x:${USER_ID}:${GROUP_ID}:Default User,,,:/home/${USER}:/bin/bash" >> /etc/passwd
echo "${USER}:x:${GROUP_ID}:" >> /etc/group
echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER}
chmod 0440 /etc/sudoers.d/${USER}
usermod -a -G users ${USER}

# Make sure PS1 is set correctly.
# Changing the prompt is useful, since if you map the network and user from the
# host, the default prompt will be the same inside and outside of the
# container.
# This check doesn't really need to be here, and is a bit aggressive, but
# easiest way to update PS1 for everyone who uses the image.
if [ -f /home/${USER}/.bashrc ]; then
	if grep dockerenv /home/${USER}/.bashrc >/dev/null 2>&1; then
	    :
	else
	    echo '# Change prompt if inside a docker container' >> /home/${USER}/.bashrc
	    echo 'if [ -f /.dockerenv ]; then PS1="\u@docker:\w\$ "; fi' >> /home/${USER}/.bashrc
	fi
fi

# Execute the real command
exec /usr/local/bin/gosu ${USER} "$@"
