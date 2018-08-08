require 'rails_helper'

RSpec.describe Customer, type: :model do

  context '#full_name' do
    # Carrega o arquivo spec/fixtures/customer.yml
    # fixtures :all # Carrega todas as fixtures
    fixtures :customers

    it 'Utilizando Fixtures - Antigo' do
      customer = customers(:henrique)
      expect(customer.full_name).to eq "Sr. Henrique Shiraishi"
    end

    it 'Utilizando Factories - Recomando' do
      customer = create(:customer) # ou create(:user)     -> Por conta da aliases da factory
      expect(customer.full_name).to start_with "Sr. "
    end

    it 'Sobreescrevendo atributo' do
      customer = create(:customer, name: "Henrique Shiraishi")
      expect(customer.full_name).to eq "Sr. Henrique Shiraishi"
    end
  end

  it 'Herança de Factory' do
    customer_vip = create(:customer_vip)
    customer_default = create(:customer_default)

    expect(customer_vip.vip).to be_truthy
    expect(customer_vip.days_to_pay).to eq 30

    expect(customer_default.vip).to be_falsey
    expect(customer_default.days_to_pay).to eq 15
  end

  it { expect{ create(:customer) }.to change {Customer.all.size}.by(1) }
end

# Quando chamamos o customers(:jackson), pegamos as informações de
# name e email no arquivo spec/fixtures/customers.yml, mesmo não cadastrado,
# nós conseguimos testar o método full_name do model Customer, pois o subject é Customer.
