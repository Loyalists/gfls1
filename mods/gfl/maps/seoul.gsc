// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_utility::add_start( "seoul_intro", maps\seoul_code_gangnam::seoul_start );
    maps\_utility::add_start( "seoul_first_land_assist", maps\seoul_code_gangnam::seoul_land_assist );
    maps\_utility::add_start( "seoul_enemy_encounter_01", maps\seoul_code_gangnam::seoul_encounter_01 );
    maps\_utility::add_start( "seoul_missile_evade_sequence", maps\seoul_code_gangnam::seoul_missile_evade );
    maps\_utility::add_start( "seoul_forward_operating_base", maps\seoul_code_gangnam::seoul_fob );
    maps\_utility::add_start( "seoul_drone_swarm_intro", maps\seoul_code_gangnam::seoul_drone_swarm_intro );
    maps\_utility::add_start( "seoul_truck_push", maps\seoul_code_gangnam::seoul_truck_push );
    maps\_utility::add_start( "seoul_hotel_entrance", maps\seoul_code_gangnam::seoul_hotel_entrance );
    maps\_utility::add_start( "seoul_building_jump_sequence", maps\seoul_code_gangnam::seoul_building_jump_sequence );
    maps\_utility::add_start( "seoul_sinkhole_start", maps\seoul_code_shopping_district::debug_seoul_sinkhole_start );
    maps\_utility::add_start( "seoul_subway_start", maps\seoul_code_shopping_district::debug_seoul_subway_start );
    maps\_utility::add_start( "seoul_shopping_district_start", maps\seoul_code_shopping_district::debug_seoul_shopping_district_start );
    maps\_utility::add_start( "seoul_shopping_district_flee_swarm", maps\seoul_code_shopping_district::debug_seoul_shopping_district_flee_swarm );
    maps\_utility::add_start( "seoul_canal_intro", maps\seoul_code_shopping_district::debug_seoul_canal_start );
    maps\_utility::add_start( "seoul_canal_combat_start", maps\seoul_code_shopping_district::debug_seoul_canal_begin_combat );
    maps\_utility::add_start( "seoul_canal_combat_pt2", maps\seoul_code_shopping_district::debug_seoul_canal_fight_to_weapon_platform );
    maps\_utility::add_start( "seoul_finale_scene_start", maps\seoul_code_shopping_district::debug_seoul_finale_scene_start );
    // level.start_point = "seoul_first_land_assist";

    if ( level.currentgen )
    {
        maps\seoul_transients_cg::setup_start_points_for_transients();
        maps\_utility::tff_sync_setup();
    }

    maps\_utility::template_level( "seoul" );
    maps\createart\seoul_art::main();
    maps\seoul_fx::main();
    maps\seoul_precache::main();
    maps\_load::main();
    thread maps\_player_exo::main( "assault" );
    maps\seoul_anim::anims();
    maps\seoul_lighting::main2();
    maps\seoul_aud::main();
    maps\_patrol_extended::main();
    maps\_stealth::main();
    maps\_variable_grenade::give_player_variable_grenade();
    maps\_variable_grenade::set_variable_grenades_with_no_switch( "tracking_grenade_var", "paint_grenade_var" );
    maps\seoul_vo::main();
    vehicle_scripts\_attack_drone_common::attack_drone_formation_init();
    vehicle_scripts\_attack_drone::drone_swarm_init();
    vehicle_scripts\_pdrone_tactical_picker::main();
    animscripts\traverse\seoul_zipline::load_scripted_anims();
    maps\_vehicle_shg::set_player_rig_spawn_function( ::spawn_correct_player_rig );

    if ( level.currentgen )
    {
        maps\seoul_transients_cg::setup_level_transient_zone_variable();
        maps\seoul_transients_cg::seoul_cg_precache_models();
    }

    precacheturret( "heli_spotlight_so_castle" );
    precachemodel( "weapon_binocular" );
    precachemodel( "npc_stingerm7_base_black" );
    precacheshellshock( "iw5_stingerm7_sp" );
    precacheshellshock( "iw5_maaws_sp" );
    precacheshellshock( "seo_canal_finale_blowback" );
    precacheshader( "waypoint_ammo" );
    precachemodel( "npc_titan45_nocamo" );
    maps\seoul_code_gangnam::gangnam_main();
    maps\seoul_code_drop_pod::droppod_main();
    thread handle_player_boost_jump();
    thread objectives();
    thread handle_weapon_pickups();
    thread handle_prone_and_crouch_bugs();
    level.player notifyonplayercommand( "dpad_down", "+actionslot 2" );
    level.player notifyonplayercommand( "dpad_left", "+actionslot 3" );
    level.player notifyonplayercommand( "dpad_right", "+actionslot 4" );
    level.player notifyonplayercommand( "dpad_up", "+actionslot 1" );
    level.player notifyonplayercommand( "a_pressed", "+gostand" );
    level.player notifyonplayercommand( "b_pressed", "+stance" );
    level.player notifyonplayercommand( "y_pressed", "weapnext" );
    level.player notifyonplayercommand( "x_pressed", "+usereload" );
    level.player notifyonplayercommand( "attack_pressed", "+attack" );
    level.player notifyonplayercommand( "ads_pressed", "+speed_throw" );
    level.player notifyonplayercommand( "ads_pressed", "+toggleads_throw" );
    level.player notifyonplayercommand( "r3_pressed", "+melee" );
    level.player notifyonplayercommand( "r3_pressed", "+melee_zoom" );
    level.player notifyonplayercommand( "l3_pressed", "+sprint" );
    level.player notifyonplayercommand( "l3_pressed", "+sprint_zoom" );
    level.player notifyonplayercommand( "rb_pressed", "+frag" );
    thread setup_dont_leave_failure();
    thread setup_dont_leave_hint();
    maps\_utility::add_hint_string( "hint_dont_leave_mission", &"SEOUL_DONT_LEAVE_WARNING", ::should_break_dont_leave );
    gameplay();
    ingame_movies();
    thread cleanup_ai_think();
    setsaveddvar( "r_fastModelPrimaryLightLink", "1" );

    if ( level.currentgen )
    {
        setsaveddvar( "r_gunSightColorEntityScale", "7" );
        setsaveddvar( "r_gunSightColorNoneScale", "0.8" );
    }

    thread set_seoul_fall_height();
}

set_seoul_fall_height()
{
    wait 3;
    setsaveddvar( "bg_fallDamageMinHeight", 490 );
    setsaveddvar( "bg_fallDamageMaxHeight", 640 );
}

enable_cqb_squad()
{
    level.cormack maps\_utility::enable_cqbwalk();
    level.will_irons maps\_utility::enable_cqbwalk();
    level.jackson maps\_utility::enable_cqbwalk();
    level.player maps\_utility::player_speed_percent( 80 );
}

disable_cqb_squad()
{
    level.cormack maps\_utility::disable_cqbwalk();
    level.will_irons maps\_utility::disable_cqbwalk();
    level.jackson maps\_utility::disable_cqbwalk();
    level.player gradually_return_player_speed( 80, 100, 3 );
}

cleanup_ai_think()
{
    var_0 = getentarray( "ai_cleanup_volume_for_jerk_testers", "targetname" );
    common_scripts\utility::array_thread( var_0, ::cleanup_ai_on_trigger );
}

cleanup_ai_on_trigger()
{
    var_0 = getent( self.target, "targetname" );
    var_0 waittill( "trigger" );
    var_1 = getaiarray( "axis" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3 ) )
        {
            if ( var_3 istouching( self ) )
                var_3 maps\_shg_design_tools::delete_auto();
        }
    }
}

gradually_return_player_speed( var_0, var_1, var_2 )
{
    var_3 = var_2 * 2;
    var_4 = ( var_1 - var_0 ) / var_3;

    for ( var_5 = 0; var_5 < var_3; var_5++ )
    {
        wait 0.5;
        level.player maps\_utility::player_speed_percent( var_0 + var_5 * var_4 );
    }

    level.player maps\_utility::player_speed_percent( var_1 );
}

objectives()
{
    common_scripts\utility::flag_wait( "objective_start" );
    objective_add( maps\_utility::obj( "objective_demo_team" ), "current", &"SEOUL_OBJECTIVE_DEMO_TEAM" );
    objective_onentity( maps\_utility::obj( "objective_demo_team" ), level.cormack, ( 0, 0, 0 ) );

    while ( !isdefined( level.cormack ) )
        wait 0.05;

    thread maps\seoul_code_gangnam::objective_01_on_cormack();
    thread maps\seoul_code_gangnam::objective_01_on_cardoor();
    thread maps\seoul_code_gangnam::objective_01_on_turret();
    thread maps\seoul_code_gangnam::objective_01_on_will();
    common_scripts\utility::flag_wait( "start_sinkhole_objectives" );
    objective_onentity( maps\_utility::obj( "objective_demo_team" ), level.cormack );
    common_scripts\utility::flag_wait( "objective_sd_followed_cormack_through_sinkhole" );
    var_0 = getent( "objective_sd_origin_cormack", "targetname" );
    var_1 = getent( "objective_sinkhole_ambush", "targetname" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_1.origin );
    objective_setpointertextoverride( maps\_utility::obj( "objective_demo_team" ), "" );
    common_scripts\utility::flag_wait( "objective_sd_smoke_ambush_defeated" );
    objective_onentity( maps\_utility::obj( "objective_demo_team" ), level.cormack );
    common_scripts\utility::flag_wait( "objective_sd_followed_cormack_through_subway" );
    var_2 = getent( "subway_open_gate", "targetname" );
    objective_setpointertextoverride( maps\_utility::obj( "objective_demo_team" ), &"SEOUL_OBJECTIVE_GATE_INT" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_2.origin );
    common_scripts\utility::flag_wait( "objective_sd_gate_opened" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "objective_demo_team" ), "" );
    common_scripts\utility::flag_wait( "objective_start_shopping_district" );
    var_3 = getent( "objective_sd_origin_intersection1", "targetname" );
    var_4 = getent( "objective_sd_origin_mid", "targetname" );
    var_5 = getent( "objective_sd_origin_intersection2", "targetname" );
    var_6 = getent( "objective_sd_origin_stairs", "targetname" );
    var_0 = getent( "objective_sd_origin_cormack", "targetname" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_3.origin );
    common_scripts\utility::flag_wait( "objective_sd_mid" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_4.origin );
    common_scripts\utility::flag_wait( "objective_sd_intersection2" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_5.origin );
    common_scripts\utility::flag_wait( "objective_sd_stairs" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_6.origin );
    common_scripts\utility::flag_wait( "objective_sd_street_combat_complete" );
    var_7 = getent( "objective_sd_origin_cormack", "targetname" );
    var_8 = getent( "objective_sd_origin_stairs_bottom", "targetname" );
    var_9 = getent( "objective_sd_origin_stairs_top", "targetname" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_8.origin );
    common_scripts\utility::flag_wait( "objective_canal_stairs_bottom_reached" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_9.origin );
    common_scripts\utility::flag_wait( "objective_canal_stairs_top_reached" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_7.origin );
    common_scripts\utility::flag_wait( "objective_sd_cormack_convo_complete" );
    maps\_utility::objective_complete( maps\_utility::obj( "objective_demo_team" ) );
    common_scripts\utility::flag_wait( "demo_team_seen" );
    var_10 = getent( "objective_sd_origin_bombs", "targetname" );
    objective_add( maps\_utility::obj( "objective_bombs" ), "current", &"SEOUL_OBJECTIVE_EXPLOSIVES" );
    objective_position( maps\_utility::obj( "objective_bombs" ), var_10.origin );
    objective_setpointertextoverride( maps\_utility::obj( "objective_bombs" ), &"SEOUL_OBJECTIVE_EXPLOSIVES_INT" );
    common_scripts\utility::flag_wait( "bombs_reached" );
    objective_setpointertextoverride( maps\_utility::obj( "objective_bombs" ), &"SEOUL_OBJECTIVE_EXPLOSIVES_INT" );
    common_scripts\utility::flag_wait( "objective_sd_pick_up_bombs" );
    maps\_utility::objective_complete( maps\_utility::obj( "objective_bombs" ) );
    var_11 = getent( "objective_sd_origin_bomb", "targetname" );
    var_12 = getent( "objective_sd_origin_bomb_a", "targetname" );
    setsaveddvar( "objectiveAlphaEnabled", 1 );
    objective_add( maps\_utility::obj( "objective_follow_will" ), "current", &"SEOUL_OBJECTIVE_HELP_WILL" );
    objective_onentity( maps\_utility::obj( "objective_follow_will" ), level.will_irons );
    common_scripts\utility::flag_wait( "canal_bomb_plant_trigger_on" );
    common_scripts\utility::flag_wait( "weapon_platform_reached" );
    setsaveddvar( "objectiveAlphaEnabled", 0 );
    objective_position( maps\_utility::obj( "objective_follow_will" ), var_11.origin );
    common_scripts\utility::flag_wait( "objective_sd_bomb_planted" );
    maps\_utility::objective_complete( maps\_utility::obj( "objective_follow_will" ) );
}

spawn_correct_player_rig()
{
    return maps\_utility::spawn_anim_model( "player_rig" );
}

gameplay()
{
    thread maps\seoul_code_gangnam::seoul_start_from_pod();
    thread maps\seoul_code_shopping_district::shopping_district_main();
}

ingame_movies()
{
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingameloop( "seo_advertisement_01", 1.0, 1 );
}

setup_dont_leave_squad()
{
    common_scripts\utility::flag_wait( "player_left_squad" );
    level notify( "mission failed" );
    setdvar( "ui_deadquote", &"SEOUL_FAIL_LEAVING_SQUAD" );
    maps\_utility::missionfailedwrapper();
}

should_break_dont_leave_squad()
{
    if ( common_scripts\utility::flag( "player_returning_to_map" ) )
        return 1;

    if ( common_scripts\utility::flag( "player_left_squad" ) )
        return 1;
    else
        return 0;
}

setup_dont_leave_squad_hint()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "player_leaving_squad" );
        maps\_utility::display_hint_timeout( "hint_dont_leave_squad", 5 );
        wait 5;
    }
}

setup_dont_leave_failure()
{
    common_scripts\utility::flag_wait( "player_left_map" );
    level notify( "mission failed" );
    setdvar( "ui_deadquote", &"SEOUL_DONT_LEAVE_FAIL" );
    maps\_utility::missionfailedwrapper();
}

setup_dont_leave_hint()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "player_leaving_map" );
        maps\_utility::display_hint_timeout( "hint_dont_leave_mission", 5 );
        wait 5;
    }
}

should_break_dont_leave()
{
    if ( common_scripts\utility::flag( "player_returning_to_map" ) )
        return 1;

    if ( common_scripts\utility::flag( "player_left_map" ) )
        return 1;
    else
        return 0;
}

handle_player_boost_jump()
{
    level.player maps\_player_high_jump::enable_high_jump();

    for (;;)
    {
        var_0 = level.player common_scripts\utility::waittill_any_return( "enable_player_boost_jump", "disable_player_boost_jump", "death" );

        if ( var_0 == "enable_player_boost_jump" )
        {
            level.player maps\_player_high_jump::enable_high_jump();
            continue;
        }

        if ( var_0 == "disable_player_boost_jump" )
            level.player maps\_player_high_jump::disable_high_jump();
    }
}

handle_weapon_pickups()
{
    var_0 = getentarray( "generic_clip_pickup", "targetname" );
    var_1 = getentarray( "smart_grenade_pickup", "targetname" );
    var_2 = getentarray( "threat_grenade_pickup", "targetname" );
    common_scripts\utility::array_thread( var_0, ::setup_clip_pickups );
    common_scripts\utility::array_thread( var_1, ::setup_smart_grenade_pickups );
    common_scripts\utility::array_thread( var_2, ::setup_threat_grenade_pickups );
}

setup_clip_pickups()
{
    level.player endon( "death" );
    level endon( "missionfailed" );
    self endon( "clip_picked_up" );

    for (;;)
    {
        while ( issubstr( level.player getcurrentweapon(), "door" ) )
            waitframe();

        if ( distance( self.origin, level.player.origin ) < 42 )
        {
            var_0 = level.player getcurrentweapon();
            var_1 = level.player getcurrentweaponclipammo( "right" );
            var_2 = level.player getammocount( var_0 );
            var_3 = weaponmaxammo( var_0 );
            var_4 = weaponclipsize( var_0 );

            if ( var_3 - var_2 > var_4 )
                level.player setweaponammostock( var_0, var_2 + var_4 );
            else if ( var_3 - var_2 < var_4 )
                level.player setweaponammostock( var_0, var_3 );
            else
            {
                waitframe();
                continue;
            }

            self delete();
            self notify( "clip_picked_up" );
        }

        waitframe();
    }
}

setup_smart_grenade_pickups()
{
    level.player endon( "death" );
    level endon( "missionfailed" );
    self endon( "nade_picked_up" );

    for (;;)
    {
        if ( distance( self.origin, level.player.origin ) < 42 )
        {
            var_0 = level.player getlethalweapon();
            var_1 = weaponmaxammo( var_0 );
            var_2 = level.player getammocount( var_0 );

            if ( var_2 < var_1 )
            {
                level.player setweaponammostock( var_0, var_2 + 1 );
                self delete();
                self notify( "nade_picked_up" );
            }
        }

        waitframe();
    }
}

setup_threat_grenade_pickups()
{
    level.player endon( "death" );
    level endon( "missionfailed" );
    self endon( "nade_picked_up" );

    for (;;)
    {
        if ( distance( self.origin, level.player.origin ) < 42 )
        {
            var_0 = level.player gettacticalweapon();
            var_1 = weaponmaxammo( var_0 );
            var_2 = level.player getammocount( var_0 );

            if ( var_2 < var_1 )
            {
                level.player setweaponammostock( var_0, var_2 + 1 );
                self delete();
                self notify( "nade_picked_up" );
            }
        }

        waitframe();
    }
}

seoul_cover_art()
{
    var_0 = getent( "gi_art_spawner_gideon", "targetname" );
    var_1 = getent( "gi_art_spawner_mech", "targetname" );
    var_2 = common_scripts\utility::getstruct( "gi_art_struct_anim", "targetname" );
    var_3 = var_2 common_scripts\utility::spawn_tag_origin();
    var_4 = spawn( "script_model", var_3.origin );
    var_4 setmodel( "vehicle_walker_tank" );
    var_4.animname = "walker_tank";
    var_4 maps\_anim::setanimtree();
    var_3 thread maps\_anim::anim_first_frame_solo( var_4, "gi_pose" );
    var_5 = var_0 maps\_shg_design_tools::actual_spawn( 1 );
    var_6 = var_1 maps\_shg_design_tools::actual_spawn( 1 );
    var_3 thread maps\_anim::anim_generic_first_frame( var_5, "gi_pose_gideon" );
    var_3 thread maps\_anim::anim_generic_first_frame( var_6, "gi_pose_mech" );
    var_7 = level.player maps\seoul_code_gangnam::generic_get_player_to_arms( var_3, "gi_pose" );
    maps\_utility::lerp_fov_overtime( 0.1, 50 );

    for (;;)
    {
        var_8 = level.player common_scripts\utility::waittill_any_return( "x_pressed", "b_pressed", "a_pressed" );

        switch ( var_8 )
        {
            case "x_pressed":
                toggle_hide_guy( var_6 );
                break;
            case "b_pressed":
                toggle_hide_guy( var_5 );
                break;
            case "a_pressed":
                toggle_hide_guy( var_4 );
                break;
        }

        wait 0.25;
    }
}

toggle_hide_guy( var_0 )
{
    if ( !isdefined( var_0.toggle_hide ) )
    {
        var_0.toggle_hide = 1;
        var_0 hide();
    }
    else if ( var_0.toggle_hide )
    {
        var_0.toggle_hide = 0;
        var_0 show();
    }
    else
    {
        var_0.toggle_hide = 1;
        var_0 hide();
    }
}

toggle_fov( var_0 )
{

}

handle_prone_and_crouch_bugs()
{
    var_0 = getentarray( "vol_no_prone", "targetname" );
    common_scripts\utility::array_thread( var_0, ::no_prone_in_vol );
}

no_prone_in_vol()
{
    for (;;)
    {
        while ( !level.player istouching( self ) )
            waitframe();

        level.player allowprone( 0 );

        while ( level.player istouching( self ) )
            waitframe();

        level.player allowprone( 1 );
        waitframe();
    }
}

cheapmagicbullet( var_0, var_1, var_2, var_3 )
{
    playfx( common_scripts\utility::getfx( var_0 ), var_1, var_2 - var_1 );
}

tff_get_zone_unload_notify( var_0 )
{
    var_1 = "";

    switch ( var_0 )
    {
        case "east_view":
            var_1 = "pre_transients_intro_to_fob";
            break;
        case "intro_building_descend":
            var_1 = "pre_transients_fob_to_drone_seq_one";
            break;
        case "drone_swarm_one":
            var_1 = "pre_transients_truck_push_to_mall_office";
            break;
        case "fob":
            var_1 = "pre_transients_drone_seq_one_to_trusk_push";
            break;
        case "truck_push_trans":
            var_1 = "pre_transients_mall_office_to_sinkhole_subway";
            break;
        case "mall_offices":
            var_1 = "pre_transients_sinkhole_subway_to_subway";
            break;
        case "sinkhole_subway":
            var_1 = "pre_transients_subway_to_shopping_dist";
            break;
        case "subway_trans":
            var_1 = "pre_transients_shopping_dist_to_canal_overlook";
            break;
        case "shopping_dist":
            var_1 = "pre_transients_canal_overlook_to_riverwalk";
            break;
    }

    return var_1;
}

tff_cleanup_vehicle( var_0 )
{
    var_1 = tff_get_zone_unload_notify( var_0 );

    if ( var_1 == "" )
        return;

    level waittill( var_1 );

    if ( !isdefined( self ) )
        return;

    if ( isremovedentity( self ) )
        return;

    if ( maps\_vehicle::isvehicle() )
        maps\_vehicle_code::_freevehicle();

    self delete();
}
