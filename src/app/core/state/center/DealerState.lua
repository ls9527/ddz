--
-- 发牌
local POKE_WIDTH = 151
local POKE_HEIGHT = 209
local DealerState = class("DealerState",function(centerData)
    return require("app.core.state.center.CenterState").new(centerData)
end)
local PlayerClass =require("app.core.Player")
local PLAYER_NUMBER = 3
local SCALE = 0.7
function DealerState:pokeListTouchListener(event)
dump(event)
    if "clicked" == event.name then -- 选择一张牌
        local x,y = event.x,event.y
        local listView = event.listView
--        event.item:setMargin({left=0,right=0,top=10,bottom=0});
--        listView:removeItem(event.item)
    elseif "began" == event.name then
        print("began")
    elseif "moved" == event.name then
        print("moved")
    elseif "ended" == event.name then
        print("ended")
    end
    return true
end
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
        alignment = cc.ui.UIListView.ALIGNMENT_VCENTER ,
        viewRect = cc.rect(0,0,display.width,POKE_HEIGHT),
        bgColor = cc.c4b(200, 200, 200, 120),
    })
--    :setScale(0.8)
    :setBounceable(false) --设置滚动控件是否开启回弹功能
    :onTouch(handler(self,self.pokeListTouchListener))
    :addTo(centerData._center)


    for i=1,#cardArray,1 do
        local content = cc.ui.UIPushButton.new("#poke"..cardArray[i]:getNumber()..".png")
        content:setTouchSwallowEnabled(false)
        content:setScale(SCALE)
        content:setAnchorPoint(cc.p(0.5,0.5))
        local listItem = listView:newItem(content)
        local margin = {left=-60,right=0,top=0,bottom=0 }
        listItem:setMargin(margin)
        listItem:setItemSize(POKE_WIDTH*SCALE,POKE_HEIGHT*SCALE,false )

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
