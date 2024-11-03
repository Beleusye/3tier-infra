locals {
  bastion_user_data = <<-EOF
  #!/bin/bash
  sed -i 's/#Port 22/Port 2200/g' /etc/ssh/sshd_config
  systemctl restart sshd
  EOF

  web_user_data = <<-EOF
  #!/bin/bash
  yum install -y httpd
  cat >> /etc/httpd/conf/httpd.conf << EOT
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so
<VirtualHost *:80>
ProxyPass / http://nlb_endpoint:8080/
ProxyPassReverse / http://nlb_endpoint:8080/
</VirtualHost>
EOT
  EOF

  was_user_data = <<-EOF
  #!/bin/bash
  echo test
  EOF
}