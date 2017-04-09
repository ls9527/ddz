--
--  首次出牌状态
-- 开局第一个人出牌,或者出了牌没其他人管上的时候就是首次出牌状态

local FirstPlay = class("FirstPlay")

-- 出牌状态
function FirstPlay:exec()
    -- 重置倒计时时间
    self._player._waitTime = WAIT_TIME
end

-- 出牌
function FirstPlay:play()
    return self._player:play()
end

-- 提示
-- 首次出牌 不提示出什么牌
function FirstPlay:prompt()
end

return FirstPlay