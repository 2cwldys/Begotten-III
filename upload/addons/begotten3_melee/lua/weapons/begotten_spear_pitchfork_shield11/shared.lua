SWEP.Base = "sword_swepbase"
-- WEAPON TYPE: Spear + Shield
-- SHIELD TYPE: shield11 (Gatekeeper Shield)

SWEP.PrintName = "Pitchfork + Gatekeeper Shield"
SWEP.Category = "(Begotten) Spear"

SWEP.AdminSpawnable = true
SWEP.Spawnable = true
SWEP.AutoSwitchTo = false
SWEP.Slot = 0
SWEP.Weight = 2
SWEP.UseHands = true

SWEP.HoldType = "wos-begotten_spear_shield"

SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.ViewModelFOV = 80
SWEP.ViewModelFlip = false

--Anims
SWEP.BlockAnim = "a_spear_shield_block_twindragon"
SWEP.CriticalAnim = "a_spear_shield_attack_medium"
SWEP.ParryAnim = "a_spear_shield_parry"

SWEP.IronSightsPos = Vector(3.68, -6.835, 0.479)
SWEP.IronSightsAng = Vector(2.111, -26.031, -4.222)

--Sounds
SWEP.AttackSoundTable = "MetalSpearAttackSoundTable"
SWEP.BlockSoundTable = "WoodenShieldSoundTable"
SWEP.SoundMaterial = "Metal" -- Metal, Wooden, MetalPierce, Punch, Default

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
SWEP.AttackTable = "PitchforkAttackTable"
SWEP.BlockTable = "Shield_11_BlockTable"

function SWEP:CriticalAnimation()

	local attacksoundtable = GetSoundTable(self.AttackSoundTable)

	local vm = self.Owner:GetViewModel()
    self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK );
	self.Owner:GetViewModel():SetPlaybackRate(0.65)	
	if (SERVER) then
	timer.Simple( 0.05, function() if self:IsValid() then
	self.Weapon:EmitSound(attacksoundtable["criticalswing"][math.random(1, #attacksoundtable["criticalswing"])])
	end end)
	self.Owner:ViewPunch(Angle(1,4,1))
	end

end

function SWEP:ParryAnimation()
	local vm = self.Owner:GetViewModel()
    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK );
end

function SWEP:HandlePrimaryAttack()

	local attacksoundtable = GetSoundTable(self.AttackSoundTable)
	local attacktable = GetTable(self.AttackTable)

	--Attack animation
	self:TriggerAnim(self.Owner, "a_spear_shield_attack_medium");

	-- Viewmodel attack animation!
	local vm = self.Owner:GetViewModel()
    self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK );
	self.Owner:GetViewModel():SetPlaybackRate(0.65)	
	self.Weapon:EmitSound(attacksoundtable["primarysound"][math.random(1, #attacksoundtable["primarysound"])])
	self.Owner:ViewPunch(attacktable["punchstrength"])

end

function SWEP:OnDeploy()
	local attacksoundtable = GetSoundTable(self.AttackSoundTable)
	self.Owner:ViewPunch(Angle(0,1,0))
	self.Weapon:EmitSound(attacksoundtable["drawsound"][math.random(1, #attacksoundtable["drawsound"])])
end

/*---------------------------------------------------------
	Bone Mods
---------------------------------------------------------*/

SWEP.ViewModelBoneMods = {
	["v_weapon.Knife_Handle"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(14.444, 0, 0) },
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -12.789), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-0.556, 0, 2.407), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-2.3, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0.925), angle = Angle(-56.667, 0, 0) }
}

SWEP.VElements = {
	["v_pitchfork"] = { type = "Model", model = "models/begotten/weapons/serfpitchfork.mdl", bone = "v_weapon.Knife_Handle", rel = "", pos = Vector(1.2, -0.5, -4.676), angle = Angle(12, 0, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["quad"] = { type = "Quad", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(9.383, -80, -50.864), angle = Angle(-52.223, -116.667, -7.778), size = 0.2, draw_func = nil},
	["v_shield11"] = { type = "Model", model = "models/props/begotten/melee/twin_dragon_greatshield.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "", pos = Vector(12, 4, 2), angle = Angle(20, -30, -90), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["w_pitchfork"] = { type = "Model", model = "models/begotten/weapons/serfpitchfork.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.59, 2.596), angle = Angle(8.182, 17.531, -174.157), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["w_shield11"] = { type = "Model", model = "models/props/begotten/melee/twin_dragon_greatshield.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(2.596, 2.596, -0.519), angle = Angle(5.843, 146.104, 87.662), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}