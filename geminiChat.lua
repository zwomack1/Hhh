-- Gemini Chat GUI
local GeminiChat = {}
GeminiChat.MESSAGES = {}

function GeminiChat:onOpen()
    self.visible = true
end

function GeminiChat:onClose()
    self.visible = false
end

function GeminiChat:addMessage(sender, text)
    table.insert(self.MESSAGES, {sender=sender, text=text})
end

function GeminiChat:draw()
    if not self.visible then
        return
    end
    
    -- Draw chat window
    local width = 400
    local height = 300
    local x = 0.5 * g_screenWidth - width/2
    local y = 0.5 * g_screenHeight - height/2
    
    renderOverlay(GeminiChat.overlayId, x, y, width, height)
    
    -- Draw messages
    local startY = y + 20
    for i, message in ipairs(self.MESSAGES) do
        local textY = startY + (i-1)*20
        renderText(x + 10, textY, 14, message.sender .. ": " .. message.text)
    end
    
    -- Draw input box
    self.inputElement:draw()
end

function GeminiChat:keyEvent(unicode, sym, modifier, isDown)
    if not self.visible then
        return
    end
    
    self.inputElement:handleKeyEvent(unicode, sym, modifier, isDown)
    
    if sym == INPUT_RETURN and isDown then
        local text = self.inputElement.text
        if text ~= "" then
            self:addMessage("You", text)
            self.inputElement.text = ""
            
            -- Send to Gemini
            g_geminiAddon:sendChatMessage(text)
        end
    end
end

function GeminiChat:mouseEvent(posX, posY, isDown, isUp, button)
    if not self.visible then
        return
    end
    
    self.inputElement:handleMouseEvent(posX, posY, isDown, isUp, button)
end

function GeminiChat:init()
    self.overlayId = createOverlay("geminiChatOverlay")
    self.inputElement = TextInputField:new(0, 0, 380, 30)
    
    GeminiChat:addMessage("Gemini", "Hello! How can I assist you today?")
end

GeminiChat:init()
