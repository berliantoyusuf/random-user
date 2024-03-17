class DailyRecordsController < ApplicationController
  def index
    @daily_records = DailyRecord.all

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @posts }
    end
  end

end
