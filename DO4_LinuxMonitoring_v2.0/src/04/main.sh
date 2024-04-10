#!/bin/bash

codes=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
methods=("GET" "POST" "PUT" "PATCH" "DELETE")
urls=("ya.ru" "yandex.ru" "mail.ru" "vk.ru" "21-school.ru")
agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")

now=$(date +%s)

for (( i = 0; i < 5; i++)); do
    file="access_log$i"
    echo -n "" > $file

    rnd=$(( $RANDOM * 240 ))
    day=$(date --date @$(( $now - $rnd )) )
    day0=$(date --date="$day" +"%d/%b/%Y:%H:%M:%S")

    count=$(( $RANDOM % 900 + 100 ))
    for (( j=0; j < $count; j++)); do
        ip="$(( $RANDOM % 256 )).$(( $RANDOM % 256 )).$(( $RANDOM % 256 )).$(( $RANDOM % 256 ))"
        code=${codes[$(( $RANDOM % ${#codes[@]} ))]}
        method=${methods[$(( $RANDOM % ${#methods[@]} ))]}
        bytes=$(( $RANDOM % 256 ))
        url=${urls[$(( $RANDOM % ${#urls[@]} ))]}
        agent=${agents[$(( $RANDOM % ${#agents[@]} ))]}

        echo $ip [$day0 ] \"$method\" $code $bytes \"$url\" \"$agent\" >> $file
#             %h    %t        %r       %s     %b      %R         %u
        tmp=$(date +%s --date="$day")
        let tmp="tmp+1"
        day=$(date --date @$tmp)
        day0=$(date --date="$day" +"%d/%b/%Y:%H:%M:%S")
    done
done


# 200 OK
# 201 Created («создано»)
# 400 Bad Request («неправильный, некорректный запрос»)
# 401 Unauthorized («не авторизован (не представился)»)
# 403 Forbidden («запрещено (не уполномочен)»)
# 404 Not Found («не найдено»)
# 500 Internal Server Error («внутренняя ошибка сервера»)
# 501 Not Implemented («не реализовано»)
# 502 Bad Gateway («плохой, ошибочный шлюз»)
# 503 Service Unavailable («сервис недоступен»)
