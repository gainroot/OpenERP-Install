OpenERP-Install
===============

	Introduction
	Requirements
	Installing with `install.sh`
	  install.sh server
	  install.sh client
	  install.sh web
	Starting & Stopping
	openERP-Install files
	  server.sh
	  client.sh
	  web.sh
	init-files
	  openerp-server
	  openerp-server.cfg
	  openerp-web
	To-do List

Introduction
------------
Install OpenERP software (Server, Client and Web) on your Ubuntu system.
Currently installs OpenERP 6.0.3
These install files are not intended to be elegant, merely functional.
The impetus for writing these files was the sheer number of manual steps
required in
[this link.](http://doc.openerp.com/v6.0/install/index.html#installation-link)
The installation resulting from these files would be good for a demo or
proof-of-concept environment but would not be recommended for production.

These scripts are maintained at the [Github repo](https://github.com/gainroot/OpenERP-Install)
They are released under a GNU General Public License. If you have improvements,
please contribute via github.


For more information, please visit http://gainroot.co/solutions/openerp


Requirements
------------
I tested with two fairly vanilla Ubuntu 10.04 LTS installations.

`2.6.32-28-generic-pae #55-Ubuntu SMP Mon Jan 10 22:34:08 UTC 2011 i686 GNU/Linux`

`2.6.32-32-generic #62-Ubuntu SMP Wed Apr 20 21:54:21 UTC 2011 i686 GNU/Linux`


Check yours with `uname -rvmo`
Your mileage may vary.


Installing with `install.sh`
----------------------------

While some of the scripts are useful individually, all are accessible through
install.sh

`Usage: install.sh [server|client|web]`

## install.sh server

Installs PostgreSQL and the OpenERP Server on your host.

Creates a Postgres superuser `openerp` with password of `postgres` to get you
started. 

These settings (`db_user`, `db_password` and `db_host`) are added as options
to the OpenERP Server rc file, `.openerp_serverrc` and also
to `/etc/openerp-server.cfg`

Creates a system user `openerp` to run the openerp-server
Adds openERP Server to the boot sequence as a managed service.

Creates a log file in your home directory. You can watch it by typing:
	`tail -f ~/openERP_server_install.log`

## install.sh client

Installs the OpenERP Client on your host.
One of the first things needed will be to create a database:
File -> Databases -> New database

Creates a log file in your home directory. You can watch it by typing:
	tail -f ~/openERP_client_install.log

## install.sh web


Install the OpenERP Web client/server on your host.
(It acts like a client to the OpenERP Server and yet it serves web pages.)
Adds openERP Web to the boot sequence as a managed service.

Creates a log file in your home directory. You can watch it by typing:
	`tail -f ~/openERP_web_install.log`

Starting & Stopping
-------------------

## OpenERP Server

Usage:		sudo /etc/init.d/openerp-server start|stop|restart
Config file:	/etc/openerp-server.cfg
Log file:	/var/log/openerp/openerp-server.log

## OpenERP Client

Usage:		/usr/local/bin/openerp-client
Config file:	~/.openerprc
Log file:	unknown
Notes:		Make certain you're connected to a windowing environment
		(X11, etc.) before starting this process.
		One of the first things needed will be to create a database:
		  File -> Databases -> New database

## OpenERP Web

Usage:		sudo /etc/init.d/openerp-web start|stop|restart
Config file:	/etc/openerp-web.cfg
Log file:	/var/log/openerp/web-access.log
    		/var/log/openerp/web-error.log

openERP-Install files
---------------------

The files in this directory are called by `install.sh` to do the actual
installation.

## `server.sh`

Corresponds to `./install.sh server`.

Also calls code to install /etc/init.d/openerp-server

## client.sh

Corresponds to `./install.sh client`

## web.sh

Corresponds to `./install.sh web`
Also calls code to install `/etc/init.d/openerp-web`


init-files
----------

The following files are called by install.sh to add openerp-server
and openerp-web to the boot sequence as managed services.

## `openerp-server`

Gets installed as: `/etc/init.d/openerp-server`
Depends on PostgreSQL
See Usage above

## `openerp-server.cfg`

Gets installed as: `/etc/openerp-server.cfg`
Used by `/etc/init.d/openerp-server`

## `openerp-web`

Gets installed as: `/etc/init.d/openerp-web`
Depends on `openerp-server`
See Usage above

## `openerp-web.cfg`

Gets installed as: `/etc/openerp-web.cfg`
Used by `/etc/init.d/openerp-web`


To-Do
-----

Each install file spits all output (stderr and stout) to a named logfile

OpenERP Server and OpenERP Web log files are properly stored, rotated & maintained

Make it possible to specify passwords to use rather than accepting the defaults

===
END
