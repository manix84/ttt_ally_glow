local monsters = {}
local monster_color = Color(0, 255, 0)

net.Receive("Monsters", function()
  table.Empty(monsters)
  monsters = net.ReadTable()
end)

hook.Add("PreDrawHalos", "MonsterHalos", function()
  local ply_role = LocalPlayer():GetRole()
  if ((ply_role == ROLE_ZOMBIE or ply_role == ROLE_VAMPIRE) and LocalPlayer():Alive()) then
    if (table.Count(monsters) > 0) then
      halo.Add(monsters, monster_color, 1, 1, 10, true, true)
    end
  end
end)