require 'elasticsearch/model'

module Searchable
  extend ActiveSupport::Concern

  INDEX_NAME = "donando"

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name(INDEX_NAME)

    #==== create and delete only for the first time then comment it out
    #Demand.__elasticsearch__.client.indices.delete index: Demand.index_name

   # Demand.__elasticsearch__.client.indices.create \
      #index: INDEX_NAME,
     # body: { settings: Demand.settings.to_hash, mappings: Demand.mappings.to_hash }
    #======

    mapping do
      indexes :data, analyzer: 'german'
    end

    def self.search(query)
      # ...
    end
  end
end