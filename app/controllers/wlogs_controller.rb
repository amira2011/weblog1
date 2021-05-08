class WlogsController < ApplicationController
  def index


        if params[:date1].present?

            @date = params[:date1]
            date=DateTime.parse(@date)
            date1= date + 20.minutes
            @sdata  =Wlog.where('Time <= ? and Time >= ?', date1, date).where("rt> 1 AND methods='GET'").order("RT DESC")
            @data  =Wlog.group(:Time).where('Time <= ? and Time >= ?', date1, date).count
            @data6= Wlog.group(:Methods).where('Time <= ? and Time >= ?', date1, date).average(:rt)

            @data4= Wlog.group(:Time).where('Time <= ? and Time >= ?', date1, date).average(:rt)
            @apdex=  Wlog.apdex(date,date1)
         else

           #@apdex= Wlog.apdex()
          # @data4= Wlog.group(:Time).where("RT >= 3").count
           @data3 =Wlog.group(:Time).average(:RT)
           @data  =Wlog.group(:Time).count
          #@data5=Wlog.where("RT> 5 AND methods='GET'").order("RT DESC").first(10)
         @data6= Wlog.group(:Method).average(:RT)
           @data7= Wlog.group(:Status).count()
         end

  end

  def home
  end

  def import1
   Wlog.import1(params[:file])
   redirect_to wlogs_path, notice: "Logs Added successfully"
 end





end
