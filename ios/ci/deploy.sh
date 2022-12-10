#!/bin/sh -e

PLATFORM="iOS"
REPOSITORY="jbbase-app"
SLACK_URL="https://hooks.slack.com/services/..."

function deploy {
  if [[ "${ENV}" == "qa" || "${ENV}" == "stg" ]]; then
    CERTIFICATE_PATH="${HOME}/certs/Certificates_Nov19.p12"
    fastlane build_sample appcenter_api_token:"$APPCENTER_API_TOKEN" \
      appcenter_app_name_ios:"$APPCENTER_APP_NAME_IOS" \
      appcenter_owner_name:"$APPCENTER_OWNER_NAME" \
      apple_team_id:"$APPLE_TEAM_ID" \
      apple_profile_name:"$APPLE_PROFILE_NAME" \
      provision_file_name:"$PROVISION_FILE_NAME" \
      apple_profile_bundle_id:"$APPLE_PROFILE_BUNDLE_ID" \
      apple_connect_api_key_base64:"$APPLE_CONNECT_API_KEY_BASE64" \
      apple_connect_issuer_id:"$APPLE_CONNECT_ISSUER_ID" \
      apple_connect_key_id:"$APPLE_CONNECT_KEY_ID" \
      apple_certificate_path:"$CERTIFICATE_PATH" \
      apple_certificate_password:"$APPLE_CERTIFICATE_PASSWORD" \
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
    tag_regex="qa/ios"
  elif [[ "${ENV}" == "stg" ]]; then
    tag_regex="stg/ios"
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
    version=$(git tag --sort=-creatordate --points-at ${GIT_COMMIT} | grep ios | head -n 1 || :)
  fi

  export SLACK_VERSION=${version}
}

function notify {
  cat <<EOF | tee /tmp/notify.json
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
  cat <<EOF | tee /tmp/error_notify.txt
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
  sed -i -e 's/""/"/g' /tmp/error_notify.txt
  mv /tmp/error_notify.txt /tmp/error_notify.json
  curl -s -XPOST -d @/tmp/error_notify.json "${SLACK_URL}"
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
