require 'pry'
require 'fileutils'
require 'uri'
require 'net/http'

json_file_name = File.join('public', ARGV[0])

json = File.read(json_file_name)
uploaded_file_paths = json.scan(/http:\\\/\\\/uploads\.hipchat\.com\\\/(.*?)"/).flatten

puts "#{uploaded_file_paths.size} files to download..."

uploaded_file_paths.each do |uploaded_file_path|
  original_uploaded_file_path = uploaded_file_path.clone

  uploaded_file_path.gsub!('\\', '')

  uploaded_file_path = uploaded_file_path.split('/')

  uploaded_file_name = uploaded_file_path.pop

  FileUtils.mkpath File.join('public', 'uploads', uploaded_file_path)

  unless File.exists? File.join('public', 'uploads', uploaded_file_path, uploaded_file_name)
    Net::HTTP.start("uploads.hipchat.com") do |http|
      begin
        puts "Downloading: #{File.join(uploaded_file_path, uploaded_file_name)}"
        file = open(File.join('public', 'uploads', uploaded_file_path, uploaded_file_name), 'wb')
        http.request_get('/' + URI.encode(File.join(uploaded_file_path, uploaded_file_name))) do |response|
          response.read_body do |segment|
            file.write(segment)
          end
        end
      ensure
        file.close
      end
    end
  else
    puts "#{uploaded_file_name} already downloaded."
  end

  json.gsub!("http:\\/\\/uploads.hipchat.com\\/#{original_uploaded_file_path}", "\\/uploads\\/#{original_uploaded_file_path}")
end

File.rename(json_file_name, "#{json_file_name}.#{Time.now.getutc.to_i.to_s}")

File.open(json_file_name, 'w') { |file| file.write(json) }

# binding.pry





