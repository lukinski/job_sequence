require 'rails_helper'
require 'input_parser'

RSpec.describe 'InputParser' do
  let(:parser) { InputParser.new }

  describe ':new object' do
    it 'responds to #parse' do
      expect(parser).to respond_to(:parse)
    end
  end

  describe '#parse' do
    let(:input_string) { "A=>\r\nB=>C\r\nC=>" }
    let(:jobs) { parser.parse(input_string) }

    it 'returns array of jobs' do
      expect(jobs).to be_a(Array)
    end

    it 'returns proper number of jobs' do
      expect(jobs.size).to eq(3)
    end

    it 'assigns nil for empty dependency' do
      expect(jobs[0].dependency).to eq(nil)
    end

    it 'assigns given dependency' do
      expect(jobs[1].dependency).to eq('C')
    end

    it 'raises error on self-dependency' do
      expect{parser.parse("A=>A")}.to raise_error(DependencyError)
    end
  end
end
