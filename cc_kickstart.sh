#!/bin/bash

# Fix locale:
echo 'export LC_ALL="en_US.UTF-8"' >> ~/.bashrc

# Fix SSH lag:
sudo sed -i -e 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Install necessary packages:
sudo yum -y update
sudo yum -y install epel-release
sudo yum -y install htop iotop screen mosh tmux pdsh nmap nmon glances psmisc
sudo yum -y groupinstall "Development Tools"

# Set .inputrc:
cat <<'EOF' > ~/.inputrc
"\e[A": history-search-backward
"\e[B": history-search-forward
"\e[C": forward-char
"\e[D": backward-char
EOF

# Set .screenrc:
cat <<'EOF' > ~/.screenrc
log on
termcapinfo xterm* ti@:te@
EOF

# Fix screen windows' names:
cat <<'EOF' >> ~/.bashrc

# Prevent bash from overwriting your screen windows names:
if [[ "$TERM" =~ screen* ]]; then
    unset PROMPT_COMMAND
fi
EOF

# Install Linköping's tools:
sudo yum -y install python-devel python3-devel fping
wget https://www.nsc.liu.se/~kent/python-hostlist/python-hostlist-1.20.tar.gz
rpmbuild -tb python-hostlist-1.20.tar.gz
sudo yum -y localinstall ~/rpmbuild/RPMS/noarch/python2-hostlist-1.20-1.el7.noarch.rpm
sudo yum -y localinstall ~/rpmbuild/RPMS/noarch/python3-hostlist-1.20-1.el7.noarch.rpm
wget https://www.nsc.liu.se/~kent/coping/coping-2.1.tar.gz
rpmbuild -tb coping-2.1.tar.gz
sudo yum -y localinstall ~/rpmbuild/RPMS/noarch/coping-2.1-1.el7.noarch.rpm

# Install HPC tools:
sudo yum -y install numactl
# Likwid:
mkdir likwid
cd likwid
wget http://ftp.fau.de/pub/likwid/likwid-stable.tar.gz
tar xfz likwid-stable.tar.gz
cp likwid-5.0.1/packaging/rpm/likwid.xpm .
wget http://ftp.fau.de/pub/likwid/likwid-5.0.0.tar.gz
sudo yum -y install lua-devel
rpmbuild -tb likwid-stable.tar.gz
sudo yum -y localinstall ~/rpmbuild/RPMS/x86_64/likwid-*.rpm

# Spack?:
# https://github.com/mkiernan/azure-spack
