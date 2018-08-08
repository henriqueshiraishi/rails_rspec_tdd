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

  it '#travel_to' do
    # Time.zone.local(ANO, MES, DIA, HORAS, MINUTOS, SEGUNDOS)
    travel_to Time.zone.local(2004, 11, 24, 01, 04, 44) do
      @customer = create(:customer_vip)
    end
    expect(@customer.created_at).to eq Time.zone.local(2004, 11, 24, 01, 04, 44)
    expect(@customer.created_at).to be < Time.zone.now
  end

  it 'Cliente Masculino Vip' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq 'M'
    expect(customer.vip).to be_truthy
  end

  it 'Cliente Masculino Default' do
    customer = create(:customer_male_default)
    expect(customer.gender).to eq 'M'
    expect(customer.vip).to be_falsey
  end

  it 'Atributo Transitório' do
    customer = create(:customer_default, upcased:true)
    expect(customer.name.upcase).to eq customer.name
  end

  it 'Usando o attributes_for' do
      attrs = attributes_for(:customer)
      customer = Customer.create(attrs)
      expect(customer.full_name).to eq "Sr. #{attrs[:name]}"
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
