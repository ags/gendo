JsonExpressions::Matcher.assume_strict_hashes = false

def expect_response_body(expression)
  expect(response_body).to match_json_expression(expression)
end

def response_body
  JSON.parse(response.body)
end

def expect_response_status(status)
  expect(response.status).to eq(status)
end

def expect_validation_failure(errors)
  expect_response_status(422)
  expect_response_body(
    message: "Validation failed.",
    errors: errors.is_a?(Array) ? errors : [errors]
  )
end
