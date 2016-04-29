require 'elasticsearch/model'
require 'query_repo.rb'
#require 'pry'

class Demand < ActiveRecord::Base

  #Elastic Search Functionality
  include Searchable

  belongs_to :ngo
  #validates :ngo, :presence => true

  attr_accessor :score

  def self.search(address, filter, size, page)
    
    if address.blank? && filter.blank?
      @demands = Demand.all
    elsif address.blank?
      @demands = search_with_filter(filter, size, page)
    elsif filter.blank?
      @demands = search_nearby(address)
    else
      @demands = full_search(address, filter, size, page)
    end

    group_by_ngo( @demands )
  end

  private

  def self.search_with_filter(filter, size, page)
    Demand.__elasticsearch__.search( QueryRepo.demands_query( filter, [] ), size: size, from: page).records
  end

  def self.search_nearby(address)
    ids = get_nearby_ngos(address).map(&:id)
      
    Demand.where(ngo_id: ids).group_by(&:ngo_id).slice(*ids).values.flatten
  end

  def self.full_search(address, filter, size, page)
    nearby_ngos = get_nearby_ngos(address)

    ids = nearby_ngos.map(&:id)

    response = Demand.__elasticsearch__.search( QueryRepo.demands_query( filter, ids ), size: size, from: page)


    demands = distance_weighting(response.results, nearby_ngos)

    demands.sort_by { |element| element[:score] }
  end

  def self.group_by_ngo( demands)
    ngo_group = ActiveSupport::OrderedHash.new

    demands.each{|demand|
      key = demand.ngo_id

      ngo_group[key] = {} if ngo_group[key].nil?
      ngo_group[key][:ngo] = demand.ngo

      ngo_group[key][:demands] = [] if ngo_group[key][:demands].nil?
      ngo_group[key][:demands].push( demand.data )
    }

    ngo_group
  end

  def self.get_nearby_ngos( address )
  	Ngo.near(address, 20, :units => :km) 
  end

  def self.distance_weighting(demands, ngos)
    ngos_hash = self.ngos_to_h(ngos)

    demands.map { |demand|  
      ngo = ngos_hash[demand._source.ngo_id.to_s]
      score = self.adjust_score( ngo[:distance], demand._score )
      
      Demand.new( { data: demand.highlight.data[0], ngo_id: demand._source.ngo_id, score: score } )
    }
  end

  def self.adjust_score(distance, score)
    distance.blank? ?  score : ( score - (  ( distance / 2 ) / 10 ) )
  end

  def self.ngos_to_h(ngos)
    ngos_hash = {}
    ngos.each{|ngo|
      ngos_hash[ ngo.id.to_s ] = { ngo: ngo, distance: ngo[:distance] }
    }
    ngos_hash
  end

end