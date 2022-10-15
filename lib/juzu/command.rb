# frozen_string_literal: true

require 'yaml'

module Juzu
  def self.load_presets(preset_name)
    command_presets = YAML.safe_load_file("#{Dir.home}/.juzu/presets.yml", symbolize_names: true)
  end
end
