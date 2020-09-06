local detectives = {}
local detective_color = Color(0, 0, 255)

net.Receive("Detectives", function()
  table.Empty(detectives)
  detectives = net.ReadTable()
end)

hook.Add("PreDrawHalos", "DetectiveHalos", function()
  if (LocalPlayer():GetRole() == ROLE_DETECTIVE and LocalPlayer():Alive()) then
    if (table.Count(detectives) > 0) then
      halo.Add(detectives, detective_color, 1, 1, 10, true, true )
    end
  end
end)