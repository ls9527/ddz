
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)


function MainScene:ctor()

end

function MainScene:onEnter()
    local GameCenterClass = require("app.core.GameCenter")
    local gameCenter = GameCenterClass.new()
    gameCenter:start()
    self:addChild(gameCenter)
end

function MainScene:onExit()
end

return MainScene
