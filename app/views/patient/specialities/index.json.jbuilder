#json.array! @specialities, partial: "specialities/speciality", as: :speciality
json.array!(@specialities) do |speciality|
    json.id speciality.id
    json.name speciality.name
    json.description speciality.description
    json.priv speciality.priv    
end