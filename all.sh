GRN='\033[0;32m'
CYA='\033[0;36m'
YEL='\033[1;33m'
NC='\033[0m' # No Color

clear
printf "!!! Internet e bağlı değilseniz devam etmeyin !!!\n"
printf "!!! Internet e bağlıysanız ilerlemek için$CYA Enter$NC 'a basın !!!\n"
read ileri

clear
printf "Modem$GRN WEB$NC arayüz root kullanıcı şifresi ne olsun?\nEn az 8 karakter,$CYA en az 1büyük, 1küçük, 1rakam$NC Örn:$YEL Sifre123$NC / $YEL Arabada5$NC  / $YEL EvdeYuz5$NC ): "
read webroot

clear
printf "Modem$GRN SSH$NC root kullanıcı şifresi ne olsun?\nEn az 8 karakter,$CYA en az 1büyük, 1küçük, 1rakam$NC Örn:$YEL Sifre123$NC / $YEL Arabada5$NC  / $YEL EvdeYuz5$NC ): "
read sshroot

clear
printf "Modem$GRN SHELL$NC root kullanıcı şifresi ne olsun?\nEn az 8 karakter,$CYA en az 1büyük, 1küçük, 1rakam$NC Örn:$YEL Sifre123$NC / $YEL Arabada5$NC  / $YEL EvdeYuz5$NC ): "
read shellroot

apt install wireshark --assume-yes

apt install isc-dhcp-server --assume-yes
printf "option domain-name \"example.org\";\n">/etc/dhcp/dhcpd.conf
printf "\n">>/etc/dhcp/dhcpd.conf
printf "default-lease-time 600;\n">>/etc/dhcp/dhcpd.conf
printf "max-lease-time 7200;\n">>/etc/dhcp/dhcpd.conf
printf "ddns-update-style none;\n">>/etc/dhcp/dhcpd.conf
printf "\n">>/etc/dhcp/dhcpd.conf
printf "option subnet-mask 255.255.255.0;\n">>/etc/dhcp/dhcpd.conf
printf "option broadcast-address 10.116.13.255;\n">>/etc/dhcp/dhcpd.conf
printf "option routers 10.116.13.1;\n">>/etc/dhcp/dhcpd.conf
printf "option domain-name-servers 8.8.8.8;\n">>/etc/dhcp/dhcpd.conf
printf "\n">>/etc/dhcp/dhcpd.conf
printf "option space zte;\n">>/etc/dhcp/dhcpd.conf
printf "option zte.adr code 1 = text;\n">>/etc/dhcp/dhcpd.conf
printf "option local-encapsulation code 43 = encapsulate zte;\n">>/etc/dhcp/dhcpd.conf
printf "option zte.adr \"http://10.116.13.21/cwmpWeb/WGCPEMgt\";\n">>/etc/dhcp/dhcpd.conf
printf "\n">>/etc/dhcp/dhcpd.conf
printf "subnet 10.116.13.0 netmask 255.255.255.0 {\n">>/etc/dhcp/dhcpd.conf
printf "range 10.116.13.10 10.116.13.100;\n">>/etc/dhcp/dhcpd.conf
printf "}\n">>/etc/dhcp/dhcpd.conf

apt install lighttpd --assume-yes
ln -s /etc/lighttpd/conf-available/10-accesslog.conf /etc/lighttpd/conf-enabled/
ln -s /etc/lighttpd/conf-available/10-cgi.conf /etc/lighttpd/conf-enabled/

printf "# /usr/share/doc/lighttpd/cgi.txt\n">/etc/lighttpd/conf-enabled/10-cgi.conf
printf "\n">>/etc/lighttpd/conf-enabled/10-cgi.conf
printf "server.modules += ( \"mod_cgi\" )\n">>/etc/lighttpd/conf-enabled/10-cgi.conf
printf "\n">>/etc/lighttpd/conf-enabled/10-cgi.conf
printf "\$HTTP[\"url\"] =~ \"^/.*\" {\n">>/etc/lighttpd/conf-enabled/10-cgi.conf
printf "        cgi.assign = ( \"/simula\" => \"\" )\n">>/etc/lighttpd/conf-enabled/10-cgi.conf
printf "        alias.url = ( \"\" => \"/etc/lighttpd/simula\")\n">>/etc/lighttpd/conf-enabled/10-cgi.conf
printf "}\n">>/etc/lighttpd/conf-enabled/10-cgi.conf

printf "#!/bin/bash\n">/etc/lighttpd/simula
printf "\n">>/etc/lighttpd/simula
printf "\n">>/etc/lighttpd/simula
printf "eval \$HTTP_COOKIE\n">>/etc/lighttpd/simula
printf "if [ -z \$session ] ; then\n">>/etc/lighttpd/simula
printf "   session=\$(date +'%%F-%%T')\n">>/etc/lighttpd/simula
printf "   mkdir /tmp/acs/\$session\n">>/etc/lighttpd/simula
printf "fi\n">>/etc/lighttpd/simula
printf "\n">>/etc/lighttpd/simula
printf "if [ -f /tmp/acs/\${session}/status ] ; then\n">>/etc/lighttpd/simula
printf "  status=\$(cat /tmp/acs/\${session}/status)\n">>/etc/lighttpd/simula
printf "else\n">>/etc/lighttpd/simula
printf "  status=1\n">>/etc/lighttpd/simula
printf "fi\n">>/etc/lighttpd/simula
printf "\n">>/etc/lighttpd/simula
printf "if [ ! -f /etc/lighttpd/resp\${status} ] ; then\n">>/etc/lighttpd/simula
printf "  exit\n">>/etc/lighttpd/simula
printf "fi\n">>/etc/lighttpd/simula
printf "\n">>/etc/lighttpd/simula
printf "echo \"Content-Type: text/xml\"\n">>/etc/lighttpd/simula
printf "[ -n \"\$session\" ] && echo \"Set-Cookie: session=\$session\"\n">>/etc/lighttpd/simula
printf "echo \"\" \n">>/etc/lighttpd/simula
printf "cat /dev/stdin > /tmp/acs/\${session}/req\${status}\n">>/etc/lighttpd/simula
printf "cat /etc/lighttpd/resp\${status}\n">>/etc/lighttpd/simula
printf "\n">>/etc/lighttpd/simula
printf "status=\$((\$status+1))\n">>/etc/lighttpd/simula
printf "echo \$status > /tmp/acs/\${session}/status\n">>/etc/lighttpd/simula
chmod +x /etc/lighttpd/simula

printf "<SOAP-ENV:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:cwmp=\"urn:dslforum-org:cwmp-1-0\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" > /etc/lighttpd/resp1
printf "<SOAP-ENV:Header>\n" >> /etc/lighttpd/resp1
printf "<cwmp:ID SOAP:mustUnderstand=\"1\">1</cwmp:ID>\n" >> /etc/lighttpd/resp1
printf "<cwmp:NoMoreRequest>0</cwmp:NoMoreRequest>\n" >> /etc/lighttpd/resp1
printf "</SOAP-ENV:Header>\n" >> /etc/lighttpd/resp1
printf "<SOAP-ENV:Body>\n" >> /etc/lighttpd/resp1
printf "<cwmp:InformResponse><MaxEnvelopes>1</MaxEnvelopes></cwmp:InformResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>\n" >> /etc/lighttpd/resp1

printf "<SOAP-ENV:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:cwmp=\"urn:dslforum-org:cwmp-1-0\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" > /etc/lighttpd/resp2
printf "<SOAP-ENV:Header>\n" >> /etc/lighttpd/resp2
printf "<cwmp:ID SOAP:mustUnderstand=\"1\">1</cwmp:ID>\n" >> /etc/lighttpd/resp2
printf "<cwmp:NoMoreRequest>0</cwmp:NoMoreRequest>\n" >> /etc/lighttpd/resp2
printf "</SOAP-ENV:Header>\n" >> /etc/lighttpd/resp2
printf "<SOAP-ENV:Body>\n" >> /etc/lighttpd/resp2
printf "<cwmp:SetParameterValues>\n" >> /etc/lighttpd/resp2
printf "<ParameterList>\n" >> /etc/lighttpd/resp2
printf "<ParameterValueStruct><Name>InternetGatewayDevice.X_TT.Configuration.Shell.Enable</Name><Value xsi:type=\"xsd:boolean\">1</Value></ParameterValueStruct>\n" >> /etc/lighttpd/resp2
printf "<ParameterValueStruct><Name>InternetGatewayDevice.X_TT.Configuration.Shell.Password</Name><Value xsi:type=\"xsd:string\">$shellroot</Value></ParameterValueStruct>\n" >> /etc/lighttpd/resp2
printf "<ParameterValueStruct><Name>InternetGatewayDevice.X_ZTE-COM_SSH.Enable</Name><Value xsi:type=\"xsd:boolean\">1</Value></ParameterValueStruct>\n" >> /etc/lighttpd/resp2
printf "<ParameterValueStruct><Name>InternetGatewayDevice.X_ZTE-COM_SSH.UserName</Name><Value xsi:type=\"xsd:string\">root</Value></ParameterValueStruct>\n" >> /etc/lighttpd/resp2
printf "<ParameterValueStruct><Name>InternetGatewayDevice.X_ZTE-COM_SSH.Password</Name><Value xsi:type=\"xsd:string\">$sshroot</Value></ParameterValueStruct>\n" >> /etc/lighttpd/resp2
printf "<ParameterValueStruct><Name>InternetGatewayDevice.X_TT.Users.User.2.Enable</Name><Value xsi:type=\"xsd:boolean\">1</Value></ParameterValueStruct>\n" >> /etc/lighttpd/resp2
printf "<ParameterValueStruct><Name>InternetGatewayDevice.X_TT.Users.User.2.Username</Name><Value xsi:type=\"xsd:string\">root</Value></ParameterValueStruct>\n" >> /etc/lighttpd/resp2
printf "<ParameterValueStruct><Name>InternetGatewayDevice.X_TT.Users.User.2.Password</Name><Value xsi:type=\"xsd:string\">$webroot</Value></ParameterValueStruct>\n" >> /etc/lighttpd/resp2
printf "</ParameterList>\n" >> /etc/lighttpd/resp2
printf "<ParameterKey/>\n" >> /etc/lighttpd/resp2
printf "</cwmp:SetParameterValues>\n" >> /etc/lighttpd/resp2
printf "</SOAP-ENV:Body>\n" >> /etc/lighttpd/resp2
printf "</SOAP-ENV:Envelope>\n" >> /etc/lighttpd/resp2

touch /etc/lighttpd/resp3
mkdir /tmp/acs
chown www-data /tmp/acs

wireshark &
sleep 3
clear
printf "\n\n1 - Açılan Wireshark ekranında modeme bağlanacak network kartını (örn:$YEL eno1$NC ) çift tıklayın, \n2 - Sonrasinda açılan ekranda filtre kısmına ---  $YEL dhcp or xml$NC  --- yazıp$CYA Enter$NC 'a basin. \n3 - Sonra bu ekrana geri dönün ve ilerlemek için$CYA Enter$NC 'a basın."
read ileri

clear
printf "\nNetwork kartı IP ayarlarını yapın.\nSonra bu ekrana geri dönün ve ilerlemek için$CYA Enter$NC 'a basın."
read ileri

clear
#printf "\nSırasıyla; \n1 - Modemin$YEL WAN$NC kablosunu çıkarın, \n2 - Modemi fabrika ayarlarına döndürün, \n3 - Bilgisayarınızı modemin$YEL WAN$NC portuna bağlayın. \n4 - Ilerlemek için$CYA Enter$NC 'a basın."
printf "\nSırasıyla; \n1 - Modemin$YEL WAN$NC kablosunu çıkarın, \n2 - Modemi web ekranından fabrika ayarlarına döndürün, işlem başladığında hemen bilgisayarınızı modemin$YEL WAN$NC portuna bağlayın. \n3 - Ilerlemek için$CYA Enter$NC 'a basın."

read ileri

row=2
col=2
msg="Modemin kendine gelmesini 60 sn. bekliyorum... ${1}"
clear
tput cup $row $col
echo -n "$msg"
l=${#msg}
l=$(( l+$col ))
for i in {60..0}
do
tput cup $row $l
kk=$i
if (($kk < 10))
    then kk="0$i"
fi
printf "$YEL$kk$NC"
sleep 1
done

sleep 1
printf " \n \n"
clear

/etc/init.d/isc-dhcp-server restart
/etc/init.d/lighttpd restart

printf "\nHata vermediyse çok şükür, devam için$CYA Enter$NC 'a basın."
read ileri
clear

row=2
col=2
msg="DHCP nin kendine gelmesini 30 sn. bekliyorum... ${1}"
clear
tput cup $row $col
echo -n "$msg"
l=${#msg}
l=$(( l+$col ))
for i in {30..0}
do
tput cup $row $l
kk=$i
if (($kk < 10))
    then kk="0$i"
fi
printf "$YEL$kk$NC"
sleep 1
done

sleep 1
printf " \n \n"
clear



printf "\n\nWireshark da işlem tamam mı kontrol edin\nTamamsa hayırlı olsun\nDeğilse 1-2dk bekleyin. Olmazsa geçmiş olsun  :) \nMücadeleye devam etmek için$CYA Enter$NC 'a basın."

read ileri
clear

printf "DHCP işlemleri tamam değilse --- $YEL sudo /etc/init.d/isc-dhcp-server restart$NC  --- komutunu çalıştırın, baktınız yine olmadı modemi yeniden başlatın.\n\n\n"
printf "XML işlemleri tamam değilse --- $YEL sudo /etc/init.d/lighttpd restart$NC  ---  komutunu çalıştırın, baktınız yine olmadı modemi yeniden başlatın.\n\n\n"
printf "Daha da olmazsa bir duş alın deneyin, daha da olmazsa ben de bilemedim...\n\n\n"
printf "Başarılı olduysanız, WAN kablosunu çıkarıp, modemi yeniden başlatın,login oluğunuzdan emin olduktan sonra normal hatta bağlayabilirsiniz. Ayarları kendi alacaktır.\n\n\n"

printf "$YELÖnemli Not:$NC Modem arayüzünden yedeğinizi alın. Oldu ki ISP şifrenizi resetledi yedekten geri dönüp kullanırsınız.\n"

