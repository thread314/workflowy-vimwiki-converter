#!/home/eddie/.rbenv/shims/ruby
require 'nokogiri'

filenames = ["index"]
masterlist = []
filetoopen = ""

until File.file?(filetoopen)
  puts "Enter the name of the file with the exported OPML from Workflowy?"
  filetoopen = gets.chomp 
end

vimwikifolder = ""
until File.directory?(vimwikifolder)
  puts "Enter the destination folder"
  vimwikifolder = gets.chomp 
end


File.open(filetoopen, "r") do |f|
  f.each_line do |line|
    formattedstring = Nokogiri::HTML(line)
    text = formattedstring.xpath('//outline/@text')
    cleantext = text.to_s.gsub(/[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ]/,'')
    cleantext = cleantext[0..22]
    if line.strip == "</outline>"
      filenames.pop
    elsif !text.empty?
       if line[-3] != "/"
	loop do
		if masterlist.include?(cleantext)
			cleantext = ">#{cleantext}"
		else
       			currentwiki = "#{vimwikifolder}#{filenames[-1]}.wiki"
			File.write(currentwiki, "", mode: 'a')
          		filenames.push(cleantext)
          		File.write(currentwiki, "[[#{cleantext}]]\n", File.size(currentwiki) , mode: 'a')
          		currentwiki = "#{vimwikifolder}#{filenames[-1]}.wiki"
          		File.write(currentwiki, "", mode: 'a')
			masterlist.push(cleantext)
			break
		end
	end
       else
       	  currentwiki = "#{vimwikifolder}/#{filenames[-1]}.wiki"
          File.write(currentwiki, "#{text}\n", File.size(currentwiki) , mode: 'a')
       end
    end
  end
end

puts "All complete - the Workflowy data from \"#{filetoopen}\" has been converted to VimWiki format and saved in \"#{vimwikifolder}\"."
