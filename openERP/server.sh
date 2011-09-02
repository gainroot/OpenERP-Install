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
# Written by J Gifford
#
# Version 0.93, 20110902
#
# Installs OpenERP 6.0.3 Server and PostgreSQL
# According to instructions found at:
# http://doc.openerp.com/v6.0/install/linux/postgres/index.html
# http://doc.openerp.com/v6.0/install/linux/server/index.html
#
# Tested with a default Ubuntu 10.04 LTS installation. (uname -rvmo)
# 2.6.32-28-generic-pae #55-Ubuntu SMP Mon Jan 10 22:34:08 UTC 2011 i686 GNU/Linux
# Your mileage may vary.
#
# Called by ./OpenERP-Install/install.sh server
# Usage:
# ./OpenERP-Install/openERP/server.sh
# --------
#
# When finished with this script, start OpenERP Server by typing "openerp-server" (no quotes)
# You may need/want to install OpenERP Client and/or OpenERP Web after installing OpenERP Server (this script)
# These and other installation scripts can be found at http://gainroot.co/solutions/openerp
#
# --------
# Below are some variables you can modify
STAGING_DIR=~
LOGFILE=~/openERP_server_install.log
#
# That's all, stop editing!
# ---------------------------------------------------------

# Installing PostgreSQL package
echo "************ Installing PostgreSQL package **********" | tee -a $LOGFILE
{
sudo apt-get -y install postgresql
# You might also need/want this
sudo apt-get -y install postgresql-client
} >> $LOGFILE 2>&1

# Installing PostgreSQL users
echo "************  Installing PostgreSQL users  **********" | tee -a $LOGFILE
sudo su -c "createuser --superuser openerp" postgres >> $LOGFILE
sudo su -c "psql --command \"alter role openerp with password 'postgres';\"" postgres >> $LOGFILE

# Inserting this information into the .openerp_serverrc file
echo "********* Seeding the .openerp_serverrc file ********" | tee -a $LOGFILE
if [ -f ~/.openerp_serverrc ] ; then
    {
    echo "Found existing \".openerp_serverrc\" file; backing up" | tee -a $LOGFILE
    cd ~
    mv .openerp_serverrc .openerp_serverrc_orig
    } >> $LOGFILE 2>&1
else
    {
    echo "No \".openerp_serverrc\" file found; making one" | tee -a $LOGFILE
    cd ~
    touch .openerp_serverrc
    chmod 600 .openerp_serverrc
    echo "[options]" >> .openerp_serverrc
    echo "db_user = openerp" >> .openerp_serverrc
    echo "db_password = postgres" >> .openerp_serverrc
    echo "db_host = localhost" >> .openerp_serverrc
    } >> $LOGFILE 2>&1
fi

# Install required Python packages
echo "************   Installing Python packages  **********" | tee -a $LOGFILE
{
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
} >> $LOGFILE 2>&1

# Get and install OpenERP server
echo "************  Getting OpenERP Server 6.0.3 **********" | tee -a $LOGFILE
{
cd $STAGING_DIR
wget http://www.openerp.com/download/stable/source/openerp-server-6.0.3.tar.gz
gzip -dc openerp-server-6.0.3.tar.gz | tar -xvf -
cd $STAGING_DIR/openerp-server-6.0.3
} >> $LOGFILE 2>&1

echo "********** Installing OpenERP Server 6.0.3 **********" | tee -a $LOGFILE
sudo python setup.py install >> $LOGFILE 2>&1

echo "************************ Done ***********************" | tee -a $LOGFILE
echo "type \"openerp-server\" to manually start OpenERP Server" | tee -a $LOGFILE

# Run the Server
# openerp-server