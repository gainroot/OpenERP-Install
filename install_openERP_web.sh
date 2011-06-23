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
# Version 0.9, 20110621
#
# Installs OpenERP 6.0.2 Web
# According to instructions found at:
# http://doc.openerp.com/v6.0/install/linux/web/index.html
#
# Tested with a default Ubuntu 10.04 LTS installation. (uname -rvmo)
# 2.6.32-28-generic-pae #55-Ubuntu SMP Mon Jan 10 22:34:08 UTC 2011 i686 GNU/Linux
# Your mileage may vary.
#
# Usage:
# ./install_openERP_web.sh
#
# You may need/want to install OpenERP Server before installing OpenERP Web (this script)
# When finished with this script, start OpenERP Web by typing "openerp-web" (no quotes)
# Point your browser to http://SERVERNAME:8080
# where SERVERNAME is the name of the server 
#
# --------
# Below are some variables you can modify
INSTALL_DIR=~
#
# That's all, stop editing!
# ---------------------------------------------------------

# Install required Python packages
echo "************ Installing Python packages ************"
sudo apt-get -y install python python-dev build-essential
sudo apt-get -y install python-cherrypy
sudo apt-get -y install python-setuptools

# Get and install OpenERP Web
echo "************  Getting OpenERP Web 6.0.2  ************"
cd $INSTALL_DIR
wget http://www.openerp.com/download/stable/source/openerp-web-6.0.2.tar.gz
gzip -dc openerp-web-6.0.2.tar.gz | tar -xvf -
##
## Perhaps this next step (populate.sh) isn't necessary?
##
echo "************   Installing Dependencies    ************"
# Checks if file exists.
if [ ! -d $INSTALL_DIR/openerp-web-6.0.2/lib ] ; then
    echo "Directory \"$INSTALL_DIR/openerp-web-6.0.2/lib\" does not exist."
    echo "Creating . . ."
    sudo mkdir $INSTALL_DIR/openerp-web-6.0.2/lib
fi
cd $INSTALL_DIR/openerp-web-6.0.2/lib
if [ ! -f $INSTALL_DIR/openerp-web-6.0.2/lib/populate.sh ] ; then
    echo "file \"$INSTALL_DIR/openerp-web-6.0.2/lib/populate.sh\" does not exist."
    echo "Downloading . . ."
    sudo wget http://bazaar.launchpad.net/~openerp/openobject-client-web/6.0/download/head:/populate.sh-20090420111152-vkdawd3ki04ekrac-2/populate.sh
    sudo chmod 755 ./populate.sh
fi
echo "************ Running ./populate.sh ******************"
sudo ./populate.sh
##
## Seems like we have to run this next step twice....
##
echo "************ Installing OpenERP Web 6.0.2 ************"
cd $INSTALL_DIR/openerp-web-6.0.2
sudo python setup.py install

echo "************ Done ************"
echo "type \"openerp-web\" to start OpenERP Web"
echo "point your browser to \"http://SERVERNAME:8080\""
echo "where SERVERNAME is the network name (or IP address) of this host"

# Run OpenERP Web
# openerp-web