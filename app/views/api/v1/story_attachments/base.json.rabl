attributes :id, :content_type, :file_size, :file_name, :created_at, :updated_at
node(:url){|attachment| URI.join(request.url, attachment.url)}