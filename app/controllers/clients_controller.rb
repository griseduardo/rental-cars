class ClientsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create]
  def index
    
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client, notice: 'Cliente cadastrado com sucesso!'
    else
      render :new
    end
  end

  private

  def client_params 
    params.require(:client)
          .permit(:name, :cpf, :email)
  end

end