# frozen_string_literal: true

require_relative "juzu/version"
require_relative "juzu/command"

module Juzu
  class Error < StandardError; end
  # Your code goes here...
end

Juzu::Preset.new.exec
