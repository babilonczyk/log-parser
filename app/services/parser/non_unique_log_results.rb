
module Parser

  class NonUniqueLogResults 
  
    def initialize( path: file_path, sort: 'desc' )
      @path = path
      @sort = sort
    end
  
    def call
      parse_file(@path)
    end
  
    private
  
    def parse_file(path)
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

      return result
    end
  end
end