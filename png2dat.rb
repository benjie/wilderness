# Based on raw2dat.rb
unless ARGV.length >= 2
  puts "Please pass filename and width"
  exit
end
width = ARGV[1].to_i # => width of resized raw image
basename = File.basename(ARGV[0], ".png")
#imagemagick
system "convert #{basename}.png -type Grayscale -resize #{width}x -depth 8 -negate gray:#{basename}.raw"
#Now process the RAW
str = File.binread("#{basename}.raw")
pixels = str.unpack("C*")

File.open("#{basename}.dat", 'w') do |f|
  pixels.each_with_index do |pixel, idx|
    f.write(pixel)
    if ((idx + 1) % width) == 0
      f.write("\n")
    else
      f.write(" ")
    end
  end
  f.write("\n")
end
