require "spec_helper"

describe CreatesRequest do
  let(:app) { App.make! }
  let(:source) { {
    controller:     "PostsController",
    action:         "new",
    format_type:    "*/*",
    method_name:    "GET",
  } }
  let(:default_payload) { {
    source:         source,
    shinji_version: "0.0.1",
    framework:      "Rails 5.0.0",
    path:           "/posts/new",
    status:         200,
    started_at:     1370939786.0706801,
    ended_at:       1370939787.0706801,
    db_runtime:     0.1234,
    view_runtime:   0.4567,
    duration:       1.98,
  } }
  let(:payload) { default_payload }

  subject(:request) { CreatesRequest.create!(app, payload) }

  describe "#create!" do
    it "creates a Request from the given parameters" do
      expect(request.source.app).to         eq(app)
      expect(request.source.controller).to  eq("PostsController")
      expect(request.source.action).to      eq("new")
      expect(request.source.method_name).to eq("GET")
      expect(request.source.format_type).to eq("*/*")

      expect(request.shinji_version).to     eq("0.0.1")
      expect(request.framework).to          eq("Rails 5.0.0")
      expect(request.path).to               eq("/posts/new")
      expect(request.status).to             eq(200)
      expect(request.started_at.to_f).to    eq(1370939786.0706801)
      expect(request.ended_at.to_f).to      eq(1370939787.0706801)
      expect(request.db_runtime).to         eq(0.1234)
      expect(request.view_runtime).to       eq(0.4567)
      expect(request.duration).to           eq(1.98)
    end

    context "with nested sql_events data" do
      let(:payload) { {
        source:       source,
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
        expect(request.sql_events.count).to eq(1)

        sql_event = request.sql_events.first
        expect(sql_event.sql).to eq("SELECT * FROM users WHERE id = '1'")
        expect(sql_event.duration).to eq(0.321)
        expect(sql_event.started_at.to_f).to eq(1370939786.0706801)
        expect(sql_event.ended_at.to_f).to eq(1370939787.0706801)
      end
    end

    context "with nested view_events data" do
      let(:payload) { {
        source:         source,
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

      it "creates nested ViewEvents" do
        expect(request.view_events.count).to eq(1)

        view_event = request.view_events.first
        expect(view_event.identifier).to eq("/app/views/posts/new.html.erb")
        expect(view_event.duration).to eq(0.321)
        expect(view_event.started_at.to_f).to eq(1370939786.0706801)
        expect(view_event.ended_at.to_f).to eq(1370939787.0706801)
      end
    end

    context "with nested mailer_events data" do
      let(:payload) { {
        source:         source,
        started_at:   1,
        ended_at:     2,
        mailer_events: [
          {
            mailer:     "FooMailer",
            message_id: "123@mba.local.mail",
            started_at: 1370939786.0706801,
            ended_at:   1370939787.0706801,
            duration:   0.321,
          }
        ]
      } }

      it "creates nested MailerEvents" do
        expect(request.mailer_events.count).to eq(1)

        mailer_event = request.mailer_events.first
        expect(mailer_event.mailer).to eq("FooMailer")
        expect(mailer_event.message_id).to eq("123@mba.local.mail")
        expect(mailer_event.duration).to eq(0.321)
        expect(mailer_event.started_at.to_f).to eq(1370939786.0706801)
        expect(mailer_event.ended_at.to_f).to eq(1370939787.0706801)
      end
    end

    context "when the given source already exists" do
      it "uses the existing source" do
        source = Source.make!(payload[:source].merge(app: app))

        expect {
          expect { request }.to change { source.requests.count }.by(1)
        }.to_not change { Source.count }
      end
    end

    context "when the given db_runtime is nil" do
      let(:payload) { default_payload.merge(db_runtime: nil) }

      it "sets the db_runtime to 0.0" do
        expect(request.db_runtime).to eq(0.0)
      end
    end

    context "when the given view_runtime is nil" do
      let(:payload) { default_payload.merge(view_runtime: nil) }

      it "sets the view_runtime to 0.0" do
        expect(request.view_runtime).to eq(0.0)
      end
    end

    context "when the given duration is nil" do
      let(:payload) { default_payload.merge(duration: nil) }

      it "sets the duration to 0.0" do
        expect(request.duration).to eq(0.0)
      end
    end
  end
end
