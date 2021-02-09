
module Parser

  class NonUniqueLogResults 
  
    def initialize( path: file_path, sort: 'DESC' )
      @path = path
      @sort = sort
    end
  
    def call
      parse_file(@path, @sort)
    end
  
    private 
  
    def parse_file(path, sort)
      raise Exception.new('Wrong argument. It should be ASC OR DESC') unless sort.upcase == ( 'DESC' || 'ASC' )
      raise Exception.new('Wrong path') unless ( !path.nil? && path.length > 0 )

      file = File.readlines(path)
 
      #Split records content into 2 element array
      file = file.map { |record| [
        record.split(" ")
      ]}

      #Array of all view records
      view_records = file.map { |record| record[0][0] }

      #Array of unique pages from all view records
      file_unique_pages = view_records.uniq

      #Change array into array of hashes
      result = file_unique_pages.map { |record| 
        {
          page: record,
          count: view_records.count(record) 
        }
      }

      #Sort
      if sort.upcase == 'DESC'
        result.sort_by { |record| record[:count] }.reverse
      elsif sort.upcase == 'ASC'
        result.sort_by { |record| record[:count] }
      end
    end
  end
end