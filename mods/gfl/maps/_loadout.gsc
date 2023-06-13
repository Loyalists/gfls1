// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init_loadout()
{
    if ( !isdefined( level.campaign ) )
        level.campaign = "american";

    give_loadout();
    maps\_loadout_code::loadout_complete();
}

give_loadout()
{
    if ( isdefined( level.dodgeloadout ) )
        return;

    var_0 = maps\_loadout_code::get_loadout();
    level.player maps\_loadout_code::setdefaultactionslot();
    level.has_loadout = 0;
    maps\_loadout_code::campaign( "british" );
    maps\_loadout_code::persist( "innocent", "london" );
    maps\_loadout_code::loadout( "ship_graveyard", "mp5_underwater", undefined, undefined, undefined, "viewhands_udt" );
    maps\_loadout_code::loadout( "jungle_ghosts", "iw5_ak47_sp_acog_silencerunderbarrel", undefined, "fraggrenade", undefined, "viewhands_sas_woodland" );
    maps\_loadout_code::loadout( "london", "mp5_silencer_eotech", undefined, "fraggrenade", "flash_grenade", "viewhands_sas" );
    maps\_loadout_code::loadout( "innocent", "mp5_silencer_eotech", "usp_silencer", "fraggrenade", "flash_grenade", "viewhands_sas" );
    maps\_loadout_code::campaign( "delta" );
    maps\_loadout_code::loadout( "berlin", "m14ebr_scope", "acr_hybrid_berlin", "fraggrenade", "ninebang_grenade", "viewhands_delta" );
    maps\_loadout_code::loadout( "ny_harbor", "mp5_silencer_reflex", "usp_no_knife", "fraggrenade", "ninebang_grenade", "viewhands_udt" );
    maps\_loadout_code::loadout( "hamburg", "m4m203_acog_payback", "smaw_nolock", "fraggrenade", "flash_grenade", "viewhands_delta" );
    maps\_loadout_code::loadout( "prague", "rsass_hybrid_silenced", "usp_silencer", "fraggrenade", "flash_grenade", "viewhands_yuri_europe" );
    maps\_loadout_code::loadout( "payback", "m4m203_acog_payback", "deserteagle", "fraggrenade", "flash_grenade", "viewhands_yuri" );
    maps\_loadout_code::loadout( "black_ice", "m4_grunt_reflex", "ksg_grip", "fraggrenade", "flash_grenade", "viewmodel_base_viewhands" );
    maps\_loadout_code::campaign( "xslice" );
    maps\_loadout_code::persist( "sanfran_b", "sanfran" );
    maps\_loadout_code::loadout( "seoul", "iw5_himar_sp_himarscope", "iw5_titan45_sp", "tracking_grenade_var", "paint_grenade_var", "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "recovery", "iw5_bal27_sp_silencer01_variablereddot", "iw5_titan45_sp_silencerpistol", "fraggrenade", "flash_grenade", "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "lagos", "iw5_asm1_sp_variablereddot", "iw5_uts19_sp", "fraggrenade", "flash_grenade", "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "fusion", "iw5_bal27_sp_glsp_variablereddot", "iw5_em1_sp_opticsreddot", "fraggrenade", "flash_grenade", "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "detroit", "iw5_bal27_sp_silencer01_variablereddot", undefined, "fraggrenade", "flash_grenade", "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "greece", "iw5_titan45_sp_opticsreddot_silencerpistol", undefined, "fraggrenade", "flash_grenade", "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "betrayal", "iw5_sn6_sp_opticsreddot", undefined, undefined, undefined, "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "irons_estate", "iw5_kf5singleshot_sp_opticsreddot_silencer01", "iw5_pbwsingleshot_sp_silencerpistol", undefined, undefined, "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "crash", "iw5_hbra3_sp_opticstargetenhancer", "iw5_kf5_sp", "fraggrenade", "flash_grenade", "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "lab", "iw5_unarmed_nullattach", undefined, "fraggrenade", "flash_grenade", "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "sanfran", "iw5_hbra3_sp_opticsacog2", "iw5_microdronelauncher_sp", "fraggrenade", "flash_grenade", "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "sanfran_b", "iw5_hbra3_sp_opticsacog2", "iw5_microdronelauncher_sp", "fraggrenade", "flash_grenade", "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "df_baghdad", "iw5_asm1_sp_variablereddot", "iw5_em1_sp_opticsreddot", "fraggrenade", "flash_grenade", "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "captured", "iw5_titan45onearm_sp", undefined, undefined, undefined, "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::loadout( "finale", "iw5_unarmedfinale_nullattach", undefined, undefined, undefined, "s1_gfl_ump45_viewhands" );
    maps\_loadout_code::default_loadout_if_notset();
}
