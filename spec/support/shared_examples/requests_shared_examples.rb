RSpec.shared_examples_for "it returns an unauthorized error" do
  before do
    send(method, path, params: data.merge(format: :json), headers: headers)
  end

  it "fails with a 401 response" do
    expect(response).to be_unauthorized
  end
end

RSpec.shared_examples_for "is a valid request" do
  before do
    send(method, path, params: data.merge(format: :json), headers: headers)
  end

  it "returns with a success response" do
    expect(response).to be_success
  end
end

RSpec.shared_examples_for "it returns an unprocessable error" do
  before do
    send(method, path, params: data.merge(format: :json), headers: headers)
  end

  it "fails with a 422 response" do
    expect(response).to be_unprocessable
  end
end
