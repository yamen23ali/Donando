json.extract! @demand, :id, :data, :created_at, :updated_at
json.ngo @demand.ngo.as_json(:except => [:id, :created_at, :updated_at])
