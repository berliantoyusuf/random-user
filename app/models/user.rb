class User < ApplicationRecord
  after_destroy :update_daily_record
  def self.insert_all(records)
    normalized = normalize(records)
    super(normalized)
  end

  def self.normalize(records)
    records.each do |rec|
      add_timestamp(rec)
    end
  end

  def self.add_timestamp(record)
    time = Time.now.utc
    record['created_at'] = time
    record['updated_at'] = time
  end

  def full_name
    name['first'] + ' ' + name['last']
  end

  private
  def update_daily_record
    female_count = REDIS.get('female_count').to_i
    male_count   = REDIS.get('male_count').to_i

    if gender == 'female'
      female_count = female_count - 1
      REDIS.set('female_count', female_count)
    else
      male_count = male_count - 1
      REDIS.set('male_count', male_count)
    end

    date = Time.now.to_date.to_s
    daily_record = DailyRecord.find_or_create_by(date: date)

    daily_record.female_count = female_count
    daily_record.male_count   = male_count
    daily_record.save
  end
end
