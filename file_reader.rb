require "csv"
require "fileutils"
require "caracal"

# Empty output directory
FileUtils.rm_rf("output/.", secure: true)

# Put all the input file names so it can iterate through all
files = %w[inaja]

files.each do |file|
  # Set document H1 styling
  Caracal::Document.save "output/#{file}.docx" do |document|
    document.style do
      id "Heading1"
      name "heading 1"
      type "paragraph"
      font "Arial"
      size 72
      bold true
      bottom 0
      top 0
      color 'fca311'
    end

    # Defines the string that will be the header on each page
    page_header = "Povoado"

    # Reads input csv file using BOM and utf-8 encoding and the first row elements as the headers
    CSV.foreach(
      "input/#{file}.csv",
      headers: :first_row,
      encoding: "bom|utf-8"
    ) do |row|
      # Insert the header h1
      document.h1 row[page_header]
      # Iterates through all the csv headers but the page header (defined in line 31) and insert the info in the document
      (row.headers - [page_header]).each do |header|
        document.p header + ':'
        document.p "#{row[header].nil? ? '-' : row[header].upcase}" do
            bold true
        end
      end
      # Adds a new page to the document
      document.page
    end
  end
end
