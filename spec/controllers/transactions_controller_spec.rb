require 'spec_helper'

describe TransactionsController do
  before do
    User.make!
  end

  it "creates a Transaction" do
    expect do
      post :create, transaction: {
        controller:   'PostsController',
        action:       'new',
        path:         '/posts/new',
        format:       '*/*',
        method:       'GET',
        status:       200,
        started_at:   1370939786.0706801,
        ended_at:     1370939787.0706801,
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
        started_at:   1370939786.0706801,
        ended_at:     1370939787.0706801,
        sql_events: [
          {
            sql: "SELECT * FROM users WHERE id = '1'",
            started_at:   1370939786.0706801,
            ended_at:     1370939787.0706801,
            duration:     0.321,
          }
        ]
      }
    end.to change { SqlEvent.count }.by(+1)
  end

  it "creates nested view events" do
    expect do
      post :create, transaction: {
        controller: 'PostsController',
        action:     'new',
        started_at:   1370939786.0706801,
        ended_at:     1370939787.0706801,
        view_events: [
          {
            identifier:   '/foo/bar.html.erb',
            started_at:   1370939786.0706801,
            ended_at:     1370939787.0706801,
            duration:     0.321,
          }
        ]
      }
    end.to change { ViewEvent.count }.by(+1)
  end
end
