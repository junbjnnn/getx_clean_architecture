# frozen_string_literal: true

class BuildManager
  def initialize(fastlane:)
    @fastlane = fastlane
  end

  def generate_ipa(scheme:, export_method:, app_identifier:, profile_name:, team_id:, configuration:, build_path:, product_name:)
    @fastlane.gym(
      clean: true,
      scheme: scheme,
      export_method: export_method,
      export_options: {
        compileBitcode: false,
        method: export_method,
        provisioningProfiles: {
          "#{app_identifier}" => "#{profile_name}"
        },
        signingStyle: "manual",
        teamID: team_id
      },
      export_xcargs: "-allowProvisioningUpdates",
      skip_profile_detection: true,
      configuration: configuration,
      output_name: product_name,
      output_directory: build_path,
      archive_path: "#{build_path}/#{product_name}.xcarchive",
      build_path: "#{build_path}/#{product_name}.xcarchive",
      verbose: true
    )
  end
end