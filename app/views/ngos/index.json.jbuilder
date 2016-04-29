json.array!(@ngos) do |ngo|
  json.extract! ngo, :id, :name, :address, :phone, :email, :url, :others
end
