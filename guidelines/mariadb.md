# MARIA DATABASE

## Installation rpm packages mariadb

    unixODBC perl-DBD-MySQL perl-DBI mysql-selinux mariadb-errmsg mariadb-common mariadb mariadb-server mariadb-gssapi-server mariadb-backup mariadb-connector-c mariadb-connector-c-config mariadb-connect-engine mariadb-connector-odbc mariadb-cracklib-password-check mariadb-server-utils

## Preaparation mariadb

`script preparation mariadb server`

    #!/bin/env bash
    # -*- coding: utf-8 -*-

    declare -rx base_path='replace of your base folder'

    sudo cp /etc/my.cnf.d/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf.back
    sudo sed -i 's%^datadir=/var/lib.*$%datadir='${base_path}'%' /etc/my.cnf.d/mariadb-server.cnf

    [[ -n "{$base_path}" ]] && sudo mkdir -p "${base_path}"
    [[ -d "${base_path}" ]] && sudo chown -R mysql: "${base_path}"

    sudo systemctl enable mariadb
    sudo systemctl start mariadb

`Use mysqladmin and create superuser`

    set root password
    sudo mysqladmin -u root password

    login to mysql at console
    mysql -u root -p

    create new user
    CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';

    check created of user
    SELECT User,Host FROM mysql.user;

    set privileges of user
    GRANT ALL PRIVILEGES ON *.* TO 'user'@'host' WITH GRANT OPTION;

    check all privileges grant user
    SHOW GRANTS FOR 'user'@'host';

    reload privileges
    FLUSH PRIVILEGES;

    quit

`To work with mariadb from the console without constantly entering a password, do the following:`

    Create sequrity file:
      echo -e "[mysql]\nuser=root\npassword=your password" > mariadb.conf
    use
      mysql --defaults-file=mariadb.conf 'your commands list'
    or
      mysql --defaults-file=mariadb.conf < 'your commands list in file'

## Installation mysql-workbench-community

    FILE_OS_RELEASE="/etc/os-release"
    OS_VERSION_ID="$(grep VERSION_ID ${FILE_OS_RELEASE} | awk -F= '{ print $2 }')"
    "https://dev.mysql.com/get/mysql80-community-release-fc${OS_VERSION_ID}-1.noarch.rpm"

    sudo dnf config-manager --set-disable mysql80-community mysql-connectors-community

    mysql-workbench-community
