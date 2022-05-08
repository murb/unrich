# frozen_string_literal: true

require_relative "unrich/version"

module Unrich
  class Error < StandardError; end

  # Main class that parses the richt text to unrich text, read regular plain text
  class Text
    attr_accessor :rtf_text

    def initialize(rtf_text)
      self.rtf_text = rtf_text
    end

    def encoding
      @encoding ||= {
        "ansicpg1252" => "Windows-1252"
      }[rtf_text.match(/\A\{\\rtf1\\([a-zA-Z0-9]*)\\([a-zA-Z0-9]*)\\/)[2]]
    end

    def to_txt
      txt = rtf_text.gsub(/\\\'([a-z0-9]{2})/) { |a|
        [a.sub("\\'",
               '')].pack("H*").force_encoding(encoding).encode("utf-8")
      }
                    .gsub(/\\par\s/, "\n")
                    .sub('{\rtf1', "")
                    .sub(/{[^{^}]*}/, "")
                    .sub(/{[^{^}]*}/, "")
                    .sub(/{[^{^}]*}/, "")
                    .gsub(/\\\w*/, "")
                    .gsub(/\{\s*\;\;\}/,"").strip
      txt[txt.length - 1] = "" if txt.end_with?("}")
      txt.delete("\u0000").strip
    end

    def to_s
      to_txt
    end

    private

    def clean_up dirty_text
      newstr = ""
      dirty_text.length.times do |i|
        character = dirty_text[i]
        newstr += if character < 0x80
                    character.chr
                  elsif character < 0xC0
                    "\xC2" + character.chr
                  else
                    "\xC3" + (character - 64).chr
                  end
      end
      newstr
    end

    class << self
      def read(contents)
        if contents.is_a? String
          return self.new(contents)
        elsif contents.is_a? File
          return self.new(contents.read)
        elsif raise Error, "unkown contents"
        end
      end
    end
  end
  # Your code goes here...
end
