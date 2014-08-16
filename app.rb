require 'sinatra'
require 'haml'
require './wd_common'

include WatchDogCommon

#herokuでの書き出し先がtmpなのでsinatraの見る先を変更しておく
set :public_folder, File.dirname(__FILE__) + '/tmp'

get '/' do
	"Hello world"
end

post '/upload' do
	if params[:file]
		t = Time.now
#		save_path = settings.root + "/tmp/" + t.strftime("%Y%m%d%H%M%S") + ".jpg"
		save_path = "./tmp/" + t.strftime("%Y%m%d%H%M%S") + ".jpg"
		File.open(save_path, 'wb') do |f|
			f.write params[:file][:tempfile].read
			@mes = "Upload completed."
			delete_surplus_image(10)
		end
	else
		pmes = "Upload failed."
	end
	pmes
end

post '/settimer' do
	save_path = "./tmp/timer"
	File.open(save_path, 'wb') do |f|
		f.write(params[:timer])
	end
	"update timer"
end

get '/images' do
	imgs = Dir.glob("./tmp/*.jpg")
	@newest_img = ""
	@update_interval = capture_interval

	imgs.each do |img|
		if @newest_img.empty? || File.mtime(img) > File.mtime(@newest_img)
			@newest_img = img
		end
	end

	@newest_img.sub!("./tmp/", "")

	haml :images
end

get '/timer' do
	capture_interval
end

