require 'draper'
require './spec/support/shared_examples_for_decorates_event_timestamps'
require './app/decorators/app_decorator'

Draper::ViewContext.test_strategy :fast

class App; end

describe AppDecorator do
  let(:app) { stub(:app) }
  subject(:decorated) { AppDecorator.new(app) }

  describe "#latest_transactions" do
    it "delegates to the App and decorates the result" do
      latest_transactions = stub(:latest_transactions)
      decorated_transactions = stub(:decorated_transactions)

      app.should_receive(:latest_transactions) { latest_transactions }
      latest_transactions.should_receive(:decorate) { decorated_transactions }

      expect(decorated.latest_transactions).to eq(decorated_transactions)
    end
  end

  describe "#worst_sources_by_db_runtime" do
    it "delegates to App#sources_by_median_desc for db_runtime" do
      worst_sources = stub(:worst_sources)

      app.should_receive(:sources_by_median_desc).
        with(:db_runtime, limit: 3).
        and_return(worst_sources)

      expect(decorated.worst_sources_by_db_runtime).to eq(worst_sources)
    end
  end
end
