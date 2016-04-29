require 'spreadsheet'

class DataImporter

  # Bulk insert will disable the auto sync with ES , so will go with regular insert for now
  def self.import(file_path)
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet.open "#{Rails.root}#{file_path}"

    ngos = get_ngos(book.worksheet 0)
    demands = get_deamnds(book.worksheet 1)
    
    ngos.each{|ngo|
      begin
        next if ngo.id.blank? || ngo.id == 0
        ngo_id = ngo.id
        ngo.id = nil #to avoid conflict
        ngo.save()

        demands.each{|demand| 
          if demand.ngo_id == ngo_id 
            demand.ngo_id = ngo.id 
            demand.save()
          end
        }
      rescue Exception => e
        puts "Exception In import #{e}"
      end
    }
  end

  
  private 

  def self.get_ngos(ngos_sheet)
    ngos_sheet.map do |row|
      Ngo.new({id: row[0], name: row[1], phone: row[2], email: row[3], address: row[4].gsub(/\n/," "), 
        url: row[5], others: row[6] })
    end
  end

  def self.get_deamnds(demands_sheet)
    demands_sheet.map do |row|
      Demand.new({ngo_id: row[1], data: row[2]})
    end
  end

end
