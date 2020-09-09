# [TTT] Ally Glow
Give your allies a glowing halo.

I designed this to work with [Custom Roles for TTT](https://steamcommunity.com/workshop/filedetails/?id=2045444087). That means the logic as to who can see who's halo is based on that.

Features:
- Traitor Team (Traitors, Hypnotists, and Assassins) see:
    - Traitors, Hypnotists, and Assassins glow Red
    - Glitches glow Red (pretending to be a Traitor)
    - Jesters and Swappers glow Pink (optional)
- Monster Team (Zombies, and Vampires) see:
    - Zombies and Vampires glow Green
    - Glitches glow Green (pretending to be a Zombie)
    - Jesters and Swappers glow Pink (optional)
- Innocent Team (Innocent, Glitch, Mercenary, Phantom, and Detectives) see:
    - Nothing, except...
    - Detectives glow Blue to other Detectives

If you want to enable Jester Glow, you can do so by adding `ttt_jester_glow 1` to your server.cfg
