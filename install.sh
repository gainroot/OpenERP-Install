#!/bin/bash

# --------
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# --------
#
# Author: http://Gainroot.co and J Gifford
# Acknowledgement is given to J Lynch, 
#
# Version 0.92, 20110708
#
# Tested with a default Ubuntu 10.04 LTS installation. (uname -rvmo)
# 2.6.32-28-generic-pae #55-Ubuntu SMP Mon Jan 10 22:34:08 UTC 2011 i686 GNU/Linux
# Your mileage may vary.
#
# Usage: ./install.sh {server|client|web}
#
# Installs OpenERP Server, Client and/or Web on a Ubuntu or Ubuntu-like system.
#
# The installation resulting from these files would be good for a demo or
# proof-of-concept environment but would not be recommended for production.
#

# See README for more details
#

# ---------------------------------------------------------
# Below are some variables you can modify
SCRIPTNAME=$0
BASE=`dirname $SCRIPTNAME`
CONFIGFILE=$BASE/init-files/openerp-server.cfg
CONFIGDEST=/etc/openerp-server.cfg
SERVERINIT=openerp-server
WEBINIT=openerp-web
INITFILES=$BASE/init-files
#DEBUG="true"
USER=openerp
# That's all, stop editing!
# ---------------------------------------------------------

[ -n "$DEBUG" ] && echo "BASE=$BASE"
[ -n "$DEBUG" ] && echo `ls -l $BASE/init-files/openerp-server`

case "$1" in
  server)
	# Install OpenERP Server
	$BASE/openERP/server.sh

	# try to create USER, exit if fails
	/usr/bin/id $USER >/dev/null 2>&1
	RETVAL=$?
	if [ $RETVAL -ne 0 ]; then
	    echo "User $USER doesn't exist, creating . . ."
	    sudo adduser --system --group $USER
	    RETVAL=$?
	    if [ $RETVAL -ne 0]; then
		echo "User $USER failed to create, exiting . . ."
		exit 1
	    fi
	fi

	# Install config file
	sudo install -b -c -g $USER -m 640 -o root $CONFIGFILE $CONFIGDEST
	RETVAL=$?
	if [ $RETVAL -ne 0 ]; then
	    echo "Failed to install config file"
	fi

	# Install openerp-server init file
	sudo install -b -c -g root -m 755 -o root $INITFILES/$SERVERINIT /etc/init.d/$SERVERINIT
	RETVAL=$?
	if [ $RETVAL -ne 0 ]; then
	    echo "Failed to install openerp-server init file"
	fi

	# Propagate openerp-server init file into correct RC levels
	sudo update-rc.d openerp-server defaults
	RETVAL=$?
	if [ $RETVAL -ne 0 ]; then
	    echo "Failed to propagate openerp-server init file"
	fi
	echo "Done. Please check above messages for errors."
	;;
  client)
	# Install OpenERP Client
	$BASE/openERP/client.sh

	echo "Done. Please check above messages for errors."
	;;
  web)
	# Install
	# Install OpenERP Web
	$BASE/openERP/web.sh

	# try to create USER, exit if fails
	/usr/bin/id $USER >/dev/null 2>&1
	RETVAL=$?
	if [ $RETVAL -ne 0 ]; then
	    echo "User $USER doesn't exist, creating . . ."
	    sudo adduser --system --group $USER
	    RETVAL=$?
	    if [ $RETVAL -ne 0]; then
		echo "User $USER failed to create, exiting . . ."
		exit 1
	    fi
	fi

	# Install openerp-web init file
	sudo install -b -c -g root -m 755 -o root $INITFILES/$WEBINIT /etc/init.d/$WEBINIT
	RETVAL=$?
	if [ $RETVAL -ne 0 ]; then
	    echo "Failed to install openerp-web init file"
	fi

	# Propagate openerp-web init file into correct RC levels
	sudo update-rc.d openerp-web defaults
	RETVAL=$?
	if [ $RETVAL -ne 0 ]; then
	    echo "Failed to propagate openerp-web init file"
	fi
	echo "Done. Please check above messages for errors."
	;;
  *)
	echo "Usage: $SCRIPTNAME {server|client|web}" >&2
	echo "Installs OpenERP Server, Client or Web" >&2
	exit 3
	;;
esac
