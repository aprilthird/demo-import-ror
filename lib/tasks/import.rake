require 'roo'

namespace :import do
  desc "Import data from spreadsheet"
  task data: :environment do
    puts 'Importing Data' # add this linebundle exec rails import:databundle exec rails import:databundle exec rails import:data
  end

end
