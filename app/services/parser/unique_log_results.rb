
module Parser

  class UniqueLogResults
  
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

      #Array of all view pages
      view_pages = file.map { |record| record[0][0] }

      #Array of unique pages from all view records
      file_unique_pages = view_pages.uniq

      #Array of unique combinations of address and page user visited
      file_unique_visits = file.uniq

      #Go through array, count number of page views and return array of hashes with view count
      result = []
      file_unique_pages.each { |page|
        count = 0

        file_unique_visits.each { |record|
          if page == record[0][0]
            count = count + 1  
          end
        }

        result << { page: page, count: count }
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