cat <<EOF >> /etc/apt/sources.list.d/openmediavault.list
deb https://packages.openmediavault.org/public usul main
EOF

apt-get install wget curl gnupg2

export LANG=C.UTF-8
export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=none

wget -O "/etc/apt/trusted.gpg.d/openmediavault-archive-keyring.asc" https://packages.openmediavault.org/public/archive.key
apt-key add "/etc/apt/trusted.gpg.d/openmediavault-archive-keyring.asc"

apt-get update -y
apt-get upgrade -y

apt-get --yes --auto-remove --show-upgraded --allow-downgrades --allow-change-held-packages --no-install-recommends --option Dpkg::Options::="--force-confdef" --option DPkg::Options::="--force-confold" --allow-unauthenticated install postfix openmediavault

omv-confdbadm populate

dpkg -i openmediavault-omvextrasorg_latest_all5.deb

# Docker & Jellyfin http://loonlog.com/tag/omv/
