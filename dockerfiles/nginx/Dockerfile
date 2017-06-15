FROM nginx:1.13

RUN apt-get update
RUN apt-get install -y \
    rkhunter \
    fail2ban \
    logwatch \
    chkrootkit

# Create a directory the Logwatch package in the repositories currently does not create, but is required for proper operation
RUN mkdir /var/cache/logwatch

COPY conf/logwatch.conf /etc/logwatch/conf/

