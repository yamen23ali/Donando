class DataImportWorker
  include Sidekiq::Worker
  
  sidekiq_options :retry => 0

  def perform(file_path)
    DataImporter.import(file_path)
  end
end