module Api::V1
  class DataController < ApplicationController
    def process_data
      file_data = NormalizerService.new(params[:file])
      render json: file_data.process_data, status: :ok

    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end
end