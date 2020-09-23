class Api::V1::CarsController < Api::V1::ApiController

  def index
    render json: Car.available
  end

  def show
    @car = Car.find(params[:id])
    render json: @car if @car
  end

  def create
    @car = Car.new(car_params)
    @car.save!
    render status: :created, json: @car

  rescue ActionController::ParameterMissing
    render status: :precondition_failed, json: 'Parâmetros inválidos'
  end

  private

  def car_params
    params.require(:car).permit(:license_plate, :color, :mileage, :car_model_id, :subsidiary_id)
  end
end