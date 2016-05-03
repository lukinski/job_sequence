require 'input_parser'
require 'job_container'

class JobProcessor
  def initialize(input_string)
    @input = input_string
    @job_container = JobContainer.new
  end

  def find_sequence
    load_jobs
    begin
      @job_container.sequence.join
    rescue TSort::Cyclic
      raise JobProcessorError
    end
  end

  private

  def load_jobs
    InputParser.new.parse(@input).each do |job|
      @job_container.add(job.name, job.dependency)
    end
  end
end

class JobProcessorError < StandardError
  def initialize(msg = 'Jobs can\'t have circular dependencies')
    super
  end
end
