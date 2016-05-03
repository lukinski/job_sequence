require 'rails_helper'
require 'job_processor'

RSpec.describe 'JobProcessor' do
  context '#find_sequence method' do
    it 'can be called' do
      expect(JobProcessor.new('')).to respond_to(:find_sequence)
    end

    context 'returns' do
      it 'empty string for empty input' do
        expect(JobProcessor.new('').find_sequence).to eq('')
      end

      it 'proper result for single job' do
        expect(JobProcessor.new("A=>").find_sequence).to eq('A')
      end

      it 'proper result when no dependencies' do
        input = "A=>\r\nB=>\r\nC=>"
        expect(JobProcessor.new(input).find_sequence).to eq('ABC')
      end

      it 'proper result with single dependency' do
        input = "A=>\r\nB=>C\r\nC=>"
        expect(JobProcessor.new(input).find_sequence).to eq('ACB')
      end

      it 'proper result with multiple dependencies' do
        input = "A=>\r\nB=>C\r\nC=>F\r\nD=>A\r\nE=>B\r\nF=>"
        expect(JobProcessor.new(input).find_sequence).to eq('AFCBDE')
      end
    end

    context 'raises' do
      it 'JobParseError for self-dependency' do
        input = "A=>\r\nB=>\r\nC=>C"
        expect{JobProcessor.new(input).find_sequence}.to raise_error(JobParseError, /can\’t depend on itself/)
      end

      it 'JobProcessorError for circular dependencies' do
        input = "A=>\r\nB=>C\r\nC=>F\r\nD=>A\r\nE=>\r\nF=>B"
        expect{JobProcessor.new(input).find_sequence}.to raise_error(JobProcessorError, /can\'t have circular dependencies/)
      end
    end
  end
end
