json.extract! customer, :id, :first_name, :last_name, :occupation, :company, :age, :salary, :address, :created_at, :updated_at
json.url customer_url(customer, format: :json)
