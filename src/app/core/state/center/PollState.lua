--
-- 轮询状态,  封装 叫地主，抢地主，运行 三个状态的流程

--倒计时时间
local COUNT_DOWN = 15

local PollState = class("PollState",function()
    return require("app.core.state.center.CenterState").new()
end)

function PollState:ctor(centerData)
    self._callFinish = false
    self:refreshState(centerData)
end



--  继承者专用，外部不要调用，这一步必须在CallState(叫地主) 之后才可以用
function PollState:getCurrentPlayer()
    return  self._centerData._playerArray[self._centerData._currentPlayerIndex]
end

-- --  继承者专用，外部不要调用，将下一个玩家设置为可出牌
function PollState:nextPlay()
    self:getCurrentPlayer():refresh()
    self._flagTime = os.time()
    self._centerData._currentPlayerIndex = self._centerData._currentPlayerIndex % 3 +1
    self._changeNext = true
end
-- --  继承者专用，刷新状态
function PollState:refreshState(centerData)
    self._flagTime = os.time()
    self._centerData = centerData
end


-- --  继承者专用，外部不要调用，倒计时
function PollState:countDown()
    local time = os.time()
    local second = time - self._flagTime

    local printSecond = COUNT_DOWN - second
    if printSecond <= 0 then
        self:nextPlay()
    end
--    print("玩家id",self._centerData._currentPlayerIndex,"倒计时秒",printSecond)
end

-- 当前状态是否结束,返回ture就会进入下一个状态,这里由子类去重写
function PollState:currentStateFinish()
    return true
end

function PollState:canNext()
    self:countDown()
    return self:currentStateFinish()
end

return PollState