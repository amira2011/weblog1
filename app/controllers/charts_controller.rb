class ChartsController < ApplicationController



  def completed_tasks
    render json: Wlog.group_by_day(:created_at).count
  end




  def server_throughput
    render json: Wlog.group_by_minute(:Time).where('"Time" <= ? and "Time" >= ?',   $date2,   $date1).count
  end

def average_RT
render json: Wlog.group_by_minute(:Time).where('"Time" <= ? and "Time" >= ?', $date2,   $date1).average(:RT)

end

def error_rate

  render json: Wlog.group_by_minute(:Time).where('"Time" <= ? and "Time" >= ?', $date2,   $date1).where('"Status" = ? ', "400").count


end

def method_RT
render json:    Wlog.group(:Method).where('"RT" != ?', 0).where('"Time" <= ? and "Time" >= ?', $date2,   $date1).average(:RT)

end


end
