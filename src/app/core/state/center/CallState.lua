--
-- 叫地主

local BTN_WIDTH = 241
local BTN_HEIGHT = 79
local CallState = class("CallState",function(centerData)
    return require("app.core.state.center.PollState").new(centerData)
end)

function CallState:addScoreBtn(listView,normal,pressed,disabled,callback)
    local score = cc.ui.UIPushButton.new({ normal = normal,pressed=pressed, disabled=disabled})
    :onButtonClicked(function()
        callback()
    end)
    local listItem = listView:newItem(score)
    listItem:setItemSize(BTN_WIDTH,BTN_HEIGHT,true)
    listView:addItem(listItem)
end
function CallState:ctor(centerData)
    math.randomseed(os.time())
    -- 设置当前叫地主玩家
    centerData._currentPlayerIndex = math.random(1,3);
    centerData._currentScore =0
    centerData._callCount = 0

end

function CallState:enterState(centerData)
print(display.cy+200)
    local listView = cc.ui.UIListView.new({
        direction = cc.ui.UIScrollView.DIRECTION_HORIZONTAL,
        alignment = cc.ui.UIListView.ALIGNMENT_VCENTER,
        viewRect = cc.rect(display.cx,display.cy+200,BTN_WIDTH * 4,BTN_HEIGHT),
    })
    :setScale(0.5)
    :setAnchorPoint(cc.p(0.5,0.5))
    :setBounceable(false) --设置滚动控件是否开启回弹功能
    :addTo(centerData._center)

    local callBackScore = function(currentScore)
        if currentScore~=0 and  currentScore<=centerData._currentScore then
            print("叫的分数不对啊，大佬")
            return
        end
        centerData._currentScore = currentScore
        centerData._callCount = centerData._callCount +1
        self:nextPlay()
        listView:hide()
    end
    self:addScoreBtn(listView,"#main_btn_1.png",
        "#main_btn_1_select.png",
        "#main_btn_1_disable.png",function()
            callBackScore(1)
        end)
    -- 二分
    self:addScoreBtn(listView, "#main_btn_2.png",
        "#main_btn_2_select.png",
        "#main_btn_2_disable.png",function()
            callBackScore(2)
        end)
    -- 三分
    self:addScoreBtn(listView, "#main_btn_3.png",
        "#main_btn_select.png",
        "#main_btn_3_disable.png",function()
            callBackScore(3)
        end)

    -- 不叫
    self:addScoreBtn(listView,"#main_btn_score_0.png",
        "#main_btn_score_0_select.png","",function()
            callBackScore(0)
        end)

    listView:reload()
end
-- 当前状态是否结束
function CallState:currentStateFinish()
    -- 有人叫了3分  或者 三个人分别点击
    return self._centerData._currentScore == 3 or self._centerData._callCount == 3
end

return CallState
