SWEP.Base = "sword_swepbase"
-- WEAPON TYPE: Rapier + Shield
-- SHIELD TYPE: shield4 (Buckler)

SWEP.PrintName = "Elegant Epee + Buckler"
SWEP.Category = "(Begotten) Rapier"

SWEP.AdminSpawnable = true
SWEP.Spawnable = true
SWEP.AutoSwitchTo = false
SWEP.Slot = 0
SWEP.Weight = 2
SWEP.UseHands = true

SWEP.HoldType = "wos-begotten_1h_shield"

SWEP.ViewModel = "models/v_begottenknife.mdl"
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false

--Anims
SWEP.BlockAnim = "a_sword_shield_block_drakekeeper"
SWEP.CriticalAnim = "a_sword_shield_attack_stab_fast_01"
SWEP.ParryAnim = "a_sword_shield_parry"

SWEP.IronSightsPos = Vector(7, -6.433, 5.119)
SWEP.IronSightsAng = Vector(-3.518, -3.518, -13.367)

--Sounds
SWEP.AttackSoundTable = "MetalDaggerAttackSoundTable" 
SWEP.BlockSoundTable = "MetalShieldSoundTable"
SWEP.SoundMaterial = "MetalPierce" -- Metal, Wooden, MetalPierce, Punch, Default

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
SWEP.AttackTable = "ElegantEpeeAttackTable"
SWEP.BlockTable = "Shield_4_BlockTable"

function SWEP:CriticalAnimation()

	local attacksoundtable = GetSoundTable(self.AttackSoundTable)

	-- Viewmodel attack animation!
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
	self.Owner:GetViewModel():SetPlaybackRate(0.35)
	
	if (SERVER) then
	timer.Simple( 0.05, function() if self:IsValid() then
	self.Weapon:EmitSound(attacksoundtable["criticalswing"][math.random(1, #attacksoundtable["criticalswing"])])
	end end)
	self.Owner:ViewPunch(Angle(1,4,1))
	end
	
end

function SWEP:ParryAnimation()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ))
end

function SWEP:HandlePrimaryAttack()

	local attacksoundtable = GetSoundTable(self.AttackSoundTable)
	local attacktable = GetTable(self.AttackTable)

	--Attack animation
	self:TriggerAnim(self.Owner, "a_sword_shield_attack_stab_fast_01");

	-- Viewmodel attack animation!
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
	self.Owner:GetViewModel():SetPlaybackRate(0.35)
	
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
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(6.852, -9.815, -3.149), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["v_elegantepee"] = { type = "Model", model = "models/demonssouls/weapons/epee rapier.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.557, 0.518), angle = Angle(-87.663, 8.182, 120.389), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["v_shield4"] = { type = "Model", model = "models/demonssouls/shields/buckler.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(4.675, -7.792, 4.675), angle = Angle(-139.092, -57.273, -174.157), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["w_elegantepee"] = { type = "Model", model = "models/demonssouls/weapons/epee rapier.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.1, -0.75), angle = Angle(-90, 90, -146.105), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["w_shield4"] = { type = "Model", model = "models/demonssouls/shields/buckler.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(1.899, 1.899, 0.5), angle = Angle(87.662, 66.623, 5.842), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}