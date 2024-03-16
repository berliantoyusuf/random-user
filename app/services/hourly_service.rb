class HourlyService
  def initialize(results)
    @results = results
  end

  def call
    results = mapping_results

    existing_data = User.where(uuid: results.pluck(:uuid))

    if existing_data.present?
      existing_data.each do |data|
        element = results.select {|result| result[:uuid] == data.uuid.to_s}

        data.update(element)
        results.delete_if{|result| result[:uuid] == data.uuid.to_s}
      end

      create_user(results)
    else
      create_user(results)
    end

  end

  private
  def mapping_results
    mapped_results = []

    @results.each do |result|
      obj = {
        uuid: result['login']['uuid'],
        gender: result['gender'],
        name: result['name'],
        location: result['location'],
        age: result['dob']['age']
      }

      mapped_results << obj
    end

    mapped_results
  end

  def create_user(results)
    User.insert_all(results)

    female_count = REDIS.get('female_count').to_i
    male_count   = REDIS.get('male_count').to_i

    new_female_count = results.select { |result| result[:gender] == 'female' }.count
    new_male_count   = results.select { |result| result[:gender] == 'male' }.count

    REDIS.set('female_count', female_count + new_female_count)
    REDIS.set('male_count', male_count + new_male_count)
  end
end