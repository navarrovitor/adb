require "csv"
require "fileutils"
require "caracal"

# Empty output directory
# FileUtils.rm_rf("output/.", secure: true)

# Put all the input file names so it can iterate through all
files = %w[inaja]

files.each do |file|
  Caracal::Document.save "output/#{file}.docx" do |document|
    document.style do
      id "Heading1" # sets the internal identifier for the style.
      name "heading 1" # sets the friendly name of the style.
      type "paragraph" # sets the style type. accepts `paragraph` or `character`
      font "Arial" # sets the font family.
      size 28 # sets the font size. units in half points.
      bold true # sets the font weight.
    end

    CSV.foreach(
      "input/#{file}.csv",
      headers: :first_row,
      encoding: "bom|utf-8"
    ) do |row|
      new_line = ->(field) { field + ": #{row[field].upcase}" }
      document.h1 "New Page"
      document.page
    end
  end
end
