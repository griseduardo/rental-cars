class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: true
  validates :cnpj, uniqueness: true
  validates :cnpj, length: { is: 18 }

  validate :cnpj_must_be_valid

  def cnpj_must_be_valid
    if cnpj.present? && !CNPJ.valid?(cnpj, strict: true)
      errors.add(:cnpj, 'não é válido')
    end
  end
end
