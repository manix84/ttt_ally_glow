util.AddNetworkString("Traitors")
util.AddNetworkString("Monsters")
util.AddNetworkString("Detectives")
util.AddNetworkString("Jesters")

CreateConVar("ttt_jester_glow", 0, 1, "Should Jesters glow for Traitors?", 0, 1)

local showJesters = GetConVar("ttt_jester_glow"):GetBool()

hook.Add("Tick", "GetAndSendTraitors", function()

  local traitors = {}
  local monsters = {}
  local detectives = {}
  local jesters = {}

  for _, target_ply in pairs(player.GetAll()) do
    if (target_ply:IsValid() and target_ply:Alive()) then
      local target_role = target_ply:GetRole()

      -- Traitor/Hypnotist/Assassin +Glitch (alive)
      if (target_role == ROLE_TRAITOR or target_role == ROLE_HYPNOTIST or target_role == ROLE_ASSASSIN or target_role == ROLE_GLITCH) then
        table.insert(traitors, target_ply)
      end

      -- Vampire/Zombie +Glitch (alive)
      if (target_role == ROLE_ZOMBIE or target_role == ROLE_VAMPIRE or target_role == ROLE_GLITCH) then
        table.insert(monsters, target_ply)
      end

      -- Detective (alive)
      if (target_role == ROLE_DETECTIVE) then
        table.insert(detectives, target_ply)
      end
      
      -- Jester/Swapper (alive)
      if (showJesters and (target_role == ROLE_JESTER or target_role == ROLE_SWAPPER)) then
        table.insert(jesters, target_ply)
      end
    end
  end

  for _, target_ent in pairs(ents.FindByClass( "prop_ragdoll" )) do
    if (IsValid(target_ent)) then
      local target_role = target_ent.was_role

      -- Traitor/Hypnotist/Assassin +Glitch (dead)
      if (target_role == ROLE_TRAITOR or target_role == ROLE_HYPNOTIST or target_role == ROLE_ASSASSIN or target_role == ROLE_GLITCH) then
        table.insert(traitors, target_ent)
      end

      -- Vampire/Zombie (dead)
      if (target_role == ROLE_ZOMBIE or target_role == ROLE_VAMPIRE or target_role == ROLE_GLITCH) then
        table.insert(monsters, target_ent)
      end
    
      -- Detective (dead)
      if (target_role == ROLE_DETECTIVE) then
        table.insert(detectives, target_ent)
      end
      
      -- Jester/Swapper (dead)
      if (target_role == ROLE_JESTER or target_role == ROLE_SWAPPER) then
        table.insert(jesters, target_ent)
      end
    end
  end

  -- -- Broadcast -- --

  -- Traitors (Traitor/Hypnotist/Assassin +Glitch) & Jesters (to Traitor/Hypnotist/Assassin)
  for _, target_ply in pairs(traitors) do
    if (target_ply:IsPlayer()) then
      net.Start("Traitors")
      net.WriteTable(traitors)
      net.Send(target_ply)

      net.Start("Jesters")
      net.WriteTable(jesters)
      net.Send(target_ply)
    end
  end

  -- Monsters (Vampires/Zombies +Glitch) & Jesters (to Vampires/Zombies)
  for _, target_ply in pairs(monsters) do
    if (target_ply:IsPlayer()) then
      net.Start("Monsters")
      net.WriteTable(monsters)
      net.Send(target_ply)

      net.Start("Jesters")
      net.WriteTable(jesters)
      net.Send(target_ply)
    end
  end

  -- Detectives (to Detectives)
  for _, target_ply in pairs(detectives) do
    if (target_ply:IsPlayer()) then
      net.Start("Detectives")
      net.WriteTable(detectives)
      net.Send(target_ply)
    end
  end

end)
