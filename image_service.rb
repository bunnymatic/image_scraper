class ImageService

  def self.getImages(url, options)
    method = options[:bing] ? :bing : :generic
    send(method, url, options)
  end

  class << self

    private

    def bing(url, options)
    end

    def generic(url, options)
      Nokogiri::HTML(open(url)).css(options[:css]).map do |img|
        src = img['src']
        src unless src.nil? || src.empty?
      end.compact.uniq
    end
  end
end
