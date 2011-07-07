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
# Version 0.9, 20110620
#
# Installs OpenERP 6.0.2 Client
# According to instructions found at:
# http://doc.openerp.com/v6.0/install/linux/client/index.html
#
# Tested with a default Ubuntu 10.04 LTS installation. (uname -rvmo)
# 2.6.32-28-generic-pae #55-Ubuntu SMP Mon Jan 10 22:34:08 UTC 2011 i686 GNU/Linux
# Your mileage may vary.
#
# Usage:
# ./install_openERP_client.sh
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
INSTALL_DIR=~
OPENERP_CLIENT_PACKAGE=/usr/local/lib/python2.6/dist-packages/openerp-client
PIXMAPS=/usr/share/pixmaps/openerp-client
SHARE=/usr/share/openerp-client
#
# That's all, stop editing!
# ---------------------------------------------------------

# Install required Python packages
echo "************ Installing Python packages ************"
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

# Get and install OpenERP Client
echo "************  Getting OpenERP Client 6.0.2  ************"
cd $INSTALL_DIR
wget http://www.openerp.com/download/stable/source/openerp-client-6.0.2.tar.gz
gzip -dc openerp-client-6.0.2.tar.gz | tar -xvf -
cd $INSTALL_DIR/openerp-client-6.0.2
sudo python setup.py install

# Cleaning up stuff that should be there but isn't
echo "************ Cleaning up stuff that should be there ************"
# Sometimes (always?) the egg doesn't discharge its contents
# Checks if file exists.
if ([ ! -d $OPENERP_CLIENT_PACKAGE ] || [ ! -h $OPENERP_CLIENT_PACKAGE ]); then
    echo "File \"$OPENERP_CLIENT_PACKAGE\" does not exist."
    echo "Linking . . ."
    sudo ln -s /usr/local/lib/python2.6/dist-packages/openerp_client-6.0.2-py2.6.egg/openerp-client $OPENERP_CLIENT_PACKAGE
fi

# Fix the "openerp-icon.png" issue
if ([ ! -d $PIXMAPS ] || [ ! -h $PIXMAPS ]); then
    echo "File \"$PIXMAPS\" does not exist."
    echo "Linking . . ."
    sudo ln -s /usr/local/lib/python2.6/dist-packages/openerp_client-6.0.2-py2.6.egg/share/pixmaps/openerp-client $PIXMAPS

fi
# Fix  issue
if ([ ! -d $SHARE ] || [ ! -h $SHARE ]); then
    echo "File \"$SHARE\" does not exist."
    echo "Linking . . ."
    sudo ln -s /usr/local/lib/python2.6/dist-packages/openerp_client-6.0.2-py2.6.egg/share/openerp-client $SHARE
fi
echo "************ Done ************"
echo "type \"openerp-client\" to start OpenERP Client"
echo "make sure you're in an X11 or windowing environment"
echo "one of the first things you'll want to do is create a database"
echo "File -> Databases -> New database"

# Run the Client
#openerp-client