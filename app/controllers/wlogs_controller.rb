class WlogsController < ApplicationController
  before_action :authenticate_user!

  def index


        if params[:date1].present?

  puts "All Record",  Benchmark.measure {
            @date = params[:date1]
            @date_to = params[:date2]
            date=DateTime.parse(@date)
            date1=DateTime.parse(@date_to)
            $date1=date
            $date2=date1
          #  date1= date + 20.minutes
            @total=Wlog.where('"Time" <= ? and "Time" >= ?', date1, date).count
            @total1= Wlog.where('"RT" = ?', 0).where('"Time" <= ? and "Time" >= ?', date1, date).count

            @total2= Wlog.where('"Time" <= ? and "Time" >= ?', date1, date).where('"RT" > ?',   $RT).count
            @total3 =Wlog.where('"Time" <= ? and "Time" >= ?', date1, date).average(:RT)
            @total3 =@total3&.ceil(2)



            @apdex=  Wlog.apdex(date,date1)

            @DataTable_data=Wlog.where('"Time" <= ? and "Time" >= ?', date1, date).where('"RT" > ?',   $RT)


          }

         else
           date1= (a = Wlog.first).present? ? a.Time : 1.hour.ago
           date2= date1 + 20.minutes

           $date1=date1
           $date2=date2

           @total= Wlog.where('"Time" <= ? and "Time" >= ?', date2, date1).count
           @total1= Wlog.where('"RT" = ?', 0).where('"Time" <= ? and "Time" >= ?', date2, date1).count
           @total2= Wlog.where('"Time" <= ? and "Time" >= ?', date2, date1).where('"RT" > ?',   $RT).count
           @total3 =Wlog.where('"Time" <= ? and "Time" >= ?', date2, date1).average(:RT)
           @total3 = @total3.to_f.ceil(2)





           @apdex= Wlog.apdex(date1,date2)
           @DataTable_data=Wlog.where('"Time" <= ? and "Time" >= ?', date2, date1).where('"RT" > ?',   $RT)




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
