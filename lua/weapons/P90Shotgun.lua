SWEP.PrintName = "P90 Shotgun" -- The name of the weapon
    
SWEP.Author = "Token"
SWEP.Contact = "your email adress"--Optional
SWEP.Purpose = "GET DUNKED"
SWEP.Instructions = "Oh god why."
SWEP.Category = "Sandbox_Joke" --This is required or else your weapon will be placed under "Other"

SWEP.Spawnable= true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "weapon_base"

local ShootSound = Sound("Weapon_p90.Single")
SWEP.Primary.Damage = 25 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 50 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 50  -- How much bullets are in the mag
SWEP.Primary.Ammo = "SMG1" --The ammo type will it use
SWEP.Primary.DefaultClip = 60 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = 30 -- The spread when shot
SWEP.Primary.NumberofShots = 50 -- Number of bullets when shot
SWEP.Primary.Automatic = true -- Is it automatic
SWEP.Primary.Recoil = .2 -- The amount of recoil
SWEP.Primary.Delay = 0.1 -- Delay before the next shot
SWEP.Primary.Force = 100

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true --Does it draw the crosshair
SWEP.DrawAmmo = true
SWEP.Weight = 5 --Priority when the weapon your currently holding drops
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= true
SWEP.ViewModelFOV		= 60
SWEP.ViewModel			= "models/weapons/v_smg_p90.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_p90.mdl"
SWEP.UseHands           = true

SWEP.HoldType = "ar2" 

SWEP.FiresUnderwater = true

SWEP.ReloadSound = "Weapon_p90.Reload"

SWEP.CSMuzzleFlashes = true

function SWEP:Initialize()
util.PrecacheSound(ShootSound) 
util.PrecacheSound(self.ReloadSound) 
self:SetWeaponHoldType( self.HoldType )
end 

function SWEP:PrimaryAttack()
 
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
self:EmitSound(Sound(self.ReloadSound)) 
        self.Weapon:DefaultReload( ACT_VM_RELOAD );
end