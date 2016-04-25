class Demand < ActiveRecord::Base
  belongs_to :ngo
  validates :ngo, :presence => true


  def self.search( address, filter)
  	ids = get_nearby_ngos(address).map(&:id)

  	demands = Demand.where(:ngo_id => ids)

  	if !filter.blank?
  		query = search_conditions(filter)
  		demands = demands.where(query)
  	end

  	demands.group_by(&:ngo_id).slice(*ids).values.flatten
  end

  def self.get_nearby_ngos( address )
  	address.blank? ? Ngo.all : Ngo.near(address, 100, :units => :km) 
  end

  def self.search_conditions(filter)
  	filter.split(" ").map {|item| "data LIKE '%#{item}%'"}.join(' OR ')
  end

end
