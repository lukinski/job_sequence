require 'tsort'

class JobContainer
  include TSort

  def initialize
    @jobs = Hash.new{|h,k| h[k] = []}
  end

  alias_method :sequence, :tsort

  def add(name, dependency = [])
    @jobs[name] = dependency.blank? ? [] : [dependency]
  end

  def tsort_each_node(&block)
    @jobs.each_key(&block)
  end

  def tsort_each_child(node, &block)
    @jobs[node].each(&block) if @jobs.has_key?(node)
  end
end
