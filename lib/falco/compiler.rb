module Falco
  class KeywordAppearance
    attr_accessor :keyword, :indent

    def initialize keyword, indent
      @keyword = keyword
      @indent = indent
    end
  end

  class Compiler
    KEYWORDS = {
      'module' => [],
      'class' => [],
      'def' => ['rescue'],
      'begin' => ['rescue'],
      'do' => [],
      'while' => [],
      'for' => [],
      'case' => ['when', 'else'],
      'if' => ['elsif', 'else'],
    }

    def self.compile lines
      self.new(lines).compile
    end

    def initialize lines
      @lines = lines
    end

    def compile
      reset

      while not_done?
        analyze_indent
        @result += line.to_s + "\n"
        detect_appearances
        step
      end

      @result.strip
    end

    private

    def analyze_indent
      return if line.indent >= previous_line.indent

      while @history.last
        if @history.last.indent >= line.indent && append_end?
          @result += ' '*@history.last.indent + "end\n"
          @history.pop
        else
          break
        end
      end
    end

    def append_end?
      return true if @history.last.indent > line.indent

      KEYWORDS[@history.last.keyword].each do |keyword|
        return false if line.to_s[/\b#{keyword}\b/]
      end

      true
    end

    def detect_appearances
      if (next_line && ((next_line.indent > line.indent) || (line.indent == next_line.indent && line.include?('case'))))
        KEYWORDS.keys.each do |keyword|
          next unless line.to_s[/\b#{keyword}\b/]
          @history << KeywordAppearance.new(keyword, line.indent)
        end
      end
    end

    def reset
      @index = 0
      @history = []
      @result = ''
    end

    def step
      @index += 1
    end

    def previous_line
      @lines[@index - 1]
    end

    def line
      @lines[@index]
    end

    def next_line
      @lines[@index + 1]
    end

    def done?
      @index >= @lines.count
    end

    def not_done?
      !done?
    end
  end
end
