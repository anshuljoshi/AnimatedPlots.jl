function make_gif(window::PlotWindow, width, height, duration, filename="plot.gif", delay=0.06)
	textures = Texture[]
	duration_clock = Clock()
	delay_clock = Clock()

	@async begin
		println("Taking pictures")
		while as_seconds(get_elapsed_time(duration_clock)) <= duration
			sleep(0)
			print("$(round(as_seconds(get_elapsed_time(duration_clock))/duration*100))% done\r")
			if as_seconds(get_elapsed_time(delay_clock)) >= delay
				restart(delay_clock)
				texture = Texture(800, 600)
				update(texture, window.renderwindow)
				push!(textures, texture)
			end
		end
		make_gif(textures, width, height, filename, delay)
	end
	nothing
end

function make_gif(textures::Array{Texture}, width, height, filename="plot.gif", delay=0.06)
	images = Image[]
	for i = 1:length(textures)
		push!(images, copy_to_image(textures[i]))
	end

	println("Done taking pictures")
	make_gif(images, width, height, filename, delay)
end

function make_gif(images::Array{Image}, width, height, filename="plot.gif", delay=0.06)
	println("Please wait while your gif is made... This may take awhile")
	dir = mktempdir()
	name = filename[1:search(filename, '.')-1]
	size = "$width" * "x" * "$height"

	for i = 1:length(images)
		save_to_file(images[i], "$dir/$name$i.png")
		cmd = `convert $dir/$name$i.png -resize $size\! $dir/$name$i.png`
		run(cmd)
		print("$(round(i/length(images)*100))% done\r")
	end
	println("Assembling gif (this may take awhile)")
	args = reduce(vcat, [[joinpath("$dir", "$name$i.png"), "-delay", "$(delay * 100)", "-alpha", "remove"] for i in 1:length(images)])
	imagemagick_cmd = `convert $args $filename`
	run(imagemagick_cmd)
	run(`rm -rf $dir`)
	println("Created gif $filename")
end

export make_gif
