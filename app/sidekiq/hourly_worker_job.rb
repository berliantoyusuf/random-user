class HourlyWorkerJob
  include Sidekiq::Job
  def perform(retry_count = nil)
    response = HTTParty.get('https://randomuser.me/api/?results=20')

    if response.code == 200
      results = JSON.parse(response.body).try(:[], 'results')

      HourlyService.new(results).call
    else
      new_retry_count = retry_count.blank? ? 1 : retry_count + 1

      HourlyWorkerJob.perform_in(5.minutes, new_retry_count) unless new_retry_count > 3
    end
  end
end
