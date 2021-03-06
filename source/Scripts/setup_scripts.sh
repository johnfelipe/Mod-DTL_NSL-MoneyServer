#!/bin/bash

#
# Setup helper scripts for OpenSim/Aurora-Sim 
#                               by Fumi.Iseki
#

LANG=C
COMMAND="$0"

ALL_SCRIPT="NO"
SYMBL_LINK="YES"
ONLY_DWNLD="NO"

SHOW_HELP="NO"


while [ $# != 0 ]; do
    if   [ "$1" = "-a" -o "$1" = "--all" ]; then
        ALL_SCRIPT='YES' 
    elif [ "$1" = "-c" -o "$1" = "--copy" ]; then
        SYMBL_LINK="NO"
    elif [ "$1" = "-d" -o "$1" = "--download" ]; then
        ONLY_DWNLD="YES"
    elif [ "$1" = "-h" -o "$1" = "--help" ]; then
        SHOW_HELP="YES"
    fi 

    shift
done


if [ "$SHOW_HELP" = "YES" ]; then
    echo
    echo "usage... $COMMAND [-c/--copy] [-d/--download] [-a/--all] [-h/--help]"
    echo "-c or --copy     : not symbolic link but copy files"
    echo "-d or --download : download only"
    echo "-a or --all      : treat all scripts include optional scripts"
    echo "-h or --help     : show this help"
    echo
    exit 0
fi


if [ "$SYMBL_LINK" = "NO" ]; then
    if [ -f include/config.php -a ! -L include/config.php ]; then 
        mv -f include/config.php 'config.php.temp.$$$'
    fi
    rm -rf helper
    rm -rf include
fi

mkdir -p helper
mkdir -p include

if [ "$SYMBL_LINK" = "NO" ]; then
    if [ -f 'config.php.temp.$$$' -a ! -L 'config.php.temp.$$$' ]; then 
        mv -f 'config.php.temp.$$$' include/config.php
    fi
fi



########################################################################
# Basic Scripts

# download flotsam_XmlRpcGroup
if [ -d flotsam_XmlRpcGroup ]; then
    svn update flotsam_XmlRpcGroup
else
    svn co http://www.nsl.tuis.ac.jp/svn/opensim/flotsam_XmlRpcGroup/trunk flotsam_XmlRpcGroup
fi

if [ "$ONLY_DWNLD" = "NO" ]; then
    if   [ "$SYMBL_LINK" = "YES" ]; then
        ln -sf ../flotsam_XmlRpcGroup/groups.sql helper/groups.sql
        ln -sf ../flotsam_XmlRpcGroup/xmlgroups.php helper/xmlgroups.php
        ln -sf ../flotsam_XmlRpcGroup/xmlgroups_config.php helper/xmlgroups_config.php
        ln -sf ../flotsam_XmlRpcGroup/xmlrpc.php helper/xmlrpc.php
        if [ -d helper/phpxmlrpclib ]; then
            rm -rf helper/phpxmlrpclib
        fi
        ln -sf ../flotsam_XmlRpcGroup/phpxmlrpclib helper/phpxmlrpclib
    elif [ "$SYMBL_LINK" = "NO" ]; then
        cp -puf flotsam_XmlRpcGroup/groups.sql helper/groups.sql
        cp -puf flotsam_XmlRpcGroup/xmlgroups.php helper/xmlgroups.php
        cp -puf flotsam_XmlRpcGroup/xmlgroups_config.php helper/xmlgroups_config.php
        cp -puf flotsam_XmlRpcGroup/xmlrpc.php helper/xmlrpc.php
        cp -Rpdf flotsam_XmlRpcGroup/phpxmlrpclib helper/phpxmlrpclib
    fi
fi


# download opensimwiredux
if [ -d opensimwiredux ]; then
    svn update opensimwiredux
else
    svn co http://www.nsl.tuis.ac.jp/svn/opensim/opensimwiredux/trunk opensimwiredux
fi

if [ "$ONLY_DWNLD" = "NO" ]; then
    if   [ "$SYMBL_LINK" = "YES" ]; then
        ln -sf ../opensimwiredux/currency.php helper/currency.php
        ln -sf ../opensimwiredux/landtool.php helper/landtool.php
        ln -sf ../opensimwiredux/helpers.php helper/helpers.php
        ln -sf ../opensimwiredux/offline.php helper/offline.php
        ln -sf ../opensimwiredux/mysql.php include/mysql.func.php
    elif [ "$SYMBL_LINK" = "NO" ]; then
        cp -puf opensimwiredux/currency.php helper/currency.php
        cp -puf opensimwiredux/landtool.php helper/landtool.php
        cp -puf opensimwiredux/helpers.php helper/helpers.php
        cp -puf opensimwiredux/offline.php helper/offline.php
        cp -puf opensimwiredux/mysql.php include/mysql.func.php
    fi
fi


# download opensim.phplib
if [ -d opensim.phplib ]; then
    svn update opensim.phplib
else
    svn co http://www.nsl.tuis.ac.jp/svn/opensim/opensim.phplib/trunk opensim.phplib
fi

if [ "$ONLY_DWNLD" = "NO" ]; then
    if   [ "$SYMBL_LINK" = "YES" ]; then
        ln -sf ../opensim.phplib/env.mysql.php include/env.mysql.php
        ln -sf ../opensim.phplib/opensim.mysql.php include/opensim.mysql.php
        ln -sf ../opensim.phplib/tools.func.php include/tools.func.php
    elif [ "$SYMBL_LINK" = "NO" ]; then
        cp -puf opensim.phplib/env.mysql.php include/env.mysql.php
        cp -puf opensim.phplib/opensim.mysql.php include/opensim.mysql.php
        cp -puf opensim.phplib/tools.func.php include/tools.func.php
    fi
fi



########################################################################
# Optional Scripts

if [ "$ALL_SCRIPT" = "YES" ]; then

# download nsl.modules
if [ -d nsl.modules ]; then
    svn update nsl.modules
else
    svn co http://www.nsl.tuis.ac.jp/svn/opensim/opensim.nsl.modules/trunk nsl.modules
fi

if [ "$ONLY_DWNLD" = "NO" ]; then
    if   [ "$SYMBL_LINK" = "YES" ]; then
        ln -sf ../nsl.modules/php/mute.php helper/mute.php
    elif [ "$SYMBL_LINK" = "NO" ]; then
        cp -puf nsl.modules/php/mute.php helper/mute.php
    fi
fi


# download osprofile
if [ -d osprofile ]; then
    svn update osprofile
else
    svn co http://www.nsl.tuis.ac.jp/svn/opensim/opensim.osprofile/trunk osprofile
fi

if [ "$ONLY_DWNLD" = "NO" ]; then
    if   [ "$SYMBL_LINK" = "YES" ]; then
        ln -sf ../osprofile/webroot/profile.php  helper/profile.php
        ln -sf ../osprofile/webroot/profile_config.php helper/profile_config.php
    elif [ "$SYMBL_LINK" = "NO" ]; then
        cp -puf osprofile/webroot/profile.php  helper/profile.php
        cp -puf osprofile/webroot/profile_config.php helper/profile_config.php
    fi
fi


# download ossearch
if [ -d ossearch ]; then
    svn update ossearch
else
    svn co http://www.nsl.tuis.ac.jp/svn/opensim/opensim.ossearch/trunk ossearch
fi

if [ "$ONLY_DWNLD" = "NO" ]; then
    if   [ "$SYMBL_LINK" = "YES" ]; then
        ln -sf ../ossearch/webroot/parser.php helper/parser.php
        ln -sf ../ossearch/webroot/query.php  helper/query.php
        ln -sf ../ossearch/webroot/register.php helper/register.php
        ln -sf ../ossearch/webroot/search_config.php helper/search_config.php
    elif [ "$SYMBL_LINK" = "NO" ]; then
        cp -puf ossearch/webroot/parser.php helper/parser.php
        cp -puf ossearch/webroot/query.php  helper/query.php
        cp -puf ossearch/webroot/register.php helper/register.php
        cp -puf ossearch/webroot/search_config.php helper/search_config.php
    fi
fi


fi  # ALL_SCRIPT



########################################################################
#

if [ "$ONLY_DWNLD" = "NO" ]; then
    if   [ "$SYMBL_LINK" = "YES" ]; then
        ln -sf ../config/cron.php include/cron.php
        ln -sf ../config/env_interface.php include/env_interface.php
        ln -sf ../config/index.html helper/index.html
        ln -sf ../config/index.html include/index.html
        if [ ! -f include/config.php ]; then 
            ln -sf ../config/config.php include/config.php
        fi
    elif [ "$SYMBL_LINK" = "NO" ]; then
        cp -puf config/cron.php include/cron.php
        cp -puf config/env_interface.php include/env_interface.php
        cp -puf config/index.html helper/index.html
        cp -puf config/index.html include/index.html
        if [ ! -f include/config.php ]; then 
            cp -puf config/config.php include/config.php
        fi
    fi
fi

