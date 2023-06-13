// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( level.nextgen )
        anim.forced_s1_motionset = 1;

    human_anims();
    player_anims();
    prop_anims();
    vehicle_anims();
    load_script_model_anims();
}

#using_animtree("generic_human");

human_anims()
{
    level.scr_anim["first_mech"]["mech_dropin"] = %dogfight_ast_drop_in_mech;
    level.scr_anim["generic"]["patrol_bored_idle_smoke"][0] = %patrol_bored_idle_smoke;
    level.scr_anim["holt"]["readystand_idle"] = %readystand_idle;
    level.scr_anim["gideon"]["readystand_idle"] = %readystand_idle;
    level.scr_anim["ilana"]["readystand_idle"] = %readystand_idle;
    level.scr_anim["gideon"]["patrol_jog"] = %patrol_jog;
    level.scr_anim["ilana"]["patrol_jog"] = %patrol_jog;
    level.scr_anim["holt"]["shore_briefing"] = %dogfight_shore_briefing_captain;
    level.scr_anim["gideon"]["shore_briefing"] = %dogfight_shore_briefing_gideon;
    level.scr_anim["ilana"]["shore_briefing"] = %dogfight_shore_briefing_ilona;
    level.scr_anim["ally1"]["shore_briefing"] = %dogfight_shore_briefing_ally1;
    level.scr_anim["ally2"]["shore_briefing"] = %dogfight_shore_briefing_ally2;
    level.scr_anim["ally3"]["shore_briefing"] = %dogfight_shore_briefing_ally3;
    level.scr_anim["ilona"]["intro_wave"][0] = %dogfight_staging_area_meet_ilona;
    level.scr_anim["gideon"]["intro_pod_scene"] = %dogfight_shore_briefing_gideon_enter;
    level.scr_anim["ilana"]["intro_pod_scene"] = %dogfight_shore_briefing_knox_enter;
    level.scr_anim["generic"]["vtol_death_pilot"] = %dogfight_grapple_vtol_death_pilot;
    level.scr_anim["generic"]["vtol_idle_pilot"][0] = %dogfight_grapple_vtol_idle_pilot;
    level.scr_anim["generic"]["vtol_react_pilot"] = %dogfight_grapple_vtol_react_pilot;
    level.scr_anim["generic"]["vtol_fire_pilot"][0] = %dogfight_grapple_vtol_fire_pilot;
    level.scr_anim["vtol_mid"]["death_anim"] = %dogfight_grapple_vtol_death_enemy1;
    level.scr_anim["vtol_mid"]["grapple_pullout_r"] = %dogfight_grapple_vtol_react_enemy1;
    level.scr_anim["vtol_mid"]["grapple_pullout_l"] = %dogfight_grapple_vtol_react_enemy1;
    level.scr_anim["vtol_mid"]["vtol_react_mid"] = %dogfight_grapple_vtol_react_enemy1;
    level.scr_anim["vtol_left"]["enemy_fire_loop"][0] = %dogfight_grapple_vtol_fire_enemy2;
    level.scr_anim["vtol_left"]["grapple_pullout_l"] = %dogfight_grapple_vtol_pullout_l_enemy2;
    level.scr_anim["vtol_left"]["death_anim"] = %dogfight_grapple_vtol_death_enemy2;
    level.scr_anim["vtol_right"]["enemy_fire_loop"][0] = %dogfight_grapple_vtol_fire_enemy3;
    level.scr_anim["vtol_right"]["grapple_pullout_r"] = %dogfight_grapple_vtol_pullout_r_enemy3;
    level.scr_anim["vtol_right"]["death_anim"] = %dogfight_grapple_vtol_death_enemy3;
    level.scr_anim["generic"]["injured_soldier_drag_guy01"] = %seo_injured_soldier_drag_guy01;
    level.scr_anim["generic"]["injured_soldier_drag_guy02"] = %seo_injured_soldier_drag_guy02;
    level.scr_anim["generic"]["injured_soldier_cpr_guy01"] = %dc_burning_cpr_wounded;
    level.scr_anim["generic"]["injured_soldier_cpr_guy02"] = %dc_burning_cpr_medic;
    level.scr_anim["generic"]["injured_soldier_cpr_guy01_idle"][0] = %dc_burning_cpr_medic_endidle;
    level.scr_anim["generic"]["injured_soldier_cpr_guy02_idle"][0] = %dc_burning_cpr_wounded_endidle;
    level.scr_anim["generic"]["snipers_binoc_idle"][0] = %blackout_binoc_idle;
    level.scr_anim["generic"]["sniper_balcony_death"] = %oilrig_balcony_death;
    level.scr_anim["ally1"]["intro_balcony_drag"] = %dogfight_staging_area_drag_intro_guya;
    level.scr_anim["ally1"]["intro_balcony_drag_loop"][0] = %dogfight_staging_area_drag_loop_guya;
    level.scr_anim["ally2"]["intro_balcony_drag"] = %dogfight_staging_area_drag_intro_guyb;
    level.scr_anim["ally2"]["intro_balcony_drag_loop"][0] = %dogfight_staging_area_drag_loop_guyb;
    level.scr_anim["generic"]["intro_balcony_radio"][0] = %dogfight_staging_area_radio_loop;
    level.scr_anim["ilona"]["vtol_wave"][0] = %dogfight_vtol_ride_enter_idle_ilona;
    level.scr_anim["ilona"]["enter_vtol"] = %dogfight_vtol_ride_enter_ilona;
    level.scr_anim["gideon"]["enter_vtol"] = %dogfight_vtol_ride_enter_gideon;
    level.scr_anim["ilana"]["enter_vtol"] = %dogfight_vtol_ride_enter_knox;
    level.scr_anim["zipline_guy_left"]["zipline_right_land_guy_a"] = %zipline_right_land_guy_a;
    level.scr_anim["zipline_guy_left"]["zipline_right_land_guy_b"] = %zipline_right_land_guy_b;
    level.scr_anim["zipline_guy_right"]["zipline_left_landing_guy_a"] = %zipline_left_landing_guy_a;
    level.scr_anim["zipline_guy_right"]["zipline_left_landing_guy_b"] = %zipline_left_landing_guy_b;
    level.scr_anim["generic"]["seo_fob_drop_guy_01"] = %dogfight_fob_drop_guy_01;
    level.scr_anim["generic"]["seo_fob_drop_guy_02"] = %dogfight_fob_drop_guy_02;
    level.scr_anim["generic"]["seo_fob_drop_guy_03"] = %dogfight_fob_drop_guy_03;
    level.scr_anim["generic"]["pilot_idle"] = %helicopter_pilot1_idle;
    level.scr_anim["gideon"]["vtol_crash"] = %dogfight_finale_knoxdeath_gideon;
    level.scr_anim["ilona"]["vtol_crash"] = %dogfight_finale_knoxdeath_ilona;
    level.scr_anim["ilana"]["vtol_crash"] = %dogfight_finale_knoxdeath_knox;
    level.scr_anim["ally1"]["vtol_crash"] = %dogfight_finale_knoxdeath_ally1;
    level.scr_anim["mech"]["vtol_crash"] = %dogfight_finale_knoxdeath_goliath;
    maps\_anim::addnotetrack_flag( "mech", "fire_rockets", "mech_anim_fire_rockets", "vtol_crash" );
    level.scr_anim["drag_enemy1"]["drag_humans"] = %dogfight_captured_enemy1;
    level.scr_anim["drag_enemy2"]["drag_humans"] = %dogfight_captured_enemy2;
    level.scr_anim["drag_enemy3"]["drag_humans"] = %dogfight_captured_enemy3;
    level.scr_anim["drag_enemy4"]["drag_humans"] = %dogfight_captured_enemy4;
    level.scr_anim["drag_enemy5"]["drag_humans"] = %dogfight_captured_enemy5;
    level.scr_anim["drag_ally1"]["drag_humans"] = %dogfight_captured_ally1;
    level.scr_anim["ilona"]["drag_humans"] = %dogfight_captured_ilana;
    level.scr_anim["gideon"]["drag_humans"] = %dogfight_captured_gideon;
    level.scr_anim["irons"]["drag_humans"] = %dogfight_captured_irons;
}

#using_animtree("animated_props");

prop_anims()
{
    level.scr_animtree["intro_boat"] = #animtree;
    level.scr_model["intro_boat"] = "generic_prop_raven";
    level.scr_anim["intro_boat"]["shore_briefing"] = %dogfight_shore_briefing_boat;
    level.scr_animtree["pergola"] = #animtree;
    level.scr_model["pergola"] = "nb_pergola_anim";
    level.scr_anim["pergola"]["intro_pod_scene"] = %dogfight_shore_briefing_pergola;
    maps\_anim::addnotetrack_flag( "pergola", "pergola_break", "pergola_break", "intro_pod_scene" );
    level.scr_animtree["bomb1"] = #animtree;
    level.scr_model["bomb1"] = "df_dna_bomb";
    level.scr_anim["bomb1"]["finale_start"] = %dogfight_finale_knoxdeath_dnabomb1;
    maps\_anim::addnotetrack_flag( "bomb1", "dna_explosion_start", "dnabomb1_exploded", "finale_start" );
    maps\_anim::addnotetrack_flag( "bomb1", "safe_2_launch_next", "launch_bomb2", "finale_start" );
    level.scr_animtree["bomb2"] = #animtree;
    level.scr_model["bomb2"] = "df_dna_bomb";
    level.scr_anim["bomb2"]["finale_bomb2"] = %dogfight_finale_knoxdeath_dnabomb2;
    maps\_anim::addnotetrack_flag( "bomb2", "dna_explosion_start", "dnabomb2_exploded", "finale_bomb2" );
    maps\_anim::addnotetrack_flag( "bomb2", "safe_2_launch_next", "launch_bomb3", "finale_bomb2" );
    level.scr_animtree["bomb3"] = #animtree;
    level.scr_model["bomb3"] = "df_dna_bomb";
    level.scr_anim["bomb3"]["finale_bomb3"] = %dogfight_finale_knoxdeath_dnabomb3;
    maps\_anim::addnotetrack_flag( "bomb3", "dna_explosion_start", "dnabomb3_exploded", "finale_bomb3" );
    maps\_anim::addnotetrack_flag( "bomb3", "knox_death_start", "start_knox_scene", "finale_bomb3" );
    level.scr_animtree["prop10"] = #animtree;
    level.scr_model["prop10"] = "genericprop_x10";
    level.scr_anim["prop10"]["vtol_crash"] = %dogfight_finale_knoxdeath_props;
    level.scr_animtree["prop10_drones"] = #animtree;
    level.scr_model["prop10_drones"] = "genericprop_x10";
    level.scr_anim["prop10_drones"]["vtol_crash"] = %dogfight_finale_knoxdeath_dnabombs2;
    level.scr_animtree["prop30"] = #animtree;
    level.scr_model["prop30"] = "genericprop_x30";
    level.scr_anim["prop30"]["vtol_crash"] = %dogfight_finale_knoxdeath_dnabombs;
    level.scr_anim["prop30"]["intro_pod_scene"] = %dogfight_shore_briefing_chairs_tables;
    level.scr_animtree["warbird_pturret"] = #animtree;
    level.scr_model["warbird_pturret"] = "npc_zipline_gun_right";
    level.scr_anim["warbird_pturret"]["enter_turret_pvtol"] = %dogfight_vtol_ride_enter_turret_turret;
    maps\_anim::addnotetrack_flag( "prop30", "start_carpet_bombs", "start_carpet_bombs", "vtol_crash" );
    maps\_anim::addnotetrack_flag( "prop30", "last_carpet_bomb", "last_carpet_bomb", "vtol_crash" );
    level.scr_animtree["surveillance_post"] = #animtree;
    level.scr_model["surveillance_post"] = "nb_atlas_surveillance_post_anim";
    level.scr_anim["surveillance_post"]["surveillance_post_idle"][0] = %dogfight_surv_post_search_idle;
    level.scr_animtree["palm_01_anim"] = #animtree;
    level.scr_model["palm_01_anim"] = "foliage_has_palm_01_anim";
    level.scr_anim["palm_01_anim"]["palm_01_anim_heavy"][0] = %foliage_has_palm_01_sway_heavy;
    level.scr_anim["palm_01_anim"]["palm_01_anim_light"][0] = %foliage_has_palm_01_sway_light;
}

#using_animtree("player");

knuckles_left_fellout()
{
    level.scr_anim["player_rig"]["grapple_pullout_l"] = %dogfight_grapple_vtol_unmanned_l_player;
}

knuckles_right_fellout()
{
    level.scr_anim["player_rig"]["grapple_pullout_r"] = %dogfight_grapple_vtol_unmanned_r_player;
}

player_anims()
{
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_rig"]["grapple_warbird_l"] = %vm_grapple_warbird_mantle_door_l;
    level.scr_anim["player_rig"]["grapple_warbird_r"] = %vm_grapple_warbird_mantle_door_r;
    level.scr_anim["player_rig"]["drag_player"] = %dogfight_captured_player;
    level.scr_anim["player_rig"]["intro_pod_scene"] = %dogfight_shore_briefing_player_enter;
    level.scr_anim["player_rig"]["grapple_pvtol"] = %dogfight_vtol_ride_enter_player;
    level.scr_anim["player_rig"]["enter_turret_pvtol"] = %dogfight_vtol_ride_enter_turret_player;
    level.scr_anim["player_rig"]["grapple_pullout_r"] = %dogfight_grapple_vtol_pullout_r_player;
    level.scr_anim["player_rig"]["grapple_pullout_l"] = %dogfight_grapple_vtol_pullout_l_player;
    level.scr_anim["player_rig"]["grapple_enter_r"] = %dogfight_grapple_vtol_pullout_r_enter_player;
    level.scr_anim["player_rig"]["grapple_enter_l"] = %dogfight_grapple_vtol_pullout_l_enter_player;
    maps\_anim::addnotetrack_flag( "player_rig", "start_allies", "grapple_notetrack", "grapple_pvtol" );
    level.scr_anim["player_rig"]["grapple_warbird_enemy_l"] = %dogfight_grapple_vtol_pullout_l_enter_player;
    level.scr_anim["player_rig"]["grapple_pullout_l"] = %dogfight_grapple_vtol_pullout_l_player;
    level.scr_anim["player_rig"]["vtol_crash"] = %dogfight_finale_knoxdeath_player;
    maps\_anim::addnotetrack_flag( "player_rig", "shell_shock", "knoxdeath_shellshock", "vtol_crash" );
    maps\_anim::addnotetrack_notify( "player_rig", "queen1_offscreen", "queen1_offscreen", "vtol_crash" );
    maps\_anim::addnotetrack_notify( "player_rig", "fade_out", "knox_death_fade_out", "vtol_crash" );
    maps\_anim::addnotetrack_flag( "player_rig", "fade_in", "flag_drag_fade_in", "drag_player" );
    maps\_anim::addnotetrack_flag( "player_rig", "fade_out", "flag_drag_fade_out", "drag_player" );
    maps\_anim::addnotetrack_flag( "player_rig", "fade_out_end_level", "flag_drag_end_level", "drag_player" );
}

load_script_model_anims()
{
    level.scr_model["warbird_pulley"] = "vehicle_xh9_warbird_pulley";
    level.scr_model["warbird_walker"] = "vehicle_x4walker_wheels";
    level.scr_model["warbird_walker2"] = "vehicle_walker_tank_long_lod";
}

#using_animtree("vehicles");

vehicle_anims()
{
    level.scr_animtree["warbird"] = #animtree;
    level.scr_model["warbird"] = "vehicle_xh9_warbird_stealth";
    level.scr_anim["warbird"]["vtol_crash"] = %dogfight_finale_knoxdeath_warbird;
    level.scr_anim["captured_truck"]["drag_veh"] = %dogfight_captured_truck;
    level.scr_animtree["spider_turret"] = #animtree;
    level.scr_anim["spider_turret"]["spider_turret_emplaced"] = %dogfight_x4walker_emplacement_pose;
    maps\_anim::addnotetrack_flag( "player_vtol", "trigger_bomb3", "launch_bomb3", "vtol_crash" );
    level.scr_animtree["sentinel_drop_pod"] = #animtree;
    level.scr_model["sentinel_drop_pod"] = "sentinel_drop_pod";
    level.scr_anim["player_pod"]["intro_pod_scene"] = %dogfight_shore_briefing_player_pod_enter;
    level.scr_anim["gideon_pod"]["intro_pod_scene"] = %dogfight_shore_briefing_gideon_pod_enter;
    level.scr_anim["knox_pod"]["intro_pod_scene"] = %dogfight_shore_briefing_knox_pod_enter;
}

addnotetrack_df( var_0, var_1, var_2, var_3 )
{
    var_1 = tolower( var_1 );
    var_3 = maps\_anim::get_generic_anime( var_3 );
    var_4 = maps\_anim::add_notetrack_and_get_index( var_0, var_1, var_3 );
    var_5 = [];
    var_5["function"] = var_2;
    level.scr_notetrack[var_0][var_3][var_1][var_4] = var_5;
}
