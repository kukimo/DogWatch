require 'sinatra'
require 'haml'
require './wd_common'

include WatchDogCommon

get '/' do
	"Hello world"
end

post '/upload' do
	if params[:file]
		t = Time.now
		save_path = "./public/images/" + t.strftime("%Y%m%d%H%M%S") + ".jpg"
		File.open(save_path, 'wb') do |f|
			f.write params[:file][:tempfile].read
			@mes = "Upload completed."
			delete_surplus_image(10)
		end
	else
		pmes = "Upload failed."
	end
	redirect 'images'
end

get '/images' do
	imgs = Dir.glob("./public/images/*.jpg")
	@newest_img = ""

	imgs.each do |img|
		if @newest_img.empty? || File.mtime(img) > File.mtime(@newest_img)
			@newest_img = img
		end
	end

	@newest_img.sub!("./public/", "./")
	haml :images
end

