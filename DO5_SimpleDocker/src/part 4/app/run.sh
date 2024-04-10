apt-get update
apt-get install -y gcc libfcgi-dev spawn-fcgi
cc main.c -o app.fcgi -lfcgi
spawn-fcgi -p 8080 -n app.fcgi
#./app.fcgi
