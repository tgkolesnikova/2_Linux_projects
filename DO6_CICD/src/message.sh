#!/bin/bash

TELEGRAM_BOT_TOKEN="telegram_bot_token"
TELEGRAM_USER_ID="telegram_user_ID"

TIME=30

if [[ $1 == "success" ]]
then
    pic="🍀"
    RESUME="CONGRATULATIONS 🎊🎉✨!"
else
    pic="😞"
    RESUME="Don't worry, try again 😊!"
fi

URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="Deploy status: $1+$pic%0A%0AProject:+$CI_PROJECT_NAME%0A%0AStage:+$CI_JOB_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG%0A%0A+$RESUME"

curl -s -S --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
