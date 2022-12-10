# frozen_string_literal: true

class VersioningManager
    def initialize(fastlane:)
      @fastlane = fastlane
    end

    def get_app_version(api_token, owner_name, app_name)
      begin
        version = @fastlane.appcenter_fetch_version_number(
          api_token: api_token,
          owner_name: owner_name,
          app_name: app_name
        )
      rescue => ex
        version = { "version" => "0", "build_number" => 0 }
      end
    end

    def bump_app_version_ios(api_token:, owner_name:, app_name:, target_name:)
      version = get_app_version(api_token, owner_name, app_name)

      bump_version = {
        "version" => version["version"].to_s,
        "build_number" => @fastlane.increment_build_number_in_plist(
          target: target_name,
          build_number: (version["build_number"].to_i + 1).to_s
        )
      }
  
      puts bump_version
    end

    def bump_app_version_android(api_token:, owner_name:, app_name:)
      version = get_app_version(api_token, owner_name, app_name)

      bump_version = {
        "version" => version["version"].to_s,
        "build_number" => @fastlane.increment_version_code(
          gradle_file_path: "./app/build.gradle",
          version_code: (version["build_number"].to_i + 1).to_s
        )
      }

      puts bump_version
    end
  end