SWEP.PrintName = "RussianRevolver" -- The name of the weapon
    
SWEP.Author = "Token"
SWEP.Contact = "your email adress"--Optional
SWEP.Purpose = "Deal massive damage and/or die"
SWEP.Instructions = "Deal massive damage, but one shot in the clip will kill you!"
SWEP.Category = "Joke" --This is required or else your weapon will be placed under "Other"

SWEP.Spawnable= true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_EQUIP1
SWEP.InLoadoutFor = nil
SWEP.CanBuy = nil
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false
SWEP.AutoSpawnable = false
SWEP.HeadshotMultiplier = 4

local ShootSound = Sound("Weapon_357.Single")
SWEP.Primary.Damage = 90 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 6  -- How much bullets are in the mag
SWEP.Primary.Ammo = "Pistol" --The ammo type will it use
SWEP.Primary.DefaultClip = 18 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = 0.1 -- The spread when shot
SWEP.Primary.NumberofShots = 1 -- Number of bullets when shot
SWEP.Primary.Automatic = false -- Is it automatic
SWEP.Primary.Recoil = .2 -- The amount of recoil
SWEP.Primary.Delay = 0.1 -- Delay before the next shot
SWEP.Primary.Force = 100

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot = 7
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true --Does it draw the crosshair
SWEP.DrawAmmo = false
SWEP.Weight = 5 --Priority when the weapon your currently holding drops
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 90
SWEP.ViewModel			= "models/weapons/v_357.mdl"
SWEP.WorldModel			= "models/weapons/w_357.mdl"
SWEP.UseHands           = true

SWEP.HoldType = "Pistol" 

SWEP.ReloadSound = "Weapon_357.Reload" 

SWEP.FiresUnderwater = true

SWEP.CSMuzzleFlashes = true

function SWEP:Initialize()
util.PrecacheSound(ShootSound) 
util.PrecacheSound(self.ReloadSound) 
self:SetWeaponHoldType( self.HoldType )
bad = math.random(1,6)
shot = 1
end 

function SWEP:PrimaryAttack()
local player = self.Owner
if (bad == shot) then player:Kill()
	player:EmitSound(Sound("vo/npc/male01/no02.wav"))
	player:EmitSound(Sound("weapons/357/357_fire3.wav"))
	return end
shot = shot + 1
if ( !self:CanPrimaryAttack() ) then return end
 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1
bullet.Force = self.Primary.Force 
bullet.Damage = self.Primary.Damage 
bullet.AmmoType = self.Primary.Ammo 
 
local rnda = self.Primary.Recoil * -1 
local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:EmitSound(ShootSound)
self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 
self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
end 

function SWEP:SecondaryAttack()

end

function SWEP:Reload()
--self:EmitSound(Sound()) 
end