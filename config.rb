require 'compass/import-once/activate'
# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "../webroot/css"
sass_dir = "scss"
images_dir = "../webroot/image"
javascripts_dir = "../webroot/js"

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

if environment == :production
  output_style = :compressed
  line_comments = false
else
  output_style = :nested
  line_comments = true
end

# http://docs.ruby-lang.org/ja/2.1.0/doc/
input_encoding = Encoding::UTF_8.name
output_encoding = Encoding::Shift_JIS.name

# convert encoding and replace charset when saved
on_stylesheet_saved do |filename|
  # convert and replace
  File.open("#{filename}.bak", "w:#{output_encoding}") do |output|

    # save to tempfile
    File.open(filename, "r:#{input_encoding}") do |input|
      input.each do |line|
        output << line.gsub(/@charset[^;]*?/, %Q{@charset "#{output_encoding}"})
      end
    end

    # overwrite css
    File.rename("#{filename}.bak", filename)
  end

  # request LiveReload
  begin
    Net::HTTP.start('127.0.0.1', 35729) do |http|
      http.get("/changed?files=#{File.basename(filename)}")
    end
  rescue => e
    p e
  end
end
