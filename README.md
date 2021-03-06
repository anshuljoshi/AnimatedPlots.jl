# AnimatedPlots

Animated plots is a package for making animated and static plots. It is built on top of [SFML.jl] (https://github.com/zyedidia/SFML.jl) and allows for fast plotting of functions and variables over time.

![double pendulum](https://zyedidia.github.io/assets/double_pendulum2.gif)

# Installation

Make sure you have SFML and CSFML installed (see the SFML [installation instructions] (https://github.com/zyedidia/SFML.jl#installation) for more information)

```
julia> Pkg.clone("https://github.com/zyedidia/AnimatedPlots.jl")
```

# Usage

The easiest way to plot a function is to use the `plot` function:

### Static Plots

```
julia> plot(sin)
julia> close(current_window())
```

A `StaticGraph` object can also be passed to `plot` if you want to be able to modify the graph afterward (such as changing the color or line thickness)

```
julia> sin_graph = StaticGraph(sin, thickness=5, color=SFML.blue) # thickness and color
julia> plot(sin_graph)
julia> sin_graph.color = SFML.green
julia> plot(cos)
julia> close(current_window())
```

### Animated Plots

You can use the `AnimatedGraph` to make animated plots.

```
julia> animated_sin = AnimatedGraph(sin)
julia> plot(animated_sin)
julia> animated_cos = AnimatedGraph(cos, color=SFML.blue, startx=-10)
julia> animated_cos.speed = 3 # Speed in units per second
julia> plot(animated_cos)
julia> follow(animated_cos) # have the camera follow the plot
```

See `examples/double_pendulum.jl` for an advanced showcase of how to integrate an animated plot into an SFML application

### Output

AnimatedPlots supports creating images and gifs of your plots. Creating gifs may take a while, only close your program after it says `Created gif file.gif`. In addition, you must have [imagemagick] (http://www.imagemagick.org/script/binary-releases.php) installed in order to make gifs (most package managers provide it).

```
julia> screenshot("my_screenshot.png") # Take a screenshot and save it to my_screenshot.png
julia> make_gif(300, 300, 10, "MyGif.gif", 0.06) # Create a gif with width, height, duration (in seconds), filename, and delay (the delay between each frame in seconds)
```
