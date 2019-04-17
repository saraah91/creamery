json.extract! user, :id, :employee_id, :integer, :email, :string, :password_digest, :string, :created_at, :updated_at
json.url user_url(user, format: :json)
