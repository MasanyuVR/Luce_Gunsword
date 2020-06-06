------------------------------------------------------------
-- このファイルを 'main.lua' にコピーして使用できます
------------------------------------------------------------

--同じVCIが複数存在しても良いようにユニークナンバーを用意してみる？

--アセットの取得
local gunsword = vci.assets.GetSubItem("gunsword")

--装備中かのステータス切り替え用変数
local attachedStatus = nil
if vci.assets.IsMine then -- 呼び出したユーザーが代表して初期化する
    vci.state.Set("ATTACHEDSTATUS", false) 
end
if vci.state.Get("ATTACHEDSTATUS") ~=nil then --現在の部屋の状態と同期
    attachedStatus = vci.state.Get("ATTACHEDSTATUS")
end

---アイテムを生成したユーザーで毎フレーム呼ばれる
function update()
end

---全ユーザーで毎フレーム呼ばれる
function updateAll()

    
end

---[SubItemの所有権&Use状態]アイテムをグラッブしてグリップボタンを押すと呼ばれる。
---@param use string @押されたアイテムのSubItem名
function onUse(use)
    --バーンと音を鳴らす
    vci.assets._ALL_PlayAudioFromName("bang")
end

---[not SubItemの所有権&Use状態]アイテムをグラッブしてグリップボタンを押してはなしたときに呼ばれる。
---@param use string @押されたアイテムのSubItem名
function onUnuse(use)
end

---[SubItemの所有権]アイテムにCollider(Trigger)が接触したときに呼ばれる。
---@param item string @SubItem名
    --vci.assets._ALL_PlayAudioFromName("collision")
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
    --vci.assets._ALL_PlayAudioFromName("collision")
end

---[SubItemの所有権]アイテムにCollider(not Trigger)が離れたときに呼ばれる。
---@param item string @SubItem名
---@param hit string @Collider名
function onCollisionExit(item, hit)
end

---[SubItemの所有権&Grab状態]アイテムをGrabしたときに呼ばれる。
---@param target string @GrabされたSubItem名
function onGrab(target)
    print("アイテムを掴みました。")
    if vci.state.Get("ATTACHEDSTATUS") == true then
        print("掴んだ時は誰かが装着中でした。")
        print("装備解除のリクエストを送信します。")
        vci.message.Emit("set_attachedStatus", false) --"set_attachedStatus"メッセージを各々の参加者に送信
        print("装備解除時の音を鳴らします。")
        --音を鳴らす
        vci.assets._ALL_PlayAudioFromName("release")
    elseif vci.state.Get("ATTACHEDSTATUS") == false then
        vci.assets._ALL_PlayAudioFromName("grab")
    end
end

---[not SubItemの所有権&Grab状態]アイテムをUngrabしたときに呼ばれる。
---@param target string @UngrabされたSubItem名
function onUngrab(target)
    if gunsword.IsAttached == true then
        print("装着判定時にアイテムを離しました。")
        print("ステータスを装備中に変更するリクエストを送信します。")
        vci.message.Emit("set_attachedStatus", true) --"set_attachedStatus"メッセージを各々の参加者に送信
        print("装着時の音を鳴らします。")
        --音を鳴らす
        vci.assets._ALL_PlayAudioFromName("equip")
    elseif gunsword.IsAttached == false then
        print("空中でアイテムを離しました。")
        --vci.assets._ALL_PlayAudioFromName("ungrab")
    end
end


function set_attachedStatus(sender, name, message) --"set_attachedStatus"メッセージで実行される処理
    print("メッセージを受信しました。")
    print(message)
    if vci.assets.IsMine then -- 呼び出したユーザーが代表して初期化する
        print("ステータスを変更します。")
        vci.state.Set("ATTACHEDSTATUS", message) 
    end
    --ラグが発生して、変数変更より前に以下の判定が行われてしまう？
    --if vci.state.Get("ATTACHEDSTATUS") == true then
     --   print("装着時の音を鳴らします。")
    --elseif vci.state.Get("ATTACHEDSTATUS")== false then
    --    print("装備解除時の音を鳴らします。")
    --end
end

vci.message.On("set_attachedStatus", set_attachedStatus) -- "set_attachedStatus"メッセージの受信を開始