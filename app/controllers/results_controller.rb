
class ResultsController < ApplicationController
    
  def index
    file_path = 'log/webserver.log'
    @nonunique_results = Parser::NonUniqueLogResults.new( path: file_path ).call
    @unique_results = Parser::UniqueLogResults.new( path: file_path ).call
  end    
end  