// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    player_anims();
    vehicle_anims();
    animated_prop_anims();
}

#using_animtree("player");

player_anims()
{
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_rig"]["intro"] = %dogfight_fly_intro_player;
    maps\_anim::addnotetrack_customfunction( "player_rig", "player_free_look", maps\df_fly::unlimit_player_view, "intro" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "player_no_look", maps\df_fly::limit_player_view, "intro" );
    level.scr_anim["player_rig"]["deploy"] = %dogfight_deploy_main_player;
    maps\_anim::addnotetrack_customfunction( "player_rig", "canopy_fully_closed", ::play_canopy_closed_bink, "deploy" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "start_canopy_bink", ::play_canopy_bink, "deploy" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "show_player_jet", ::show_finale_jet, "deploy" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "start_uplink", ::show_uplink, "deploy" );
    maps\_anim::addnotetrack_flag( "player_rig", "black_out_player", "black_out", "deploy" );
}

#using_animtree("animated_props");

animated_prop_anims()
{
    level.scr_animtree["Dogfight_canyon_small_bridge"] = #animtree;
    level.scr_anim["Dogfight_canyon_small_bridge"]["destroy"] = %dogfight_canyon_small_bridge;
    level.scr_animtree["dogfight_canyon_hoodoo1"] = #animtree;
    level.scr_anim["dogfight_canyon_hoodoo1"]["destroy"] = %dogfight_canyon_hoodoo1;
    level.scr_animtree["dogfight_canyon_hoodoo2"] = #animtree;
    level.scr_anim["dogfight_canyon_hoodoo2"]["destroy"] = %dogfight_canyon_hoodoo2;
    level.scr_animtree["dogfight_canyon_hoodoo3"] = #animtree;
    level.scr_anim["dogfight_canyon_hoodoo3"]["destroy"] = %dogfight_canyon_hoodoo3;
    level.scr_animtree["dogfight_canyon_train_bridge"] = #animtree;
    level.scr_anim["dogfight_canyon_train_bridge"]["destroy"] = %dogfight_canyon_train_bridge;
    level.scr_animtree["dogfight_canyon_l_train"] = #animtree;
    level.scr_anim["dogfight_canyon_l_train"]["destroy"] = %dogfight_canyon_l_train;
    level.scr_animtree["dogfight_canyon_r_train"] = #animtree;
    level.scr_anim["dogfight_canyon_r_train"]["destroy"] = %dogfight_canyon_r_train;
    level.scr_animtree["dogfight_canyon_stone_arch"] = #animtree;
    level.scr_anim["dogfight_canyon_stone_arch"]["destroy"] = %dogfight_canyon_stone_arch;
    level.scr_animtree["dogfight_canyon_hoodoo_crumble"] = #animtree;
    level.scr_anim["dogfight_canyon_hoodoo_crumble"]["destroy"] = %dogfight_canyon_hoodoo_crumble;
    level.scr_animtree["dogfight_canyon_hoodoo_crumble_generic"] = #animtree;
    level.scr_anim["dogfight_canyon_hoodoo_crumble_generic"]["destroy"] = %dogfight_canyon_hoodoo_crumble_generic;
    level.scr_animtree["dogfight_canyon_dam_version1"] = #animtree;
    level.scr_anim["dogfight_canyon_dam_version1"]["destroy"] = %dogfight_canyon_dam_version1;
    level.scr_animtree["finale_genProp"] = #animtree;
    level.scr_model["finale_genProp"] = "generic_prop_raven";
    level.scr_anim["finale_genProp"]["deploy"] = %dogfight_deploy_genprop;
    level.scr_animtree["turret"] = #animtree;
    level.scr_anim["turret"]["dogfight_canyon_mwp_takeoff1"] = %dogfight_canyon_mwp_takeoff1;
    level.scr_anim["turret"]["dogfight_canyon_mwp_takeoff2"] = %dogfight_canyon_mwp_takeoff2;
    level.scr_anim["turret"]["dogfight_canyon_mwp_takeoff3"] = %dogfight_canyon_mwp_takeoff3;
    level.scr_anim["turret"]["dogfight_canyon_mwp_takeoff4"] = %dogfight_canyon_mwp_takeoff4;
    level.scr_anim["turret"]["dogfight_canyon_mwp_hover"] = %dogfight_canyon_mwp_hover;
    level.scr_anim["turret"]["crash"] = %dogfight_canyon_mwp_crash;
    level.scr_anim["turret"]["dogfight_canyon_laser_turret_pose"][0] = %dogfight_canyon_laser_turret_pose;
}

#using_animtree("vehicles");

vehicle_anims()
{
    level.scr_animtree["player_jet"] = #animtree;
    level.scr_model["player_jet"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["player_jet"]["intro"] = %dogfight_fly_intro_playerjet;
    level.scr_animtree["ally1"] = #animtree;
    level.scr_anim["ally1"]["intro"] = %dogfight_fly_intro_ally1;
    level.scr_animtree["ally2"] = #animtree;
    level.scr_anim["ally2"]["intro"] = %dogfight_fly_intro_ally2;
    level.scr_animtree["ally3"] = #animtree;
    level.scr_anim["ally3"]["intro"] = %dogfight_fly_intro_ally3;
    level.scr_animtree["refueler"] = #animtree;
    level.scr_model["refueler"] = "atlas_vtol_cargo_plane_ext_ai";
    level.scr_anim["refueler"]["intro"] = %dogfight_fly_intro_refueler;
    level.scr_animtree["fuel_rod"] = #animtree;
    level.scr_model["fuel_rod"] = "atlas_vtol_cargo_plane_fuel_rod";
    level.scr_anim["fuel_rod"]["intro"] = %dogfight_fly_intro_fuelrod;
    level.scr_animtree["cockpit"] = #animtree;
    level.scr_model["cockpit"] = "sentinel_drop_pod_vm";
    level.scr_anim["cockpit"]["intro"] = %dogfight_fly_intro_cockpit;
    level.scr_anim["cockpit"]["idle"][0] = %sentinel_fighter_jet_cockpit_idle;
    level.scr_animtree["osp"] = #animtree;
    level.scr_model["osp"] = "vehicle_mil_blimp_orbital_platform_01_static";
    level.scr_animtree["refueler_generic"] = #animtree;
    level.scr_model["refueler_generic"] = "atlas_vtol_cargo_plane_ext_ai";
    level.scr_anim["refueler_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad_refueler_idle;
    level.scr_anim["refueler_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad_refueler_exit;
    level.scr_animtree["ally1_generic"] = #animtree;
    level.scr_model["ally1_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally1_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad_ally1_idle;
    level.scr_anim["ally1_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad_ally1_exit;
    level.scr_animtree["ally2_generic"] = #animtree;
    level.scr_model["ally2_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally2_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad_ally2_idle;
    level.scr_anim["ally2_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad_ally2_exit;
    level.scr_animtree["ally3_generic"] = #animtree;
    level.scr_model["ally3_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally3_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad_ally3_idle;
    level.scr_anim["ally3_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad_ally3_exit;
    level.scr_animtree["ally4_generic"] = #animtree;
    level.scr_model["ally4_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally4_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad_ally4_idle;
    level.scr_anim["ally4_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad_ally4_exit;
    level.scr_animtree["ally1_s2_generic"] = #animtree;
    level.scr_model["ally1_s2_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally1_s2_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad2_ally1_idle;
    level.scr_anim["ally1_s2_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad2_ally1_exit;
    level.scr_animtree["ally2_s2_generic"] = #animtree;
    level.scr_model["ally2_s2_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally2_s2_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad2_ally2_idle;
    level.scr_anim["ally2_s2_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad2_ally2_exit;
    level.scr_animtree["ally3_s2_generic"] = #animtree;
    level.scr_model["ally3_s2_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally3_s2_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad2_ally3_idle;
    level.scr_anim["ally3_s2_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad2_ally3_exit;
    level.scr_animtree["ally4_s2_generic"] = #animtree;
    level.scr_model["ally4_s2_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally4_s2_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad2_ally4_idle;
    level.scr_anim["ally4_s2_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad2_ally4_exit;
    level.scr_animtree["ally1_s3_generic"] = #animtree;
    level.scr_model["ally1_s3_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally1_s3_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad3_ally1_idle;
    level.scr_anim["ally1_s3_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad3_ally1_exit;
    level.scr_animtree["ally2_s3_generic"] = #animtree;
    level.scr_model["ally2_s3_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally2_s3_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad3_ally2_idle;
    level.scr_anim["ally2_s3_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad3_ally2_exit;
    level.scr_animtree["ally3_s3_generic"] = #animtree;
    level.scr_model["ally3_s3_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally3_s3_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad3_ally3_idle;
    level.scr_anim["ally3_s3_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad3_ally3_exit;
    level.scr_animtree["ally4_s3_generic"] = #animtree;
    level.scr_model["ally4_s3_generic"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["ally4_s3_generic"]["intro_idle"][0] = %dogfight_fly_intro_generic_squad3_ally4_idle;
    level.scr_anim["ally4_s3_generic"]["intro_exit"] = %dogfight_fly_intro_generic_squad3_ally4_exit;
    level.scr_animtree["jet"] = #animtree;
    level.scr_model["jet"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["jet"]["deploy"] = %dogfight_deploy_main_jet;
    level.scr_animtree["jet_l"] = #animtree;
    level.scr_model["jet_l"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["jet_l"]["deploy"] = %dogfight_deploy_l_jet;
    level.scr_animtree["jet_r"] = #animtree;
    level.scr_model["jet_r"] = "vehicle_sentinel_fighter_jet";
    level.scr_anim["jet_r"]["deploy"] = %dogfight_deploy_r_jet;
    level.scr_animtree["pod"] = #animtree;
    level.scr_model["pod"] = "sentinel_drop_pod_vm";
    level.scr_anim["pod"]["deploy"] = %dogfight_deploy_main_pod;
    level.scr_anim["pod"]["idle"][0] = %sentinel_fighter_jet_cockpit_idle;
    level.scr_animtree["pod_l"] = #animtree;
    level.scr_model["pod_l"] = "sentinel_drop_pod";
    level.scr_anim["pod_l"]["deploy"] = %dogfight_deploy_l_pod;
    level.scr_animtree["pod_r"] = #animtree;
    level.scr_model["pod_r"] = "sentinel_drop_pod";
    level.scr_anim["pod_r"]["deploy"] = %dogfight_deploy_r_pod;
    level.scr_animtree["enemy_jet"] = #animtree;
    level.scr_model["enemy_jet"] = "atlas_fighter_jet";
    level.scr_anim["enemy_jet"]["deathspin"] = %dogfight_jet_fighter_death_corkscrew;
}

play_canopy_closed_bink( var_0 )
{
    level.finale_pod showpart( "TAG_SCREEN_JOINT_LOAD" );
    pausecinematicingame( 0 );
    wait 4;
}

play_canopy_bink( var_0 )
{
    level.finale_pod showpart( "TAG_SCREEN_JOINT_LOAD" );
}

show_uplink( var_0 )
{
    level.finale_pod showpart( "TAG_TRANSFER_AR" );
    wait 0.1;
    level.finale_pod hidepart( "TAG_TRANSFER_AR" );
    wait 0.1;
    level.finale_pod showpart( "TAG_TRANSFER_AR" );
    wait 0.2;
    level.finale_pod hidepart( "TAG_TRANSFER_AR" );
    wait 0.2;
    level.finale_pod showpart( "TAG_TRANSFER_AR" );
    wait 0.8;
    level.finale_pod hidepart( "TAG_TRANSFER_AR" );
    wait 0.1;
    level.finale_pod showpart( "TAG_TRANSFER_AR" );
}

show_finale_jet( var_0 )
{
    level.finale_jet show();
}
