local traitors = {};
local traitor_color = Color(255, 0, 0);

net.Receive("Traitors", function()
  table.Empty(traitors);
  traitors = net.ReadTable();
end);

hook.Add("PreDrawHalos", "TraitorHalos", function()
  local ply_role = LocalPlayer():GetRole();

  if ((ply_role == ROLE_TRAITOR or ply_role == ROLE_HYPNOTIST or ply_role == ROLE_ASSASSIN) and LocalPlayer():Alive() and table.Count(traitors) > 0) then
    halo.Add(traitors, traitor_color, 1, 1, 10, true, true);
  end
end);
