#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'uri'
require 'optparse'
require 'fileutils'
require 'pry'

def make_absolute( img_src, root )
  URI.parse(root).merge(URI.parse(img_src)).to_s
end

options = {
  directory: 'scraped',
  css: 'img'
}

optparse = OptionParser.new do |opts|

  opts.banner = "\nUsage: image_scraper [options] urls\n\n" +
    "All <img> tags will be scraped by finding their 'src' attribute. " +
    "If you want to trim which images are collected, you can add a css wrapper selector. " +
    "Only images that match '<css wrapper> img' will be pulled.\n\n"

  opts.on("-c CSS_WRAPPER", "--css CSS_WRAPPER", "CSS wrapper selector to limit image selection.  (ex '.img-wrapper' which will find '.img-wrapper img' images") do |css|
    options[:css] = css + " img"
  end

  opts.on("-d DIRECTORY", "--dir DIRECTORY", "directory to dump the found images (default: scraped") do |dir|
    options[:directory] = dir
  end

  opts.on("-C CSS_SELECTOR", "--CSS CSS_SELECTOR", "Exact CSS selector to find images (ex: 'img.thumbnail')") do |css|
    options[:css] = css || 'img'
  end

  opts.on_tail("-h", "--help", "Prints this help") do
    puts opts
    exit
  end

end

optparse.parse!

puts options

if ARGV.empty?
  puts "You need to specify a url or urls to scrape"
  puts parser
  exit -1
end

dir = options[:directory]
FileUtils.mkdir(dir) unless File.exists?(dir)

ARGV.compact.each do |url|
  puts "Scraping from url", url

  Nokogiri::HTML(open(url)).css(options[:css]).each do |img|
    src = img['src']
    uri = make_absolute(src, url)
    dest = File.join(dir, File.basename(uri))

    File.open(dest, 'wb'){ |f| f.write(open(uri).read()) }
    puts "Scraped and saved #{dest} from #{url}"
  end
end
