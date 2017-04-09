--
-- 玩家状态

local PlayerClass = class("PlayerClass")

-- 出牌等待时间为30秒
local WAIT_TIME = 30

function PlayerClass:ctor()
end
-- 通过玩家创建玩家状态
function PlayerClass:create(state,player)
    local playerClass = PlayerClass.new()
    playerClass._idle = require("app.core.state.player.Idle")
    playerClass._play = require("app.core.state.player.Play")
    playerClass._firstPlay = require("app.core.state.player.FirstPlay")
    playerClass._stateArray = {
        idle=playerClass._idle,
        play=playerClass._play,
        firstPlay=playerClass._firstPlay
    }
    playerClass._current = playerClass._stateArray[state]
    playerClass._player = player
    return playerClass
end

-- ui 操作
function PlayerClass:changeState(state)
    self._current:changeState(state)
end

-- ui 操作
function PlayerClass:exec()
    self._current:exec()
end




-- 出牌
-- cardArray 最近打出的牌
function PlayerClass:play(cardArray)
   self._current:play(cardArray)
end
-- 要不起
function PlayerClass:pass()
    self:pass()
end
-- 传入最近打出的牌，提示可以用什么牌管上
function PlayerClass:prompt(cardArray)
    return self._current:prompt(cardArray)
end
return PlayerClass