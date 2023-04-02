json.extract! board, :id, :email, :name, :length, :width, :mines, :created_at, :updated_at
json.url board_url(board, format: :json)
