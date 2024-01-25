StartNPC, HasGold = {},

Citizen.CreateThread(function()
    StartNPC = SpawnNPC(START_NPC.ped.model, START_NPC.ped.coords, START_NPC.ped.heading)
    FreezeEntityPosition(StartNPC, true)
    SetEntityInvincible(StartNPC, true)
    SetBlockingOfNonTemporaryEvents(StartNPC, true)
    TaskStartScenarioInPlace(StartNPC, "WORLD_HUMAN_SMOKING", 0, true)
    AddEntityMenuItem({
        entity = StartNPC,
        event = "azakit_scrapaircon:StartDisassembly",
        desc = _("start_npc")
    })

end)


function StartDisassembly()
    TriggerServerCallback('azakit_scrapaircon:Start', function(data)

        if not data.cops then
            lib.notify({
                position = 'top',
                title = _("nopolice"),
                type = 'error'
              })
            return
        end
		TriggerEvent('azakit_scrapaircon:Check')

    end)
end
RegisterNetEvent("azakit_scrapaircon:StartDisassembly", StartDisassembly)



RegisterNetEvent('azakit_scrapaircon:Check', function()

    local hasItem = true
    lib.notify({
        position = 'top',
        title = _("check"),
        type = 'info'
      })

    if ITEM then
        hasItem = false

        TriggerServerCallback('azakit_scrapaircon:itemTaken', function(cb)
        hasItem = cb

        end)
        Wait(1000)
    end
    if hasItem then
        onjob = true
        TriggerEvent('azakit_scrapaircon:startdisass')
    else
        lib.notify({
            position = 'top',
            title = _("noitem"),
            type = 'error'
          })
    end
end)

RegisterNetEvent("azakit_scrapaircon:startdisass")
AddEventHandler("azakit_scrapaircon:startdisass", function()

	lib.notify({
		position = 'top',
		title = _("gotodelivery"),
		type = 'success',
        duration = 5000,
	  })

	local itslocation = math.random(1, #Disassemblylocations)
    co = Disassemblylocations[itslocation]
	BlipMaken(co)
	Disassemblygestart = true
end)


BlipMaken = function()
    Disassemblyblip = AddBlipForCoord(co.x, co.y, co.z)
    SetBlipSprite (Disassemblyblip, blipsprite)
    SetBlipDisplay(Disassemblyblip, 4)
    SetBlipScale  (Disassemblyblip, blipscale)
    SetBlipAsShortRange(Disassemblyblip, true)
    SetBlipColour (Disassemblyblip, blipcolour)
    SetBlipRoute(Disassemblyblip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_("Disassemblyblipname"))
    EndTextCommandSetBlipName(Disassemblyblip)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        emez = true
		if Disassemblygestart then
			local coords = GetEntityCoords(PlayerPedId())
			if GetDistanceBetweenCoords(coords, co.x, co.y, co.z, true) < 3 then
				emez = false
				DrawScriptText(vector3(co.x,co.y,co.z+0.2), _("Transportdraw"))
				if IsControlJustReleased(0, 38) then
					if lib.progressCircle({
						duration = 0,
					}) then InteractAirConditioner(index)
						Disassemblygestart = false
						RemoveBlip(Disassemblyblip)
					end
				end
			else
				emez = true
			end
		end
	end
    if emez then
        Wait(500)
    end
end)


function ExchangeRequest(index)
    TriggerServerCallback("azakit_scrapaircon:exchangeProcess", function(result)
        if result then
                  lib.notify({
                    position = 'top',
                    title = _("reward"),
                    type = 'success'
                  })
        else
                lib.notify({
                  position = 'top',
                  title = _("noitem2"),
                  type = 'error'
                })
        end
    end, index)
end


function InteractAirConditioner(index)
    if Interact then return end
    Interact = true
        local ped = PlayerPedId()

-- Load animation dictionary
RequestAnimDict('mini@repair')
while not HasAnimDictLoaded('mini@repair') do
    Wait(500)
end
       -- lib.requestAnimDict('mini@repair', 10)
        TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, -8.0, -1, 48, 0)
        if Check.EnableSkillCheck then
            local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy'}, { 'w', 'a', 's', 'd' })
            if success then
                ExchangeRequest(index)
            else
                lib.notify({
                    position = 'top',
                    title = _("failed"),
                    type = 'error'
                  })
            end
        else
            Wait(1000 * Check.ProcessTime)
            lib.progressCircle({
                duration = Duration,
                label = _("process"),
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = true,
                    car = true,
                },
                anim = {
                    dict = 'mini@repair',
                    clip = 'fixing_a_ped'
                },})
            ExchangeRequest(index)
        end
        ClearPedTasks(ped)
        Interact = false
end


function DrawScriptText(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords["x"], coords["y"], coords["z"])

    SetTextScale(0.35, 0.35)
    SetTextFont(2)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = string.len(text) / 370

    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 65)
end
