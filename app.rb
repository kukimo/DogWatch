require 'sinatra'
require 'haml'

get '/' do
	"Hello world"
end

post '/upload' do
	if params[:file]
		save_path = "./public/images/test.jpg"	#[ToDo]タイムスタンプにする
		File.open(save_path, 'wb') do |f|
			f.write params[:file][:tempfile].read
			@mes = "Upload completed."
		end
	else
		pmes = "Upload failed."
	end
	redirect 'images'
end

get '/images' do
	@newest_img = "images/test.jpg"		#[ToDo]最新のタイムスタンプの画像を選択する
	haml :images
end

