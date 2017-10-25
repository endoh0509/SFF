require 'sinatra'
require 'pazucraft'

get '/' do
	# input_file = 'test.jpg'
	# output_file = 'out.png'
	Pazucraft::generate
end
