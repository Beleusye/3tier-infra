locals {
  bastion_user_data = <<-EOF
#!/bin/bash
sed -i 's/#Port 22/Port 2200/g' /etc/ssh/sshd_config
systemctl restart sshd
EOF

  web_user_data = <<-EOF
#!/bin/bash
yum install -y httpd
sed -i '/Listen 80/a\
LoadModule proxy_module modules/mod_proxy.so\
LoadModule proxy_http_module modules/mod_proxy_http.so\
<VirtualHost *:80>\
ProxyPass /health !\
ProxyPass / http://${module.seoul_instance.nlb_endpoint}:8080/\
ProxyPassReverse / http://${module.seoul_instance.nlb_endpoint}:8080/\
</VirtualHost>' /etc/httpd/conf/httpd.conf
touch /var/www/html/index.html
touch /var/www/html/health
systemctl enable --now httpd
EOF

  was_user_data = <<-EOF
#!/bin/bash
yum install -y java-17-amazon-corretto-devel.x86_64 git
mkdir /app
cd /app
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
sed -i "s/localhost/${module.seoul_instance.rds_endpoint}/" ./src/main/resources/application-mysql.properties
echo "management.endpoints.health.enabled=true" | tee -a ./src/main/resources/application-mysql.properties
echo "management.endpoints.web.base-path=/" | tee -a ./src/main/resources/application-mysql.properties
export HOME=/root
./mvnw package -DskipTests=true
sleep 1.0
java -jar -Dspring.profiles.active="mysql" target/*.jar &
EOF
}