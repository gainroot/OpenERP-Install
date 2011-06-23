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
# Installs OpenERP 6.0.2 Server and PostgreSQL
# According to instructions found at:
# http://doc.openerp.com/v6.0/install/linux/postgres/index.html
# http://doc.openerp.com/v6.0/install/linux/server/index.html
#
# Tested with a default Ubuntu 10.04 LTS installation. (uname -rvmo)
# 2.6.32-28-generic-pae #55-Ubuntu SMP Mon Jan 10 22:34:08 UTC 2011 i686 GNU/Linux
# Your mileage may vary.
#
# Usage:
# ./install_openERP_server.sh
# --------
#
# When finished with this script, start OpenERP Server by typing "openerp-server" (no quotes)
# You may need/want to install OpenERP Client and/or OpenERP Web after installing OpenERP Server (this script)
# These and other installation scripts can be found at http://gainroot.co/solutions/openerp
#
# --------
# Below are some variables you can modify
INSTALL_DIR=~
#
# That's all, stop editing!
# ---------------------------------------------------------

# Installing PostgreSQL package
echo "************ Installing PostgreSQL package ************"
sudo apt-get -y install postgresql
# You might also need/want this
sudo apt-get -y install postgresql-client

# Installing PostgreSQL users
echo "************  Installing PostgreSQL users  ************"
sudo su -c "createuser --superuser openerp" postgres
# psql -l
sudo su -c "psql --command \"alter role openerp with password 'postgres';\"" postgres

# Inserting this information into the .openerp_serverrc file
echo "************ Seeding the .openerp_serverrc file  ************"
if [ ! -f ~/.openerp_serverrc ] ; then
    echo "Found existing \".openerp_serverrc\" file; backing up"
    cd ~
    mv .openerp_serverrc .openerp_serverrc_orig
    touch .openerp_serverrc
    chmod 600 .openerp_serverrc
    echo "[options]" >> .openerp_serverrc
    echo "db_user = openerp" >> .openerp_serverrc
    echo "db_password = postgres" >> .openerp_serverrc
    echo "db_host = localhost" >> .openerp_serverrc
fi

# Install required Python packages
echo "************   Installing Python packages  ************"
sudo apt-get -y install python-lxml
sudo apt-get -y install python-mako
sudo apt-get -y install python-egenix-mxdatetime
sudo apt-get -y install python-dateutil
sudo apt-get -y install python-psycopg2
sudo apt-get -y install python-pychart
sudo apt-get -y install python-pydot
sudo apt-get -y install python-tz
sudo apt-get -y install python-reportlab
sudo apt-get -y install python-yaml
sudo apt-get -y install python-vobject
# May not need this next one, but I did
sudo apt-get -y install python-setuptools

# Get and install OpenERP server
echo "************  Getting OpenERP Server 6.0.2 ************"
cd $INSTALL_DIR
wget http://www.openerp.com/download/stable/source/openerp-server-6.0.2.tar.gz
gzip -dc openerp-server-6.0.2.tar.gz | tar -xvf -
cd $INSTALL_DIR/openerp-server-6.0.2
echo "************   Installing OpenERP Server 6.0.2 ************"
sudo python setup.py install

echo "************ Done ************"
echo "type \"openerp-server\" to start OpenERP Server"

# Run the Server
# openerp-server