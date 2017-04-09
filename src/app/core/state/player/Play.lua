--
--  最近一次有其他人打出牌的状态
--

local Play = class("Play")
local PlayStateClass = class("PlayState")

function Play:ctor()
end
-- 出牌状态
function Play:exec()
    -- 重置倒计时时间
    self._player._waitTime = WAIT_TIME
end


-- 出牌
function Play:play()
    return self._player:play()
end


-- 提示 返回要不起(nil)或者一组牌(cardArray)
function Play:prompt(cardArray)
    return self._state:prompt(cardArray)
end

return Play