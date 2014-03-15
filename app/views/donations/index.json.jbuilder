json.array!(@donations) do |donation|
  json.extract! donation, :id, :amount, :site_donation, :approved
  json.url donation_url(donation, format: :json)
end
