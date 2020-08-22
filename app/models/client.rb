class Client < ApplicationRecord
  validates :name, :cpf, :email, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, length: { is: 14 }

  validate :cpf_can_have_12_type_of_characters
  validate :cpf_must_be_valid

  def information
    "#{name} - #{cpf}"
  end

  private

  def cpf_can_have_12_type_of_characters
    return if cpf.blank?
    return if cpf.length != 14
    if cpf.count('0-9') != 11 || cpf.count('.') != 2 || cpf.count('-') != 1
      errors.add(:cpf, 'os caracteres aceitos para CPF são: números(0 a 9), ponto(.) e traço(-)')
    end
  end

  def cpf_must_be_valid
    return if cpf.blank?
    return if CPF.valid?(cpf, strict: true)

    errors.add(:cpf, :invalid)
  end
end
