require 'spec_helper'

describe RomanticMeeting do

  before :each do
    Time.stub(:now) { Time.new(2013,1,1, 1,1,1) }
  end

  it "can be created normally" do
    RomanticMeeting.create! start: Time.now, length: 60
  end

  it "can be created with chronic fields" do
    r = RomanticMeeting.create! chronic_start: "now", chronic_duration_length: "1 minute"
    r.should be_valid
    r.start.should == Time.zone.now
    r.length.should == 60
  end

  it "accepts blank values fields that aren't 'required'" do
    r = RomanticMeeting.create chronic_start: "now", chronic_duration_length: ""
    r.should be_valid
    r.start.should == Time.zone.now
    r.length.should be_nil
  end

  it "fails when blank values are passed for 'required' fields" do
    r = RomanticMeeting.create chronic_start: "", chronic_duration_length: ""
    r.should_not be_valid
    r.should have(1).errors_on(:chronic_start)
    r.should have(:no).errors_on(:chronic_duration_length)
  end

  it "fails on unparsable nonsense" do
    r = RomanticMeeting.create chronic_start: "the last iceage", chronic_duration_length: "a mother-in-law's visit"
    r.should_not be_valid
    r.should have(1).errors_on(:chronic_start)
    r.should have(1).errors_on(:chronic_duration_length)
  end
end
