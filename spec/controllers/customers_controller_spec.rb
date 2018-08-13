require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  it 'responds succesfully' do
    get :index
    expect(response).to be_success
  end

  it 'returns a :ok response' do
    get :index
    expect(response).to have_http_status :ok
  end
end
