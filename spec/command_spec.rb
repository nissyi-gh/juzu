# frozen_string_literal: true

RSpec.describe Juzu::Command do
  describe 'initialize' do
    example 'typeがnilの場合はtypeが1に設定される' do
      command = Juzu::Command.new('true', nil)
      expect(command.type).to eq 1
    end
  end

  describe 'exec' do
    example '成功するコマンドはtrueを返す' do
      command = Juzu::Command.new('true', 0)
      expect(command.exec).to eq true
    end

    example '存在しないコマンドはnilを返す' do
      command = Juzu::Command.new('hogefugapiyo', 0)
      expect(command.exec).to eq nil
    end

    example '失敗するコマンドはfalseを返す' do
      command = Juzu::Command.new('false', 0)
      expect(command.exec).to eq false
    end
  end
end
