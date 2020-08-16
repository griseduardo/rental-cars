class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: true
  validates :cnpj, uniqueness: true
  validates :cnpj, length: { is: 18 }

  validate :cnpj_can_have_13_characters
  validate :cnpj_must_be_valid

  def cnpj_can_have_13_characters
    if cnpj.present? && cnpj.length == 18 
      if cnpj.count("0-9") != 14 || cnpj.count(".") != 2 || cnpj.count("/") != 1 || cnpj.count("-") != 1
        errors.add(:cnpj, 'os caracteres aceitos são: números(0 a 9), ponto(.), barra(/) e traço(-)')
      end
    end
  end

  def cnpj_must_be_valid
    if cnpj.present? && !CNPJ.valid?(cnpj, strict: true)
      errors.add(:cnpj, 'não é válido')
    end
  end
end
