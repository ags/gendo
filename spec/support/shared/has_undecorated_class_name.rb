class FooBar; end

shared_examples "a decorator with undecorated class name methods" do
  describe "#underscored_class_name" do
    it "is the underscored class name of the decorated object" do
      object = FooBar.new
      decorated = described_class.new(object)

      expect(decorated.underscored_class_name).to eq("foo_bar")
    end
  end
end
