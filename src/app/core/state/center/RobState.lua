--
--  抢地主
-- 2017-04-08 没有素材,省略抢地主


local RobState = class("RobState",function(centerData)
    return require("app.core.state.center.PollState").new(centerData)
end)


function RobState:ctor(centerData)
end

function RobState:currentStateFinish()
    return true
end

return RobState