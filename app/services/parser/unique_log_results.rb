
module Parser

  class UniqueLogResults
  
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

      #Array of all view pages
      view_pages = file.map { |record| record[0][0] }

      #Array of unique pages from all view records
      file_unique_pages = view_pages.uniq

      #Array of unique combinations of address and page user visited
      file_unique_visits = file.uniq

      #Go through array, count number of page views and return array of hashes with view count
      res = []
      file_unique_pages.each { |page|
        count = 0

        file_unique_visits.each { |record|
          if page == record[0][0]
            count = count + 1  
          end
        }

        res << { page: page, count: count}
      }

      return res
    end
  end
end