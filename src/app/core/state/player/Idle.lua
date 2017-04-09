--
-- 等待出牌状态 什么都不能干
--
local Idle = class("Idle")

function Idle:exec()

end

-- 出牌
function Idle:play(cardArray)
end

-- 提示
function Idle:prompt()
end

return Idle