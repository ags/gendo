require 'spec_helper'

describe TransactionsController do
  it "creates a Transaction" do
    expect do
      post :create, transaction: {
        controller:   'PostsController',
        action:       'new',
        path:         '/posts/new',
        format:       '*/*',
        method:       'GET',
        status:       200,
        started_at:   Time.now,
        ended_at:     1.second.from_now,
        db_runtime:   0.1234,
        view_runtime: 0.4567,
        duration:     1.98,
      }
    end.to change { Transaction.count }.by(+1)
  end

  it "creates nested sql events" do
    expect do
      post :create, transaction: {
        controller: 'PostsController',
        action:     'new',
        sql_events: [
          {
            sql: "SELECT * FROM users WHERE id = '1'",
            started_at:   Time.now,
            ended_at:     1.second.from_now,
            duration:     0.321,
          }
        ]
      }
    end.to change { SqlEvent.count }.by(+1)
  end
end
