class DailyService
  def initialize(date, female_count, male_count)
    @date         = date
    @female_count = female_count
    @male_count   = male_count
  end

  def call
    daily_record = DailyRecord.find_or_create_by(date: @date)

    daily_record.female_count = @female_count
    daily_record.male_count   = @male_count
    daily_record.save
  end

end
