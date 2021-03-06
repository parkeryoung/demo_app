require 'rails_helper'

describe RatePlan do
  describe ".active" do
    let!(:active_rate_plan) { FactoryGirl.create(:rate_plan, start_date: Date.today - 1.day, end_date: Date.today + 1.day)}
    let!(:not_yet_active_rate_plan) { FactoryGirl.create(:rate_plan, start_date: Date.today + 1.day, end_date: Date.today + 2.day)}
    let!(:expired_rate_plan) { FactoryGirl.create(:rate_plan, start_date: Date.today - 2.days, end_date: Date.today - 1.days)}

    it "should only return active products" do
      expect(RatePlan.active).to contain_exactly(active_rate_plan)
    end
  end

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
