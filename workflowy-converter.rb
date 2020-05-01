#!/home/eddie/.rbenv/shims/ruby
require 'nokogiri'

filenames = ["index"]
masterlist = []
puts "Enter the name of the file with the exported OPML from Workflowy?"
filetoopen = gets.chomp 
puts "Enter the destination folder"
vimwikifolder = gets.chomp 


File.open(filetoopen, "r") do |f|
  f.each_line do |line|
    formattedstring = Nokogiri::HTML(line)
    text = formattedstring.xpath('//outline/@text')
    cleantext = text.to_s.gsub(/[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ]/,'')
    puts cleantext
    cleantext = cleantext[0..22]
    if line.strip == "</outline>"
      filenames.pop
    elsif !text.empty?
       if line[-3] != "/"
	loop do
		if masterlist.include?(cleantext)
			cleantext = ">#{cleantext}"
			puts "doubleup - #{cleantext}"
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
       	  currentwiki = "#{vimwikifolder}#{filenames[-1]}.wiki"
          File.write(currentwiki, "#{text}\n", File.size(currentwiki) , mode: 'a')
       end
    end
  end
end
