
require Rails.root + 'app/services/import_pdf.rb'

namespace :cam_dictionary do
  desc "Import data from pdf"
  task :import_dictionary => :environment  do
    ImportPDF.new.import
  end
end
