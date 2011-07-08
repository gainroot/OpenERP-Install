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
# From http://gainroot.co/solutions/openerp
# Written by Jeffrey Gifford
#
# Version 0.92, 20110707
#
# Installs OpenERP 6.0.2 Client
# According to instructions found at:
# http://doc.openerp.com/v6.0/install/linux/client/index.html
#
# Tested with a default Ubuntu 10.04 LTS installation. (uname -rvmo)
# 2.6.32-28-generic-pae #55-Ubuntu SMP Mon Jan 10 22:34:08 UTC 2011 i686 GNU/Linux
# Your mileage may vary.
#
# Called by ./OpenERP-Install/install.sh client
# Usage:
# ./OpenERP-Install/openERP/client.sh
# --------
#
# You may need/want to install OpenERP Server before installing OpenERP Web (this script)
# When finished with this script, start OpenERP Client by typing "openerp-client" (no quotes)
# You may need X11 or a suitable windowing system to accomplish this.
#
# You may need/want to install OpenERP Web after installing OpenERP Client (this script)
# These and other installation scripts can be found at http://gainroot.co/solutions/openerp
#
# --------
# Below are some variables you can modify
STAGING_DIR=~
LOGFILE=~/openERP_client_install.log
OPENERP_CLIENT_PACKAGE=/usr/local/lib/python2.6/dist-packages/openerp-client
PIXMAPS=/usr/share/pixmaps/openerp-client
SHARE=/usr/share/openerp-client
#
# That's all, stop editing!
# ---------------------------------------------------------

# Install required Python packages
echo "************ Installing Python packages *************" | tee -a $LOGFILE
{
sudo apt-get -y install python-gtk2
sudo apt-get -y install python-glade2
sudo apt-get -y install python-matplotlib
sudo apt-get -y install python-egenix-mxdatetime
sudo apt-get -y install python-xml
sudo apt-get -y install python-tz
sudo apt-get -y install python-hippocanvas
sudo apt-get -y install python-pydot
#
sudo apt-get -y install python-setuptools
} >> $LOGFILE 2>&1

# Get and install OpenERP Client
echo "************  Getting OpenERP Client 6.0.2  *********" | tee -a $LOGFILE
{
cd $STAGING_DIR
wget http://www.openerp.com/download/stable/source/openerp-client-6.0.2.tar.gz
gzip -dc openerp-client-6.0.2.tar.gz | tar -xvf -
cd $STAGING_DIR/openerp-client-6.0.2
sudo python setup.py install
} >> $LOGFILE 2>&1

# Cleaning up stuff that should be there but isn't
echo "****** Cleaning up stuff that should be there *******" | tee -a $LOGFILE
# Sometimes (always?) the egg doesn't discharge its contents
# Checks if file exists.
if ([ ! -d $OPENERP_CLIENT_PACKAGE ] || [ ! -h $OPENERP_CLIENT_PACKAGE ]); then
    echo "File \"$OPENERP_CLIENT_PACKAGE\" does not exist." | tee -a $LOGFILE
    echo "Linking . . ." | tee -a $LOGFILE
    sudo ln -s /usr/local/lib/python2.6/dist-packages/openerp_client-6.0.2-py2.6.egg/openerp-client $OPENERP_CLIENT_PACKAGE >> $LOGFILE 2>&1
fi

# Fix the "openerp-icon.png" issue
if ([ ! -d $PIXMAPS ] || [ ! -h $PIXMAPS ]); then
    echo "File \"$PIXMAPS\" does not exist." | tee -a $LOGFILE
    echo "Linking . . ." | tee -a $LOGFILE
    sudo ln -s /usr/local/lib/python2.6/dist-packages/openerp_client-6.0.2-py2.6.egg/share/pixmaps/openerp-client $PIXMAPS >> $LOGFILE 2>&1

fi
# Fix  issue
if ([ ! -d $SHARE ] || [ ! -h $SHARE ]); then
    echo "File \"$SHARE\" does not exist." | tee -a $LOGFILE
    echo "Linking . . ." | tee -a $LOGFILE
    sudo ln -s /usr/local/lib/python2.6/dist-packages/openerp_client-6.0.2-py2.6.egg/share/openerp-client $SHARE >> $LOGFILE 2>&1
fi
echo "************************ Done ***********************" | tee -a $LOGFILE
echo "type \"openerp-client\" to start OpenERP Client" | tee -a $LOGFILE
echo "make sure you're in an X11 or windowing environment" | tee -a $LOGFILE
echo "one of the first things you'll want to do is create a database" | tee -a $LOGFILE
echo "File -> Databases -> New database" | tee -a $LOGFILE

# Run the Client
#openerp-client