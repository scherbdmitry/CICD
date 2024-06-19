#!/bin/bash

TELEGRAM_BOT_TOKEN="7145841417:AAFYVFhGWobEkJf_blPwGj67GhpWLny5350"
TELEGRAM_USER_ID="248276967"
STAGE_TYPE=$1

URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"

if [ "$CI_JOB_STATUS" == "success" ]; then 
    EMOJI=✅
else
    EMOJI=🔴
fi

TEXT="Deploy: $STAGE_TYPE%0A%0AProject:+$CI_PROJECT_NAME%0AStatus:+$EMOJI$CI_JOB_STATUS!$EMOJI%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG"

curl -s -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
