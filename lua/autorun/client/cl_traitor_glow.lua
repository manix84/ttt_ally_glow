local traitors = {}
local traitor_color = Color(255, 0, 0)

net.Receive("Traitors", function()
  table.Empty(traitors) 
  traitors = net.ReadTable()
end)

hook.Add("PreDrawHalos", "TraitorHalos", function()
  if ((LocalPlayer():GetRole() == ROLE_TRAITOR or LocalPlayer():GetRole() == ROLE_HYPNOTIST or LocalPlayer():GetRole() == ROLE_ASSASSIN) and LocalPlayer():Alive()) then
    if (table.Count(traitors) > 0) then
      halo.Add(traitors, traitor_color, 1, 1, 10, true, true)
    end
  end
end )