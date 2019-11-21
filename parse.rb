require 'csv'

#page = File.read('JobSearch.php')
#page = page.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')

page = File.read('jobs.html')

matches = page.scan(/<td>(.*?)<tr>/).to_a

CSV.open("jobs.csv", "w") do |csv|
  puts "Found #{matches.size} postings"
  matches.each do |posting|
    csv << posting[0].scan(/(?<=<\/b>)(.*?)(?<=<b>)/).to_a.map { |a| a[0].gsub(/<[^>]+>/, '').chomp }
  end
end
