class WlogsController < ApplicationController
  def index


        if params[:date1].present?

            @date = params[:date1]
            date=DateTime.parse(@date)
            date1= date + 20.minutes
            @data8  =Wlog.where('"Time" <= ? and "Time" >= ?', date1, date).where('"RT" > ?',   3)
            @data  =Wlog.group(:Time).where('"Time" <= ? and "Time" >= ?', date1, date).count
            @data6= Wlog.group(:Method).where('"Time" <= ? and "Time" >= ?', date1, date).average(:RT)

            @data4= Wlog.group(:Time).where('"Time" <= ? and "Time" >= ?', date1, date).average(:RT)
            @apdex=  Wlog.apdex(date,date1)
         else
           date1= Wlog.first.Time
           date2= date1 + 20.minutes
           @apdex= Wlog.apdex(date1,date2)
           @data4= Wlog.group(:Time).where('"RT" > ?',   0.005).count
           @data3 =Wlog.group(:Time).average(:RT)
           @data  =Wlog.group(:Time).count
          #@data5=Wlog.where("RT> 5 AND methods='GET'").order("RT DESC").first(10)
          @data6= Wlog.group(:Method).average(:RT)
           @data7= Wlog.group(:Status).count()
           @data8=Wlog.where('"RT" > ?',   3)
         end

  end

  def home
  end

  def import1
   Wlog.import1(params[:file])
   redirect_to wlogs_path, notice: "Logs Added successfully"
 end





end
