
require 'nokogiri'
require 'open-uri'
require 'pry'

class ClassNames

@@all = []

  def self.all
    @@all
  end

  def self.scrape_home_page
    html = open("http://ruby-doc.org/core-2.5.3/")
    doc = Nokogiri::HTML(html)
    doc.xpath("//p [@class='class']/a").each do |class_name|
       @@all << {class_name.text => class_name.attr('href') }
    end
  end


end



class DocScraper

 attr_accessor :description, :methods, :page_data

 #This instance method retrieves all of the class names from the ruby-docs website
  def scrape_and_store(class_url)
    html = open(class_url)
    doc = Nokogiri::HTML(html)
    @page_data = doc
  end

  #This instance method breaks up the description and method section in order and stores the html type in order to be used later.
  def scrape_class_page
      @page_data.xpath("//div [@id] [@class='description']").each do |description_section|
      @description = []
      description_section.xpath("p|pre|h2|h3|h1").each do |description_item|

        item = {
          "name" => description_item.name,
          "text" => description_item.text
        }
        @description << item
        end
      end
  end


end




t = DocScraper.new
v= t.scrape_and_store("http://ruby-doc.org/core-2.5.3/Array.html")
r=t.scrape_class_page
ClassNames.new
ClassNames.scrape_home_page
puts ClassNames.all
