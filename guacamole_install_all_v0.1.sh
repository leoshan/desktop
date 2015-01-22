#!/bin/bash
# Install update
yum update -y
# Install dependency
yum remove -y cairo-devel libpng-devel uuid-devel freerdp-devel pango-devel libssh2-devel libtelnet-devel libvncserver-devel pulseaudio-libs-devel openssl-devel libvorbis-devel
yum -y install cairo-devel libpng-devel uuid-devel freerdp-devel pango-devel libssh2-devel libtelnet-devel libvncserver-devel pulseaudio-libs-devel openssl-devel libvorbis-devel
# Download tar
wget http://tcpdiag.dl.sourceforge.net/project/guacamole/current/source/guacamole-server-0.9.4.tar.gz
wget http://jaist.dl.sourceforge.net/project/guacamole/current/binary/guacamole-0.9.4.war
wget http://tcpdiag.dl.sourceforge.net/project/guacamole/current/source/guacamole-client-0.9.4.tar.gz
#Install guacamole-server
tar -xzf guacamole-server-0.9.4.tar.gz
cd ./guacamole-server-0.9.4/
./configure --with-init-dir=/etc/init.d
make
make install
ldconfig
#Install Tomcat7
yum -y install tomcat7
#Install guacamole-client
mkdir /usr/share/tomcat7/.guacamole
cd ../
cp ./guacamole-0.9.4.war /var/lib/tomcat7/webapps/guacamole.war
mkdir /etc/guacamole
tar -xzf guacamole-client-0.9.4.tar.gz
cd guacamole-client-0.9.4/
cp guacamole/doc/example/guacamole.properties /etc/guacamole/guacamole.properties
ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat7/.guacamole/
cd ../
/etc/init.d/tomcat7 restart
/etc/init.d/guacd start
