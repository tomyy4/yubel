
require_relative "config/environment"

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

def extract_application_record_name(string)
  # first remove the the < ApplicationRecord
  klass, _ = string.split("<")
  # then remove the class
  _, model_name = klass.split("class")
  model_name
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
          name = extract_application_record_name(line)
          application_records << name
        end
      end
    end
  end

  application_records.each do |model|
    model_name = model.strip
    puts "Getting fields of #{model_name}"
    column_names = "#{model_name.strip}.column_names"
    system("rails runner 'puts #{column_names}'")
  end
end

scan_app