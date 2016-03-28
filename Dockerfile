#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM dockerfile/ubuntu

# Install Nginx.
RUN add-apt-repository -y ppa:nginx/stable && \
		apt-get update && \
		apt-get install -y nginx && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/* && \
		echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
		chown -R www-data:www-data /var/lib/nginx && \
		echo "!/bin/sh ntpdate ntp.ubuntu.com" >> /etc/cron.daily/ntpdate && \
    chmod 750 /etc/cron.daily/ntpdate && \
		cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    echo 'Asia/Taipei' > /etc/timezone && date && \
    sed -e 's;UTC=yes;UTC=no;' -i /etc/default/rcS

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
