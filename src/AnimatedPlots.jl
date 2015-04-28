module AnimatedPlots

import Base: isopen
using Reexport
@reexport using SFML

# Pixels per unit
global ppu = 20

include("graph.jl")
include("axis.jl")
include("plotwindow.jl")

function static_plot(fun::Function, name="Plot", width=800, height=600)
	window = create_window(name, width, height)
	add_graph(window, Graph(fun))
	redraw(window)
	open_window(window)

	return window
end
function static_plot(fun::Function, window::PlotWindow)
	add_graph(window, Graph(fun))
	redraw(window)
end

function create_window(name="Plot", width=800, height=600)
	window = PlotWindow(name, width, height)
	redraw(window)
	return window
end

function open_window(window::PlotWindow)
	@async begin
		while isopen(window)
			sleep(0)
			check_input(window)
			draw(window)
		end
		destroy(window.renderwindow)
	end
end

export open_window, create_window, static_plot

end
