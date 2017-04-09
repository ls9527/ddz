--
--  玩


local FinishState = class("FinishState",function(centerData)
    return require("app.core.state.center.CenterState").new(centerData)
end)
function FinishState:ctor(centerData)
    centerData._center:gameFinish()
end
function FinishState:canNext()
    return false
end

return FinishState