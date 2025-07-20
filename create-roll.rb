# this script creates roll.md and photo.md(s) from images placed in assets/images
#
#
require 'find'

ROLL_IMAGE_PATH = "assets/images/rolls"
ROLL_MDS_PATH = "_rolls"
PHOTOS_MDS_PATH = "_photos"

def userInput
    print "\n~ "
    gets.chomp
  end

system 'cls' 

#find all roll in assets
roll_image_folders = Dir.entries(ROLL_IMAGE_PATH)
roll_image_folders = roll_image_folders.select { |entry| File.directory?(File.join(ROLL_IMAGE_PATH, entry)) && entry != "." && entry != ".." }

#find roll .md(s)
roll_mds = Dir.entries(ROLL_MDS_PATH)
roll_mds = roll_mds.select { |entry| File.file?(File.join(ROLL_MDS_PATH, entry)) && entry.downcase.end_with?(".md") }
#strip roll md of extension
roll_mds = roll_mds.map { |file| File.basename(file, File.extname(file)) }

#removes existing roll .mds
roll_image_folders.reject! {|element| roll_mds.include?(element)}

if roll_image_folders.size < 1 
    puts "no new rolls found"
    abort   #might reroute for when adding images to roll
end

puts "\n*** #{roll_image_folders.size} found!   ***"
puts "Enter corresponding number to roll you would like to import (y for exit)\n"

roll_image_folders.each_with_index do |roll, i|
    puts "#{i}: #{roll}"
end


user_number = userInput

if !user_number.match?(/\A\d+\z/)
    puts "invalid input, unless it was y ;)"
    abort
end

if !(user_number.to_i >= 0 && user_number.to_i < roll_image_folders.size)
    puts "Invalid number"
    abort
end

#real roll selected
#selected_roll = roll_image_folders.each_index.select { |i| roll_image_folders[i] == user_number }
selected_roll = roll_image_folders[user_number.to_i]

system 'cls' 
puts "***   `#{selected_roll}` selected   ***"

puts "Enter film type:"
film_type = userInput

puts "Enter film capture dates range (e.g. jan - feb 2023):"
capture_dates = userInput

puts "Enter film development date: (e.g. 1/1/2023)"
dev_date = userInput


system 'cls' 
puts "Interesting. Now before I stamp these papers, make sure this information is correct.\n\n"

puts "Roll name: #{selected_roll}"
puts "Film type: #{film_type}" 
puts "capture dates: #{capture_dates}"
puts "development date: #{dev_date}\n\n"

puts "continue y/n"

if userInput.downcase != "y"
    puts "Exiting program."
    abort
end

#starting roll/photos creation
system 'cls' 
puts "starting process\n..."

#creating roll .md
roll_md_path = ROLL_MDS_PATH + "/" + selected_roll + ".md"

File.open(roll_md_path, "w") do |file|
    file.puts("---
title: #{selected_roll}
film-type: #{film_type}
capture-dates: #{capture_dates}
development-date: #{dev_date}
---")
  end

#creating photo .md(s)
Dir.mkdir(PHOTOS_MDS_PATH + "/" + selected_roll) unless File.exist?(PHOTOS_MDS_PATH + "/" + selected_roll)
Dir.foreach(ROLL_IMAGE_PATH + "/" + selected_roll) do |photo_name|
    next if photo_name == '.' || photo_name == '..'
  
    photo_name = File.basename(photo_name, File.extname(photo_name)) #strip ext
    
    photos_mds_path = PHOTOS_MDS_PATH + "/" + selected_roll + "/" + photo_name + ".md"

    File.open(photos_mds_path, "w") do |file|
        file.puts("---
title: #{photo_name}
roll: #{selected_roll}
---")
      end

  end

  #complete
puts "***   process complete    ***"