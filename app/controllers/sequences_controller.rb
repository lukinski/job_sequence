require 'job_processor'

class SequencesController < ApplicationController
  def index
  end

  def create
    begin
      sequence = JobProcessor.new(params[:job_input]).find_sequence
      render json: {sequence: sequence}
    rescue Exception => e
      render json: { error: e.message }, status: 422
    end
  end
end
