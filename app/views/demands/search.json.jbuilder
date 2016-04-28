json.array!(@demands) do |demand|
  #json.extract! demand, :data, :ngo
  json.merge! demand[1]
end
