--
-- 游戏中心

local GameCenter = class("GameCenter",function()
    return display.newLayer()
end)

local CenterState =require("app.core.state.center.CenterState")
function GameCenter:ctor()
    -- 按钮
    display.addSpriteFrames("newMain/main_resource.plist", "newMain/main_resource.png")
    -- 卡牌
    display.addSpriteFrames("cardList.plist", "cardList.png")
    --添加背景图片
    local sprite =  display.newSprite("spr_bg_game_scene.jpg")
    sprite:pos(display.cx,display.cy)
    :setScale(0.8)
    self:addChild(sprite)


end


-- 定时器
function GameCenter:update(dt)
    -- 当前状态是否可以切换为下一个状态
    if self._state:canNext() then
        -- 切换到下一个状态
        self._state:changeToNext()
    end
end

-- 游戏结束
function GameCenter:gameFinish()
    print("游戏结束")
    self:unscheduleUpdate()
end


-- 游戏开始
function GameCenter:start()
    -- 创建中心状态
    self._state = CenterState.create(self)
    self._state:enterState()
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
        self:update(dt)
    end)
    self:scheduleUpdate()
end
return GameCenter


