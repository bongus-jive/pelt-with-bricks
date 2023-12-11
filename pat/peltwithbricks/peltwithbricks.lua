require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/scripts/rect.lua"

local spawnRect = {50, -2.5, 25, 20}
local projId = "pat_peltingbrick"

function init()
	id = player.id()
	speed = root.projectileConfig(projId).speed
	gravity = root.projectileGravityMultiplier(projId)
	
	script.setUpdateDelta(3)
end

function update(dt)
	local r = copy(spawnRect)
	if math.random(0, 1) == 0 then
		r = rect.flipX(r)
	end
	
	local s = speed * util.randomInRange({0.8, 1.2})
	
	local spawnPos = vec2.add(rect.randomPoint(r), mcontroller.position())
	local targetPos = world.entityMouthPosition(id)
	targetPos = util.predictedPosition(targetPos, spawnPos, mcontroller.velocity(), s)
	
	local aimPos = world.distance(targetPos, spawnPos)
	aimPos[2] = aimPos[2] + sb.nrand(0.25, 0.25)
	local aimVector = util.aimVector(aimPos, s, gravity, math.random(1, 40) == 1)
	
	world.spawnProjectile(projId, spawnPos, 0, aimVector, false, {speed = s, targetPos = targetPos})
end
