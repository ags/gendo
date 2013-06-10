require 'spec_helper'

describe TransactionController do
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
end
