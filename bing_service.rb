require 'searchbing'

class BingService

  def self.search(query, height = nil, width = nil)
    client.search(query)
  end

  private

  def self.client
    require 'byebug'
    debugger
    puts ENV['BING_SEARCH_API_KEY']
    Bing.new(ENV['BING_SEARCH_API_KEY'], 50, 'Image')
  end

end
