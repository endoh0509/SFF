require 'sinatra'
require 'pazucraft'
require 'slim'
require 'slim/include'

set :environment, :production

set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
  @ids = Dir.glob('public/img/*').map do |img_path|
    img_path.split('/').last
  end
  @ids.sort
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
    noroshiro = 'public/assets/img/norishiro.png'
    Dir.mkdir "public/img/#{image_num}"
    File.open(@input_file, 'wb') do |f|
      if content_type == 'image/jpeg'
        f.write(tempfile.read)
        Pazucraft::generate @input_file, @output_file
        image = Magick::Image.read(@output_file).first
        norishiro_img = Magick::Image.read(noroshiro).first
        image = norishiro_img.composite(image, 0, 0, Magick::OverCompositeOp)
        image.write(@output_file)
      else
        image = Magick::Image.read(tempfile.path)[0]
        image.write(@input_file)
        Pazucraft::generate @input_file, @output_file
      end
    end
    redirect :"link_to_image/#{image_num}"
  else
    slim :cannot_upload_image
  end
end
