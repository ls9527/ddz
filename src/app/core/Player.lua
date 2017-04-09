
--
-- 玩家



local Player = class("Player")


function Player:ctor()
    self.oprationArray = {}
    self._cardArray = {}
    self._state = false
    self._callIndex = 0
    self._call = 1
end

function Player:refresh()
    self._state = false
    self._callIndex = 0
    self._played = false
    self._call = 1
end



-- 不断的调用此方法，直到玩家叫地主或者不叫
function Player:getCallState()
    return self._call
end
-- 点击叫地主
function Player:CallOk()
    self._call = 2
end
function Player:CallPass()
    self._call = 3
end
function Player:played()
    return self._played
end
-- 发牌给玩家
function Player:addCard(card)
    table.insert(self._cardArray,card)
end
-- 设置将要出的牌
function Player:setSelectedCard(cardArray)
    --校验cardArray是不是自己手里拥有的牌
    --设置牌
    self._selectCardArray = cardArray
end

function Player:changeState(state)
    self._state:changeState(state)
end
--  出牌
function Player:play()
    if #self._selectCardArray == 0 then
        print("没有选择要出的牌")
        return
    end
    -- 将已选的牌从手牌扣除并返回
    return self._selectCardArray
end

function Player:pass()
    self._played = true
end

function Player:getCardArray()
    table.sort(self._cardArray,function(a,b)
        return a:getSort() > b:getSort()
    end)
    return self._cardArray
end
return Player