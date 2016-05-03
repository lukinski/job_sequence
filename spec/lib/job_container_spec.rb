require 'rails_helper'
require 'job_container'

RSpec.describe 'JobContainer' do
  let(:job_container) { JobContainer.new }

  describe ':new object' do
    it 'can generate #sequence' do
      expect(job_container).to respond_to(:sequence)
    end

    it 'can #add dependency' do
      expect(job_container).to respond_to(:add)
    end
  end

  context 'TSort compatibility' do
    it 'supports #tsort_each_node' do
      expect(job_container).to respond_to(:tsort_each_node)
    end

    it 'supports #tsort_each_child' do
      expect(job_container).to respond_to(:tsort_each_child)
    end
  end
end
