require 'aws-sdk'
require 'open-uri'

class DataImportWorker
  include Sidekiq::Worker
  
  sidekiq_options :retry => 0

  def perform
    file_path = "#{Rails.root}/public/#{ENV['NGOS_FILE']}"

    puts "Start file downloading from S3"
    download_file(file_path)
    
    DataImporter.import(file_path)
  end

  def download_file(file_path)
    open(file_path, 'wb') do |file|
      file << open("https://s3-eu-west-1.amazonaws.com/donando-storage/#{ENV['NGOS_FILE']}").read
    end
    puts "Finish file downloading from S3"
  end

end