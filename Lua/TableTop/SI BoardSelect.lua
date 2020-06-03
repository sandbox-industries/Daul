-- Spirit Tile for Bone White's Spirit Island Mod v2 --

function onLoad()
    SpiritDeck = getObjectFromGUID(SpiritDeck)
    self.createButton({
        click_function = "SetupSpirit",
        function_owner = self,
        label          = "Choose Spirit",
        position       = {0.7, -0.1, 0.9},
        rotation       = {0,0,180},
        scale = {0.2,0.2,0.2},
        width          = 1800,
        height         = 500,
        font_size      = 300,
    })
end

function SetupSpirit(object_pick,player_color)
    local xPadding = 1.3
    local xOffset = 1
    counterBag = getObjectFromGUID(Global.getVar("counterBag"))
    ListPressence = getObjectFromGUID(Global.getTable("PresenceTokenZones")[player_color]).getObjects()
    if ListPressence[1] != nil then
        local castObjects = upCast(self,1,0.5)
        local hpos = Player[player_color].getHandTransform().position
        self.setPosition(Vec_sum({hpos.x,0,hpos.z},{0,1.05,11.8}))
        self.setRotation({0,180,0})
        self.setLock(true)
        local spos = self.getPosition()
        ListPressence = getObjectFromGUID(Global.getTable("PresenceTokenZones")[player_color]).getObjects()
        local snaps = self.getSnapPoints()
        local placed = 0
        for i = 1,13 do
            p = snaps[i]
            if i <= #snaps then
                --p = {p.position.x/self.getScale().x,0.2,p.position.z/self.getScale().z}
                ListPressence[i].setPositionSmooth(self.positionToWorld(p.position))
            else
                ListPressence[i].setPositionSmooth(Vec_sum({spos.x,0,spos.z},{-placed*xPadding+xOffset,1.1,10}))
                placed = placed + 1
            end
        end
        ListPressence = getObjectFromGUID(Global.getTable("PresenceTokenZones")[player_color]).getObjects()
        zoneTemp = getObjectFromGUID(Global.getTable("AidTokenZones")[player_color]).getObjects()
        zoneTemp[1].setPositionSmooth(Vec_sum({spos.x,0,spos.z},{-9.2, 1.1, -5}))
        zoneTemp[2].setPositionSmooth(Vec_sum({spos.x,0,spos.z},{-9.2, 1.1, -3}))
        zoneTemp[3].setPositionSmooth(Vec_sum({spos.x,0,spos.z},{-9.2, 1.1, -1}))
        newCounter = counterBag.takeObject({ -- counterBag
            position       = Vec_sum({spos.x,0,spos.z},{-5,1,5})
        })
        newCounter.setLock(true)
        self.removeButton(0)
        for i,obj in pairs (castObjects) do
            obj.setLock(false)
            if obj.tag == "Deck" then
                if string.find(obj.getName(),"Progression") then
                    obj.setPosition(Vec_sum({spos.x,0,spos.z},{0,1.1,14}))
                else
                    obj.deal(#obj.getObjects(),player_color)
                end
            else
                obj.setPositionSmooth(Vec_sum({spos.x,0,spos.z},{-placed*xPadding+xOffset,1.1,10}))
                placed = placed + 1
            end
        end
    else
        broadcastToAll(player_color .. " already picked a spirit", {1,0,0})
    end
end
-----
function Vec_sum(vec1,vec2)
    return {vec1[1]+vec2[1], vec1[2]+vec2[2],  vec1[3]+vec2[3]}
end
---------------
function waitone(some)
local Time = os.clock() + some
        while os.clock() < Time do
            coroutine.yield(0)
        end
end
--------------------
function upCast(obj,dist,offset,multi)
    local dist = dist or 1
    local offset = offset or 0
    local multi = multi or 1
    local oPos = obj.getPosition()
    local oBounds = obj.getBoundsNormalized()
    local oRot = obj.getRotation()
    local orig = {oPos[1],oPos[2]+offset,oPos[3]}
    local siz = {oBounds.size.x*multi,dist,oBounds.size.z*multi}
    local orient = {oRot[1],oRot[2],oRot[3]}
    local hits = Physics.cast({
        origin       = orig,
        direction    = {0,1,0},
        type         = 3,
        size         = siz,
        orientation  = orient,
        max_distance = 0,
        --debug        = true,
    })
    local hitObjects = {}
    for i,v in pairs(hits) do
        if v.hit_object ~= obj then table.insert(hitObjects,v.hit_object) end
    end
    return hitObjects
end