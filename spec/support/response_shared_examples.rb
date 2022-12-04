# http status code check
shared_examples 'return http_status_code' do |status_code|
  it "return #{status_code}" do
    expect(response.status).to eq(status_code)
  end
end

# error message check
shared_examples 'return error_message' do |error_message|
  it "return #{error_message}" do
    expect(JSON.parse(response.body)["error"]).to eq(error_message)
  end
end
