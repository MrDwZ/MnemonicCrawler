require 'open-uri'
require 'nokogiri'

@out = File.new("/Users/eiyasushiki/Desktop/out.txt", "w")

for num in 1..787
    doc = Nokogiri::HTML(open('http://mnemonicdictionary.com/wordlist/GREwordlist?page='+num.to_s))
    words_info = doc.css("div#home-middle-content")
    words_info.children.each do |word_info|
        if word_info["class"] == "row-fluid"
            begin
                word = word_info.css("h2").text
                short_def = word_info.css("p")[0].text
                defi = word_info.css("div.span9")[0].text
                de = word_info.css("div[style='padding-bottom:0px;']").text
                de = de.squeeze(' ').gsub(/^[ \t]*\r\n/, "").gsub(/\s+,\s+/, ", ")
                defi = defi.squeeze(' ').gsub(/^[ \t]*\r\n/ ,"").gsub(/\s+,\s+/, ", ")

                @out.puts "#{word}\n\n#{short_def}\n\n#{de}\nmem:\n#{defi}\n"
                @out.puts "============================================\n"
            rescue
            end
        end
    end
end
