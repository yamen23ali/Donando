json.array!(@ngos) do |ngo|
  json.extract! ngo, :id, :name, :address, :phone, :email, :distance, :url, :others
end
