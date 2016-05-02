require 'rails_helper'

RSpec.describe Job, type: :model do
  context ':new object' do
    let(:job) { Job.new }

    it 'responds to all necessary attributes' do
      %w[name dependency].each do |attr|
        expect(job).to respond_to(attr)
      end
    end

    it 'is invalid without name' do
      job.name = nil
      job.valid?
      expect(job.errors.messages[:name]).to_not be_empty
    end

    it 'can\'t depend on itself' do
      job.dependency = job.name
      job.valid?
      expect(job.errors.messages[:dependency]).to_not be_empty
    end
  end
end
