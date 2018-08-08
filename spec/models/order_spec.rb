require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'belongs_to' do
    order = create(:order)
    expect(order.customer).to be_kind_of(Customer)
  end

  it '#create_list' do
    # Existe o método create_pair, que cria como defult 2 registros
    orders = create_list(:order, 3)
    expect(orders.count).to eq 3
  end

  it 'has_many' do
    customer_orders = create(:customer, :with_orders)
    customer_5_orders = create(:customer, :with_orders, qtt_orders: 5)

    expect(customer_orders.orders.count).to eq 3
    expect(customer_5_orders.orders.count).to eq 5
  end
end
