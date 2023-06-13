// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( character\gfl\_utility::check_npc_weapon_substr( ["mahem"] ) ) 
    {
        character\gfl\randomizer_sf_sniper::main();
    }
    else 
    {
        character\gfl\randomizer_sf_smg::main();
    }

    self.voice = "kva";
}

precache()
{
    character\gfl\randomizer_sf_smg::precache();
    character\gfl\randomizer_sf_sniper::precache();
}
