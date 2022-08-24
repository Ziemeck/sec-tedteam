#!/bin/bash

# Globalne zmienne
SPLUNK_URL="wget -q -O splunk-9.0.1-82c987350fde-linux-2.6-amd64.deb "https://download.splunk.com/products/splunk/releases/9.0.1/linux/splunk-9.0.1-82c987350fde-linux-2.6-amd64.deb""
SPLUNK_PKG=`echo $SPLUNK_URL | cut -d " " -f4`

# Funkcje


function f_msg() {
	echo "### $1 = $2"
}

# Sprawdzanie distro
function f_check_distro() {
	if [ -f /etc/os-release ]; then
	. /etc/os-release
		if [[ "$ID_LIKE" =~ .*debian.* ]]; then
			distro_id=1
		else
			distro_id=0
		fi
	return $distro_id
	fi
}

# Pobieranie
function f_wget_splunk() {
	f_msg "INFO" "Pobieram paczke: $SPLUNK_PKG"
	$SPLUNK_URL
	f_msg "INFO" "Pobieranie ukonczone"
}

# Instalacja
function f_install_splunk() {
	if [ f_check_distro == 0 ]; then
		rpm -i $1
	else 
		dpkg -i $1
	fi
}

# Po instalacji ==================

# ulimits


# Main
if [ f_check_distro == 1 ]; then
		f_msg "DISTRO" "debian"
	else 
		f_msg "DISTRO" "redhat"
	fi

f_wget_splunk
f_install_splunk($SPLUNK_PKG)