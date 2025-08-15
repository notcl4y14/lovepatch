local lovepatch = require("lovepatch")

function love.load()
	love.graphics.setDefaultFilter("nearest")

	img_metal = lovepatch.load("metal.png", 10, 10)
	img_wood  = lovepatch.load("wood.png", 3, 3)
	img_glass = lovepatch.load("glass.png", 8, 8)

	mx = 0
	my = 0
end

function love.update(dt)
end

function love.draw()
	love.graphics.clear(0.9, 0.9, 0.9, 1)

	-- Top-left corner
	local metal_x = 10
	local metal_y = 10
	local metal_w = mx - 10
	local metal_h = my - 10
	lovepatch.draw(img_metal, metal_x, metal_y, metal_w, metal_h)

	-- Top-right corner
	local wood_x = mx
	local wood_y = 10
	local wood_w = love.graphics.getWidth() - mx - 10
	local wood_h = my - 10
	lovepatch.draw(img_wood, wood_x, wood_y, wood_w, wood_h, 4, 4)

	local glass_x = 10
	local glass_y = my
	local glass_w = mx - 10
	local glass_h = love.graphics.getHeight() - my - 10
	lovepatch.draw(img_glass, glass_x, glass_y, glass_w, glass_h, 2, 2)
end

function love.mousemoved(mouseX, mouseY)
	mx = mouseX
	my = mouseY
end