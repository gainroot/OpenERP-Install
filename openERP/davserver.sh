#!/bin/sh
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
# Version 0.90, 20110906
#
# Installs OpenERP 6.0.3 Server and PostgreSQL
# According to instructions found at:
# http://www.openerp.com/forum/topic22147.html
#
# Tested with a default Ubuntu 10.04 LTS installation. (uname -rvmo)
# 2.6.32-28-generic-pae #55-Ubuntu SMP Mon Jan 10 22:34:08 UTC 2011 i686 GNU/Linux
# Your mileage may vary.
#
# Called by ./OpenERP-Install/install.sh davserver
# Usage:
# ./OpenERP-Install/openERP/davserver.sh
# --------
#
# When finished with this script, start Python WebDAV "/usr/bin/davserver -D /tmp -n -J &" (no quotes)
# These and other installation scripts can be found at http://gainroot.co/solutions/openerp
#
# --------
# Below are some variables you can modify
STAGING_DIR=~
LOGFILE=~/davserver_install.log
#
# That's all, stop editing!
# ---------------------------------------------------------

# Install required Python packages
echo "************   Installing Python packages  **********" | tee -a $LOGFILE
{
sudo apt-get install python-webdav
# May not need this next one, but I did
sudo apt-get -y install python-vobject
} >> $LOGFILE 2>&1

echo "************************ Done ***********************" | tee -a $LOGFILE
echo "type \"/usr/bin/davserver -D /tmp -n -J &\" to manually start Python WebDAV" | tee -a $LOGFILE

