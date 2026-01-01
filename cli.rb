require_relative "colorizer"

def dummy_models
  ["Product", "Order", "Meal"]
end

def run
  puts "Welcome to " + purple("Yubel") + ". Please select the model to export"
  dummy_models.each_with_index do |value, index| 
    puts "#{index}: #{value}"
  end
end

run