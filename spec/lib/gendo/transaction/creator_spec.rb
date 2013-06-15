require "spec_helper"

describe Gendo::Transaction::Creator do
  let(:app) { App.make! }
  let(:params) { {
    controller:   "PostsController",
    action:       "new",
    path:         "/posts/new",
    format:       "*/*",
    method:       "GET",
    status:       200,
    started_at:   1370939786.0706801,
    ended_at:     1370939787.0706801,
    db_runtime:   0.1234,
    view_runtime: 0.4567,
    duration:     1.98,
  } }
  subject(:creator) { Gendo::Transaction::Creator.new(app, params) }

  describe ".create!" do
    it "creates a Transaction from the given parameters" do
      transaction = creator.create!

      expect(transaction.app).to              eq(app)
      expect(transaction.controller).to       eq("PostsController")
      expect(transaction.action).to           eq("new")
      expect(transaction.path).to             eq("/posts/new")
      expect(transaction.method).to           eq("GET")
      expect(transaction.status).to           eq(200)
      expect(transaction.started_at.to_f).to  eq(1370939786.0706801)
      expect(transaction.ended_at.to_f).to    eq(1370939787.0706801)
      expect(transaction.db_runtime).to       eq(0.1234)
      expect(transaction.view_runtime).to     eq(0.4567)
      expect(transaction.duration).to         eq(1.98)
    end

    context "with nested SqlEvents" do
      let(:params) { {
        controller:   'PostsController',
        action:       'new',
        started_at:   1,
        ended_at:     2,
        sql_events: [
          {
            sql:          "SELECT * FROM users WHERE id = '1'",
            started_at:   1370939786.0706801,
            ended_at:     1370939787.0706801,
            duration:     0.321,
          }
        ]
      } }

      it "creates nested SqlEvents" do
        transaction = creator.create!

        expect(transaction.sql_events.count).to eq(1)

        sql_event = transaction.sql_events.first
        expect(sql_event.sql).to eq("SELECT * FROM users WHERE id = '1'")
        expect(sql_event.duration).to eq(0.321)
        expect(sql_event.started_at.to_f).to eq(1370939786.0706801)
        expect(sql_event.ended_at.to_f).to eq(1370939787.0706801)
      end
    end
  end

  context "with nested ViewEvents" do
    let(:params) { {
      controller:   'PostsController',
      action:       'new',
      started_at:   1,
      ended_at:     2,
      view_events: [
        {
          identifier:   "/app/views/posts/new.html.erb",
          started_at:   1370939786.0706801,
          ended_at:     1370939787.0706801,
          duration:     0.321,
        }
      ]
    } }

    it "creates nested viewEvents" do
      transaction = creator.create!

      expect(transaction.view_events.count).to eq(1)

      view_event = transaction.view_events.first
      expect(view_event.identifier).to eq("/app/views/posts/new.html.erb")
      expect(view_event.duration).to eq(0.321)
      expect(view_event.started_at.to_f).to eq(1370939786.0706801)
      expect(view_event.ended_at.to_f).to eq(1370939787.0706801)
    end
  end
end
