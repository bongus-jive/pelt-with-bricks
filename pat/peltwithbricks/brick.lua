function init()
	target = config.getParameter("targetPos")
end

function update()
	if not target or world.magnitude(target, mcontroller.position()) <= 4 then
		mcontroller.applyParameters({collisionEnabled = true})
		script.setUpdateDelta(0)
	end
end
