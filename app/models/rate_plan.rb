class RatePlan < ApplicationRecord
  validate :date_conflict
  DATE_FORMAT = '%m/%d/%Y'

  scope :active, -> { where("rate_plans.end_date IS NULL OR (rate_plans.start_date < :today AND rate_plans.end_date > :today)", today: Time.now.to_s(:db))}

  RECURRENCE = {
    "One-Time" => 0,
    "Monthly" => 1,
    "Quarterly" => 3,
    "Annually" => 12
  }

  def start_date
    display_date(super)
  end

  def end_date
    display_date(super)
  end

  def display_recurrence
    RatePlan::RECURRENCE.invert[recurrence]
  end

  private

  def display_date(date)
    date.try(:strftime, DATE_FORMAT)
  end

  def date_conflict
    if start_date && end_date && start_date > end_date
      errors.add(:start_date, "must be before end date")
      errors.add(:end_date, "must be after start date")
    end
  end
end
