--- Radio equipment playing distraction sounds

AddCSLuaFile()

   -- this entity can be DNA-sampled so we need some display info
--ENT.Base = "Scripted Item"
ENT.Icon = "vgui/ttt/icon_radio"
ENT.PrintName = "actual_radio"

ENT.Type = "anim"
ENT.Model = Model("models/props/cs_office/radio.mdl")

ENT.CanUseKey = true
ENT.CanHavePrints = false
ENT.SoundLimit = 5
ENT.SoundDelay = 0.5

function ENT:Initialize()
   self:SetModel(self.Model)

   self:PhysicsInit(SOLID_VPHYSICS)
   self:SetMoveType(MOVETYPE_VPHYSICS)
   self:SetSolid(SOLID_VPHYSICS)
   self:SetCollisionGroup(COLLISION_GROUP_NONE)
   if SERVER then
      self:SetMaxHealth(50)
   end
   self:SetHealth(50)

   if SERVER then
      self:SetUseType(SIMPLE_USE)
   end
   self.Playing = false
   self.fingerprints = {}
end

function ENT:UseOverride(activator)
   -- if IsValid(activator) and activator:IsPlayer() then
   --    local prints = self.fingerprints or {}
   --    table.Add(wep.fingerprints, prints)
      sound.PlayURL ( "http://www.wnyc.org/stream/wnyc-fm939/mp3.pls", "mono")
--                      station:SetPos( LocalPlayer():GetPos() )
--                      station:Play()
--                g_station = station
--                )
end