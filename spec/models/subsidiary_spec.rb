require 'rails_helper'

describe Subsidiary, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:cnpj]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:address]).to include('não pode ficar em branco')
    end

    it 'cnpj must be uniq' do
      Subsidiary.create!(name: 'Vila Leopoldo', cnpj: '52.172.478/0001-00', 
                         address: 'Rua Ananias, 566')
      subsidiary = Subsidiary.new(cnpj: '52.172.478/0001-00')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end

    it 'cnpj length must be 18' do
      subsidiary = Subsidiary.new(cnpj: '52.172.478/001-00')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('não possui o tamanho esperado (18 caracteres)')
    end

    it 'cnpj is not valid' do
      subsidiary = Subsidiary.new(cnpj: '52.172.478/0001-79')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('não é válido')
    end
  end
end
