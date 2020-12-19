script.on_init(function(event)
	if remote.interfaces["freeplay"] then
		local items_to_insert = remote.call("freeplay", "get_created_items")
		-- local landfill = "landfill"
		-- if game.item_prototypes["landfill-sand-3"] then
		-- 	landfill = "landfill-sand-3"
		-- end
		items_to_insert["omnidensator-1"] = (items_to_insert["omnidensator-1"] or 0) + 1
		items_to_insert["burner-omni-furnace"] = (items_to_insert["burner-omni-furnace"] or 0) + 1
		items_to_insert["crystallizer"] = (items_to_insert["crystallizer"] or 0) + 1
		--Give some starter fuel for the first furnace & crusher
		items_to_insert["wood-pellets"] = (items_to_insert["wood-pellets"] or 0) + 50
		items_to_insert["landfill"] = (items_to_insert["landfill"] or 0) + 200
		--Nil the burner mining drill that omnimatter inserts
		items_to_insert["burner-mining-drill"] = nil
		--Start with 2 electric omnitractors to avoid unneeded handcrafting cellulose for fuel
		items_to_insert["omnitractor-1"] = 2
		items_to_insert["burner-omnitractor"] = nil
		--Start with 1 clarifier for the initial setup
		items_to_insert["clarifier"] = 1
		--Swap burner phlog into electric
		items_to_insert["omniphlog-1"] = 1
		items_to_insert["burner-omniphlog"] = nil
		remote.call("freeplay", "set_created_items", items_to_insert)
	end
end)

--Unlock startup1 with Omnite ( and 3+4 if omnimatter_energy is active)
function checkCraftResultTechs(player,inventory)
    local inv = player.get_inventory(inventory)
    if inv.get_item_count("omnite") > 0 then
    player.force.technologies["sb-startup1"].researched = true
    end
    if game.active_mods["omnimatter_energy"] then
        if inv.get_item_count("omnitor") > 0 then
        player.force.technologies["sb-startup2"].researched = true
        end
        if inv.get_item_count("omnitor-lab") > 0 then
            if player.force.technologies["sct-research-t1"] then
            player.force.technologies["sct-research-t1"].researched = true
            else
            player.force.technologies["sb-startup4"].researched = true
            end
        end
    end
end

script.on_event(defines.events.on_player_main_inventory_changed, function(event)
  local player = game.players[event.player_index]
  checkCraftResultTechs(player,defines.inventory.character_main)
end)