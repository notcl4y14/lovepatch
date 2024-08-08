local lovepatch = require("lovepatch")

function love.load()
	love.graphics.setDefaultFilter("nearest")
	img = lovepatch.load("img.png", 10, 10)

	x = 10
	y = 10
	width = 10
	height = 10
end

function love.update(dt)
end

function love.draw()
	love.graphics.clear(0.9, 0.9, 0.9, 1)
	lovepatch.draw(img, x, y, width, height)
end

function love.mousemoved(mouseX, mouseY)
	width = mouseX - x
	height = mouseY - y
end