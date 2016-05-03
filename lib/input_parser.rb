require 'dependency_error'

class InputParser
  def initialize(separator = '=>')
    @separator = separator
  end

  def parse(input_string)
    @jobs = []
    input_string.each_line { |line| parse_line(line) }
    @jobs
  end

  private

  def parse_line(line)
    name, dependency = line.chomp.split(@separator).map { |c| c.blank? ? nil : c }
    add_job(name, dependency)
  end

  def add_job(name, dependency)
    job = Job.new(name, dependency)
    raise DependencyError, job.errors.full_messages.first if job.invalid?
    @jobs << job
  end
end
