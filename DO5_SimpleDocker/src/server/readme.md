Установить библиотеки:
``` bash
sudo apt-get update
sudo apt-get install libfcgi-dev nginx
```

Заменить конфигурационный файл `/etc/nginx/nginx.conf` на файл `nginx.conf`, содержащийся в этой папке (либо вписать вручную содержимое секции *server*). После этого перезапустить **nginx**:
``` bash
sudo service nginx restart
```

Скомпилировать файл `main.c` и запустить полученный файл:
``` C
cc main.c -o app.fcgi -lfcgi
./app.fсgi
```
Сервер запущен, он работает.

Чтобы проверить его работу:
- переключиться во второй терминал (можно комбинацией клавиш `Alt`+`F2`)
- набрать `curl localhost:81`
- получить в ответ `Hello, World!`

Профит!