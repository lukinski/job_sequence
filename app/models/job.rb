class Job
  include ActiveModel::Model

  validates_presence_of :name
  validate :check_dependency

  attr_accessor :name, :dependency

  def initialize(name, dependency = nil)
    @name, @dependency = name, dependency
  end

  private

  def check_dependency
    errors.add(:dependency, "can’t depend on itself") if dependency == name
  end
end
