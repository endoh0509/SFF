require File.dirname(__FILE__) + '/spec_helper'

describe 'My Sinatra Application' do
  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'return the image after uploading the png image' do
    upload_file = 'spec/img/test.jpg'
    upload_type = 'image/jpeg'
    upload_image = Rack::Test::UploadedFile.new(upload_file, upload_type)
    res = post '/upload', file: upload_image
    p res
    content_type = res.original_headers['Content-Type']
    expect(content_type).to eq('image/png')
  end

  it 'routing the error page after uploading the image' do
    res = post '/upload'
    p res
    expect(last_response).to be_ok
  end
end
