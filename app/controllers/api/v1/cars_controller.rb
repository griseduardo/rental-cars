class Api::V1::CarsController < Api::V1::ApiController
  def index
    render json: Car.available
  end
end