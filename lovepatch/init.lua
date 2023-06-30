local lib = {}

-- Thanks to darkfrei for helping with the code
-- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=145963
function lib.load(filename, edgeW, edgeH)
	local image = love.graphics.newImage(filename)
	local imageW, imageH = image:getDimensions()
	local middleW, middleH = imageW - 2*edgeW, imageH - 2*edgeH
	
	-- quads:
	-- 1 2 3
	-- 4 5 6
	-- 7 8 9
	
	local quad1 = love.graphics.newQuad(0,0, edgeW, edgeH, image)
	local quad2 = love.graphics.newQuad(edgeW, 0, middleW, edgeH, image)
	local quad3 = love.graphics.newQuad(edgeW+middleW,0, edgeW, edgeH, image)
	
	local quad4 = love.graphics.newQuad(0,edgeH, edgeW, middleH, image)
	local quad5 = love.graphics.newQuad(edgeW,edgeH, middleW, middleH, image)
	local quad6 = love.graphics.newQuad(edgeW+middleW,edgeH, edgeW, middleH, image)
	
	local quad7 = love.graphics.newQuad(0,edgeH+middleH, edgeW, edgeH, image)
	local quad8 = love.graphics.newQuad(edgeW,edgeH+middleH, middleW, edgeH, image)
	local quad9 = love.graphics.newQuad(edgeW+middleW,edgeH+middleH, edgeW, edgeH, image)
	
	local quadPatch = {
		w = imageW,
		h = imageH,
		edgeW = edgeW,
		edgeH = edgeH,
		quads = {quad1, quad2, quad3, quad4, quad5, quad6, quad7, quad8, quad9},
		image = image,
	}
	return quadPatch
end

-- drawPatch
function lib.draw(patch, x, y, width, height)
	local imageW, imageH = patch.image:getDimensions()
	
	
-- edited:
	local imageMiddleW = imageW-2*patch.edgeW -- actually you can store this values in the patch
	local imageMiddleH = imageH-2*patch.edgeH
	
	local patchMiddleW = width-2*patch.edgeW
	local patchMiddleH = height-2*patch.edgeH
	
	local scaleX = patchMiddleW/imageMiddleW
	local scaleY = patchMiddleH/imageMiddleH
	
	local x1, x2, x3 = x, x+patch.edgeW, x+patch.edgeW + patchMiddleW
	local y1, y2, y3 = y, y+patch.edgeH, y+patch.edgeH + patchMiddleH


-- not edited:
	love.graphics.draw(patch.image, patch.quads[1], x1, y1)
	love.graphics.draw(patch.image, patch.quads[2], x2, y1, 0, scaleX, 1)
	love.graphics.draw(patch.image, patch.quads[3], x3, y1)
	
	love.graphics.draw(patch.image, patch.quads[4], x1, y2, 0, 1, scaleY)
	love.graphics.draw(patch.image, patch.quads[5], x2, y2, 0, scaleX, scaleY)
	love.graphics.draw(patch.image, patch.quads[6], x3, y2, 0, 1, scaleY)
	
	love.graphics.draw(patch.image, patch.quads[7], x1, y3)
	love.graphics.draw(patch.image, patch.quads[8], x2, y3, 0, scaleX, 1)
	love.graphics.draw(patch.image, patch.quads[9], x3, y3)
end

return lib

--[[local anim = require("lib/anim8/anim8")

local lib = {}

local patch = {}
patch.__index = patch

function patch:draw(x, y, width, height, scaleX, scaleY)
	quad = {
		love.graphics.newQuad(x, y, self.left, self.top, self.left, self.top),
		love.graphics.newQuad(x + self.left, y, x + self.left, self.top, self.top + self.left, self.top),
		love.graphics.newQuad(x + self.left + self.top, y, x + self.left + self.top, self.top, self.top + self.left + self.right, self.top)
	}

	for i, value in pairs(quad) do
		love.graphics.draw(self.source, value, x, y)
	end

	-- local width = self.width / self.image:getWidth()
	-- local height = self.height / self.image:getWidth()

	local lefttop = love.graphics.newQuad(0, 0, self.left, self.top, self.source)
	local top = love.graphics.newQuad(self.left, 0, self.left, self.top, self.source)
	local righttop = love.graphics.newQuad(self.source:getWidth() - self.right, 0, self.right, self.top, self.source)

	love.graphics.draw(self.source, lefttop, x, y, 0, scaleX, scaleY)
	love.graphics.draw(self.source, top, x + self.left * scaleX, y, 0, scaleX, scaleY)
	love.graphics.draw(self.source, righttop, x + self.right * 2 * scaleX, y, 0, scaleX, scaleY)
end

function lib.load(filename, left, right, top, bottom)
	local patch = setmetatable({}, patch)

	patch.source = love.graphics.newImage(filename)
	patch.left = left
	patch.right = right
	patch.top = top
	patch.bottom = bottom

	return patch
end

return lib]]