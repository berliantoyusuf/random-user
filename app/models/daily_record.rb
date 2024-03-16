class DailyRecord < ApplicationRecord
  include ActiveModel::Dirty

  before_save :count_average

  def count_average
    self.male_avg_age   = User.where(gender: 'male').average(:age).to_f if male_count_changed?
    self.female_avg_age = User.where(gender: 'female').average(:age).to_f if female_count_changed?
  end

end
