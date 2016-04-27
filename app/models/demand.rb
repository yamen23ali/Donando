require 'elasticsearch/model'
require 'query_repo.rb'
require 'pry'

class Demand < ActiveRecord::Base

  #Elastic Search Functionality
  include Searchable

  belongs_to :ngo
  validates :ngo, :presence => true

  def self.search(address, filter, size, page)
    nearby_ngos = get_nearby_ngos(address)

    ids = nearby_ngos.map(&:id)

    response = Demand.__elasticsearch__.search( QueryRepo.demands_query( filter, ids ), size: size, from: page)

    demands = distance_weighting(response.results, nearby_ngos)

    demands.sort_by { |element| element[:_score] }.reverse

    demands
  end

  def self.search_all(filter, size, page)

    response = Demand.__elasticsearch__.search( QueryRepo.demands_query( filter, [] ), size: size, from: page)

    distance_weighting(response.results, Ngo.all)
   # binding.pry
  end

  private

  def self.get_nearby_ngos( address )
  	Ngo.near(address, 20, :units => :km) 
  end

  def self.distance_weighting(demands, ngos)
    ngos_hash = self.ngos_to_h(ngos)

    demands.map { |demand|  
      ngo = ngos_hash[demand._source.ngo_id.to_s]
      score = self.adjust_score( ngo[:distance], demand._score )
      
      { "_score": score, data: demand.highlight.data[0], ngo: ngo[:ngo] }
    }
  end

  def self.adjust_score(distance, score)
    distance.blank? ?  score : ( score - (  ( distance / 2 ) / 10 ) )
  end

  def self.ngos_to_h(ngos)
    ngos_hash = Hash.new
    ngos.each{|ngo|
      ngos_hash[ ngo.id.to_s ] = { ngo: ngo, distance: ngo[:distance] }
    }
    ngos_hash
  end

end
