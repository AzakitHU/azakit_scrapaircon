LANGUAGE = 'en'
Webhook = "" -- Discord Webhook

-- Blip settings
blipscale = 1.0
blipcolour = 3
blipsprite = 544

ITEM = "weapon_wrench"  -- item for work
ITEM_REMOVE = false -- removal of required item in case of successful dismantling
TICKETITEM_REQ = true -- if true, you need an extra ticket item
TICKETITEM = "infoticket" -- ticket item
TICKETITEM_AMOUNT = 1 -- the number of tickets check/remove
TICKETITEM_REMOVE = true -- required ticket item remove on check
POLICE_REQ = 0  -- Minimum police required to start
POLICE_JOB = "police"  -- Police Job

START_NPC = {   -- start npc settings
    ped = {
        model = "s_m_m_trucker_01",
        coords = vector3(-428.8789, -1728.2451, 18.7839),
        heading = 73.6692
    }
}

Rewarditem = 'metalscrap' -- reward item
Minrewardamount = 15  -- minimum reward
Maxrewardamount = 25  -- maximum reward

Disassemblylocations = {  -- air conditioner disassembly points
    {x = -627.7693,   y = -217.3746, z = 57.6612},
    {x = -1264.0413,  y = -785.4565,  z = 24.0309},
    {x = -1127.7084,    y = -477.1190, z = 51.0980},
    {x = -292.1199,   y = 102.2725, z = 80.9622},
    {x = 207.4774, y = 138.0430,  z = 113.6768},
	{x = 237.5443,   y = -324.6733,  z = 63.8996},
	{x = 160.4813,   y = -1049.9990,  z = 71.7389},
	{x = 809.9802,   y = -2020.0101, z = 43.4367},
	{x = -674.0121,   y = -891.1252,  z = 39.3409},
	{x = -1331.9915,   y = -1282.3604,  z = 12.4889},
}


Check = {
    EnableSkillCheck = true, -- OX_LIB Skill Check.
    ProcessTime = 15, -- second - Only used when EnableSkillCheck is false.
}
