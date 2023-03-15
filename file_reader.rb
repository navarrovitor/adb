require 'csv'
require 'fileutils'

# Empty output directory
FileUtils.rm_rf("output/.", secure: true)

files = %w[alagoas catimbau ceara inaja]

files.each do |file|
    CSV.foreach("input/#{file}.csv", headers: :first_row) do |row|
        
    end
end