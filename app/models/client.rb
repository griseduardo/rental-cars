class Client < ApplicationRecord
  validates :name, :cpf, :email, presence: true

  def information
    "#{name} - #{cpf}"
  end
end
