json.extract! address, :id, :street, :number, :neighborhood, :city, :state, :zipcode, :created_at, :updated_at
json.url address_url(address, format: :json)
