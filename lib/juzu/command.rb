# frozen_string_literal: true

require 'yaml'

module Juzu
  class Preset
    attr_accessor :commands, :exec_status, :successes, :failures

    def initialize
      @successes = []
      @failures = []
      @exec_status = 0
      @commands = Preset.load_presets
    end

    def exec
      @commands[0...-1].each do |command|
        command.exec ? @successes << command : @failures << command
      end

      unless @failures.empty?
        puts "期待しない動作で終了したコマンドがあります。"
        @failures.each do |command|
          puts command.command
        end

        puts "最終コマンド#{@commands.last.command}を実行しますか？[y/N]"
        if STDIN.gets.chomp == "y"
          puts "実行します"
        else
          puts '実行をキャンセルします'
          @exec_status = 1
        end
      end

      @commands.last.exec if @exec_status == 0
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
