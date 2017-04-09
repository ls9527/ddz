--
-- 发牌
local POKE_WIDTH = 151
local POKE_HEIGHT = 209
local DealerState = class("DealerState",function(centerData)
    return require("app.core.state.center.CenterState").new(centerData)
end)
local PlayerClass =require("app.core.Player")
local PLAYER_NUMBER = 3

function DealerState:ctor(centerData)
    centerData._playerArray = {}
    local playerArray = {}
    local playingCard =  self._centerData._playingCard
    -- 初始化玩家
    for i=1,PLAYER_NUMBER,1 do
        table.insert(playerArray,PlayerClass.new())
    end
    -- 初始化玩家手里的卡牌
    for i=0,#playingCard -4,1 do
        local playerIndex = i% PLAYER_NUMBER +1
        playerArray[playerIndex]:addCard(playingCard[i+1])
    end

    local cardArray = playerArray[1]:getCardArray()
    print("DealerState:execute()", playerArray[1]:getCardArray())

    local listView = cc.ui.UIListView.new({
        direction = cc.ui.UIScrollView.DIRECTION_HORIZONTAL,
        alignment = cc.ui.UIListView.ALIGNMENT_VCENTER,
        viewRect = cc.rect(0,0,display.width,POKE_HEIGHT*1.5),
        bgColor = cc.c4b(200, 200, 200, 120),
    })
    :setScale(0.8)
    :setAnchorPoint(cc.p(0.5,0.5))
    :setBounceable(false) --设置滚动控件是否开启回弹功能
    :onScroll(function(event)
        if "began" == event.name then
            print("began")
            return true
        elseif "moved" == event.name then
            print("moved")
        elseif "ended" == event.name then
            print("ended")
        end
    end)
    :addTo(centerData._center)


    for i=1,#cardArray,1 do
        local content = cc.ui.UIPushButton.new("#poke"..cardArray[i]:getNumber()..".png", {scale9 = true})
        content:setTouchSwallowEnabled(false)
        content:setScale(0.8)
        local listItem = listView:newItem(content)
        listItem:setItemSize(50,POKE_HEIGHT,true)
        listView:addItem(listItem)
    end
    print("cardArray",#cardArray)

    listView:reload()
--    listView:refreshView()
    self._centerData._playerCardListView = listView
    self._centerData._playerArray = playerArray
end

function DealerState:canNext()
    return true
end


return DealerState
