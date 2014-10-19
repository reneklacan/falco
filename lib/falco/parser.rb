module Falco
  class Parser
    def self.parse_file file
      parse(File.read(file) + "\n")
    end

    def self.parse text
      parsed = []

      lines = text.lines.reject{ |l| l.strip.empty? }.map(&:rstrip)

      i = 0

      while i < lines.count
        previous_line = lines[i - 1]
        line = lines[i]
        next_line = lines[i + 1]

        if line.end_with?('\\')
          line = line[0..-2] + next_line.strip
          i += 1
        end

        parsed << Line.new(line)

        i += 1
      end

      parsed << Line.new('')
      parsed
    end
  end
end
