describe 'HTTParty' do
  it 'content-type', vcr: { cassette_name: 'jsonplaceholder/posts', record: :new_episodes } do
    # stub_request(:get, 'https://jsonplaceholder.typicode.com/posts/2').
    #   to_return(status: 200, body: '', headers: {'content-type': 'application/json'})

    response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/#{rand(3)}")
    content_type = response.headers['content-type']
    expect(content_type).to match /application\/json/
  end
end

# IMPORTANTE!
# O VCR ele guarda a requisição feita, para que após novas requisições,
# não precise acessar a internet. Isto, ganha desempenho no testes e posibilita fazer o teste offline (quando guardado)

# Para facilitar, includa o seguinte código no spec_helper:
# require 'vcr'
# VCR.configure do |config|
#   config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
#   config.hook_into :webmock
#   config.configure_rspec_metadata!
#   config.filter_sensitive_data('<API-URL>') { 'https://jsonplaceholder.typicode.com' }
# end
# e para os testes que queira guardar as requisições, basta colocar :vcr igual 'TAG'.
# Colocando apenas :vcr, o proprio VCR gerencia as requisições, caso você queira gerenciar
# Basta colocar:
# vcr: { cassette_name: 'folder/name_file' }

# Use vcr: { match_requests_on: [:body] }, quando a URL é indeterminavel
# Porém, o VCR ainda continua guardando apenas UMA requisição, para que o VCR
# consiga guardar diversas requisições em um unico arquivo, utilize:
# vcr: { record: :new_episodes }

# Opções:
# :once - Unica requisição
# :new_episodes - Guarda diversas requisições sem repetir
# :none - Garante que nunca irá fazer uma requisição
# :all - Guarda cada requisição realizada, mesmo repetindo
