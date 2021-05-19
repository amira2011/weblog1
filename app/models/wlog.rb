class Wlog < ApplicationRecord



def self.apdex(date, date1)
     hash= {}

     data= Wlog.group_by_minute(:Time).where('"RT" != ?', 0).where('"Time" <= ? and "Time" >= ?', date1, date).count
     data1= Wlog.group_by_minute(:Time).where('"RT" != ?', 0).where('"Time" <= ? and "Time" >= ?', date1, date).count
     data2= Wlog.group_by_minute(:Time).where('"RT" != ?', 0).where('"Time" <= ? and "Time" >= ?', date1, date).where('"RT" < ?',   0.3).count
     data3= Wlog.group_by_minute(:Time).where('"RT" != ?', 0).where('"Time" <= ? and "Time" >= ?', date1, date).where('"RT" < ? and "RT" > ?',   1.2, 0.3).count

     #puts data.size, data1.size, data2.size, data3.size


     data.each do |i|
        ts=data1[i[0]]
        sc=data2[i[0]]
        tc=data3[i[0]]



     if sc==nil
           sc=0
     end

     tc=tc.to_f/2
     ap=sc.to_f+tc.to_f
     ap=ap/ts.to_f

     hash[i[0]]=ap
   end
   return hash

end


      def self.import1(file)
        #  CSV.foreach(file.path, headers: true) do |row|
        #    Log.create! row.to_hash
      #    items = []

#items = CSV.read(file.path, headers: true)
    #CSV.foreach(file.path, headers: true) do |row|
    #    items << row.to_h
    #    end
    #    Wlog.import(items)

    batch=[]
    batch_size=6000
    puts "import",  Benchmark.measure {

    CSV.foreach(file.path, liberal_parsing: true, col_sep: " ") do |row|
      date = DateTime.parse(row[3][1..11]+" "+row[3][13..-1])
      rt1= row[10].split("\"")
      rt1= rt1[1].to_f

      u= row[5].split()
        if u[1]
          url_1= u[1].split('?')[0]
        else
          url_1 ='-'
        end

      hash= {:IP => row[0], :Time => date, :URL => u[1],
        :Status => row[6].to_i, :istatus => row[7].to_i, :RT => rt1,
        :Method => u[0], :URL1 =>url_1
         }

      batch.push(hash)

      if batch.size== batch_size
        Wlog.import  batch
        batch=[]
      end


     end
     }
        Wlog.import  batch


      end
















end
