FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Pedido número #{n}." }
    customer # É mesma coisa que: 'association :customer, factory: :customer'
    # belongs_to
  end
end
