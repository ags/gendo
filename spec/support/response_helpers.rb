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

def expect_missing_authorization
  expect_response_status(401)
  expect_response_body(message: "Authorization header missing or empty.")
end

def expect_not_found
  expect_response_status(404)
  expect_response_body(message: "Resource not found.")
end
