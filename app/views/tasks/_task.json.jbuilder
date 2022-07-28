json.extract! task, :id, :list_id, :done, :desscription, :created_at, :updated_at
json.url task_url(task, format: :json)
