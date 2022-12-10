#!/bin/sh -e

PLATFORM="Android"
REPOSITORY="JBBase-app"
SLACK_URL="https://hooks.slack.com/services/xxx"

function deploy {
  if [[ "${ENV}" == "qa" || "${ENV}" == "stg" ]]; then
    fastlane android build_sample appcenter_api_token:"$APPCENTER_API_TOKEN" \
      appcenter_app_name_android:"$APPCENTER_APP_NAME_ANDROID" \
      appcenter_owner_name:"$APPCENTER_OWNER_NAME" \
      release_notes:"$RELEASE_TICKETS" \
      env:"$ENV"
  fi

  if [ $? -eq 0 ]; then
    echo "Deploy succeeded"
    notify
  else
    echo "Deploy failed"
    error_message="Failed. Please check fastlane log"
    error_notify "${error_message}"

    export STATUS_CODE=1
  fi
}

function get_tickets {
  slack_tickets=""
  release_tickets=""
  tag_regex=""
  if [[ "${ENV}" == "qa" ]]; then
    tag_regex="qa/android"
  elif [[ "${ENV}" == "stg" ]]; then
    tag_regex="stg/android"
  fi

  if [[ -n "${tag_regex}" ]]; then
    previous_tag=$(git for-each-ref --sort=-creatordate --format '%(refname)' refs/tags/ | grep "refs/tags/${tag_regex}" | sed -n 2p)
    next_tag=$(git for-each-ref --sort=-creatordate --format '%(refname)' refs/tags/ | grep "refs/tags/${tag_regex}" | sed -n 1p)

    if [[ -n "${previous_tag}" ]]; then
      slack_tickets=$(git log --no-merges --format="%s" ${previous_tag}..${next_tag} | sed -e 's/^Approved-by.*//g' | sed -e 's/Bump.*//g' | sed -e 's/Release.*//g' | sed -e 's/\[JBBase-/\\n\- \[JBBase-/g' | awk 'NF > 0')
      release_tickets=$(git log --no-merges --format="%s" ${previous_tag}..${next_tag} | sed -e 's/^Approved-by.*//g' | sed -e 's/Bump.*//g' | sed -e 's/Release.*//g' | sed -e 's/\[JBBase-/- \[JBBase-/g' | awk 'NF > 0')
    else
      slack_tickets=$(git log --no-merges --format="%s" ${next_tag} | sed -e 's/^Approved-by.*//g' | sed -e 's/Bump.*//g' | sed -e 's/Release.*//g' | sed -e 's/\[JBBase-/\\n\- \[JBBase-/g' | awk 'NF > 0')
      release_tickets=$(git log --no-merges --format="%s" ${next_tag} | sed -e 's/^Approved-by.*//g' | sed -e 's/Bump.*//g' | sed -e 's/Release.*//g' | sed -e 's/\[JBBase-/- \[JBBase-/g' | awk 'NF > 0')
    fi
  fi

  export SLACK_TICKETS=${slack_tickets}
  export RELEASE_TICKETS=${release_tickets}
}

function get_version {
  version=""

  if [[ "${ENV}" == "qa" || "${ENV}" == "stg" ]]; then
    version=$(git tag --sort=-creatordate --points-at ${GIT_COMMIT} | grep android | head -n 1 || :)
  fi

  export SLACK_VERSION=${version}
}

function notify {
  cat <<EOF | tee /tmp/android_notify.json
{
  "channel": "JBBase-deployment-notifier",
  "blocks": [
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "Deployed finished"
      }
    },
  ],
  "attachments": [
	  {
      "blocks" : [
        {
          "type": "section",
          "fields": [
            {
              "type": "mrkdwn",
              "text": "*Repository:*\n${REPOSITORY}"
            },
            {
              "type": "mrkdwn",
              "text": "*Platform:*\n${PLATFORM}"
            }
          ]
        },
        {
          "type": "section",
          "fields": [
            {
              "type": "mrkdwn",
              "text": "*Environment:*\n${ENV}"
            },
            {
              "type": "mrkdwn",
              "text": "*Release version:*\n${SLACK_VERSION}"
            }
          ]
        },
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": "*Tickets*\n\`\`\`${SLACK_TICKETS}\`\`\`"
          }
			  }
			],
      "color": "#37ce27"
    }
  ]
}
EOF
  curl -s -XPOST -d @/tmp/notify.json "${SLACK_URL}"
}

function error_notify {
  cat <<EOF | tee /tmp/android_error_notify.txt
{
  "channel": "JBBase-deployment-notifier",
  "attachments": [
	  {
      "text": "*Deploy failed*",
      "fields": [
          {
              "title": "Repository",
              "value": "${REPOSITORY}",
              "short": true
          },
          {
              "title": "Platform",
              "value": "${PLATFORM}",
              "short": true
          },
          {
              "title": "Environment",
              "value": "${ENV}",
              "short": true
          },
          {
              "title": "Release version",
              "value": "${SLACK_VERSION}",
              "short": true
          },
          {
              "title": "Release date",
              "value": "$(date "+%Y-%m-%d %H:%M") UTC",
              "short": true
          },
          {
              "title": "Error Message",
              "value": "${error_message}",
              "short": false
          }
      ],
      "color": "#ee5f5b"
    }
  ]
}
EOF
  sed -i -e 's/""/"/g' /tmp/android_error_notify.txt
  mv /tmp/android_error_notify.txt /tmp/android_error_notify.json
  curl -s -XPOST -d @/tmp/android_error_notify.json "${SLACK_URL}"
}

function main {
  cd ./..

  STATUS_CODE=0

  get_tickets
  get_version
  deploy

  return ${STATUS_CODE}
}

main