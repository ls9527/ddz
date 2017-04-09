--
-- 中心状态

local CenterState = class("CenterClass")

function CenterState:ctor( centerData)
    self._centerData = centerData
end
function CenterState.create(center)
    local centerState = CenterState.new()
    local centerData = {_center=center}
    centerState._centerData = centerData

    centerState._stateArray = {}
    centerState._stateArray[1] = require("app.core.state.center.ShuffleState").new(centerData)
    centerState._stateArray[2] = require("app.core.state.center.DealerState").new(centerData)
    centerState._stateArray[3] = require("app.core.state.center.CallState").new(centerData)
    centerState._stateArray[4] = require("app.core.state.center.RobState").new(centerData)
    centerState._stateArray[5] = require("app.core.state.center.RunState").new(centerData)
    centerState._stateArray[6] = require("app.core.state.center.FinishState").new(centerData)
    centerState._currentIndex = 1
    centerState._current = centerState._stateArray[centerState._currentIndex]
    return centerState
end

function CenterState:changeToNext()
    self._currentIndex = self._currentIndex  + 1
    -- 越界处理
    if self._currentIndex == #self._stateArray+1 then
        return
    end
    self._current = self._stateArray[self._currentIndex]
    self._current:enterState(self._centerData)
end
-- 进入当前状态
function CenterState:enterState()
end

function CenterState:canNext()
    return self._current:canNext()
end

return CenterState
