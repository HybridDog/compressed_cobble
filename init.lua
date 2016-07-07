local load_time_start = minetest.get_us_time()


local technic_available = minetest.global_exists"technic"

local def = minetest.registered_nodes["default:cobble"]
local box = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},
}

for i = 1,6 do
	local scale = 3^i
	local amount = scale^3
	local ns = scale*.5
	scale = 1/scale
	local name = "compressed_cobble:cobble_"..i
	minetest.register_node(name, {
		description = amount.." compressed cobble",
		drawtype = "nodebox",
		tiles = def.tiles,
		paramtype = "light",
		groups = def.groups,
		sounds = def.sounds,
		visual_scale = scale,
		wield_scale = {x=scale, y=scale, z=scale},
		node_box = {
			type = "fixed",
			fixed = {
				{-ns, -ns, -ns, ns, ns, ns},
			},
		},
		selection_box = box,
		collision_box = box,
	})

	if technic_available then
		local input_i = i-1
		local input
		if input_i == 0 then
			input = "default:cobble 27"
		else
			input = "compressed_cobble:cobble_"..input_i.." 27"
		end
		technic.register_compressor_recipe{input = {input}, output = name}
		minetest.register_craft{output = input, recipe = {{name}}}
	end
end


local time = (minetest.get_us_time() - load_time_start) / 1000000
local msg = "[compressed_cobble] loaded after ca. " .. time .. " seconds."
if time > 0.01 then
	print(msg)
else
	minetest.log("info", msg)
end
