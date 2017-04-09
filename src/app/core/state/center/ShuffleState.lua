--
-- 洗牌
local ShuffleState = class("ShuffleState",function(centerData)
    return require("app.core.state.center.CenterState").new(centerData)
end)
local CardClass = require("app.core.Card")
-- 卡牌数量
local CARD_COUNT = 54
function ShuffleState:ctor(centerData)
    self._centerData = centerData

    local cardArray = {}
    -- 初始化所有扑克
    for i=CARD_COUNT,1,-1 do
        local type = i%4 + 1
        local card = CardClass.new(i-1,type)
        table.insert(cardArray,card)
    end

    math.randomseed(os.time())
    -- 每次生成一张最大的牌，与随机的某张牌换位子
    for i=#cardArray,2,-1 do
        local rnd = math.random(1,i);
        cardArray[i],cardArray[rnd] = cardArray[rnd],cardArray[i]
    end

    centerData._playingCard = cardArray
end

function ShuffleState:canNext()
    return true
end

return ShuffleState
