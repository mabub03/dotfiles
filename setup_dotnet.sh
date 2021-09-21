#!/bin/bash
sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/8/mssql-server-2019.repo

sudo dnf install -y dotnet mssql-server openldap-compat

sudo /opt/mssql/bin/mssql-conf setup

sudo firewall-cmd --add-port=1433/tcp --permanent
sudo firewall-cmd --reload

systemctl enable mssql-server

# install SQL Server command line tools
sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/8/prod.repo

# if you have previous versions of mssql-tools run this command
sudo yum remove unixODBC-utf16 unixODBC-utf16-devel

# install mssql tools
sudo yum install -y mssql-tools unixODBC-devel

# add /opt/mssql-tools/bin to your PATH environment for convienence
# echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
# echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
# source ~/.bashrc

echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >>~/.zshrc
source ~/.zshrc

# install azure functions (emulates storage for azure functions)
# npm install -g azurite
