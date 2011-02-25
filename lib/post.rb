class Post < Sequel::Model
  plugin :schema
  
  unless table_exists?
    set_schema do
      primary_key :id
      String :title
      text :body
      DateTime :created_at
    end
    create_table
  end
end