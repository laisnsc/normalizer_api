module Api::V1
  class DataController < ApplicationController
    before_action :data_params
    def process_data
      file_data = NormalizerService.new(params[:file], params[:order_ids],
                                        params[:start_date], params[:end_date])
      render json: file_data.process_data, status: :ok

    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end

    private

    def data_params
      params.permit(:file, :order_ids, :start_date, :end_date)
    end
  end
end