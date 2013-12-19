require 'spec_helper'

describe App do
  include_examples "has access tokens", AppAccessToken

  describe ".from_param" do
    it "returns the App with the given slug" do
      app = App.make!
      expect(App.from_param(app.slug)).to eq(app)
    end

    context "when no such app exists" do
      it "raises ActiveRecord::RecordNotFound" do
        expect do
          App.from_param("rei")
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#slug" do
    it "returns the App id + parameterized name" do
      app = App.make!
      expect(app.slug).to eq("#{app.id}-#{app.name.parameterize}")
    end
  end

  describe "#find_or_create_source!" do
    let(:params) { {
      controller: "FooCtrl",
      action: "bar",
      method_name: "post",
      format_type: "json"
    } }
    let(:app) { App.make! }

    it "creates an associated source with the given attributes" do
      source = app.find_or_create_source!(params)
      source = app.find_or_create_source!(params)

      expect(app.sources).to eq([source])
      params.each do |attribute, value|
        expect(source.send(attribute)).to eq(value)
      end
    end

    context "handling race conditions" do
      let(:not_unique_error) { ActiveRecord::RecordNotUnique.new('not unique') }

      it "retries on RecordNotUnique" do
        relation_a = double(:relation_a)
        relation_b = double(:relation_b)
        source = double(:source)

        allow(app.sources).to \
          receive(:where).
          with(params).
          and_return(relation_a, relation_b)

        allow(relation_a).to \
          receive(:first_or_create!).
          and_raise(not_unique_error)

        allow(relation_b).to \
          receive(:first_or_create!).
          and_return(source)

        expect(app.find_or_create_source!(params)).to eq(source)
      end

      it "propogates other exceptions" do
        allow(app.sources).to \
          receive(:where).
          and_raise(RuntimeError)

        expect do
          app.find_or_create_source!(params)
        end.to raise_error(RuntimeError)
      end

      it "has a maximum number of attempts" do
        relation = double(:relation)

        allow(app.sources).to \
          receive(:where).
          and_return(relation)

        allow(relation).to \
          receive(:first_or_create!).
          and_raise(not_unique_error)

        expect do
          app.find_or_create_source!(params)
        end.to raise_error(not_unique_error)
      end
    end
  end
end
