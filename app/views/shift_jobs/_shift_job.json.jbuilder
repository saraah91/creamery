json.extract! shift_job, :id, :shift_id, :integer, :job_id, :integer, :created_at, :updated_at
json.url shift_job_url(shift_job, format: :json)
