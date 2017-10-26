require 'sinatra'
require 'pazucraft'
require 'slim'
require 'slim/include'

set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
  @ids = Dir.glob('public/img/*').map do |img_path|
    img_path.split('/').last
  end
  slim :index
end

get '/link_to_image/:id' do
  image_num = params[:id]
  @input_file = "/img/#{image_num}/in.jpg"
  @output_file = "/img/#{image_num}/out.png"
  slim :link_to_image
end

post '/upload' do
  if params[:file]
    content_type params[:file][:type]
    tempfile = params[:file][:tempfile]
    image_num = Dir.glob('public/img/*').size
    @input_file = "public/img/#{image_num}/in.jpg"
    @output_file = "public/img/#{image_num}/out.png"
    Dir.mkdir "public/img/#{image_num}"
    File.open(@input_file, 'wb') do |f|
      f.write(tempfile.read)
      Pazucraft::generate @input_file, @output_file
    end
    redirect :"link_to_image/#{image_num}"
  else
    slim :cannot_upload_image
  end
end
