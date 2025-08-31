-- GeminiDisplay.lua

GeminiDisplay = {}
local GeminiDisplay_mt = Class(GeminiDisplay, HUDDisplayElement)

function GeminiDisplay:new()
    local self = GeminiDisplay:superClass().new(nil, GeminiDisplay_mt)

    -- Create a frame
    self.frame = FrameElement.new()
    self.frame:setFrameColor(0, 0, 0, 0.5) -- Black with 50% transparency
    self.frame:setSize(0.4, 0.2) -- 40% of screen width, 20% of screen height
    self.frame:setPosition(0.3, 0.4) -- Centered horizontally, slightly above center vertically
    self:addElement(self.frame)

    -- Create text element
    self.text = TextElement.new()
    self.text:setText("")
    self.text:setTextSize(0.015)
    self.text:setTextColor(1, 1, 1, 1) -- White
    self.text:setPosition(0.02, 0.18) -- Relative to the frame
    self.frame:addElement(self.text)

    return self
end

function GeminiDisplay:setText(text)
    self.text:setText(text)
end
