def secrets = [
  [
    path: 'infra/app_center',
    engineVersion: 2,
    secretValues: [
      [envVar: 'APPCENTER_API_TOKEN', vaultKey: 'api_key']
    ]
  ],
  [
    path: 'infra/apple',
    engineVersion: 2,
    secretValues: [
      [envVar: 'APPLE_TEAM_ID', vaultKey: 'apple_team_id'],
      [envVar: 'APPLE_CONNECT_API_KEY_BASE64', vaultKey: 'apple_connect_api_key_base64'],
      [envVar: 'APPLE_CONNECT_ISSUER_ID', vaultKey: 'apple_connect_issuer_id'],
      [envVar: 'APPLE_CONNECT_KEY_ID', vaultKey: 'apple_connect_key_id'],
      [envVar: 'APPLE_CERTIFICATE_PASSWORD', vaultKey: 'apple_certificate_password']
    ]
  ],
  [
    path: 'projects/jbbase/${env}',
    engineVersion: 2,
    secretValues: [
      [envVar: 'APPCENTER_APP_NAME_IOS', vaultKey: 'appcenter_app_name_ios'],
      [envVar: 'APPCENTER_APP_NAME_ANDROID', vaultKey: 'appcenter_app_name_android'],
      [envVar: 'APPCENTER_OWNER_NAME', vaultKey: 'appcenter_owner_name'],
      [envVar: 'APPLE_PROFILE_NAME', vaultKey: 'apple_profile_name'],
      [envVar: 'APPLE_PROFILE_BUNDLE_ID', vaultKey: 'apple_profile_bundle_id'],
      [envVar: 'PROVISION_FILE_NAME', vaultKey: 'provision_file_name']
    ]
  ]
]
def configuration = [vaultUrl: 'https://vault...com',  vaultCredentialId: 'VAULT_APP_ROLE_ID', engineVersion: 2]

pipeline {
  agent {
    node {
      label 'label';
    }
  }

  options {
    timeout(time: 30, unit: "MINUTES")
    buildDiscarder(
      logRotator(
        numToKeepStr: env.BRANCH_NAME ==~ /master/ ? '15' :
          env.BRANCH_NAME ==~ /develop/ ?  '15' : '5'
      )
    )
    lock("${env.JOB_NAME}")
  }

  environment {
    FASTLANE_DISABLE_COLORS = 1
    LANG = "en_US.UTF-8"
    LANGUAGE = "en_US.UTF-8"
    LC_ALL = "en_US.UTF-8"
    PATH="${env.PATH}:/opt/homebrew/bin:/usr/local/bin"
    OBJC_DISABLE_INITIALIZE_FORK_SAFETY = 'YES'
  }

  stages {
    stage('Build and deploy iOS for the QA') {
      when {
        allOf {
          anyOf {
            branch 'develop'
          }

          expression { sh(returnStdout: true, script: 'git tag --sort=-creatordate --points-at ${GIT_COMMIT} | grep ios | head -n 1 || :').trim() =~ /(qa\/ios)/ }
        }
      }

      environment {
        ENV = 'qa'
      }

      steps {
        withVault([configuration: configuration, vaultSecrets: secrets]) {
          script {
            dir('ios/ci') {
              int statusCode = sh(returnStatus: true, script: "bash deploy.sh")

              if (statusCode != 0) {
                currentBuild.result = 'FAILURE'
                error 'Build and deploy sample app failed.'
              }
            }
          }
        }
      }

      post {
        always {
          // always collect build log for investigate when failed
          archiveArtifacts artifacts: 'fastlane.log', allowEmptyArchive: true
        }
      }
    }

    stage('Build and deploy iOS for the Staging') {
      when {
        allOf {
          anyOf {
            branch 'stg'
          }

          expression { sh(returnStdout: true, script: 'git tag --sort=-creatordate --points-at ${GIT_COMMIT} | grep ios | head -n 1 || :').trim() =~ /(stg\/ios)/ }
        }
      }

      environment {
        ENV = 'stg'
      }

      steps {
        withVault([configuration: configuration, vaultSecrets: secrets]) {
          script {
            dir('ios/ci') {
              int statusCode = sh(returnStatus: true, script: "bash deploy.sh")

              if (statusCode != 0) {
                currentBuild.result = 'FAILURE'
                error 'Build and deploy sample app failed.'
              }
            }
          }
        }
      }

      post {
        always {
          // always collect build log for investigate when failed
          archiveArtifacts artifacts: 'fastlane.log', allowEmptyArchive: true
        }
      }
    }

    stage('Build and deploy android for the QA') {
      when {
        allOf {
          anyOf {
            branch 'develop'
          }

          expression { sh(returnStdout: true, script: 'git tag --sort=-creatordate --points-at ${GIT_COMMIT} | grep android | head -n 1 || :').trim() =~ /(qa\/android)/ }
        }
      }

      environment {
        ENV = 'qa'
      }

      steps {
        withVault([configuration: configuration, vaultSecrets: secrets]) {
          script {
            dir('android/ci') {
              int statusCode = sh(returnStatus: true, script: "bash deploy.sh")

              if (statusCode != 0) {
                currentBuild.result = 'FAILURE'
                error 'Build and deploy sample app failed.'
              }
            }
          }
        }
      }

      post {
        always {
          // always collect build log for investigate when failed
          archiveArtifacts artifacts: 'fastlane.log', allowEmptyArchive: true
        }
      }
    }

    stage('Build and deploy android for the Staging') {
      when {
        allOf {
          anyOf {
            branch 'stg'
          }

          expression { sh(returnStdout: true, script: 'git tag --sort=-creatordate --points-at ${GIT_COMMIT} | grep android | head -n 1 || :').trim() =~ /(stg\/android)/ }
        }
      }

      environment {
        ENV = 'stg'
      }

      steps {
        withVault([configuration: configuration, vaultSecrets: secrets]) {
          script {
            dir('android/ci') {
              int statusCode = sh(returnStatus: true, script: "bash deploy.sh")

              if (statusCode != 0) {
                currentBuild.result = 'FAILURE'
                error 'Build and deploy sample app failed.'
              }
            }
          }
        }
      }

      post {
        always {
          // always collect build log for investigate when failed
          archiveArtifacts artifacts: 'fastlane.log', allowEmptyArchive: true
        }
      }
    }
  }

  post {
    always {
      cleanWs(
        deleteDirs: true
      )
    }
  }
}
