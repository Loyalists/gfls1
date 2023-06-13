// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_utility::template_level( "finale" );
    maps\_utility::add_start( "intro", ::debug_start_intro, "Intro", ::intro_logic );
    maps\_utility::add_start( "intro_skip", ::debug_start_intro_skip, "Intro skip", ::intro_logic );
    maps\_utility::add_start( "canal", ::debug_canal_start, "Canal", ::canal_logic );
    maps\_utility::add_start( "canal_breach", ::debug_canal_breach_start, "Canal Breach", ::canal_breach_logic );
    maps\_utility::add_start( "silo_approach", ::debug_silo_approach_start, "Silo Approach", ::silo_approach_logic );
    maps\_utility::add_start( "silo_floor_03", ::debug_silo_floor_03_start, "Silo Floor 3", ::silo_floor_03_logic );
    maps\_utility::add_start( "silo_door_kick", ::debug_door_kick_start, "Silo Door Kick", ::silo_door_kick_logic );
    maps\_utility::add_start( "silo_exhaust_entrance", ::debug_silo_exhaust_entrance_start, "Silo Exhaust Entrance", ::silo_exhaust_entrance_logic );
    maps\_utility::add_start( "lobby", ::debug_lobby_start, "Lobby", ::silo_lobby_logic );
    maps\_utility::add_start( "sky_bridge", ::debug_sky_bridge_start, "Sky Bridge", ::silo_sky_bridge_logic );
    maps\_utility::add_start( "will_room", ::debug_will_room_start, "Will Room", ::will_room_logic );
    maps\_utility::add_start( "irons_chase", ::debug_irons_chase, "Irons Chase", ::irons_chase_logic );
    maps\_utility::add_start( "roof", ::debug_roof_start, "Roof", ::roof_logic );
    // level.start_point = "silo_approach";

    if ( level.currentgen )
    {
        setup_cg_start_points();
        maps\_utility::tff_sync_setup();
    }

    common_scripts\utility::flag_init( "flag_exhaust_hatch_open" );
    maps\createart\finale_art::main();
    maps\finale_fx::main();
    maps\finale_precache::main();
    maps\_load::main();
    thread maps\_player_exo::main( undefined, undefined, 0 );
    maps\_credits::initcredits( "all" );
    maps\finale_lighting::main2();
    maps\finale_aud::main();
    maps\finale_anim::main();
    maps\_water::init();
    maps\_utility::add_control_based_hint_strings( "takedown_hint", &"FINALE_ACTION_MELEE", maps\finale_utility::takedown_hint_off );
    maps\_utility::add_control_based_hint_strings( "player_input_shaft_buttons", &"FINALE_SHAFT_BUTTONS", maps\finale_shaft::player_input_shaft_buttons_off );
    maps\_utility::add_control_based_hint_strings( "player_input_shaft_buttons_pc_alt", &"FINALE_SHAFT_BUTTONS_PC_ALT", maps\finale_shaft::player_input_shaft_buttons_off );
    maps\_utility::add_control_based_hint_strings( "player_input_sprint_hint", &"FINALE_SPRINT_BUTTON_HINT", maps\finale_utility::player_input_sprint );
    maps\_utility::add_control_based_hint_strings( "player_input_slide_button", &"FINALE_SLIDE_BUTTON_HINT", maps\finale_utility::player_input_slide_under_door, &"FINALE_SLIDE_BUTTON_HINT_KB" );
    maps\_utility::add_control_based_hint_strings( "release_hint", &"FINALE_HELO_RELEASE_HINT", maps\finale_code::release_hint_off );
    maps\_utility::add_control_based_hint_strings( "player_input_tackle_hint", &"FINALE_ACTION_TACKLE", maps\finale_utility::tackle_handle_hint_display );
    maps\_utility::add_control_based_hint_strings( "break_free_buttonmash_hint", &"FINALE_ACTION_TAP_FREE", maps\finale_utility::process_buttonmash_handle_hint );
    maps\_utility::add_control_based_hint_strings( "final_scene_melee_hint", &"FINALE_ACTION_MELEE_FINAL", maps\finale_utility::final_scene_handle_melee_hint );
    maps\_utility::add_control_based_hint_strings( "final_scene_buttonmash_hint", &"FINALE_ACTION_TAP_STRUGGLE", maps\finale_utility::process_buttonmash_handle_hint );
    precacheturret( "heli_spotlight_so_castle" );
    precachemodel( "com_blackhawk_spotlight_on_mg_setup" );
    precachemodel( "npc_titan45_base" );
    precachemodel( "npc_titan45_cutscene" );
    precachemodel( "npc_titan45_base_nocamo" );
    precachemodel( "vm_world_body_mech" );
    precachemodel( "semx_explosive_mech" );
    precachemodel( "fin_silo_floor_hatch_piston_l" );
    precachemodel( "fin_silo_floor_hatch_piston_r" );
    precachemodel( "fin_silo_floor_hatch" );
    precacheshellshock( "iw5_titan45finalelobby_sp_xmags" );
    precacheshellshock( "iw5_unarmedfinale_nullattach" );
    precacheshellshock( "iw5_unarmedfinaleknife" );
    precacheshellshock( "iw5_hbra3_sp" );
    precachemodel( "genericprop" );
    precachemodel( "npc_exo_armor_bigfin" );
    precachemodel( "fin_body_scanner_door" );
    precachemodel( "body_sentinel_exo_ingress" );
    precachemodel( "viewhands_sentinel_mitchell_prosthetic_smashed" );
    precachemodel( "viewhands_noexo_mitchell_prosthetic_smashed" );
    precachemodel( "viewbody_sentinel_pilot_mitchell_nub_fullarm" );
    precachemodel( "viewbody_sentinel_pilot_mitchell_nub" );
    precachemodel( "viewbody_sentinel_mitchell_egress_custom" );
    precacheshellshock( "playermech_auto_cannon_finale_exhaust" );
    precacheshellshock( "playermech_rocket_swarm_finale_exhaust" );
    precacheshellshock( "playermech_rocket_finale_exhaust" );
    precachemodel( "fin_side_missile_02" );
    precachemodel( "fin_side_missile_white_panel_top_r_01" );
    precachemodel( "fin_side_missile_white_panel_top_l_01" );
    precachemodel( "fin_side_missile_white_panel_bottom_r_01" );
    precachemodel( "fin_side_missile_white_panel_bottom_l_01" );
    precachemodel( "fin_side_missile_engine_nozzel_piece_01" );
    precachemodel( "fin_side_missile_engine_nozzel_piece_02" );
    precachemodel( "fin_side_missile_engine_brace_piece_01" );
    precachemodel( "fin_side_missile_side_box_piece_r_01" );
    precachemodel( "fin_side_missile_side_box_piece_l_01" );
    precachemodel( "vm_exo_armor_minigun_base" );
    precachemodel( "vm_mitchell_finale_knife" );
    precachemodel( "fin_railing_roof_03_anim" );
    precachemodel( "rope1ft_2j" );
    precacherumble( "damage_light" );
    precacherumble( "light_1s" );
    precacherumble( "damage_heavy" );
    precacherumble( "heavy_1s" );
    precacherumble( "pistol_fire" );
    precacheshader( "bls_end_credits_b1" );

    if ( level.currentgen )
        precacheshader( "fullscreen_lit_bloodsplat_01" );

    common_scripts\utility::flag_init( "flag_chyron_finale_complete" );
    common_scripts\utility::flag_init( "flag_release_hint_off" );
    common_scripts\utility::flag_init( "flag_intro_screen_complete" );
    common_scripts\utility::flag_init( "flag_canal_combat_start" );
    common_scripts\utility::flag_init( "flag_se_intro_flyin_start" );
    common_scripts\utility::flag_init( "flag_intro_flyin_start" );
    common_scripts\utility::flag_init( "flag_boat_single_dead" );
    common_scripts\utility::flag_init( "flag_boat_canal_dead" );
    common_scripts\utility::flag_init( "flag_intro_flyin_release" );
    common_scripts\utility::flag_init( "flag_ai_silo_floor_01_end" );
    common_scripts\utility::flag_init( "flag_missile_seated" );
    common_scripts\utility::flag_init( "flag_silo_watwalks_open" );
    common_scripts\utility::flag_init( "flag_silo_combat_complete" );
    common_scripts\utility::flag_init( "flag_se_door_kick_complete" );
    common_scripts\utility::flag_init( "flag_countdown_complete_mission_fail" );
    common_scripts\utility::flag_init( "flag_obj_exhaust_hatch_open" );
    common_scripts\utility::flag_init( "flag_obj_exhaust_hatch_position" );
    common_scripts\utility::flag_init( "flag_exhaust_hatch_complete" );
    common_scripts\utility::flag_init( "flag_missile_ignition_start" );
    common_scripts\utility::flag_init( "flag_player_shoot_missile" );
    common_scripts\utility::flag_init( "flag_exhaust_corridor_timer_fail" );
    common_scripts\utility::flag_init( "flag_missile_hit" );
    common_scripts\utility::flag_init( "flag_missile_failed" );
    common_scripts\utility::flag_init( "flag_missile_damaged" );
    common_scripts\utility::flag_init( "flag_obj_escape" );
    common_scripts\utility::flag_init( "flag_obj_stop_missile_launch_complete" );
    common_scripts\utility::flag_init( "flag_se_mech_exit_init" );
    common_scripts\utility::flag_init( "flag_se_mech_exit_start" );
    common_scripts\utility::flag_init( "flag_lobby_combat_start" );
    common_scripts\utility::flag_init( "flag_lobby_seek_player" );
    common_scripts\utility::flag_init( "flag_lobby_player_can_shoot" );
    common_scripts\utility::flag_init( "flag_lobby_clear" );
    common_scripts\utility::flag_init( "flag_se_will_reveal" );
    common_scripts\utility::flag_init( "flag_will_reveal_complete" );
    common_scripts\utility::flag_init( "flag_will_reveal_irons_complete" );
    common_scripts\utility::flag_init( "flag_obj_escape_complete" );
    common_scripts\utility::flag_init( "flag_bridge_takedown_jump_complete" );
    common_scripts\utility::flag_init( "flag_se_bridge_takedown_success" );
    common_scripts\utility::flag_init( "flag_balcony_tackle_fake_okay" );
    common_scripts\utility::flag_init( "flag_balcony_tackle_okay" );
    common_scripts\utility::flag_init( "flag_balcony_tackle_too_late" );
    common_scripts\utility::flag_init( "flag_balcony_tackle_started" );
    common_scripts\utility::flag_init( "flag_balcony_tackle_success" );
    common_scripts\utility::flag_init( "flag_balcony_pt2_start" );
    common_scripts\utility::flag_init( "flag_button_melee_success" );
    common_scripts\utility::flag_init( "flag_stop_display_melee_hint" );
    common_scripts\utility::flag_init( "flag_buttonmash_success" );
    common_scripts\utility::flag_init( "flag_irons_escaped" );
    common_scripts\utility::flag_init( "flag_se_irons_end" );
    common_scripts\utility::flag_init( "flag_player_speed_control_on" );
    common_scripts\utility::flag_init( "flag_obj_irons_complete" );
    common_scripts\utility::flag_init( "flag_balcony_finale_success" );
    common_scripts\utility::flag_init( "underwater_flashlight" );
    common_scripts\utility::flag_init( "lighting_missile_fail" );
    common_scripts\utility::flag_init( "flag_lighting_fall_blur" );
    common_scripts\utility::flag_init( "lighting_flag_obj_stop_missile_complete" );
    common_scripts\utility::flag_init( "arm_off" );
    common_scripts\utility::flag_init( "flag_sit_down" );

    if ( level.currentgen )
    {
        common_scripts\utility::flag_init( "load_middle_transient" );
        common_scripts\utility::flag_init( "middle_loaded_successfully" );
        common_scripts\utility::flag_init( "load_outro_transient" );
        common_scripts\utility::flag_init( "outro_loaded_successfully" );
        thread load_middle_transient();
        thread load_missile_area_transient();
        thread load_outro_transient();
    }

    maps\finale_utility::load_mech();
    var_0["mech_base_weapon"] = "playermech_auto_cannon_finale";
    var_0["mech_lethal_weapon"] = "playermech_rocket_finale";
    var_0["mech_tactical_weapon"] = "playermech_rocket_swarm_finale";
    var_0["mech_swarm_rocket"] = "playermech_rocket_projectile";
    var_0["mech_swarm_rocket_deploy"] = "playermech_rocket_deploy_projectile";
    var_0["mech_base_no_weapon"] = "playermech_auto_cannon_noweap";
    var_0["mech_dmg1_weapon"] = "playermech_auto_cannon_dmg1";
    var_0["mech_dmg2_weapon"] = "playermech_auto_cannon_dmg2";
    level.player maps\_playermech_code::playermech_init( var_0 );
    level.player maps\_playermech_code::playermech_disable_badplace();
    common_scripts\utility::flag_set( "flag_mech_vo_active" );
    thread maps\finale_utility::mech_setup();
    thread global_spawn_functions();
    thread delete_wills_room_clip();
    thread lightingstate();
    level.friendlyfire_damage_modifier = 0.05;
    maps\finale_vo::main();
    maps\finale_utility::spawn_metrics_init();
    level.player enablealternatemelee();
    animscripts\traverse\boost::precache_boost_fx_npc();
    level.underwater_lightset = "underwater_lightset";
    level.visionset_default = "finale_interior";
    level.visionset_underwater = "finale_underwater";
    level.use_two_stage_swarm = 1;
    level.clut_underwater = "clut_finale_underwater";
    level.clut_previous = "clut_finale_intro";

    if ( level.currentgen )
    {
        setsaveddvar( "r_gunSightColorEntityScale", "7" );
        setsaveddvar( "r_gunSightColorNoneScale", "0.8" );
    }

    common_scripts\utility::flag_wait( "flag_balcony_finale_success" );
    thread maps\_credits::allow_early_back_out();
    maps\_credits::playcredits();
    post_credits_still_image();
    maps\_utility::nextmission();
    changelevel( "", 0 );
}

post_credits_still_image()
{
    var_0 = 2;
    var_1 = 2;
    var_2 = maps\_hud_util::create_client_overlay( "black", 0, level.player );
    var_2.sort = 100;
    var_2 fadeovertime( 1 );
    var_2.alpha = 1;
    wait(var_0 + var_1);
    var_3 = maps\_hud_util::create_client_overlay( "bls_end_credits_b1", 0, level.player );
    var_3.sort = 101;
    var_4 = 3;
    var_1 = 5;
    var_5 = 3;
    var_3 fadeovertime( var_4 );
    var_3.alpha = 1;
    wait(var_4 + var_1);
    var_3 fadeovertime( var_5 );
    var_3.alpha = 0;
    wait 2;
}

delete_wills_room_clip()
{
    var_0 = getent( "clip_wills_room", "targetname" );
    var_0 delete();
}

setup_cg_start_points()
{
    var_0 = [ "finale_intro_tr" ];
    maps\_utility::set_start_transients( "intro", var_0 );
    maps\_utility::set_start_transients( "intro_skip", var_0 );
    maps\_utility::set_start_transients( "canal", var_0 );
    maps\_utility::set_start_transients( "canal_breach", var_0 );
    var_0 = [ "finale_middle_tr" ];
    maps\_utility::set_start_transients( "silo_approach", var_0 );
    maps\_utility::set_start_transients( "silo_floor_03", var_0 );
    maps\_utility::set_start_transients( "silo_exhaust_entrance", var_0 );
    var_0 = [ "finale_outro_tr" ];
    maps\_utility::set_start_transients( "lobby", var_0 );
    maps\_utility::set_start_transients( "sky_bridge", var_0 );
    maps\_utility::set_start_transients( "will_room", var_0 );
    maps\_utility::set_start_transients( "roof", var_0 );
}

load_middle_transient()
{
    maps\_utility::trigger_wait_targetname( "load_finale_middle_tr" );
    common_scripts\utility::flag_set( "load_middle_transient" );
    unload_load_transients( "finale_intro_tr", "finale_middle_tr", "middle_loaded_successfully" );
}

load_missile_area_transient()
{
    maps\_utility::trigger_wait_targetname( "player_is_falling_down_the_exhaust_shaft" );
    unload_load_transients( "finale_middle_tr", "finale_missile_area_tr", "missile_area_loaded_successfully" );
}

load_outro_transient()
{
    common_scripts\utility::flag_wait( "load_outro_transient" );
    unload_load_transients( "finale_missile_area_tr", "finale_outro_tr", "outro_loaded_successfully" );
}

unload_load_transients( var_0, var_1, var_2 )
{
    if ( istransientloaded( var_0 ) )
        unloadtransient( var_0 );

    loadtransient( var_1 );

    for (;;)
    {
        if ( istransientloaded( var_1 ) )
        {
            if ( common_scripts\utility::flag_exist( var_2 ) )
                common_scripts\utility::flag_set( var_2 );

            break;
        }

        wait 0.1;
    }
}

global_spawn_functions()
{
    maps\_utility::add_global_spawn_function( "axis", ::enable_jump_jet_pathing );
    maps\_utility::add_global_spawn_function( "axis", maps\finale_code::player_mech_melee_modifier );
}

enable_jump_jet_pathing()
{
    if ( issubstr( self.classname, "jump" ) )
        self.canjumppath = 1;
}

set_completed_flags()
{
    if ( maps\_utility::is_default_start() )
        return;

    var_0 = level.start_point;

    if ( var_0 == "intro" )
        return;

    if ( var_0 == "intro_skip" )
        return;

    common_scripts\utility::flag_set( "flag_intro_screen_complete" );
    common_scripts\utility::flag_set( "flag_intro_flyin_release" );

    if ( var_0 == "canal" )
        return;

    common_scripts\utility::flag_set( "flag_obj_enter_silo_update" );

    if ( var_0 == "canal_breach" )
        return;

    common_scripts\utility::flag_set( "flag_obj_enter_silo_complete" );

    if ( var_0 == "silo_approach" )
        return;

    if ( var_0 == "silo_floor_03" )
        return;

    common_scripts\utility::flag_set( "flag_silo_combat_stop" );
    common_scripts\utility::flag_set( "flag_silo_combat_complete" );

    if ( var_0 == "silo_door_kick" )
        return;

    common_scripts\utility::flag_set( "flag_dialogue_exhaust_hatch" );
    common_scripts\utility::flag_set( "flag_obj_exhaust_hatch_position" );
    common_scripts\utility::flag_set( "flag_missile_seated" );
    common_scripts\utility::flag_set( "flag_se_exhaust_hatch_init" );

    if ( var_0 == "silo_exhaust_entrance" )
        return;

    common_scripts\utility::flag_set( "flag_obj_exhaust_hatch_open" );
    common_scripts\utility::flag_set( "flag_exhaust_hatch_grab" );
    common_scripts\utility::flag_set( "flag_exhaust_hatch_open" );
    common_scripts\utility::flag_set( "flag_missile_launch_stop" );
    common_scripts\utility::flag_set( "flag_obj_escape" );
    common_scripts\utility::flag_set( "flag_obj_stop_missile_launch_complete" );

    if ( var_0 == "lobby" )
        return;

    if ( var_0 == "sky_bridge" )
        return;

    common_scripts\utility::flag_set( "flag_dialogue_carry_scene_02_complete" );

    if ( var_0 == "will_room" )
        return;

    common_scripts\utility::flag_set( "flag_start_irons_chase" );
    common_scripts\utility::flag_set( "flag_obj_escape_complete" );

    if ( var_0 == "irons_chase" )
        return;

    common_scripts\utility::flag_set( "flag_irons_rooftop" );

    if ( var_0 == "roof" )
        return;
}

spawn_gideon_mech()
{
    level.gideon = maps\_utility::spawn_targetname( "gideon_mech" );
	level.gideon character\gfl\character_gfl_hk416_mech::main();
    level.gideon thread maps\_utility::deletable_magic_bullet_shield();
    maps\_playermech_code::add_swarm_repulsor_for_ally( level.gideon, level.player );
    level.gideon.animname = "gideon_mech";
    level.gideon maps\finale_utility::setstencilstate();
    thread maps\finale_lighting::gideon_mech_light();
    level.gideon.forcealtmeleedeaths = 1;
    level.gideon thread dont_tread_on_me();

    if ( common_scripts\utility::flag( "flag_obj_enter_silo_complete" ) )
        level.gideon maps\_mech::mech_start_rockets( 512, undefined, undefined, undefined, 83.3333, undefined, undefined );
}

dont_tread_on_me()
{
    var_0 = squared( 36 );
    self endon( "death" );

    for (;;)
    {
        foreach ( var_2 in getaiarray( "axis" ) )
        {
            if ( distancesquared( var_2.origin, self.origin ) < var_0 )
                var_2 dodamage( 999999999, self.origin, self, self, "MOD_MELEE" );
        }

        waitframe();
    }
}

spawn_gideon()
{
    if ( !isdefined( level.gideon ) )
    {
        level.gideon = maps\_utility::spawn_targetname( "gideon" );
        level.gideon thread maps\_utility::magic_bullet_shield();
        level.gideon.animname = "gideon";
        level.gideon maps\finale_utility::disable_grenades();
    }
}

obj_init()
{
    obj_enter_atlas_silo();
    obj_stop_missile_launch();
    obj_escape();
    obj_irons();
}

debug_start_intro_skip()
{
    level.debugskip_intro = 1;
    debug_start_intro();
}

debug_start_intro()
{
    soundscripts\_snd::snd_message( "start_intro" );
    common_scripts\utility::flag_set( "first_half_lighting" );
    thread maps\finale_lighting::enable_physical_dof();
    thread maps\finale_lighting::dof_intro();
    set_completed_flags();
    spawn_gideon_mech();
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
    level.player lightsetforplayer( "finale" );
    maps\_utility::vision_set_fog_changes( "finale", 0 );
    level.player setclutforplayer( "clut_finale_intro", 0 );
}

intro_logic()
{
    common_scripts\utility::flag_set( "flag_intro_flyin_start" );
    common_scripts\utility::flag_set( "flyin_mb" );
    level.player setclutforplayer( "clut_finale_intro", 0 );
}

debug_canal_start()
{
    soundscripts\_snd::snd_message( "start_canal" );
    common_scripts\utility::flag_set( "first_half_lighting" );
    common_scripts\utility::flag_set( "underwater_flashlight" );
    set_completed_flags();
    spawn_gideon_mech();
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
    maps\finale_utility::teleport_to_scriptstruct( "checkpoint_canal_start" );
    level.player maps\finale_utility::mech_enable( undefined, 1 );
    level.player thread maps\finale_code::threat_bias_silo_think();
    maps\_utility::vision_set_fog_changes( "finale_underwater", 0 );
    level.player setclutforplayer( "clut_finale_underwater", 0 );
    wait 0.05;
    level.player.inwater = 1;
    var_0 = getent( "trigger_underwater", "targetname" );
    level.player thread maps\_water::playerinwater( var_0 );
    level.gideon thread maps\_water::aiinwater( var_0 );
    thread maps\finale_code::player_speed_control_underwater();
    maps\_utility::activate_trigger_with_targetname( "trig_color_canal_land" );
}

canal_logic()
{

}

debug_canal_breach_start()
{
    soundscripts\_snd::snd_message( "start_canal" );
    common_scripts\utility::flag_set( "first_half_lighting" );
    set_completed_flags();
    spawn_gideon_mech();
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
    maps\finale_utility::teleport_to_scriptstruct( "checkpoint_canal_breach_start" );
    level.player maps\finale_utility::mech_enable( undefined, 1 );
    level.player thread maps\finale_code::threat_bias_canal_think();
    maps\_utility::vision_set_fog_changes( "finale_underwater", 0 );
    level.player setclutforplayer( "clut_finale_underwater", 0 );
    wait 0.05;
    level.player.inwater = 1;
    var_0 = getent( "trigger_underwater", "targetname" );
    level.player thread maps\_water::playerinwater( var_0 );
    level.gideon thread maps\_water::aiinwater( var_0 );
    thread maps\finale_code::player_speed_control_underwater();
}

canal_breach_logic()
{

}

debug_silo_approach_start()
{
    soundscripts\_snd::snd_message( "start_silo_approach" );
    common_scripts\utility::flag_set( "first_half_lighting" );
    thread maps\finale_lighting::debug_silo_approach_clut();
    level.player lightsetforplayer( "finale_silo_orange" );
    maps\_utility::vision_set_fog_changes( "finale_silo_orange", 0 );
    set_completed_flags();
    spawn_gideon_mech();
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
    maps\finale_utility::teleport_to_scriptstruct( "checkpoint_silo_approach_start" );
    level.player maps\finale_utility::mech_enable( undefined, 1 );
    level.player thread maps\finale_code::threat_bias_silo_think();
    level.player thread maps\finale_utility::mech_glass_damage_think( "flag_obj_escape" );
    thread maps\finale_lighting::main_missle_lighting_silotop();
}

silo_approach_logic()
{

}

debug_silo_floor_03_start()
{
    soundscripts\_snd::snd_message( "start_silo_floor_03" );
    common_scripts\utility::flag_set( "first_half_lighting" );
    thread maps\finale_lighting::debug_silo_floor_03_clut();
    level.player lightsetforplayer( "finale_silo_blue" );
    maps\_utility::vision_set_fog_changes( "finale_silo_blue", 1 );
    set_completed_flags();
    spawn_gideon_mech();
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
    maps\finale_utility::teleport_to_scriptstruct( "checkpoint_silo_floor_03" );
    level.player maps\finale_utility::mech_enable( undefined, 1 );
    level.player thread maps\finale_code::threat_bias_silo_think();
    level.player thread maps\finale_utility::mech_glass_damage_think( "flag_obj_escape" );
    thread maps\finale_lighting::main_missle_lighting_floor3();
}

silo_floor_03_logic()
{
    level.player thread maps\finale_utility::player_follow_volume_think();
    thread maps\finale_code::se_missile_load();
}

debug_door_kick_start()
{
    soundscripts\_snd::snd_message( "start_silo_floor_03" );
    common_scripts\utility::flag_set( "first_half_lighting" );
    thread maps\finale_lighting::debug_silo_door_kick_clut();
    level.player lightsetforplayer( "finale_silo_orange" );
    maps\_utility::vision_set_fog_changes( "finale_silo_orange", 0 );
    set_completed_flags();
    spawn_gideon_mech();
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
    maps\finale_utility::teleport_to_scriptstruct( "checkpoint_silo_door_kick" );
    level.player maps\finale_utility::mech_enable( undefined, 1 );
    level.player thread maps\finale_utility::mech_glass_damage_think( "flag_obj_escape" );
}

silo_door_kick_logic()
{
    soundscripts\_snd::snd_message( "start_door_kick" );
    maps\finale_code::se_door_kick();
}

debug_silo_exhaust_entrance_start()
{
    soundscripts\_snd::snd_message( "start_silo_exhaust_entrance" );
    common_scripts\utility::flag_set( "first_half_lighting" );
    level.player lightsetforplayer( "finale_silo_blue" );
    maps\_utility::vision_set_fog_changes( "finale_silo_blue", 0 );
    thread maps\finale_lighting::debug_silo_exhaust_entrance_clut();
    set_completed_flags();
    spawn_gideon_mech();
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
    maps\finale_utility::teleport_to_scriptstruct( "checkpoint_silo_exhaust_entrance" );
    level.player maps\finale_utility::mech_enable( undefined, 1 );
}

silo_exhaust_entrance_logic()
{
    thread maps\finale_code::se_exhaust_hatch();
    thread maps\finale_code::se_exhaust_land();
    maps\finale_code::player_exhaust_corridor();
    maps\finale_code::se_mech_exit();
}

debug_lobby_start()
{
    soundscripts\_snd::snd_message( "start_lobby" );
    common_scripts\utility::flag_set( "second_half_lighting" );
    level.player lightsetforplayer( "finale_lobby_2" );
    maps\_utility::vision_set_fog_changes( "finale_lobby", 0 );
    set_completed_flags();
    spawn_gideon();
    setsaveddvar( "g_friendlyNameDist", 0 );
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
}

silo_lobby_logic()
{
    if ( level.currentgen )
    {
        common_scripts\utility::flag_set( "load_outro_transient" );
        common_scripts\utility::flag_wait( "outro_loaded_successfully" );
    }

    maps\finale_code::lobby_protect();
}

debug_sky_bridge_start()
{
    soundscripts\_snd::snd_message( "start_sky_bridge" );
    common_scripts\utility::flag_set( "second_half_lighting" );
    level.player lightsetforplayer( "finale_lobby" );
    maps\_utility::vision_set_fog_changes( "finale_sky_bridge", 0 );
    set_completed_flags();
    spawn_gideon();
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
    setsaveddvar( "g_friendlyNameDist", 0 );
    maps\finale_utility::teleport_to_scriptstruct( "checkpoint_sky_bridge" );
}

silo_sky_bridge_logic()
{
    maps\finale_code::player_carried_skybridge();
}

debug_will_room_start()
{
    soundscripts\_snd::snd_message( "start_will_room" );
    common_scripts\utility::flag_set( "second_half_lighting" );
    level.player lightsetforplayer( "finale_will" );
    maps\_utility::vision_set_fog_changes( "finale_cinematic_nofog", 0 );
    level.player setclutforplayer( "clut_finale_irons", 0 );
    set_completed_flags();
    spawn_gideon();
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
    setsaveddvar( "g_friendlyNameDist", 0 );
    maps\finale_utility::teleport_to_scriptstruct( "checkpoint_will_room_start" );
}

will_room_logic()
{
    maps\finale_code::se_irons_reveal();
}

debug_irons_chase()
{
    soundscripts\_snd::snd_message( "start_roof" );
    common_scripts\utility::flag_set( "second_half_lighting" );
    level.player lightsetforplayer( "finale_night" );
    maps\_utility::vision_set_fog_changes( "finale_roof", 0 );
    level.player setclutforplayer( "clut_finale_roof", 0 );
    thread maps\finale_lighting::light_strip_checkpoint();
    set_completed_flags();
    spawn_gideon();
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
    level.gideon maps\_utility::enable_cqbwalk();
    setsaveddvar( "ai_friendlyFireBlockDuration", 0 );
    setsaveddvar( "g_friendlyNameDist", 0 );
    maps\finale_utility::teleport_to_scriptstruct( "checkpoint_chase_start" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    thread maps\finale_lighting::setup_final_lighting();
    setsaveddvar( "player_sprintSpeedScale", 1.6 );
    level.player setviewmodel( "s1_gfl_ump45_viewhands" );
}

irons_chase_logic()
{
    soundscripts\_snd::snd_message( "start_irons_chase" );
    maps\finale_code::se_irons_chase();
}

debug_roof_start()
{
    soundscripts\_snd::snd_message( "start_roof" );
    common_scripts\utility::flag_set( "second_half_lighting" );
    maps\_utility::vision_set_fog_changes( "finale_roof", 0 );
    level.player setclutforplayer( "clut_finale_roof", 0 );
    level.player lightsetforplayer( "finale_will_litend" );
    set_completed_flags();
    spawn_gideon();
    thread maps\finale_code::setup_combat();
    thread maps\finale_code::setup_se();
    thread obj_init();
    level.gideon maps\_utility::enable_cqbwalk();
    setsaveddvar( "ai_friendlyFireBlockDuration", 0 );
    setsaveddvar( "g_friendlyNameDist", 0 );
    maps\finale_utility::teleport_to_scriptstruct( "checkpoint_roof_start" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    level.player allowmelee( 0 );
    thread maps\finale_lighting::setup_final_lighting();
    setsaveddvar( "player_sprintSpeedScale", 1.6 );
    level.player setviewmodel( "s1_gfl_ump45_viewhands" );

    while ( !isdefined( level.irons ) )
        waitframe();

    if ( !common_scripts\utility::flag( "flag_player_speed_control_on" ) )
        thread maps\finale_utility::player_chase_speed_control();
}

roof_logic()
{
    thread maps\finale_code::se_bridge_takedown();
    maps\finale_code::se_balcony_finale();
}

lightingstate()
{
    var_0 = getent( "tube_off", "targetname" );
    var_0 hide();
}

obj_enter_atlas_silo()
{
    common_scripts\utility::flag_wait( "flag_intro_screen_complete" );
    objective_add( 1, "current", &"FINALE_OBJ_REACH_ATLAS" );
    var_0 = getent( "obj_canal_breach", "targetname" );
    common_scripts\utility::flag_wait( "flag_intro_flyin_release" );
    level.player setclutforplayer( "", 2 );
    objective_position( 1, var_0.origin );
    common_scripts\utility::flag_wait( "flag_obj_enter_silo_update" );
    objective_onentity( 1, level.gideon );
    common_scripts\utility::flag_wait( "flag_obj_enter_silo_complete" );
    common_scripts\utility::flag_set( "flag_dialogue_canal_breach_complete" );
    maps\_utility::objective_complete( 1 );
}

obj_stop_missile_launch()
{
    thread maps\finale_lighting::rocket_success_lighting_pre_cine();
    objective_add( 2, "current", &"FINALE_OBJ_STOP_LAUNCH" );
    objective_onentity( 2, level.gideon );
    common_scripts\utility::flag_wait( "flag_obj_exhaust_hatch_position" );
    var_0 = getent( "org_obj_exhaust_hatch", "targetname" );
    var_1 = getent( "trig_exhaust_hatch", "targetname" );
    objective_position( 2, var_0.origin );
    common_scripts\utility::flag_wait( "flag_obj_exhaust_hatch_open" );

    if ( level.player usinggamepad() )
        var_1 sethintstring( &"FINALE_PISTON_HINT" );
    else
        var_1 sethintstring( &"FINALE_PISTON_HINT_PC" );

    var_2 = var_1 maps\_shg_utility::hint_button_trigger( "x" );
    common_scripts\utility::flag_wait( "flag_exhaust_hatch_grab" );
    var_1 sethintstring( "" );
    var_2 maps\_shg_utility::hint_button_clear();
    objective_position( 2, ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_exhaust_hatch_open" );
    objective_onentity( 2, level.gideon );
    common_scripts\utility::flag_wait( "flag_missile_launch_stop" );
    var_3 = getent( "org_missile", "targetname" );
    objective_position( 2, var_3.origin );
    objective_setpointertextoverride( 2, &"FINALE_OBJECTIVE_DESTROY" );
    common_scripts\utility::flag_wait( "flag_obj_stop_missile_launch_complete" );
    maps\_utility::objective_complete( 2 );
}

obj_escape()
{
    common_scripts\utility::flag_wait( "flag_obj_escape" );
    objective_add( 3, "current", &"FINALE_OBJ_ESCAPE" );
    objective_position( 3, ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_escape_complete" );
    maps\_utility::objective_complete( 3 );
}

obj_irons()
{
    common_scripts\utility::flag_wait( "flag_obj_escape_complete" );
    objective_add( 4, "current", &"FINALE_OBJ_IRONS" );
    common_scripts\utility::flag_wait( "flag_obj_irons_complete" );
    maps\_utility::objective_complete( 4 );
}

ending_on_off_think()
{
    var_0 = 0;
    var_1 = 5.0;

    for (;;)
    {
        if ( self buttonpressed( "BUTTON_Y" ) )
        {
            var_0 += 0.05;
            wait 0.05;
        }
        else
        {
            var_0 = 0;
            wait 0.05;
        }

        if ( var_0 >= var_1 )
        {
            iprintlnbold( "Ending Off" );
            self playsound( "wpn_exo_launcher_raise_plr_mech" );
            break;
        }
    }

    wait 0.05;
}
