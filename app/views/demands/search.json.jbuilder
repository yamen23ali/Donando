json.array!(@demands) do |demand|
  json.extract! demand, :data, :ngo
end
