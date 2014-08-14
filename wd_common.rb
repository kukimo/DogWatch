module WatchDogCommon
	def delete_surplus_image(max)
		files = Dir.glob("./public/images/*.jpg")
		return 	if files.count <= max

		oldest_img = ""
		files.each do |f|
			if oldest_img.empty? || File.mtime(oldest_img) > File.mtime(f)
				oldest_img = f
			end
		end

		File.delete(oldest_img)
	end

	def hello
		p "hello"
	end
end

