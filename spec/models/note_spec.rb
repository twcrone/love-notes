require "spec_helper"

describe Note do
  it "has a message" do
    Note.create!(message: 'Hi')
    expect(Note.count).to eq(1)
  end
end