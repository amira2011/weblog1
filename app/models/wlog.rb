class Wlog < ApplicationRecord

  def self.apdex(date, date1)
     hash= {}
     data= Wlog.group(:Time).where('"Time" <= ? and "Time" >= ?', date1, date).select(:Time)
     data1= Wlog.group(:Time).where('"Time" <= ? and "Time" >= ?', date1, date).count
     data2= Wlog.group(:Time).where('"Time" <= ? and "Time" >= ?', date1, date).where('"RT" < ?',   0.05).count
     data3= Wlog.group(:Time).where('"Time" <= ? and "Time" >= ?', date1, date).where('"RT" < ? and "RT" > ?',   0.2, 0.05).count

     puts data

   data.each do |i|

     ts=data1[i.Time]
     sc=data2[i.Time]
     tc=data3[i.Time]


     if sc==nil
       sc=0
     end
      print "ts ", ts, " sc ", sc, " tc ", tc , "\n"
      tc=tc.to_f/2
     ap=sc.to_f+tc.to_f
     ap=ap/ts.to_f

     hash[i.Time]=ap

  end

  return hash

   end


      def self.import1(file)
        #  CSV.foreach(file.path, headers: true) do |row|
        #    Log.create! row.to_hash
          items = []

#items = CSV.read(file.path, headers: true)
    CSV.foreach(file.path, headers: true) do |row|
        items << row.to_h
        end
        Wlog.import(items)
      end


end
