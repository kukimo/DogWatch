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

	def capture_interval
		schedule = "300"
		if File.exist?("./tmp/timer")
			File.open("./tmp/timer", "rb") do |f|
				schedule = f.read
			end
		end

		schedule
	end
end

