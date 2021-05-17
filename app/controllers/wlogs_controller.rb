class WlogsController < ApplicationController
  before_action :authenticate_user!

  def index


        if params[:date1].present?

            @date = params[:date1]
            date=DateTime.parse(@date)
            date1= date + 20.minutes
            @total=Wlog.where('"RT" != ?', 0).where('"Time" <= ? and "Time" >= ?', date1, date).count
            @total1= Wlog.where('"RT" = ?', 0).where('"Time" <= ? and "Time" >= ?', date1, date).count

            @total2= Wlog.where('"Time" <= ? and "Time" >= ?', date1, date).where('"RT" > ?',   3).count
            @total3 =Wlog.where('"Time" <= ? and "Time" >= ?', date1, date).average(:RT)
            @total3 =@total3&.ceil(2)
            @data7= Wlog.group(:Status).where('"Time" <= ? and "Time" >= ?', date1, date).count()

            @data8  =Wlog.where('"Time" <= ? and "Time" >= ?', date1, date).where('"RT" > ?',   3)
            @data  =Wlog.group_by_minute(:Time).where('"Time" <= ? and "Time" >= ?', date1, date).count
            @data6= Wlog.group(:Method).where('"RT" != ?', 0).where('"Time" <= ? and "Time" >= ?', date1, date).average(:RT)

            @data4= Wlog.group(:Time).where('"RT" != ?', 0).where('"Time" <= ? and "Time" >= ?', date1, date).average(:RT)


            @apdex=  Wlog.apdex(date,date1)


         else
           date1= (a = Wlog.first).present? ? a.Time : 1.hour.ago
           date2= date1 + 20.minutes

           @apdex= Wlog.apdex(date1,date2)

           @total= Wlog.where('"RT" != ?', 0).where('"Time" <= ? and "Time" >= ?', date2, date1).count
           @total1= Wlog.where('"RT" = ?', 0).where('"Time" <= ? and "Time" >= ?', date2, date1).count
           @total2= Wlog.where('"Time" <= ? and "Time" >= ?', date2, date1).where('"RT" > ?',   3).count
           @total3 =Wlog.where('"Time" <= ? and "Time" >= ?', date2, date1).average(:RT)
           @total3 = @total3.to_f.ceil(2)
           @data4= Wlog.group(:Time).where('"RT" != ?', 0).where('"Time" <= ? and "Time" >= ?', date2, date1).average(:RT)
           @data3 =Wlog.group(:Time).where('"Time" <= ? and "Time" >= ?', date1, date).average(:RT)
           @data  =Wlog.group_by_minute(:Time).where('"Time" <= ? and "Time" >= ?', date2, date1).count
        #  @data5=Wlog.where("RT> 5 AND methods='GET'").order("RT DESC").first(10)
          @data6= Wlog.group(:Method).where('"Time" <= ? and "Time" >= ?', date2, date1).average(:RT)
           @data7= Wlog.group(:Status).where('"Time" <= ? and "Time" >= ?', date2, date1).count()
           @data8=Wlog.where('"Time" <= ? and "Time" >= ?', date2, date1).where('"RT" > ?',   3)

         end

  end

  def home
  end

  def import1
   Wlog.import1(params[:file])
   redirect_to wlogs_path, notice: "Logs Added successfully"
 end


   def import2

    Wlog.import2
    redirect_to wlogs_path, notice: "Logs Added successfully"

  end



  def RT


    if params[:rt1].present?

      $RT= params[:rt1]
      $RT= $RT&.to_f
    end

  end





end
