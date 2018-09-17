require 'nokogiri'
require 'open-uri'

def get_verse(url)
	puts "#{Time.now}, downloading #{url}"
	file = open(url)
	contents = file.read
	puts "#{Time.now}, downloaded #{url}"
	sups = Nokogiri::HTML(contents).css(".versehover")
	puts sups[0].parent.parent.text
	puts "#{Time.now}, parsed #{url}"

	sups.each do
		|sup|
		puts sup.parent.parent.text
		@file.puts(sup.parent.parent.text)
	end
end

@file = File.open("bible.txt", 'w')

(1..31).each do
	|index|
	get_verse("http://www.kingjamesbibleonline.org/Genesis-Chapter-#{index}")
end

(1..28).each do
	|index|
	get_verse("http://www.kingjamesbibleonline.org/Matthew-Chapter-#{index}")
end

(1..28).each do
	|index|
	get_verse("http://www.kingjamesbibleonline.org/Matthew-Chapter-#{index}")
end

(1..16).each do
	|index|
	get_verse("http://www.kingjamesbibleonline.org/Mark-Chapter-#{index}")
end

(1..24).each do
	|index|
	get_verse("http://www.kingjamesbibleonline.org/Luke-Chapter-#{index}")
end

(1..21).each do
	|index|
	get_verse("http://www.kingjamesbibleonline.org/John-Chapter-#{index}")
end

@file.close()
