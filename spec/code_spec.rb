
NAMES = Dir[('./spec/examples/*.in')].sort
INPUTS = Dir[('./spec/examples/*.in')].sort.map{ |f| File.read(f) }
OUTPUTS = Dir[('./spec/examples/*.out')].sort.map{ |f| File.read(f) }
EXAMPLES = INPUTS.zip(OUTPUTS)
EXAMPLES = NAMES.zip(INPUTS, OUTPUTS)

include Falco

def compile_it input
  Compiler.compile(Parser.parse(input))
end

def prepare text
  text.lines.reject(&:'blank?').join("\n").strip
end

describe Compiler do
  EXAMPLES.each do |name, input, output|
    context name do
      it 'should compile code correctly' do
        input = prepare(compile_it(input))
        expected_output = prepare(output)
        expect(input).to eq expected_output
      end
    end
  end
end
