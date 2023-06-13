precache_all_viewmodels()
{
    precachemodel( "s1_gfl_ump45_viewbody" );
    precachemodel( "s1_gfl_ump45_viewbody_dismembered" );
    precachemodel( "s1_gfl_ump45_viewhands" );
    precachemodel( "s1_gfl_ump45_viewhands_player" );
    precachemodel( "s1_gfl_ump45_arm" );

    precachemodel( "viewhands_playermech" );
    precachemodel( "worldhands_playermech" );
    precachemodel( "vm_view_arms_mech" );
    precachemodel( "vm_world_body_mech" );
}

precache_all_characters()
{
	// main characters
    character\gfl\character_gfl_hk416::precache();
	character\gfl\character_gfl_hk416_mech::precache();
	character\gfl\character_gfl_g11::precache();
	character\gfl\character_gfl_ump9::precache();
	character\gfl\character_gfl_ro635::precache();
    character\gfl\character_gfl_m16a1_prime::precache();
	character\gfl\character_gfl_commander_v2::precache();
	character\gfl\character_gfl_an94::precache();
	character\gfl\character_gfl_an94_nocoat::precache();
	character\gfl\character_gfl_dima::precache();

	// randomized npcs
	character\gfl\character_gfl_p90::precache();
	character\gfl\character_gfl_9a91::precache();
	character\gfl\character_gfl_rfb::precache();
	character\gfl\character_gfl_saiga12::precache();
	character\gfl\character_gfl_sten::precache();
	character\gfl\character_gfl_g36c::precache();
	character\gfl\character_gfl_spas12::precache();
	character\gfl\character_gfl_ppsh41::precache();
	character\gfl\character_gfl_suomi::precache();
	character\gfl\character_gfl_sv98::precache();
	character\gfl\character_gfl_super_sass::precache();
	character\gfl\character_gfl_super_sass_nocoat::precache();
	character\gfl\character_gfl_mp7_tights::precache();
	character\gfl\character_gfl_mp7_casual_tights::precache();
	character\gfl\character_gfl_mp7::precache();
	character\gfl\character_gfl_mp7_casual::precache();
	character\gfl\character_gfl_m14::precache();

	// sf
	character\gfl\character_gfl_dreamer::precache();
	character\gfl\character_gfl_destroyer::precache();
	character\gfl\character_gfl_vespid::precache();
	character\gfl\character_gfl_jaeger::precache();
	character\gfl\character_gfl_jaeger_goggle_up::precache();
	character\gfl\character_gfl_ripper::precache();
	character\gfl\character_gfl_guard::precache();
	character\gfl\character_gfl_guard_visor_up::precache();
}