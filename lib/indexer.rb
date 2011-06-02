require 'rest-client'

class Indexer
  class << self
    attr_accessor :host
  end

  @host = "cove-search.dev"

  def self.update_index(parameters)
    response = post("/update_index", parameters)
    raise "Index could not be updated" unless response["status"] =~ /success/
  end

  def self.get(path, parameters)
    uri = "http://" + @host + path + format_query_string(parameters)
    response = RestClient.get uri
    JSON.parse(response)
  end

  def self.post(path, parameters)
    uri = "http://" + @host + path
    response = RestClient.post uri, parameters
    JSON.parse(response)
  end

  def self.format_query_string(parameters)
    query_string = ""
    parameters.each_with_index do |key, value, index|
      if index == 0
        query_string << "?#{key}=#{value}"
      else
        query_string << "&#{key}=#{value}"
      end
    end
    return query_string
  end

end
