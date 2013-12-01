def expect_response_body(body)
  expect(response_body).to eq(body.stringify_keys)
end

def response_body
  JSON.parse(response.body)
end

def expect_response_status(status)
  expect(response.status).to eq(status)
end
