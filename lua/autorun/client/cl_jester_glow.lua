local jesters = {}
local jester_color = Color(255, 0, 255)

net.Receive("Jesters", function()
  table.Empty(jesters) 
  jesters = net.ReadTable()
end)

hook.Add("PreDrawHalos", "JesterHalos", function()
  local ply_role = LocalPlayer():GetRole()
  if ((ply_role == ROLE_TRAITOR or ply_role == ROLE_HYPNOTIST or ply_role == ROLE_ASSASSIN or ply_role == ROLE_ZOMBIE or ply_role == ROLE_VAMPIRE) and LocalPlayer():Alive()) then
    if (table.Count(jesters) > 0) then
      halo.Add(jesters, jester_color, 1, 1, 10, true, true)
    end
  end
end )