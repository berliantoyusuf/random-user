class DailyWorkerJob
  include Sidekiq::Job

  def perform
    date         = Time.now.to_date.to_s
    female_count = REDIS.get('female_count').to_i
    male_count   = REDIS.get('male_count').to_i

    DailyService.new(date, female_count, male_count).call
  end
end