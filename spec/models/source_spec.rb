require "spec_helper"

describe Source do
  describe ".from_param!" do
    it "finds by id" do
      source = Source.make!(id: 123, controller: "PostsController", action: "new")
      expect(Source.from_param!("123-PostsController#new")).to eq(source)
    end

    context "when no such Source exists" do
      it "raises ActiveRecord::RecordNotFound" do
        expect do
          Source.from_param!("123-PostsController#new")
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#name" do
    it "returns the controller and action" do
      source = Source.new(controller: "PostsController", action: "new")

      expect(source.name).to eq("PostsController#new")
    end
  end

  describe "#to_param" do
    it "returns the id hyphentated with name" do
      source = Source.make!
      expect(source.to_param).to eq("#{source.id}-#{source.name}")
    end
  end

  describe "#latest_requests" do
    let(:source) { Source.make! }
    let!(:a) { Request.make!(source: source, created_at: 3.days.ago) }
    let!(:b) { Request.make!(source: source, created_at: 1.days.ago) }
    let!(:c) { Request.make!(source: source, created_at: 2.days.ago) }

    it "returns associated request sorted by most recently created" do
      expect(source.latest_requests).to eq([b, c, a])
    end

    it "can be limited to a subset of results" do
      expect(source.latest_requests(limit: 1)).to eq([b])
    end
  end

  describe "#latest_n_plus_one_query" do
    it "returns the most recently detected associated NPlusOneQuery" do
      request = Request.make!
      a = NPlusOneQuery.make!(request: request, created_at: 3.days.ago)
      b = NPlusOneQuery.make!(request: request, created_at: 1.days.ago)
      c = NPlusOneQuery.make!(request: request, created_at: 2.days.ago)

      expect(request.source.latest_n_plus_one_query).to eq(b)
    end
  end

  describe "#latest_bulk_insertable" do
    it "returns the most recently detected associated BulkInsertable" do
      request = Request.make!
      a = BulkInsertable.make!(request: request, created_at: 3.days.ago)
      b = BulkInsertable.make!(request: request, created_at: 1.days.ago)
      c = BulkInsertable.make!(request: request, created_at: 2.days.ago)

      expect(request.source.latest_bulk_insertable).to eq(b)
    end
  end

  describe "#latest_mailer_event" do
    it "returns the most recently detected associated MailerEvent" do
      request = Request.make!
      MailerEvent.make!(request: request, created_at: 3.days.ago)
      latest = MailerEvent.make!(request: request, created_at: 1.days.ago)
      MailerEvent.make!(request: request, created_at: 2.days.ago)

      expect(request.source.latest_mailer_event).to eq(latest)
    end
  end

  describe "#mailer_events_created_after" do
    it "returns associated mailer events created after the given date" do
      request = Request.make!

      MailerEvent.make!(request: request, created_at: 2.days.ago)
      recent = MailerEvent.make!(request: request, created_at: 1.minute.ago)

      events = request.source.mailer_events_created_after(1.day.ago)
      expect(events).to eq([recent])
    end
  end

  describe "#median_request_duration_by_day" do
    it "returns the median request duration grouped by day" do
      source = Source.make!
      date_a = Date.new(2013, 1, 1)
      date_b = Date.new(2013, 1, 2)

      Request.make!(source: source, duration: 1, created_at: date_a)
      Request.make!(source: source, duration: 2, created_at: date_a)
      Request.make!(source: source, duration: 3, created_at: date_b)

      expect(source.median_request_duration_by_day.map(&:attributes)).to eq([
        {"date" => date_b, "duration" => 3, "id" => nil},
        {"date" => date_a, "duration" => 1.5, "id" => nil},
      ])
    end
  end
end
