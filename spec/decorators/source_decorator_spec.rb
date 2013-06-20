require 'draper'
require './app/decorators/source_decorator'

Draper::ViewContext.test_strategy :fast

class Source; end

describe SourceDecorator do
  let(:source) { stub(:source) }
  subject(:decorated) { SourceDecorator.new(app) }

  pending
end
