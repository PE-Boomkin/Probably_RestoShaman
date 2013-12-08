ProbablyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

-- Custom Resto Shaman Rotation v0.1
-- Updated on Dec 7th

ProbablyEngine.rotation.register_custom(264, "Boomkin Resto Shaman", {

-- Pause Rotation
{ "pause", "modifier.lalt" },

-- Pause Rotation - Ghost Wolf Form
{ "pause", "player.buff(2645)" },

-- Water Shield
{ "52127", "!player.buff(52127)" },

-- Earth Living Weapon Enchant
{ "51730", "!player.enchant.mainhand" },

-- Healing Tide Totem
{ "740", "modifier.rshift" },

-- Ascendance
{ "740", "modifier.rcontrol" },

-- Ascendance
{ "740", "modifier.ralt" },

-- Primal Elementalist - Coming Soon


-- Dispel - Click Toggle To Enable - 5.4 Content
{ "77130", {
	"toggle.dispel",
	"@coreHealing.needsDispelled('Aqua Bomb')" -- Aqua Bomb (Proving Grounds)
}},
{ "77130", {
	"toggle.dispel",
	"@coreHealing.needsDispelled('Shadow Word: Bane')" -- Shadow Word: Bane (Fallen Protectors)
}},
{ "77130", {
	"toggle.dispel",
	"@coreHealing.needsDispelled('Lingering Corruption')" -- Lingering Corruption (Norushen)
}},
{ "77130", {
	"toggle.dispel",
	"player.buff(144364)",
	"@coreHealing.needsDispelled('Mark of Arrogance')" -- Mark of Arrogance (Sha of Pride)
}},
{ "77130", {
	"toggle.dispel",
	"@coreHealing.needsDispelled('Corrosive Blood')" -- Corrosive Blood (Thok)
}},

-- Mouse Over Healing For Blobs and Other SoO NPCs. Note This Will Healing Anything So Use The Toggle To Disable When Not Needed
{ "8004", { 
	"toggle.mouseover", 
	"!mouseover.buff(8936)", 
	"mouseover.health < 100",
	"!mouseover.range > 40"
}, "mouseover" },

-- Healing Rain - Mouseover + Earthliving Weapon Unleash - Hold Down Button
{ "73680", { 
	"!tank.range > 40",
	 "modifier.lshift"
}, "tank" },
{ "73920", "modifier.lshift", "ground" },

-- Wind Shear Interrupt
{ "57994", "modifier.interrupts" },

-- EarthShield Focus
{ "974", { 
	"tank.buff(974).count < 2",
	"!tank.range > 40"
}, "tank" },

{ "974", { 
	"tank.buff(974).duration < 2",
	"!tank.range > 40"
}, "tank" },

-- Riptide Focus
{ "61295", { 
	"!tank.buff(61295)",
	"tank.health < 99",
	"!tank.range > 40"
}, "tank" },

-- Healing Stream Totem - Call of the Elements Support - Totemic Recall Support For Mana Regen
{ "5394", {
	"!player.totem(16190)",
	"!player.totem(108280)",
}},

{ "108285", {
	"player.spell(108285).exists",
	"@coreHealing.needsHealing(60, 3)",
}, "lowest" },

{ "36936", {
	"player.totem(5394).duration <= 2",
	"player.glyph(55438)"
}},

-- Healing Surge Focus
{ "8004", { 
	"tank.health <= 40",
	"!tank.range > 40"
}, "tank" },

-- Riptide
{ "61295", {
	"!lowest.buff(61295)",
	"lowest.health < 85", 
	"!lowest.range > 40"
}, "lowest" },

-- Healing Surge - Legendary Meta Gem Support
{ "8004", {
	"player.buff(137331)",
	"lowest.health < 95", 
	"!lowest.range > 40"
}, "lowest" },

-- ChainHeal
{ "1064", {
	"@coreHealing.needsHealing(80, 3)", 
	"!lowest.range > 40"
}, "lowest" },

-- Healing Surge
{ "61295", {
	"!player.buff(137331)",
	"player.mana > 20",
	"lowest.health < 20", 
	"!lowest.range > 40"
}, "lowest" },

-- Greater Healing Wave - Ancestral Swiftness Buff
{ "77472", {
	"player.buff(16188)",
	"player.buff(53390)",
	"lowest.health < 60", 
	"!lowest.range > 40"
}, "lowest" },

-- Greater Healing Wave
{ "77472", {
	"player.buff(53390)",
	"lowest.health < 60", 
	"!lowest.range > 40"
}, "lowest" },

-- Ancestral Swiftness
{ "16188", {
	"player.spell(16188).exists",
	"lowest.health < 30",
	"!lowest.range > 40"
}, "lowest" },

-- Healing Wave
{ "331", {
	"player.buff(53390)",
	"lowest.health < 75",
	"!lowest.range > 40"
}, "lowest" },

-- Mana Tide Totem
{ "16190", {
	"!player.totem(108280)",
	"player.mana < 80"
}},

-- Lightning Bolt
{ "403", {
	"toggle.lightning"
}},


}, {
-- Focus Macro - Out Of Combat
{ "!/focus [target=mouseover]", "modifier.lcontrol" },

-- Water Shield - Out Of Combat
{ "52127", "!player.buff(52127)" },

-- Earth Living Weapon Enchant - Out Of Combat
{ "51730", "!player.enchant.mainhand" },

}, function()
ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\ability_shaman_cleansespirit', 'Dispel', 'Toggle Dispel')
ProbablyEngine.toggle.create('mouseover', 'Interface\\Icons\\spell_nature_healingway', 'Mouseover Healing Surge', 'Toggle Mouseover Healing Surge For SoO NPC Healing')
ProbablyEngine.toggle.create('lightning', 'Interface\\Icons\\spell_nature_lightning', 'Lighning Bolt', 'Toggle Lighning Bolt')

end)