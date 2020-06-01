------------------------------------------------------------
-- このファイルを 'main.lua' にコピーして使用できます
------------------------------------------------------------

--同じVCIが複数存在しても良いようにナンバー

--アセットの取得
local gunsword = vci.assets.GetSubItem("gunsword")
aaaaa = 0

--装備中かのステータス切り替え

---アイテムを生成したユーザーで毎フレーム呼ばれる
function update()
end

---全ユーザーで毎フレーム呼ばれる
function updateAll()

    
end

---[SubItemの所有権&Use状態]アイテムをグラッブしてグリップボタンを押すと呼ばれる。
---@param use string @押されたアイテムのSubItem名
function onUse(use)
end

---[not SubItemの所有権&Use状態]アイテムをグラッブしてグリップボタンを押してはなしたときに呼ばれる。
---@param use string @押されたアイテムのSubItem名
function onUnuse(use)
end

---[SubItemの所有権]アイテムにCollider(Trigger)が接触したときに呼ばれる。
---@param item string @SubItem名
---@param hit string @Collider名
function onTriggerEnter(item, hit)
end

---[SubItemの所有権]アイテムにCollider(Trigger)が離れたときに呼ばれる。
---@param item string @SubItem名
---@param hit string @Collider名
function onTriggerExit(item, hit)
end

---[SubItemの所有権]アイテムにCollider(not Trigger)が接触したときに呼ばれる。
---@param item string @SubItem名
---@param hit string @Collider名
function onCollisionEnter(item, hit)
end

---[SubItemの所有権]アイテムにCollider(not Trigger)が離れたときに呼ばれる。
---@param item string @SubItem名
---@param hit string @Collider名
function onCollisionExit(item, hit)
end

---[SubItemの所有権&Grab状態]アイテムをGrabしたときに呼ばれる。
---@param target string @GrabされたSubItem名
function onGrab(target)
    if gunsword.IsAttached == true then
        print("装備中に掴みました。")
        print("装備解除の音を鳴らします。")
    end
    if gunsword.IsAttached == false then
        print("装備していないときに掴みました。")
    end
end

---[not SubItemの所有権&Grab状態]アイテムをUngrabしたときに呼ばれる。
---@param target string @UngrabされたSubItem名
function onUngrab(target)
    if gunsword.IsAttached == true then
        print("装備中に離しました。")
        print("装着時の音を鳴らします。")
    end
    if gunsword.IsAttached == false then
        print("装備していないときに離しました。")
    end
end


function changeTimeZone(sender, name, message) --"set_timeZone"メッセージで実行される処理
    flag = message --メッセージを受信したときにだけ値を更新
end

vci.message.On("set_timeZone", changeTimeZone) -- "set_timeZone"メッセージの受信を開始