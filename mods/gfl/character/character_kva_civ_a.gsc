// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( character\gfl\_utility::check_npc_weapon_substr( ["lsat"] ) ) 
    {
        character\gfl\randomizer_sf_lmg::main();
    }
    else if ( character\gfl\_utility::check_npc_weapon_substr( ["mahem"] ) ) 
    {
        character\gfl\randomizer_sf_sniper::main();
    }
    else if ( character\gfl\_utility::check_npc_weapon_substr( ["kf5", "mp11"] ) ) 
    {
        character\gfl\randomizer_sf_smg::main();
    }
    else 
    {
        character\gfl\randomizer_sf_ar::main();
    }

    self.voice = "kva";
}

precache()
{
	character\gfl\randomizer_sf_lmg::precache();
	character\gfl\randomizer_sf_sniper::precache();
	character\gfl\randomizer_sf_smg::precache();
	character\gfl\randomizer_sf_ar::precache();
    precachemodel( "kva_civilian_a" );
    precachemodel( "head_m_act_cau_bedrosian_base" );
}
