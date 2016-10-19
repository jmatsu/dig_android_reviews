require 'csv'

exit(1) unless ARGV.length > 0

header = [ "Package Name","App Version Name","Device","Review Submit Date and Time","Review Submit Millis Since Epoch","Review Last Update Date and Time","Review Last Update Millis Since Epoch","Star Rating","Review Title","Review Text","Developer Reply Date and Time","Developer Reply Millis Since Epoch","Developer Reply Text","Review Link" ]

CSV.open('concat_result.csv','w') do |csv|
  csv << header.map { |e| e.downcase.gsub(/ /, '_') }
  ARGV.each do |arg|
    CSV.foreach(arg, headers: true) {|row| csv << row.values_at(*header) }
  end
end

puts "Created concat_result.csv"
