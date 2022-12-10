# frozen_string_literal: true

class Constants
  def self.SDK_NAME
    'Runner'
  end

  def self.BUILD_PATH_ADHOC
    './build/adhoc'
  end

  def self.BUILD_PATH_APPSTORE
    './build/appstore'
  end

  def self.CODE_SIGN_INDENTITY_ADDHOC
    'iPhone Distribution'
  end

  def self.CODE_SIGN_INDENTITY_APPSTORE
    'Apple Distribution'
  end

  def self.METHOD_ADHOC
    'ad-hoc'
  end

  def self.METHOD_APPSTORE
    'app-store'
  end
end