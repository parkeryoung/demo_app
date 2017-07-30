require 'rails_helper'

describe Product do
  describe "#date_conflict" do
    it "should add errors if the start date is after the end date" do
      subject.start_date = Date.today
      subject.end_date = Date.today - 1.day
      expect(subject.errors).to be_empty
      subject.send(:date_conflict)
      expect(subject.errors).to_not be_empty
      expect(subject.errors.keys).to contain_exactly(:start_date, :end_date)
    end

    it "should not add errors if the start date is before the end date" do
      subject.start_date = Date.today
      subject.end_date = Date.today + 1.day
      expect(subject.errors).to be_empty
      subject.send(:date_conflict)
      expect(subject.errors).to be_empty
    end
  end
end
