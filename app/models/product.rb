class Product < ApplicationRecord
  validate :date_conflict
  has_many :rate_plans

  DATE_FORMAT = '%m/%d/%Y'

  scope :active, -> { where("products.end_date IS NULL OR products.end_date > ?", Time.now.to_s(:db))}

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
