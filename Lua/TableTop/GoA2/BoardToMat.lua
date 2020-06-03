function onCollisionEnter(info)
  if info.collision_object.getName():find('Player Mat') then
    getObjectFromGUID("75ab50").call("cleanArea", {info.collision_object, self})
  end
end

function cleanArea(params)
   local pos = params[1].getPosition()
   local selfObject = params[2]
   selfObject.setPosition({pos.x, pos.y + 10, pos.z})
   local bagPos = {pos.x - 10, pos.y + 1, pos.z}
   -- local envelopes = Global.getTable("envelopes")
   local name = selfObject.getName()
   local hittedBag = false

   local hitlist = Physics.cast({
      -- origin = ,        -- #################
      direction = {0, 1, 0},
      type = 2,
      size = {3, 3, 3},
      max_distance = 0,
      debug = false
   }) -- returns {{Vector point, Vector normal, float distance, Object hit_object}, ...}

   for i, j in pairs(hitlist) do
      if j.hit_object.tag == "Bag" and j.hit_object.getName() ~= "Summons" then
         hittedBag = j.hit_object
      end
   end

   if hittedBag then
      local _, _, zone = playerCheck(pos.x)
      for u, v in pairs(getObjectFromGUID(zone).getObjects()) do
         if v.getGUID() ~= "dff000" and v.getGUID() ~= "42d2b6" and v ~= selfObject and v.getName() ~= "Remove Player" and v ~= hittedBag then
            hittedBag.putObject(v)
         end
      end
      hittedBag.setDescription("Repacked")
      hittedBag.setPositionSmooth({pos.x, pos.y + 1, pos.z + 12}, false, true)
   end


   selfObject.setPosition(bagPos)
   selfObject.setRotationSmooth({0.00, 270.00, 0.00})
   selfObject.setVelocity({0.00, 0.00, 0.00})
   selfObject.setAngularVelocity({0.00, 0.00, 0.00})

   Wait.frames(function() checkInside({name, pos, selfObject}) end, 5)

   params[1].destruct()
end