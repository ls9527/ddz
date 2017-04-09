--
-- 单张卡牌
-- sort = 3 - 17
-- J=11 Q = 12 K = 13 A = 14 2 = 15 yong Jocker = 16 old Jocker = 17
-- type 类型, 黑桃，红桃，梅花，方块，无    1,2,3,4, 10
-- 多选牌不能由牌事件去监听，而是监听牌所在的层
local Card = class("Card")
--local HEIGHT = 105
--local WIDTH = 80
local HEIGHT = 210
local WIDTH = 128
function Card:ctor(number,type)
    local sort = number /4
    sort = tonumber(string.format("%.0f",math.floor(sort))) + 3
    self._sort = sort
    self._number = number
    self._type = type
    local x = (sort-3)*WIDTH
    local y = HEIGHT * (4-type)

--    self._sprite =  cc.Sprite:create("card2.png",cc.rect(x,y,WIDTH,HEIGHT))
    self._sprite =  display.newSprite("#poke"..number..".png")
    self._sprite:setAnchorPoint(0,0)
    :setScale(0.5)

    self._sprite:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            return true;
        end
        if(event.name=="ended") then
            print(event.x,event.y,self._sort,self._type)
        end
    end)

    self._sprite:setTouchEnabled(true)
end

-- 状态: NORMAL 正常 SELECT 选择
function Card:enableTouch()
    self._sprite:setTouchEnabled(true)
end
function Card:getSprite()
    return self._sprite
end
function Card:setSort(sort)
    self._sort = sort
end
function Card:getSort()
    return self._sort
end
function Card:getNumber()
    return self._number
end
function Card:getType()
    return self._type
end
function Card:setType(type)
    self._type = type
end

return Card