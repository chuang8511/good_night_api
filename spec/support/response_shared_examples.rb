# http status code check
shared_examples 'return http_status_code' do |status_code|
  it "return #{status_code}" do
    expect(response.status).to eq(status_code)
  end
end
