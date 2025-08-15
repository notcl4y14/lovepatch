-- https://github.com/notcl4y14/lovepatch
local lib = {}

-- Thanks to darkfrei for helping with the code
-- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=145963

function lib.load(arg0, arg1, arg2, arg3, arg4)
	local image = nil

	if type(arg0) == "table" then
		image = arg0
	elseif type(arg0) == "string" then
		image = love.graphics.newImage(arg0)
	end

	if arg3 == nil and arg4 == nil then
		return lib.loadSameEdge(image, arg1, arg2)
	end

	return lib.loadDiffrntEdge(image, arg1, arg2, arg3, arg4)
end

function lib.loadDiffrntEdge(image, left, right, top, bottom)
	local imageW, imageH = image:getDimensions()

	local quad1 = love.graphics.newQuad(0,              0, left,                 top, image)
	local quad2 = love.graphics.newQuad(left,           0, imageW - (right * 2), top, image)
	local quad3 = love.graphics.newQuad(imageW - right, 0, right,                top, image)

	local quad4 = love.graphics.newQuad(0,              top, left,                 imageH - (bottom * 2), image)
	local quad5 = love.graphics.newQuad(left,           top, imageW - (right * 2), imageH - (bottom * 2), image)
	local quad6 = love.graphics.newQuad(imageW - right, top, right,                imageH - (bottom * 2), image)

	local quad7 = love.graphics.newQuad(0,              imageH - bottom, left,                 bottom, image)
	local quad8 = love.graphics.newQuad(left,           imageH - bottom, imageW - (right * 2), bottom, image)
	local quad9 = love.graphics.newQuad(imageW - right, imageH - bottom, right,                bottom, image)

	local quadPatch = {
		image  = image,
		width  = imageW,
		height = imageH,
		left   = left,
		right  = right,
		top    = top,
		bottom = bottom,
		quads  = {
			quad1,
			quad2,
			quad3,
			quad4,
			quad5,
			quad6,
			quad7,
			quad8,
			quad9
		},
	}
	return quadPatch
end

function lib.loadSameEdge(image, edgeW, edgeH)
	local imageW, imageH = image:getDimensions()
	local middleW = imageW - 2 * edgeW
	local middleH = imageH - 2 * edgeH

	-- quads:
	-- 1 2 3
	-- 4 5 6
	-- 7 8 9

	local quad1 = love.graphics.newQuad(0,               0, edgeW,   edgeH, image)
	local quad2 = love.graphics.newQuad(edgeW,           0, middleW, edgeH, image)
	local quad3 = love.graphics.newQuad(edgeW + middleW, 0, edgeW,   edgeH, image)

	local quad4 = love.graphics.newQuad(0,               edgeH, edgeW,   middleH, image)
	local quad5 = love.graphics.newQuad(edgeW,           edgeH, middleW, middleH, image)
	local quad6 = love.graphics.newQuad(edgeW + middleW, edgeH, edgeW,   middleH, image)

	local quad7 = love.graphics.newQuad(0,               edgeH + middleH, edgeW,   edgeH, image)
	local quad8 = love.graphics.newQuad(edgeW,           edgeH + middleH, middleW, edgeH, image)
	local quad9 = love.graphics.newQuad(edgeW + middleW, edgeH + middleH, edgeW,   edgeH, image)

	return {
		image  = image,
		width  = imageW,
		height = imageH,
		left   = edgeW,
		right  = edgeW,
		top    = edgeH,
		bottom = edgeH,
		quads  = {
			quad1,
			quad2,
			quad3,
			quad4,
			quad5,
			quad6,
			quad7,
			quad8,
			quad9
		},
	}
end

function lib.draw(patch, x, y, width, height, sx, sy)
	sx = sx or 1
	sy = sy or 1

	local imageW, imageH = patch.width, patch.height

	local scaleX = (width  - 2 * patch.right  * sx) / (imageW - 2 * patch.right)
	local scaleY = (height - 2 * patch.bottom * sy) / (imageH - 2 * patch.bottom)

	local x1 = x
	local x2 = x + patch.left * sx
	local x3 = x + width - (patch.right * sx)

	local y1 = y
	local y2 = y + patch.top * sy
	local y3 = y + height - (patch.top * sy)

	love.graphics.draw(patch.image, patch.quads[1], x1, y1, 0, sx,     sy)
	love.graphics.draw(patch.image, patch.quads[2], x2, y1, 0, scaleX, sy)
	love.graphics.draw(patch.image, patch.quads[3], x3, y1, 0, sx,     sy)

	love.graphics.draw(patch.image, patch.quads[4], x1, y2, 0, sx,      scaleY)
	love.graphics.draw(patch.image, patch.quads[5], x2, y2, 0, scaleX,  scaleY)
	love.graphics.draw(patch.image, patch.quads[6], x3, y2, 0, sx,      scaleY)

	love.graphics.draw(patch.image, patch.quads[7], x1, y3, 0, sx,     sy)
	love.graphics.draw(patch.image, patch.quads[8], x2, y3, 0, scaleX, sy)
	love.graphics.draw(patch.image, patch.quads[9], x3, y3, 0, sx,     sy)
end

-- TODO: Implement
function drawRepeat(patch, x, y, width, height, sx, sy)
	sx = sx or 1
	sy = sy or 1

	local imageW, imageH = patch.width, patch.height

	local scaleX = (width  - 2 * patch.right  * sx) / (imageW - 2 * patch.right)
	local scaleY = (height - 2 * patch.bottom * sy) / (imageH - 2 * patch.bottom)

	local x1 = x
	local x2 = x + patch.left * sx
	local x3 = x + width - (patch.right * sx)

	local y1 = y
	local y2 = y + patch.top * sy
	local y3 = y + height - (patch.top * sy)

	love.graphics.draw(patch.image, patch.quads[1], x1, y1, 0, sx,     sy)
	love.graphics.draw(patch.image, patch.quads[2], x2, y1, 0, scaleX, sy)
	love.graphics.draw(patch.image, patch.quads[3], x3, y1, 0, sx,     sy)

	love.graphics.draw(patch.image, patch.quads[4], x1, y2, 0, sx,      scaleY)

	local middleW = (imageW - patch.right)  - patch.left
	local middleH = (imageH - patch.bottom) - patch.top

	local quadAmountH = width  / middleW / sx
	local quadAmountV = height / middleH / sy

	-- The last boundary quad becomes a quad of its own
	local lastQuadW = 1
	local lastQuadH = middleH

	-- Quads of the quad. R - right side, B - bottom side
	local lastQuadR  = love.graphics.newQuad(0, 0, lastQuadW, middleH,   patch.image)
	local lastQuadB  = love.graphics.newQuad(0, 0, middleW,   lastQuadH, patch.image)
	local lastQuadRB = love.graphics.newQuad(0, 0, lastQuadW, lastQuadH, patch.image)

	for ix=0, quadAmountH do
		for iy=0, quadAmountV do
			local quadX = x2 + ix * middleW * sx
			local quadY = y2 + iy * middleH * sy

			if ix == quadAmountW and iy == quadAmountH then
				love.graphics.draw(patch.image, lastQuadRB, quadX, quadY, 0, sx, sy)
			elseif ix == quadAmountW then
				love.graphics.draw(patch.image, lastQuadR, quadX, quadY, 0, sx, sy)
			elseif iy == quadAmountH then
				love.graphics.draw(patch.image, lastQuadB, quadX, quadY, 0, sx, sy)
			else
				love.graphics.draw(patch.image, patch.quads[5], quadX, quadY, 0, sx, sy)
			end
		end
	end

	love.graphics.draw(patch.image, patch.quads[6], x3, y2, 0, sx,      scaleY)

	love.graphics.draw(patch.image, patch.quads[7], x1, y3, 0, sx,     sy)
	love.graphics.draw(patch.image, patch.quads[8], x2, y3, 0, scaleX, sy)
	love.graphics.draw(patch.image, patch.quads[9], x3, y3, 0, sx,     sy)
end

return lib