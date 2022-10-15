# frozen_string_literal: true

require 'yaml'

module Juzu
  class Preset
    attr_accessor :commands

    def initialize
      @commands = Preset.load_presets
    end

    def exec
      @commands.each do |command|
        command.exec
      end
    end

    def self.load_presets
      preset_symbol = ARGV[0].to_sym
      command_presets = YAML.safe_load_file("#{Dir.home}/.juzu/presets.yml", symbolize_names: true)

      puts "指定のコマンドが見つかりませんでした。" unless command_presets.include?(preset_symbol)
      command_presets[preset_symbol].map { |command| Command.new(command[:command], command[:type]) }
    end
  end

  class Command
    attr_accessor :command, :type

    def initialize(command, type)
      @command = command
      @type = type.nil? ? 1 : type
    end

    def exec
      system @command
    end
  end
end
