local technic_available = rawget(_G, "technic") and true

for i = 1,9 do
	local scale = 3^i
	local amount = scale^3
	local ns = scale/2
	scale = 1/scale
	local name = "compressed_cobble:cobble_"..i
	minetest.register_node(name, {
		description = amount.." compressed cobble",
		drawtype = "nodebox",
		tiles = {"default_cobble.png"},
		paramtype = "light",
		groups = {cracky=3, stone=2},
		sounds = default.node_sound_stone_defaults(),
		visual_scale = scale,
		wield_scale = {x=scale, y=scale, z=scale},
		node_box = {
			type = "fixed",
			fixed = {
				{-ns, -ns, -ns, ns, ns, ns},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
	})

	if technic_available then
		local input_i = i-1
		local input
		if input_i == 0 then
			input = "default:cobble"
		else
			input = "compressed_cobble:cobble_"..input_i
		end
		technic.register_compressor_recipe({input = {input}, output = name})
	end
end
