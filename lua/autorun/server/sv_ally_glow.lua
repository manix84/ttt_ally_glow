util.AddNetworkString("Traitors")
util.AddNetworkString("Monsters")
util.AddNetworkString("Detectives")
util.AddNetworkString("Jesters")

CreateConVar("ttt_jester_glow", 0, 1, "Should Jesters glow for Traitors?", 0, 1)

hook.Add("Tick", "GetAndSendTraitors", function()

  local traitors = {}
  local monsters = {}
  local detectives = {}
  local jesters = {}

  for _, ply in pairs(player.GetAll()) do
    if (ply:IsValid() and ply:Alive()) then
      -- Traitor/Hypnotist/Assassin +Glitch (alive)
      if (ply:GetRole() == ROLE_TRAITOR or ply:GetRole() == ROLE_HYPNOTIST or ply:GetRole() == ROLE_ASSASSIN or ply:GetRole() == ROLE_GLITCH) then
        table.insert(traitors, ply)
      end

      -- Vampire/Zombie (alive)
      if (ply:GetRole() == ROLE_ZOMBIE or ply:GetRole() == ROLE_VAMPIRE) then
        table.insert(monsters, ply)
      end

      -- Detective (alive)
      if (ply:GetRole() == ROLE_DETECTIVE) then
        table.insert(detectives, ply)
      end
      
      -- Jester/Swapper (alive)
      if (GetConVar("ttt_jester_glow"):GetBool() and (ply:GetRole() == ROLE_JESTER or ply:GetRole() == ROLE_SWAPPER)) then
        table.insert(jesters, ply)
      end
    end
  end

  for _, ent in pairs(ents.FindByClass( "prop_ragdoll" )) do
    if (IsValid(ent)) then
      -- Traitor/Hypnotist/Assassin +Glitch (dead)
      if (ent.was_role == ROLE_TRAITOR or ent.was_role == ROLE_HYPNOTIST or ent.was_role == ROLE_ASSASSIN or ent.was_role == ROLE_GLITCH) then
        table.insert(traitors, ply)
      end

      -- Vampire/Zombie (dead)
      if (ent.was_role == ROLE_ZOMBIE or ent.was_role == ROLE_VAMPIRE) then
        table.insert(monsters, ply)
      end
    
      -- Detective (dead)
      if (ent.was_role == ROLE_DETECTIVE) then
        table.insert(detectives, ent)
      end
      
      -- Jester/Swapper (dead)
      if (ent.was_role == ROLE_JESTER or ent.was_role == ROLE_SWAPPER) then
        table.insert(jesters, ply)
      end
    end
  end

  -- -- Broadcast -- --

  -- Traitors (Traitor/Hypnotist/Assassin +Glitch) & Jesters (to Traitors)
  for _, ply in pairs(traitors) do
    if (ply:IsPlayer()) then
      net.Start("Traitors")
      net.WriteTable(traitors)
      net.Send(ply)

      net.Start("Jesters")
      net.WriteTable(jesters)
      net.Send(ply)
    end
  end

  -- Monsters (to Vampires and Zombies)
  for _, ply in pairs(monsters) do
    if (ply:IsPlayer()) then
      net.Start("Monsters")
      net.WriteTable(monsters)
      net.Send(ply)
    end
  end

  -- Detectives (to Detectives)
  for _, ply in pairs(detectives) do
    if (ply:IsPlayer()) then
      net.Start("Detectives")
      net.WriteTable(detectives)
      net.Send(ply)
    end
  end

end)
