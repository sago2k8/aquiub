require 'spec_helper'

RSpec.describe "Aquiub::App::BaseHelper" do
  pending "add some examples to (or delete) #{__FILE__}" do
    let(:helpers){ Class.new }
    before { helpers.extend Aquiub::App::BaseHelper }
    subject { helpers }

    it "should return nil" do
      expect(subject.foo).to be_nil
    end
  end
end
