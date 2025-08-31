-- GeminiIntegration.lua

GeminiIntegration = {}

local json
local checkTimer = 0
local checkInterval = 5 -- Check every 5 seconds
local responseDisplayTimer = 0
local responseDisplayDuration = 10 -- Show for 10 seconds

function GeminiIntegration:load()
    print("Gemini Integration mod loaded.")

    -- Load libraries
    local jsonPath = g_currentModDirectory .. "json.lua"
    local success, library = pcall(loadfile, jsonPath)
    if success and library ~= nil then
        json = library()
        print("JSON library loaded successfully.")
    else
        print("Error: Could not load json.lua.")
        return
    end

    local displayPath = g_currentModDirectory .. "GeminiDisplay.lua"
    success, library = pcall(loadfile, displayPath)
    if not success or library == nil then
        print("Error: Could not load GeminiDisplay.lua.")
        return
    end
    library() -- Execute the display script to make the class available

    g_inputBinding:registerActionEvent(self, "GEMINI_EXPORT", self.exportData, false, true, false, false)
    print("Registered GEMINI_EXPORT action.")

    -- Create the response display
    self.responseDisplay = GeminiDisplay.new()
    self.responseDisplay:setVisible(false)
    g_hud:addElement(self.responseDisplay)
end

function GeminiIntegration:update(dt)
    checkTimer = checkTimer + dt
    if checkTimer > checkInterval then
        checkTimer = 0
        self:checkResponse()
    end

    if self.responseDisplay and self.responseDisplay:isVisible() then
        responseDisplayTimer = responseDisplayTimer + dt
        if responseDisplayTimer > responseDisplayDuration then
            self.responseDisplay:setVisible(false, true) -- Animate hiding
        end
    end
end

function GeminiIntegration:checkResponse()
    local responsePath = g_currentModDirectory .. "gemini_response.txt"
    local file = io.open(responsePath, "r")

    if file then
        local content = file:read("*a")
        io.close(file)
        os.remove(responsePath)
        self:showResponse(content)
    end
end

function GeminiIntegration:showResponse(text)
    print("--- Gemini Response ---")
    print(text)
    print("-----------------------")

    self.responseDisplay:setText(text)
    self.responseDisplay:setVisible(true, true) -- Animate showing
    responseDisplayTimer = 0
end

function GeminiIntegration:exportData()
    print("Exporting data...")

    if json == nil then
        print("Error: JSON library not loaded.")
        return
    end

    local data = {}
    if g_currentMission and g_currentMission.getMoney then
        data.money = g_currentMission:getMoney()
    else
        data.money = "unknown"
    end
    if g_missionManager and g_missionManager.missionInfo and g_missionManager.missionInfo.dayTime then
        data.dayTime = g_missionManager.missionInfo.dayTime
    else
        data.dayTime = "unknown"
    end

    local jsonData = json.encode(data)
    local filePath = g_currentModDirectory .. "gemini_data.json"
    local file = createFile(filePath, FileAccess.WRITE)
    if file ~= 0 then
        fileWrite(file, jsonData)
        delete(file)
        print("Data exported to " .. filePath)
    else
        print("Error: Could not open file for writing: " .. filePath)
    end
end

addModEventListener(GeminiIntegration)
