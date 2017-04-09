--
--  玩



local RunState = class("RunState",function(centerData)
    return require("app.core.state.center.PollState").new(centerData)
end)

function RunState:currentStateFinish()
    return false
end

function RunState:ctor(centerData)

    centerData._center:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            local cardArray = self:getCurrentPlayer():getCardArray()

            return true;
        end
        if(event.name=="ended") then
        end
    end)

end

function RunState:enterState(centerData)

    centerData._center:setTouchEnabled(true)
end



return RunState