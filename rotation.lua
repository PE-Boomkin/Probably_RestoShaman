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


-- Healing Rain - Mouseover + Earthliving Weapon Unleash - Hold Down Button
{ "73680", { 
	"!tank.range > 40",
	 "modifier.lshift"
}, "tank" },
{ "73920", "modifier.lshift", "ground" },

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
	"tank.health < 95",
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
	"tank.health <= 30",
	"!tank.range > 40"
}, "tank" },

-- ChainHeal
{ "1064", {
	"@coreHealing.needsHealing(80, 3)", 
	"!lowest.range > 40"
}, "lowest" },

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
	"@coreHealing.needsHealing(75, 3)",
	"!lowest.range > 40"
}, "lowest" },

-- Mana Tide Totem
{ "16190", {
	"!player.totem(108280)",
	"player.mana < 80"
}},

-- Lightning Bolt
{ "403", {
	"modifier.multitarget"
}},


}, {
-- Focus Macro - Out Of Combat
{ "!/focus [target=mouseover]", "modifier.lcontrol" },

-- Water Shield - Out Of Combat
{ "52127", "!player.buff(52127)" },

-- Earth Living Weapon Enchant - Out Of Combat
{ "51730", "!player.enchant.mainhand" },

})