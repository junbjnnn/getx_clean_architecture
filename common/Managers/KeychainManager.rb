# frozen_string_literal: true

class KeychainManager
  def initialize(fastlane:, keychain_name:)
    @fastlane = fastlane
    @keychain_name = keychain_name
  end

  def unlock()
    @fastlane.unlock_keychain(
      path: "#{Dir.home}/Keychains/#{@keychain_name}",
      password: "",
      set_default: true
    )
  end

  def create()
    @fastlane.create_keychain(
      path: "#{Dir.home}/Keychains/#{@keychain_name}",
      password: "",
      default_keychain: true,
      unlock: true,
      timeout: 3600,
      lock_when_sleeps: true
    )
  end

  def delete()
    @fastlane.delete_keychain(
      keychain_path: "#{Dir.home}/Keychains/#{@keychain_name}"
    )
  end
end