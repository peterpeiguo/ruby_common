require 'nokogiri'
require 'open-uri'

def get_verse(book, chapter)
	url = "http://www.kingjamesbibleonline.org/#{book}-Chapter-#{chapter}"
	puts "#{Time.now}, downloading #{url}"
	file = open(url)
	contents = file.read
	puts "#{Time.now}, downloaded #{url}"
	document = Nokogiri::HTML(contents)
	puts document.css("span.chapter").text.upcase
	puts "chapter #{chapter}".upcase
	if document.css("span.chapter").text.upcase != "chapter #{chapter}".upcase then
		return false
	end

	@file.puts "#{book} chapter #{chapter}".upcase
	@file.puts

	verses = document.css(".versehover")

	verses.each do
		|verse|
		puts verse.parent.parent.text
		@file.puts(verse.parent.parent.text)
	end

	@file.puts

	return true
end

@file = File.open("bible.txt", 'w')

chapter = 0
while true do
	chapter = chapter + 1 
	break if not get_verse("Genesis", chapter) 
end

=begin
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
=end
@file.close()
