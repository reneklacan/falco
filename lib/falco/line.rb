module Falco
  class Line
    attr_accessor :indent, :code

    def initialize line
      @indent = line.match(/^[ ]*/)[0].size
      @code = line.strip
    end

    def to_s
      ' '*@indent + @code
    end

    def include? str
      !!@code[/\b#{str}\b/]
    end
  end
end
