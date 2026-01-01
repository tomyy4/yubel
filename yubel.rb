
# Look for classes that extend ApplicationRecord
def find_ruby_files_in_path(path)
  model_files = []
  Dir.children(path).each do |f|
    file_path = "#{path}/#{f}"
    if File.file?(file_path)
      model_files << file_path
    end
  end
  model_files
end


def scan_app
  path = "app/models"
  model_files = find_ruby_files_in_path(path)
  application_records = []

  needle = "< ApplicationRecord"

  model_files.each do |file|
    File.open(file, "r") do |lines|
      lines.each do |line|
        if line.include? needle
          application_records << file
        end
      end
    end
  end

  puts application_records
end

scan_app
