require 'nokogiri'
require 'open-uri'

class VerseDownloader
	def initialize(base_path)
		@base_path = base_path
		Dir.mkdir(File.join(@base_path, "verses")) if not Dir.exist?(File.join(@base_path, "verses"))
	end

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

		File.open(File.join(@base_path, "verses", "#{book}_#{chapter}.txt"), 'w') do
			|file|
			file.puts "#{book} chapter #{chapter}".upcase
			file.puts

			document.css(".versehover").each do
				|verse|
				puts verse.parent.parent.text
				file.puts(verse.parent.parent.text)
			end

			file.puts
		end

		return true
	end

	def get_book(book)
		chapter = 0
		while true do
			chapter = chapter + 1 
			break if not get_verse(book, chapter) 
		end
	end
end

downloader = VerseDownloader.new(Dir.pwd)
#downloader.get_book("Genesis")
#downloader.get_book("Exodus")
downloader.get_book("Leviticus")

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

