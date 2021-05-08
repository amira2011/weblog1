class Wlog < ApplicationRecord

  def self.apdex(date, date1)
     hash= {}
     data= Wlog.group(:Time).where('Time <= ? and Time >= ?', date1, date).select(:Time)
     data1= Wlog.group(:Time).where('Time <= ? and Time >= ?', date1, date).count
     data2= Wlog.group(:Time).where('Time <= ? and Time >= ?', date1, date).where("RT <=0.03").count
     data3= Wlog.group(:Time).where('Time <= ? and Time >= ?', date1, date).where("RT > 0.03 AND RT < 0.12 ").count


   data.each do |i|

     ts=data1[i.Time]
     sc=data2[i.Time]
     tc=data3[i.Time]
     tc=tc/2
     ap=sc+tc
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
