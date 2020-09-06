util.AddNetworkString("Traitors")
util.AddNetworkString("Detectives")
util.AddNetworkString("Jesters")

hook.Add("Tick", "GetAndSendTraitors", function()

  local traitors = {}
  local detectives = {}
  local jesters = {}

  for _, ply in pairs(player.GetAll()) do
    if (ply:IsValid() and ply:Alive()) then
      -- Traitor (alive)
      if (ply:GetRole() == ROLE_TRAITOR) then
        table.insert(traitors, ply)
      end

      -- Glitch as Traitor (alive)
      if (ply:GetRole() == ROLE_GLITCH) then
        table.insert(traitors, ply)
      end

      -- Detective (alive)
      if (ply:GetRole() == ROLE_DETECTIVE) then
        table.insert(detectives, ply)
      end
      
      -- Jester (alive)
      if (ply:GetRole() == ROLE_JESTER) then
        table.insert(jesters, ply)
      end
    end
  end

  for _, ent in pairs(ents.FindByClass( "prop_ragdoll" )) do
    if (IsValid(ent)) then
      -- Traitors (dead)
      if (ent.was_role == ROLE_TRAITOR) then
        table.insert(traitors, ent)
      end

      -- Glitch as Traitor (dead)
      if (ent.was_role == ROLE_GLITCH) then
        table.insert(traitors, ply)
      end
    
      -- Detectives (dead)
      if (ent.was_role == ROLE_DETECTIVE) then
        table.insert(detectives, ent)
      end
      
      -- Jester (dead)
      if (ent.was_role == ROLE_JESTER) then
        table.insert(jesters, ply)
      end
    end
  end

  -- -- Broadcast -- --

  -- Traitors (to Traitors)
  for _, ply in pairs(traitors) do
    if (ply:IsPlayer()) then
      net.Start("Traitors")
      net.WriteTable(traitors)
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

  -- Jesters (to Traitors)
  for _, ply in pairs(traitors) do
    if (ply:IsPlayer()) then
      net.Start("Jesters")
      net.WriteTable(jesters)
      net.Send(ply)
    end
  end

end)