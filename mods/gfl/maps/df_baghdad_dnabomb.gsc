// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

df_baghdad_dnabomb_pre_load()
{
    common_scripts\utility::flag_init( "dnabomb_start_finale" );
    common_scripts\utility::flag_init( "dnabomb_loop" );
    common_scripts\utility::flag_init( "dnabomb_end" );
    common_scripts\utility::flag_init( "blowup_door" );
    common_scripts\utility::flag_init( "flag_drag_fade_in" );
    common_scripts\utility::flag_init( "flag_drag_fade_out" );
    common_scripts\utility::flag_init( "flag_drag_end_level" );
    common_scripts\utility::flag_init( "start_capture_enemies" );
    common_scripts\utility::flag_init( "handbasket" );
    common_scripts\utility::flag_init( "dnabomb_start_knox_scene" );
    common_scripts\utility::flag_init( "launch_bomb2" );
    common_scripts\utility::flag_init( "launch_bomb3" );
    common_scripts\utility::flag_init( "start_knox_scene" );
    common_scripts\utility::flag_init( "start_pvtol_crash" );
    common_scripts\utility::flag_init( "setup_dnabomb_enemies" );
    common_scripts\utility::flag_init( "start_knox_death" );
    common_scripts\utility::flag_init( "drone_swarm_spread" );
    common_scripts\utility::flag_init( "pvtol_crashed" );
    common_scripts\utility::flag_init( "knoxdeath_shellshock" );
    common_scripts\utility::flag_init( "start_carpet_bombs" );
    common_scripts\utility::flag_init( "last_carpet_bomb" );
    common_scripts\utility::flag_init( "mech_anim_fire_rockets" );
    common_scripts\utility::flag_init( "knuckleduster_sniper" );
    common_scripts\utility::flag_init( "knuckleduster_blowingup" );
    common_scripts\utility::flag_init( "knuckles_leaving" );
    common_scripts\utility::flag_init( "player_on_knuckles" );
    common_scripts\utility::flag_init( "baghdad_4e4" );
    common_scripts\utility::flag_init( "stinger_objective_active" );
    common_scripts\utility::flag_init( "player_touching_knuckles" );
    common_scripts\utility::flag_init( "player_on_knuckles" );
    common_scripts\utility::flag_init( "no_tele_knuckles" );
    precachemodel( "head_hero_knox_blend_death" );
    precachemodel( "genericprop_x10" );
    precachemodel( "genericprop_x30" );
    precachemodel( "vehicle_xh9_warbird_stealth" );
    thread knox_death_scene();
}

setup_dnabomb()
{
    maps\df_baghdad_code::setup_common();
    thread maps\df_baghdad_code::handle_stinger_objective();
    level.player enabledeathshield( 1 );
    common_scripts\utility::flag_set( "sniper_support_finished" );
    common_scripts\utility::flag_set( "snipers_finished" );
}

setup_capture()
{
    maps\df_baghdad_code::setup_common( "dnabomb" );
    level.player enabledeathshield( 1 );
    common_scripts\utility::flag_set( "sniper_support_finished" );
    common_scripts\utility::flag_set( "snipers_finished" );
    thread capture_hack();
    level.namedist_old = getdvarint( "g_friendlyNameDist" );
}

capture_hack()
{
    wait 0.1;
    level.player thread maps\_grapple::grapple_take();
    thread handle_captured_anims();
    thread drag_fade_out();
    thread drag_fade_in();
}

begin_capture()
{
    common_scripts\utility::flag_wait( "baghdad_4e4" );
}

setup_audio_dnabomb()
{
    soundscripts\_snd::snd_message( "aud_start_dna_events" );
    soundscripts\_snd::snd_music_message( "df_baghdad_bridge" );
    soundscripts\_snd::snd_message( "snd_start_dnabomb" );
}

flag_hack()
{
    common_scripts\utility::flag_wait( "snipers_finished" );
    level notify( "base_array_end" );
    common_scripts\utility::flag_set( "sniper_support_finished" );
}

begin_dnabomb()
{
    thread flag_hack();
    thread drag_fade_out();
    thread drag_fade_in();
    common_scripts\utility::flag_wait( "dnabomb_finished" );
}

#using_animtree("vehicles");

spawn_veh( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    var_1 useanimtree( #animtree );
    return var_1;
}

start_vtol_crash()
{
    common_scripts\utility::flag_wait( "start_knox_scene" );
    wait 1;
    common_scripts\utility::flag_set( "start_pvtol_crash" );
}

stop_the_fighting()
{
    var_0 = getaiarray( "axis", "allies" );

    foreach ( var_2 in var_0 )
    {
        if ( isalive( var_2 ) )
        {
            var_3 = 1;

            if ( var_2.team == "allies" && isdefined( var_2.animname ) && ( var_2.animname == "gideon" || var_2.animname == "ilana" || var_2.animname == "ilona" ) )
                var_3 = 0;

            if ( var_3 && !maps\df_baghdad_code::raven_player_can_see_ai( var_2 ) )
                var_2 delete();
            else
            {
                var_2 maps\_utility::set_ignoreall( 1 );
                var_2 maps\_utility::set_ignoreme( 1 );
            }
        }
    }
}

player_post_crash()
{
    maps\df_baghdad_code::safe_activate_trigger_with_targetname( "allies_post_bomb" );
    level.player allowsprint( 0 );
    level.player enableweapons();
    level.player disableinvulnerability();
    level.player maps\_utility::blend_movespeedscale_percent( 25 );
    level.player maps\_player_high_jump::disable_boost_jump();
    level thread start_player_walk_sway();
}

player_ready_capture()
{
    wait 3;
    wait 3;
    level.player allowsprint( 1 );
    level.player maps\_utility::blend_movespeedscale_default( 3 );
    wait 1.5;
    level.player notify( "stop_player_walk_sway" );
}

start_player_walk_sway()
{
    level.player endon( "death" );
    level.player endon( "stop_player_walk_sway" );

    for (;;)
    {
        screenshake( level.player.origin, 1, 1, 0.5, 2, 0.2, 0.2, 0, 0.15, 0.18, 0.05 );
        wait 1.5;
    }
}

handle_capture()
{
    common_scripts\utility::flag_wait( "pvtol_crashed" );
    thread player_post_crash();
    objective_state( level.df_objectives["assault_atlas"]["obj"], "failed" );
    thread player_ready_capture();
    common_scripts\utility::flag_wait_or_timeout( "start_capture_enemies", 5 );
    var_0 = getaiarray( "axis" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
        {
            var_2 maps\_utility::set_ignoreall( 0 );
            var_2 maps\_utility::set_ignoreme( 0 );
            var_2.baseaccuracy = 0.01;
        }
    }

    var_0 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "post_dnabomb_mopup", 1 );
    var_4 = undefined;

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
        {
            var_2.ignoreall = 1;
            var_2.ignoreme = 1;

            if ( var_2.classname == "actor_enemy_mech" )
            {
                var_4 = var_2;
                var_2 maps\_utility::set_favoriteenemy( level.player );
                var_2.baseaccuracy = 0.75;
                continue;
            }

            var_2.baseaccuracy = 0.01;
        }
    }

    if ( isdefined( var_4 ) )
    {
        var_4 thread mech_capture_player();
        var_4.last_rockets_time = 0;

        if ( !isdefined( var_4.magic_bullet_shield ) )
            var_4 thread maps\_utility::magic_bullet_shield( 1 );

        var_4 maps\_utility::disable_pain();
        var_4 maps\_utility::set_ignoreme( 1 );
        var_4 thread watch_mech_firing();
    }
    else
        iprintlnbold( "failed to find mech- bad things will happen" );

    var_7 = gettime();
    var_8 = ( gettime() - var_7 ) / 1000;

    for ( var_9 = 0; var_8 < 4 || level.player.health > 10 && var_8 < 15; var_8 = ( gettime() - var_7 ) / 1000 )
    {
        wait 0.05;

        if ( !var_9 && var_8 > 7 )
        {
            var_10 = missile_createattractorent( level.player, 10000, 99999, undefined, 0, ( 0, 0, 60 ) );
            var_9 = 1;
        }

        if ( level.player.health > 50 )
            level.player.health = 50;

        if ( level.player.health < 11 )
        {
            iprintln( "setting player health" );
            level.player.health = 11;
        }

        if ( gettime() - var_4.last_rockets_time < 200 )
        {
            while ( gettime() - var_4.last_rockets_time < 750 && level.player.health > 10 )
                wait 0.05;
        }
    }

    level.player shellshock( "default", 6 );
    wait 1;
    level notify( "lerp_player_now" );
    var_0 = getaiarray( "axis", "allies" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
        {
            var_2 maps\_utility::set_ignoreall( 1 );
            var_2 maps\_utility::set_ignoreme( 1 );
        }
    }
}

mech_capture_player()
{

}

mech_fire_rockets_for_anim()
{
    maps\_utility::set_ignoreall( 0 );
    maps\_utility::set_favoriteenemy( level.player );
    common_scripts\utility::flag_wait( "start_carpet_bombs" );
    level.aud.convoactive = 0;
    common_scripts\utility::flag_wait( "mech_anim_fire_rockets" );
    soundscripts\_snd::snd_message( "postdna_mech_attack" );
    maps\_utility::set_ignoreall( 0 );
    maps\_utility::set_ignoreall( 0 );
    maps\_utility::set_favoriteenemy( level.player );
    level waittill( "knox_death_fade_out" );
    thread maps\_hud_util::fade_out( 0.4, "black" );
}

watch_mech_firing()
{
    self endon( "death" );

    for (;;)
    {
        level.player waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( var_4 == "mod_projectile" || var_4 == "mod_projectile_splash" )
            self.last_rockets_time = gettime();
    }
}

drag_fade_in()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "flag_drag_fade_in" );
        maps\_hud_util::fade_in( 2, "black" );
        common_scripts\utility::flag_clear( "flag_drag_fade_in" );
    }
}

drag_fade_out()
{
    for (;;)
    {
        var_0 = common_scripts\utility::flag_wait_any_return( "flag_drag_fade_out", "flag_drag_end_level" );

        if ( var_0 == "flag_drag_end_level" )
            break;

        thread maps\_hud_util::fade_out( 2, "black" );
        common_scripts\utility::flag_clear( "flag_drag_fade_out" );
    }

    level.player playrumblelooponentity( "damage_heavy" );
    level.player common_scripts\utility::delaycall( 0.7, ::stoprumble, "damage_heavy" );
    objective_state( level.df_objectives["approach_atlas"]["obj"], "failed" );
    thread maps\_hud_util::fade_out( 0.05, "black" );
    wait 3;

    while ( iscinematicplaying() )
        wait 0.05;

    if ( isdefined( level.namedist_old ) )
        setsaveddvar( "g_friendlyNameDist", level.namedist_old );

    maps\_utility::nextmission();
}

play_irons_bink()
{
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    wait 0.05;
    thread maps\df_baghdad_vo::dogfight_irons_speech_bink();
    // cinematicingame( "df_baghdad_irons_speech" );

    // while ( !iscinematicloaded() || iscinematicplaying() )
    //     wait 0.05;

    setsaveddvar( "cg_cinematicfullscreen", "1" );
}

lerp_player_view_to_position_absolute( var_0, var_1, var_2 )
{
    var_3 = maps\_utility::get_player_from_self();
    var_4 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_4.origin = var_3.origin;
    var_4.angles = var_3 getangles();
    var_3 playerlinktoabsolute( var_4, "" );
    var_5 = var_2 / 2;
    var_4 rotateto( var_1, var_2, var_2 * 0.25 );
    wait( var_2 );
    var_4 moveto( var_0, var_2, var_2 * 0.25 );
    wait( var_2 );
    var_4 delete();
}

handle_captured_anims()
{
    thread maps\_hud_util::fade_out( 0.5, "black" );
    level.player disableweapons();
    level.player setstance( "stand" );
    var_0 = getent( "animorg_pod_falling_guy_exit_org", "targetname" );
    var_1 = spawn_veh( "anim_captured_truck" );
    var_1.animname = "captured_truck";
    common_scripts\_exploder::kill_exploder( 650 );
    common_scripts\_exploder::exploder( 651 );
    common_scripts\_exploder::exploder( 652 );
    var_1 thread maps\df_baghdad_fx::vfx_dna_bomb_humvee_lights();
    var_2 = maps\_utility::spawn_anim_model( "player_rig", var_0.origin );
    var_2.animname = "player_rig";
    stopcinematicingame();
    wait 1.5;
    soundscripts\_snd::snd_message( "drag_scene_begin" );
    var_3 = getaiarray( "axis" );

    foreach ( var_5 in var_3 )
    {
        if ( isalive( var_5 ) && isdefined( var_5 ) )
            var_5 delete();
    }

    thread play_irons_bink();
    wait 3;
    wait 2.8;
    var_0 maps\_anim::anim_first_frame_solo( var_2, "drag_player" );
    wait 0.05;
    var_7 = var_2 gettagangles( "tag_player" );
    var_8 = var_2 gettagorigin( "tag_player" );
    level.player lerp_player_view_to_position_absolute( var_8, var_7, 0.75 );
    level.player playerlinktoabsolute( var_2, "tag_player" );
    level.player.ignoreme = 1;
    wait 1;

    if ( !isdefined( level.hidden_for_capture ) )
        thread maps\df_baghdad_code::hide_for_capture();

    var_9 = maps\_utility::spawn_targetname( "anim_captured_enemy1", 1 );
    var_10 = maps\_utility::spawn_targetname( "anim_captured_enemy2", 1 );
    var_11 = maps\_utility::spawn_targetname( "anim_captured_enemy3", 1 );
    var_12 = maps\_utility::spawn_targetname( "anim_captured_enemy4", 1 );
    var_13 = maps\_utility::spawn_targetname( "anim_captured_enemy5", 1 );
    var_14 = maps\_utility::spawn_targetname( "anim_captured_ally1", 1 );
    var_9.animname = "drag_enemy1";
    var_10.animname = "drag_enemy2";
    var_11.animname = "drag_enemy3";
    var_12.animname = "drag_enemy4";
    var_13.animname = "drag_enemy5";
    var_14.animname = "drag_ally1";
    var_15 = [];
    var_15[var_15.size] = var_9;
    var_15[var_15.size] = var_10;
    var_15[var_15.size] = var_11;
    var_15[var_15.size] = var_12;
    var_15[var_15.size] = var_13;
    var_15[var_15.size] = var_14;
    var_15[var_15.size] = level.allies[0];
    var_15[var_15.size] = level.allies[2];
    var_0 thread maps\_anim::anim_single( var_15, "drag_humans" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "drag_veh" );
    var_0 maps\_anim::anim_single_solo( var_2, "drag_player" );
    common_scripts\utility::flag_set( "dnabomb_finished" );
}

kill_on_animend()
{
    self waittillmatch( "single anim", "end" );
    self.a.nodeath = 1;
    self.allowdeath = 1;

    if ( isdefined( self.magic_bullet_shield ) )
        maps\_utility::stop_magic_bullet_shield();

    maps\_utility::die();
    self unlink();
}

prep_ending()
{
    level notify( "prep_dna_bomb_ending" );
    level endon( "prep_dna_bomb_ending" );
    common_scripts\utility::flag_wait( "dnabomb_start_finale" );
    level.player enableinvulnerability();
    wait 4;
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    wait 6;
    wait 7;
}

cleanup_snake_cloud_on_flag( var_0 )
{
    common_scripts\utility::flag_wait( var_0 );
    vehicle_scripts\_attack_drone_common::cleanup_snake_cloud();
}

dna_bomb_drone_handler( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.queen_deadzone = 0;
    var_3.queen_curl = 0.5;
    var_3.neighborhood_radius = 110;
    var_3.neighborhood_radius = 220;
    var_3.separation_factor = 20000;
    var_3.alignment_factor = 0.008;
    var_3.cohesion_factor = 0.00002;
    var_3.magnet_factor = 10;
    var_3.random_factor = 450;
    var_3.max_accel = 3200;
    var_3.drag_amount = 0.05;
    var_3.random_drag_amount = 0.3;
    var_3.queen_relative_speed = 1;
    var_3.dodge_player_shots = 1;
    var_3.emp_mode = 0;
    var_4 = spawnstruct();
    var_4.queen_deadzone = 0;
    var_4.queen_curl = 0.1;
    var_4.neighborhood_radius = 110;
    var_4.separation_factor = 12000;
    var_4.alignment_factor = 0.008;
    var_4.cohesion_factor = 0.00015;
    var_4.magnet_factor = 10;
    var_4.random_factor = 250;
    var_4.max_accel = 3200;
    var_4.drag_amount = 0.05;
    var_4.random_drag_amount = 0.3;
    var_4.queen_relative_speed = 1;
    var_4.dodge_player_shots = 1;
    var_4.emp_mode = 0;
    var_5 = 10;
    var_6 = 18;

    if ( level.currentgen )
    {
        var_5 = 5;
        var_6 = 9;
    }

    var_7 = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "queen_drone_prop10", undefined, var_5, var_6, var_0, 0 );
    var_7.follow_tag = "j_prop_6";
    var_7 vehicle_scripts\_attack_drone_common::snake_cloud_set_boid_settings( var_3 );

    foreach ( var_9 in var_7.snakes )
    {
        foreach ( var_11 in var_9.flock.boids )
        {
            var_11 setmodel( "cluster_bomb_sphere_static" );
            var_11 hide();
        }
    }

    var_14 = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "queen_drone_prop10", undefined, var_5, var_6, var_1, 0 );
    var_14.follow_tag = "j_prop_7";
    var_14 vehicle_scripts\_attack_drone_common::snake_cloud_set_boid_settings( var_4 );

    foreach ( var_9 in var_14.snakes )
    {
        foreach ( var_11 in var_9.flock.boids )
        {
            var_11 setmodel( "cluster_bomb_sphere_static" );
            var_11 hide();
        }
    }

    var_19 = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "queen_drone_prop10", undefined, var_5, var_6, var_2, 0 );
    var_19.follow_tag = "j_prop_8";
    var_19 vehicle_scripts\_attack_drone_common::snake_cloud_set_boid_settings( var_4 );

    foreach ( var_9 in var_19.snakes )
    {
        foreach ( var_11 in var_9.flock.boids )
        {
            var_11 setmodel( "cluster_bomb_sphere_static" );
            var_11 hide();
        }
    }

    var_24 = [];
    var_24[0] = var_7;
    var_24[1] = var_14;
    var_24[2] = var_19;
    level notify( "drone_swarm_spawning" );
    return var_24;
}

update_boid_settings( var_0 )
{
    level waittill( "update_boid_settings" );
    var_1 = spawnstruct();
    var_1.queen_deadzone = 0;
    var_1.queen_curl = 0.1;
    var_1.neighborhood_radius = 110;
    var_1.neighborhood_radius = 220;
    var_1.separation_factor = 20000;
    var_1.alignment_factor = 0.002;
    var_1.cohesion_factor = 0.00005;
    var_1.magnet_factor = 10;
    var_1.random_factor = 250;
    var_1.max_accel = 1600;
    var_1.drag_amount = 0.05;
    var_1.random_drag_amount = 0.2;
    var_1.queen_relative_speed = 1;
    var_1.dodge_player_shots = 1;
    var_1.emp_mode = 0;
    var_0 vehicle_scripts\_attack_drone_common::snake_cloud_set_boid_settings( var_1 );
}

queen_follow_anim( var_0, var_1, var_2, var_3, var_4 )
{
    level endon( "stop_following_anim" );

    foreach ( var_6 in var_0 )
    {
        var_7 = 0;
        var_8 = var_6.snakes.size / 3;

        foreach ( var_10 in var_6.snakes )
        {
            var_10 setturningability( 1 );
            var_10 setyawspeedbyname( "instant" );
            var_10.follow_tag = var_6.follow_tag;

            if ( var_7 >= var_8 * 2 )
                var_10.follow_ent = var_3;
            else if ( var_7 >= var_8 )
                var_10.follow_ent = var_2;
            else
                var_10.follow_ent = var_1;

            var_7++;
        }
    }

    var_13 = [];
    var_13[var_4[0]] = 3520.0;
    var_13[var_4[1]] = 880.0;
    var_13[var_4[2]] = 880.0;

    for (;;)
    {
        foreach ( var_6 in var_0 )
        {
            foreach ( var_10 in var_6.snakes )
            {
                if ( !isdefined( var_10 ) )
                    continue;

                var_16 = var_10.follow_ent gettagorigin( var_10.follow_tag );
                var_10 vehicle_helisetai( var_16, var_13[var_10.follow_tag], var_13[var_10.follow_tag], var_13[var_10.follow_tag], 0, ( 0, 0, 0 ), 0, 0, 0, 1, 0, 0, 0 );
                var_10 setturningability( 1 );
                var_10 setyawspeedbyname( "instant" );
            }
        }

        wait 0.05;
    }
}

handle_queen( var_0, var_1 )
{
    thread setup_audio_dnabomb();
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.origin = var_0.origin + ( 0, 0, 32 );
    var_2.angles = var_0.angles;
    var_3 = maps\_utility::spawn_anim_model( "prop10", var_2.origin );
    var_2 maps\_anim::anim_first_frame_solo( var_3, "vtol_crash" );
    var_4 = maps\_utility::spawn_anim_model( "prop10", var_2.origin );
    var_2 maps\_anim::anim_first_frame_solo( var_4, "vtol_crash" );
    var_5 = maps\_utility::spawn_anim_model( "prop10", var_2.origin );
    var_2 maps\_anim::anim_first_frame_solo( var_5, "vtol_crash" );
    var_6 = var_3 gettagorigin( "j_prop_6" );
    var_7 = var_3 gettagorigin( "j_prop_7" );
    var_8 = var_3 gettagorigin( "j_prop_8" );
    var_9 = common_scripts\utility::spawn_tag_origin();
    var_9.origin = var_6;
    var_9.angles = ( 0, 0, 0 );
    var_9 linkto( var_3, "j_prop_6" );
    wait 0.05;
    var_10 = dna_bomb_drone_handler( var_6, var_7, var_8 );
    var_11 = [];
    var_11[var_11.size] = "j_prop_6";
    var_11[var_11.size] = "j_prop_7";
    var_11[var_11.size] = "j_prop_8";
    thread queen_follow_anim( var_10, var_3, var_5, var_4, var_11 );
    thread cleanup_in_aisle3( var_10 );
    common_scripts\utility::flag_wait( "pvtol_crashed" );

    foreach ( var_13 in var_10 )
    {
        foreach ( var_15 in var_13.snakes )
        {
            foreach ( var_17 in var_15.flock.boids )
                var_17 show();
        }
    }

    var_2 thread maps\_anim::anim_single_solo( var_3, "vtol_crash" );
    wait 0.3;
    var_2 thread maps\_anim::anim_single_solo( var_5, "vtol_crash" );
    wait 0.3;
    var_2 maps\_anim::anim_single_solo( var_4, "vtol_crash" );
    level notify( "stop_following_anim" );
    wait 0.05;
    level.player lerpfov( 65, 0.5 );
    var_10[1] vehicle_scripts\_attack_drone_common::cleanup_snake_cloud();
    var_10[2] vehicle_scripts\_attack_drone_common::cleanup_snake_cloud();
}

cleanup_in_aisle3( var_0 )
{
    level waittill( "queen1_offscreen" );
    var_0[0] vehicle_scripts\_attack_drone_common::cleanup_snake_cloud();
    wait 7;
    level.player lerpfov( 45, 0.5 );

    if ( isdefined( level.walker ) )
        level.walker delete();

    if ( isdefined( level.walker2 ) )
        level.walker2 delete();

    // level.allies[1] swap_head_model( "head_hero_knox_blend_death" );
}

swap_head_model( var_0 )
{
    if ( isdefined( self.headmodel ) )
        self detach( self.headmodel );

    self attach( var_0, "", 1 );
    self.headmodel = var_0;
}

debug_vehicles()
{

}

ready_knuckles_delete( var_0, var_1 )
{
    common_scripts\utility::flag_wait( "knuckles_leaving" );

    if ( isdefined( var_0 ) )
    {
        if ( isalive( var_0.riders[0] ) )
        {
            if ( isdefined( var_0.riders[0].magic_bullet_shield ) )
                var_0.riders[0] maps\_utility::stop_magic_bullet_shield();

            var_0.riders[0] delete();
        }
    }

    foreach ( var_3 in var_1 )
    {
        if ( isalive( var_3 ) )
        {
            if ( isdefined( var_3.magic_bullet_shield ) )
                var_3 maps\_utility::stop_magic_bullet_shield();

            var_3 delete();
        }
    }
}

watch_jump_flag( var_0 )
{
    common_scripts\utility::flag_wait( var_0 );
    self notify( var_0 );
}

monitor_player_grappled_knuckes( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_4 = "player_touching_knuckles";
    childthread watch_jump_flag( var_4 );
    var_5 = common_scripts\utility::waittill_any_return( var_1, var_2, var_4 );
    var_6 = self;

    if ( !isdefined( self.player_grappled ) )
    {
        self.player_grappled = 1;

        if ( isdefined( var_6.riders[0].magic_bullet_shield ) )
            var_6.riders[0] maps\_utility::stop_magic_bullet_shield();

        var_6.riders[0] = maps\_utility::swap_drone_to_ai( var_6.riders[0] );
        var_6.riders[0].sidearm = "iw5_titan45_sp";
        var_6.riders[0] maps\_utility::forceuseweapon( var_6.riders[0].sidearm, "primary" );
        var_6.riders[0] maps\_utility::gun_remove();
        var_6.riders[0] maps\_utility::magic_bullet_shield( 1 );
        var_6.riders[0].animname = "generic";
        var_6.riders[0] maps\_utility::ai_ignore_everything();
        var_6.riders[0] maps\_utility::set_generic_idle_anim( "vtol_idle_pilot" );
        var_6.riders[0] linktoblendtotag( var_6, "tag_driver", 0 );
        level notify( "pilot_now_ai" );
    }

    maps\_grapple::grapple_magnet_unregister( var_6, "tag_grapple_fr" );
    maps\_grapple::grapple_magnet_unregister( var_6, "tag_grapple_bl" );
    var_7 = [];

    foreach ( var_9 in var_3 )
    {
        if ( !isalive( var_9 ) )
            continue;

        if ( isdefined( level.scr_anim[var_9.animname][var_5] ) )
        {
            var_9 maps\_utility::anim_stopanimscripted();
            var_7[var_7.size] = var_9;

            if ( var_9.animname != "vtol_mid" )
            {
                if ( isdefined( var_9.magic_bullet_shield ) )
                {
                    var_9 maps\_utility::stop_magic_bullet_shield();
                    var_9 thread kill_on_animend();
                }
            }

            continue;
        }

        var_9 thread knuckles_watch_dude_damage( var_6, 1, 1 );
    }

    level.mid_dude = undefined;

    foreach ( var_9 in var_3 )
    {
        if ( !isalive( var_9 ) )
            continue;

        if ( var_9.animname == "vtol_mid" )
        {
            var_9 linkto( var_6 );
            level.mid_dude = var_9;
            var_9 thread knuckles_watch_dude_damage( var_6, 0, 0 );
        }
    }

    if ( var_5 == var_4 )
        var_6 thread maps\_anim::anim_single_solo( level.mid_dude, var_1 );
    else
    {
        level.player enableinvulnerability();
        level.player maps\_shg_utility::setup_player_for_scene( 1 );
        level.player.grapple["no_disable_invulnerability"] = 1;
        level.player maps\_utility::delaythread( 0.4, maps\_grapple::grapple_take );
        level.player.knuckles_reenable_grapple = 1;
        var_13 = maps\_utility::spawn_anim_model( "player_rig", var_6.origin );
        var_13.animname = "player_rig";
        var_6 maps\_anim::anim_first_frame_solo( var_13, var_5, "tag_origin" );
        var_13 linkto( var_6 );
        wait 0.05;
        level.player playerlinktoabsolute( var_13, "tag_player" );
        var_7[var_7.size] = var_13;
        var_6 thread maps\_anim::anim_single( var_7, var_5, undefined, undefined, undefined, 1 );
        var_13 waittillmatch( "single anim", "end" );
        level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );
        level.player unlink();
        var_13 delete();
        level.player maps\_shg_utility::setup_player_for_gameplay();
        var_6.riders[0] maps\_utility::ai_ignore_everything();
        setsaveddvar( "cg_drawCrosshair", 1 );
    }

    level.player thread maps\_utility::ignore_me_timer( 2.5 );
    level.player disableinvulnerability();
    level notify( "pilot_drone_to_ai" );
}

knuckles_watch_dude_damage( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = "tag_origin";

    if ( !self.delayeddeath && !isdefined( self.magic_bullet_shield ) )
        maps\_utility::magic_bullet_shield( 1 );

    if ( var_3 )
    {
        var_5 = var_0;

        while ( var_5 != level.player )
            self waittill( "damage", var_6, var_5 );

        wait 0.05;
    }
    else
        common_scripts\utility::waittill_any_return( "damage", "take_a_dive" );

    if ( var_2 )
    {
        maps\_utility::anim_stopanimscripted();
        wait 0.05;
    }

    level thread special_death_anim( var_0, "death_anim", self, 0, 0, 0, var_4, var_1 );
}

special_death_anim( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_2 endon( "death" );

    if ( !isdefined( var_7 ) )
        var_7 = 0;

    var_2 dontinterpolate();
    var_8 = var_2 maps\_utility::getanim( var_1 );
    var_9 = getanimlength( var_8 );
    var_2 dontinterpolate();
    var_0 thread maps\_anim::anim_single_solo( var_2, var_1, var_6 );

    if ( var_2.animname == "vtol_mid" )
    {
        level.mid_dude_dead = 1;
        level notify( "mid_dude_dead" );
    }

    if ( var_7 == 0 )
    {
        wait( var_9 - 0.15 );
        var_2 setanim( var_8, 1, 0, 0 );
        level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );
    }
    else
    {
        wait( var_9 - 0.25 );
        level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );
        var_2 startragdoll();
        wait 0.1;
        var_2 unlink();
        var_2.a.nodeath = 1;
        var_2.allowdeath = 1;

        if ( isdefined( var_2.magic_bullet_shield ) )
            var_2 maps\_utility::stop_magic_bullet_shield();

        var_2.allowdeath = 1;
        var_2 maps\_utility::die();
    }
}

monitor_sideshooter( var_0 )
{
    level endon( "pilot_drone_to_ai" );
    maps\_utility::disable_surprise();
    maps\_utility::ai_ignore_everything();
    knuckles_watch_dude_damage( var_0, 1, 1, 1 );

    if ( self.animname == "vtol_left" )
        maps\df_baghdad_anim::knuckles_left_fellout();
    else if ( self.animname == "vtol_right" )
        maps\df_baghdad_anim::knuckles_right_fellout();
}

player_on_rotors()
{
    self endon( "death" );
    var_0 = [];
    var_0[var_0.size] = "tag_spin_main_rotor_l";
    var_0[var_0.size] = "tag_spin_main_rotor_r";
    var_1 = 16384;

    for (;;)
    {
        foreach ( var_3 in var_0 )
        {
            var_4 = self gettagorigin( var_3 );

            if ( var_4[2] < level.player.origin[2] )
            {
                if ( distancesquared( var_4, level.player.origin ) < var_1 )
                {
                    level.player disableinvulnerability();
                    earthquake( 0.5, 2, level.player.origin, 512 );
                    level.player playrumbleonentity( "damage_heavy" );
                    level.player freezecontrols( 1 );
                    level.player kill();
                    wait 10;
                }
            }
        }

        wait 0.05;
    }
}

watch_bloodplosion( var_0 )
{
    var_0 endon( "death" );

    while ( !isdefined( level.sniper_turret2 ) )
        wait 0.1;

    level.sniper_turret2 waittill( "player_roof_kill" );

    if ( common_scripts\utility::flag( "no_tele_knuckles" ) )
        return;

    var_1 = common_scripts\utility::getstruct( "knuckles_player_on_tower", "targetname" );
    var_0 vehicle_teleport( var_1.origin, var_1.angles, 0, 0 );
    var_0 vehicle_setspeedimmediate( 0, 1000, 1000 );
    var_0.attachedpath = undefined;
    var_0 notify( "newpath" );
    wait 0.05;
    var_2 = 1.6;
    var_3 = 0;

    if ( isdefined( level.sniper_turret2.grappled ) && level.sniper_turret2.grappled == 1 )
        var_3 = 1;
    else if ( isdefined( level.sniper_turret2.meleed ) && level.sniper_turret2.meleed == 1 )
        var_3 = 1;

    if ( !var_3 )
    {
        wait( var_2 );
        var_0 thread maps\_vehicle::vehicle_paths( var_1 );
    }
    else
        var_0 thread maps\_vehicle::vehicle_paths( var_1 );

    while ( !isai( level.sniper_turret2.driver ) )
        wait 0.05;

    var_4 = gettime();
    var_5 = level.sniper_turret2.driver.origin;
    level.sniper_turret2.driver.knuckles_bloodsplosion = 1;
    level.sniper_turret2.driver waittillmatch( "single anim", "intoragdoll" );
    var_6 = level.sniper_turret2.driver;
    thread soundscripts\_snd_playsound::snd_play_at( "bagh_chopper_kill", var_6.origin );
    var_7 = var_6 common_scripts\utility::spawn_tag_origin();
    var_8 = ( var_6.origin - var_5 ) / ( ( gettime() - var_4 ) / 1000 ) - ( 0, 0, 500 );
    var_9 = var_6 common_scripts\utility::spawn_tag_origin();
    var_9 dontinterpolate();
    var_6 linkto( var_9 );
    var_9 moveto( var_9.origin + var_8 * 0.25, 0.25, 0, 0 );
    wait 0.1;
    var_10 = var_6.origin + var_8 * 0.05;
    var_7.origin = ( var_10[0], var_10[1], var_0 gettagorigin( "jnt_rubrotor_l" )[2] );
    var_7.angles = var_0 gettagangles( "jnt_rubrotor_l" );
    var_7 dontinterpolate();
    playfxontag( common_scripts\utility::getfx( "gib_death" ), var_7, "tag_origin" );
    wait 0.05;

    if ( isdefined( var_6 ) )
        var_6 delete();

    wait 0.2;
    var_11 = var_7 common_scripts\utility::spawn_tag_origin();
    var_11.angles = var_0 gettagangles( "jnt_rubrotor_l" ) - ( 180, 0, 0 );
    var_11 dontinterpolate();
    playfxontag( common_scripts\utility::getfx( "gib_death" ), var_11, "tag_origin" );
    var_9 delete();
    wait 10;
    var_7 delete();
    var_11 delete();
}

knuckledusters()
{
    common_scripts\utility::flag_wait( "knuckleduster_sniper" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "knuckle_duster2" );
    soundscripts\_snd::snd_message( "aud_avs_enemy_warbird_grapple", var_0 );
    var_0 thread monitor_player_on_heli();
    var_0 setvehicleteam( "axis" );

    if ( isdefined( var_0.mgturret ) )
    {
        foreach ( var_2 in var_0.mgturret )
            var_2 setturretteam( "axis" );
    }

    var_0 thread player_on_rotors();
    var_4 = maps\_utility::getstructarray_delete( "knuckle_dudester_teleport_loc2", "targetname" );
    var_5 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "knuckle_dudester2" );
    var_6 = [];
    var_6[var_6.size] = "vtol_mid";
    var_6[var_6.size] = "vtol_left";
    var_6[var_6.size] = "vtol_right";
    var_5[1] thread maps\df_baghdad_fx::vfx_vtol_grapple();

    for ( var_7 = 0; var_7 < var_5.size; var_7++ )
    {
        var_5[var_7].animname = var_6[var_7];

        if ( var_5[var_7].animname == "vtol_mid" )
            var_0 thread maps\_anim::anim_first_frame_solo( var_5[var_7], "vtol_react_mid" );
        else
            var_0 thread maps\_anim::anim_loop_solo( var_5[var_7], "enemy_fire_loop" );

        var_5[var_7] allowedstances( "crouch" );
        var_5[var_7] maps\_utility::magic_bullet_shield( 1 );
    }

    var_8 = [];
    var_8["grapple_pullout_l"] = getent( "knuckleduster_player_tele_l", "targetname" );
    var_8["grapple_pullout_r"] = getent( "knuckleduster_player_tele_r", "targetname" );
    var_8["grapple_pullout_l"] linkto( var_0 );
    var_8["grapple_pullout_r"] linkto( var_0 );
    var_9 = getent( "player_touching_knuckles", "targetname" );
    var_9 enablelinkto();
    var_9 linkto( var_0 );
    var_0 hidepart( "TAG_INTERIOR_SEATS" );
    thread watch_bloodplosion( var_0 );

    if ( !isdefined( var_0.riders[0].magic_bullet_shield ) )
        var_0.riders[0] maps\_utility::magic_bullet_shield();

    var_0 thread vehicle_scripts\_xh9_warbird::open_left_door();
    var_0 thread vehicle_scripts\_xh9_warbird::open_right_door();
    var_0.magnetoptions = spawnstruct();
    var_0.magnetoptions.noenableweapon = 1;
    var_0.magnetoptions.distmin = 256;
    var_0.magnetoptions.dotlimitmin = 0.42;
    maps\_grapple::grapple_magnet_register( var_0, "tag_grapple_fr", ( 0, 0, 0 ), "grapple_pullout_r", undefined, var_0.magnetoptions, level.scr_anim["player_rig"]["grapple_enter_r"] );
    maps\_grapple::grapple_magnet_register( var_0, "tag_grapple_bl", ( 0, 0, 0 ), "grapple_pullout_l", undefined, var_0.magnetoptions, level.scr_anim["player_rig"]["grapple_enter_l"] );
    var_0 thread monitor_player_grappled_knuckes( var_8, "grapple_pullout_r", "grapple_pullout_l", var_5 );
    thread ready_knuckles_delete( var_0, var_5 );
    thread monitor_knuckles_vacate( var_0 );
    wait 0.05;

    foreach ( var_11 in var_5 )
        var_11 linkto( var_0 );

    var_0.riders[0].animname = "generic";
    var_0.riders[0] maps\_utility::ai_ignore_everything();
    var_0.riders[0] maps\_utility::set_generic_idle_anim( "vtol_idle_pilot" );
    var_0.riders[0] maps\_utility::gun_remove();
    var_0 thread maps\_vehicle::gopath();
    var_0 maps\_vehicle::godon();
    thread watch_turret_hit_heli( var_0, var_5 );
    var_0 common_scripts\utility::delaycall( 4, ::setmaxpitchroll, 10, 10 );
    var_13 = var_0;
    var_14 = undefined;
    thread monitor_pilot_shoot( var_0, var_5 );
    var_5[1] thread monitor_sideshooter( var_0 );
    var_5[2] thread monitor_sideshooter( var_0 );
    level waittill( "pilot_now_ai" );
    var_0.riders[0].script_drone = undefined;
    var_0.riders[0] maps\_utility::ai_ignore_everything();

    while ( var_13 != level.player )
    {
        var_0.riders[0] waittill( "damage", var_14, var_13 );

        if ( !common_scripts\utility::flag( "player_on_knuckles" ) || !isdefined( level.mid_dude_dead ) )
            var_13 = var_0;
    }

    var_0 notify( "knuckles_crashing" );

    foreach ( var_11 in var_5 )
    {
        if ( !isalive( var_11 ) )
            continue;

        var_11 notify( "take_a_dive" );
    }

    thread special_death_anim( var_0, "vtol_death_pilot", var_0.riders[0], 0, 0, 0, "tag_driver" );
    var_0.heli_crash_indirect_zoff = 256;
    var_0 thread maps\_vehicle_code::helicopter_crash_move( level.player, undefined );
    maps\_utility::smart_radio_dialogue_interrupt( "df_nox_itsgoingdown" );
    wait 0.1;
    var_0 vehicle_setspeed( 10, 10, 10 );
    var_0 setyawspeedbyname( "fast" );
    common_scripts\utility::flag_waitopen_or_timeout( "player_on_knuckles", 6.5 );
    wait 1.5;
    common_scripts\utility::flag_set( "knuckleduster_blowingup" );
    wait 0.5;

    if ( !common_scripts\utility::flag( "knuckleduster_blowingup" ) )
        return;

    common_scripts\utility::flag_set( "knuckles_leaving" );
    var_0 maps\_vehicle::godoff();

    if ( isdefined( var_0.riders[0] ) )
    {
        if ( isdefined( var_0.riders[0].magic_bullet_shield ) )
            var_0.riders[0] maps\_utility::stop_magic_bullet_shield();

        var_0.riders[0] maps\_utility::die();
    }

    var_0 thread vehicle_scripts\_xh9_warbird::warbird_emp_death( level.player, "mod_energy" );
}

watch_turret_hit_heli( var_0, var_1 )
{
    var_2 = var_0;
    var_3 = undefined;
    level endon( "snipers_finished" );
    level endon( "knuckles_leave_now" );
    var_0 endon( "knuckles_crashing" );
    var_0.p_hits = 0;

    while ( var_2 != level.player )
    {
        var_0 waittill( "damage", var_3, var_2, var_4, var_5, var_6 );

        if ( isdefined( var_2.classname ) && var_2.classname == "trigger_hurt" )
            continue;

        if ( var_2 == level.player && ( var_6 == "MOD_EXPLOSIVE_BULLET" || var_6 == "MOD_PROJECTILE" ) )
        {
            var_0.p_hits++;

            if ( var_6 == "MOD_PROJECTILE" || var_0.p_hits >= 6 )
            {
                var_0 maps\_vehicle::godoff();

                if ( isdefined( var_0.riders[0].magic_bullet_shield ) )
                    var_0.riders[0] maps\_utility::stop_magic_bullet_shield();

                var_0.alwaysrocketdeath = 1;
                var_0.preferred_crash_style = 3;
                var_0.enablerocketdeath = 1;
                var_0 notify( "death" );
                break;
            }
        }

        var_2 = var_0;
    }

    foreach ( var_8 in var_1 )
    {
        if ( isalive( var_8 ) )
        {
            if ( isdefined( var_8.magic_bullet_shield ) )
                var_8 maps\_utility::stop_magic_bullet_shield();

            var_8 kill();
        }
    }
}

monitor_pilot_shoot( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "knuckles_crashing" );
    level waittill( "pilot_now_ai" );
    var_0.riders[0] endon( "death" );
    level waittill( "mid_dude_dead" );
    var_0.riders[0] maps\_utility::ai_unignore_everything();

    while ( !common_scripts\utility::flag( "player_on_knuckles" ) )
        wait 0.1;

    var_0.riders[0] maps\_utility::gun_recall();
    var_0 maps\_anim::anim_single_solo( var_0.riders[0], "vtol_react_pilot", "tag_driver" );
    var_0.riders[0] linktoblendtotag( var_0, "tag_driver", 0 );
    var_0.riders[0] maps\_utility::set_generic_idle_anim( "vtol_fire_pilot" );
}

monitor_knuckles_vacate( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "knuckles_crashing" );
    var_0.perferred_crash_location = getent( "knuckleduster_preffered", "targetname" );
    var_1 = level common_scripts\utility::waittill_any_return( "player_on_sniper", "knuckles_leave_now" );

    if ( var_1 == "player_on_sniper" )
    {
        var_2 = common_scripts\utility::getstruct( "knuckles_player_on_tower", "targetname" );
        var_0.attachedpath = undefined;
        var_0.perferred_crash_location = getent( "knuckleduster_preffered_upper", "targetname" );
        var_0 notify( "newpath" );
        var_0 thread maps\_vehicle::vehicle_paths( var_2 );
        var_1 = level common_scripts\utility::waittill_any_return( "snipers_finished", "knuckles_leave_now" );
    }

    maps\_grapple::grapple_magnet_unregister( var_0, "tag_grapple_fr" );
    maps\_grapple::grapple_magnet_unregister( var_0, "tag_grapple_bl" );
    var_2 = common_scripts\utility::getstruct( "knuckles_vacate", "targetname" );
    var_0.attachedpath = undefined;
    var_0 notify( "newpath" );
    var_0 thread maps\_vehicle::vehicle_paths( var_2 );
    var_0 vehicle_setspeed( 40, 15, 15 );
}

#using_animtree("animated_props");

handle_knuckles_turret( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );
    var_0.mgturret[0] setmode( "manual" );
    var_0.mgturret[0] makeunusable();
    var_0.mgturret[0] useanimtree( #animtree );
    var_0.mgturret[0] hide();
    var_0.faketurret = maps\_utility::spawn_anim_model( "warbird_pturret", var_0 gettagorigin( "TAG_TURRET_ZIPLINE_FL" ), var_0 gettagangles( "TAG_TURRET_ZIPLINE_FL" ) );
    var_0.faketurret dontinterpolate();
    var_0.faketurret linkto( var_0, "TAG_GRAPPLE_FL" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_0.faketurret, "enter_turret_pvtol", "TAG_TURRET_ZIPLINE_FL" );
    maps\player_scripted_anim_util::waittill_trigger_activate_looking_at( var_1, var_2, 0.766, 0, 1, var_0 );
    var_0.mgturret[0] makeusable();
    var_4 = maps\_utility::spawn_anim_model( "player_rig", var_0.origin );
    var_4.animname = "player_rig";
    var_0 maps\_anim::anim_first_frame_solo( var_4, "enter_turret_pvtol", "tag_origin" );
    var_4 linkto( var_0 );
    var_4 hide();
    var_5 = common_scripts\utility::spawn_tag_origin();
    var_5.origin = level.player.origin;
    var_5.angles = level.player.angles;
    var_5 linkto( var_0 );
    thread update_dismount( var_0, var_5 );
    level.player disableweapons();
    level.player playerlinktoblend( var_4, "tag_player", 0.2 );
    wait 0.2;
    var_4 show();
    var_0 thread maps\_anim::anim_single_solo( var_4, "enter_turret_pvtol", "tag_origin" );
    var_0 maps\_anim::anim_single_solo( var_0.faketurret, "enter_turret_pvtol", "TAG_TURRET_ZIPLINE_FL", undefined, "warbird_pturret" );
    level.player unlink();
    var_4 unlink();
    var_0.faketurret hide();
    var_0.mgturret[0] show();
    var_0.mgturret[0] useby( level.player );
    level.player playerlinktodelta( var_0, "tag_turret_zipline_fl", 6, 60, 75, 15, 45, 1, 1 );
    level.player playerlinkedturretanglesenable();
    var_4 linktoplayerview( level.player, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ), 0 );
    level.player thread maps\_grapple::grapple_take();
    thread kick_player_timeout( var_0 );
    var_0.mgturret[0] waittill( "turretownerchange" );
    var_4 unlinkfromplayerview( level.player );
    var_4 hide();
    level.player unlink();
    var_0.mgturret[0] setturretdismountorg( var_5.origin );
    var_0.mgturret[0] makeunusable();
    var_0.riders[0] notify( "damage", 1, level.player );
    level notify( "knuckles_dismount2" );
    level maps\_utility::notify_delay( "knuckles_dismount", 0.5 );
    level.player enableweapons();
    level.player thread maps\_grapple::grapple_give();
    thread maps\_utility::autosave_by_name( "left_knuckles_turret" );
}

kick_player_timeout( var_0 )
{
    var_0 endon( "death" );
    level endon( "knuckles_dismount2" );
    wait 8;
    var_0.mgturret[0] useby( level.player );
}

update_dismount( var_0, var_1 )
{
    level endon( "knuckles_dismount" );
    var_2 = ( 0, 0, 8 );

    for (;;)
    {
        level.view_org = level.player getvieworigin();
        var_3 = level.view_org + ( 0, 0, 24 );
        var_0.mgturret[0] setturretdismountorg( var_1.origin + var_2 );
        wait 0.05;
    }
}

monitor_player_on_heli()
{
    var_0 = 0;
    var_1 = 160;
    var_2 = 0;
    level.ground_ref_ent = spawn( "script_model", ( 0, 0, 0 ) );
    level.ground_ref_ent.angles = ( 0, 0, 0 );

    while ( isdefined( self ) && var_0 > -5 && !common_scripts\utility::flag( "knuckleduster_blowingup" ) )
    {
        var_3 = level.player.origin - self.origin;
        var_0 = length( var_3 );

        if ( var_0 > var_1 )
        {
            if ( common_scripts\utility::flag( "player_on_knuckles" ) )
            {
                soundscripts\_snd::snd_message( "aud_exit_vtol" );
                common_scripts\utility::flag_clear( "player_on_knuckles" );
                level notify( "knuckles_leave_now" );
                level.player playersetgroundreferenceent( undefined );

                if ( isdefined( level.player.knuckles_reenable_grapple ) && level.player.knuckles_reenable_grapple )
                {
                    level.player maps\_grapple::grapple_give();
                    level.player.knuckles_reenable_grapple = undefined;
                }
            }
        }
        else if ( var_3[2] > -10 )
        {
            if ( !common_scripts\utility::flag( "player_on_knuckles" ) )
            {
                soundscripts\_snd::snd_message( "aud_enter_vtol" );
                common_scripts\utility::flag_set( "player_on_knuckles" );
                maps\_utility::delaythread( 3, maps\_utility::smart_radio_dialogue_interrupt, "df_gid_shootpilot" );
                maps\_utility::delaythread( 5, maps\_utility::smart_radio_dialogue_overlap, "df_cp1_hostile" );
                maps\_utility::delaythread( 7, maps\_utility::smart_radio_dialogue_overlap, "df_cp1_mayday1" );
            }
        }

        wait 0.05;
    }

    if ( !isdefined( self ) || common_scripts\utility::flag( "knuckleduster_blowingup" ) )
    {
        var_4 = undefined;
        var_5 = undefined;

        if ( isdefined( self ) )
        {
            var_4 = anglestoforward( self.angles );
            var_5 = anglestoup( self.angles );

            if ( common_scripts\utility::flag( "player_on_knuckles" ) )
                playfxontag( common_scripts\utility::getfx( "vtol_explode" ), self, "tag_origin" );
        }

        if ( common_scripts\utility::flag( "player_on_knuckles" ) )
            common_scripts\utility::flag_clear( "knuckleduster_blowingup" );

        wait 0.2;

        if ( isdefined( self ) && common_scripts\utility::flag( "player_on_knuckles" ) )
            playfxontag( common_scripts\utility::getfx( "vtol_explode" ), self, "tag_origin" );

        wait 0.1;

        if ( isdefined( self ) && common_scripts\utility::flag( "player_on_knuckles" ) )
            playfxontag( common_scripts\utility::getfx( "vtol_explode" ), self, "tag_origin" );

        if ( common_scripts\utility::flag( "player_on_knuckles" ) )
        {
            maps\_player_death::set_deadquote( &"df_baghdad_vtol_crash" );
            maps\_utility::missionfailedwrapper();
        }
    }
}

turn_trig_active_on_flag( var_0, var_1 )
{
    common_scripts\utility::flag_wait( var_1 );
    var_0 common_scripts\utility::trigger_on();
    var_0 sethintstring( &"df_baghdad_use_stinger" );
}

knox_death_scene()
{
    wait 0.1;
    thread knuckledusters();
    common_scripts\utility::flag_wait( "snipers_finished" );
    var_0 = getent( "animorg_pod_falling_guy_exit_org", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "prop10", var_0.origin );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "vtol_crash" );
    wait 0.05;
    var_2 = undefined;
    var_3 = getentarray( "stinger_stuff", "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_5 dontinterpolate();
        var_5.angles = var_1 gettagangles( var_5.script_noteworthy );
        var_5.origin = var_1 gettagorigin( var_5.script_noteworthy );
        var_5 linkto( var_1, var_5.script_noteworthy );

        if ( var_5.script_noteworthy == "j_prop_1" )
        {
            var_2 = var_5;
            var_2 maps\_utility::set_hudoutline( "objective", 1 );
        }
    }

    var_7 = getent( "player_use_stinger", "targetname" );
    var_7 sethintstring( " " );
    var_7 setcursorhint( "hint_noicon" );
    var_7 common_scripts\utility::trigger_off();
    thread turn_trig_active_on_flag( var_7, "stinger_objective_active" );
    thread watch_stinger_nags();
    common_scripts\utility::flag_wait( "prespawn_drones" );
    level.prop30 = maps\_utility::spawn_anim_model( "prop30", var_0.origin );
    level.prop10_drones = maps\_utility::spawn_anim_model( "prop10_drones", var_0.origin );
    level.prop30 thread maps\df_baghdad_fx::vfx_dna_bomb_chain_explosion();
    var_0 maps\_anim::anim_first_frame_solo( level.prop30, "vtol_crash" );
    var_0 maps\_anim::anim_first_frame_solo( level.prop10_drones, "vtol_crash" );
    var_8 = 30;
    level.floaters = [];

    for ( var_9 = 0; var_9 < var_8; var_9++ )
    {
        var_10 = "j_prop_" + ( var_9 + 1 );
        var_11 = level.prop30 gettagorigin( var_10 );
        var_12 = level.prop30 gettagangles( var_10 );
        level.floaters[var_9] = spawn( "script_model", var_11 );
        level.floaters[var_9].angles = var_12;
        level.floaters[var_9] setmodel( "sentinel_survey_drone_sphere_ai_swarm" );
        level.floaters[var_9] linkto( level.prop30, var_10 );
    }

    var_13 = 10;

    for ( var_9 = 0; var_9 < var_13; var_9++ )
    {
        var_10 = "j_prop_" + ( var_9 + 1 );
        var_11 = level.prop10_drones gettagorigin( var_10 );
        var_12 = level.prop10_drones gettagangles( var_10 );
        level.floaters[var_9 + var_8] = spawn( "script_model", var_11 );
        level.floaters[var_9 + var_8].angles = var_12;
        level.floaters[var_9 + var_8] setmodel( "sentinel_survey_drone_sphere_ai_swarm" );
        level.floaters[var_9 + var_8] linkto( level.prop10_drones, var_10 );
    }

    common_scripts\utility::flag_set( "msg_kill_ambient_war_fx" );
    thread maps\df_baghdad_fx::vfx_dna_bomb_drone_swarm_setup();
    var_14 = common_scripts\utility::getstruct( var_7.target, "targetname" );
    thread handle_queen( var_0, var_1 );
    common_scripts\utility::flag_wait( "stinger_objective_active" );
    maps\player_scripted_anim_util::waittill_trigger_activate_looking_at( var_7, var_14, 0.766, 0, 1 );

    if ( isdefined( var_2 ) )
        var_2 hudoutlinedisable();

    thread maps\_utility::autosave_by_name( "got_stinger" );
    common_scripts\utility::flag_set( "pvtol_crashed" );

    if ( level.currentgen )
        maps\_utility::tff_sync();

    var_15 = getentarray( "grenade", "classname" );

    if ( var_15.size )
        common_scripts\utility::array_call( var_15, ::delete );

    level.player freezecontrols( 1 );
    level.player thread maps\_grapple::grapple_take();
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    level notify( "stop_walker_spawners" );
    thread maps\_colors::kill_color_replacements();
    maps\_utility::delaythread( 0, common_scripts\utility::flag_set, "dnabomb_start_finale" );
    maps\_utility::delaythread( 1, maps\df_baghdad_code::safe_activate_trigger_with_targetname, "allies_post_bomb" );
    thread prep_ending();
    thread stop_the_fighting();
    level.player enabledeathshield( 1 );
    var_16 = 0.4;
    var_17 = maps\_utility::spawn_anim_model( "player_rig", var_0.origin );
    var_17.animname = "player_rig";
    var_0 maps\_anim::anim_first_frame_solo( var_17, "vtol_crash" );
    var_17 hide();
    var_17 dontinterpolate();
    var_17 thread maps\df_baghdad_fx::vfx_dna_bomb_flyby_papers();
    level.player playerlinktoblend( var_17, "tag_player", var_16, 0.05, 0.05 );
    wait( var_16 );
    level.player playerlinktoabsolute( var_17, "tag_player" );

    foreach ( var_19 in level.allies )
        var_19 unlink();

    var_21 = undefined;
    var_22 = [];
    var_22 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "anim_dnabomb_stumblers" );

    foreach ( var_24 in var_22 )
    {
        if ( isalive( var_24 ) )
        {
            var_24.animname = var_24.script_noteworthy;

            if ( var_24.animname == "ally1" )
                var_24 thread kill_on_animend();

            if ( var_24.animname == "mech" )
            {
                var_21 = var_24;
                var_24 thread maps\df_baghdad_fx::vfx_dna_bomb_mech_reveal();
            }
        }
    }

    level.allies[1] thread kill_on_animend();
    var_22[var_22.size] = level.allies[0];
    var_22[var_22.size] = level.allies[1];
    var_22[var_22.size] = level.allies[2];
    var_22[var_22.size] = var_17;
    var_22[var_22.size] = var_1;
    var_22[var_22.size] = level.prop30;
    var_22[var_22.size] = level.prop10_drones;
    common_scripts\utility::array_call( var_22, ::dontinterpolate );
    var_17 show();
    var_21 thread mech_fire_rockets_for_anim();
    level.namedist_old = getdvarint( "g_friendlyNameDist" );
    setsaveddvar( "g_friendlyNameDist", 0 );
    thread knox_rumble();
    var_0 maps\_anim::anim_single( var_22, "vtol_crash" );
    level.player unlink();
    var_17 delete();
    common_scripts\utility::flag_set( "pvtol_crashed" );
    thread handle_captured_anims();
    level waittill( "lerp_player_now" );
}

knox_rumble()
{
    thread exo_rumble();
    wait 4.9;
    level.player playrumblelooponentity( "heavy_3s" );
    wait 2;
    level.player stoprumble( "heavy_3s" );
    wait 2;
    level.player playrumblelooponentity( "heavy_3s" );
    wait 2.2;
    level.player stoprumble( "heavy_3s" );
}

exo_rumble()
{
    var_0 = 29.6;
    var_1 = 47;
    var_2 = 51;
    var_3 = 53;
    wait( var_0 );
    level.player playrumblelooponentity( "damage_light" );
    level.player common_scripts\utility::delaycall( 2, ::stoprumble, "damage_light" );
    wait( var_1 - var_0 );
    level.player playrumbleonentity( "damage_heavy" );
    wait( var_2 - var_1 );
    level.player playrumbleonentity( "damage_heavy" );
    level.player common_scripts\utility::delaycall( 0.5, ::playrumbleonentity, "damage_heavy" );
    wait( var_3 - var_2 );
    level.player playrumblelooponentity( "heavy_3s" );
    wait 2;
    level.player stoprumble( "heavy_3s" );
}

watch_stinger_nags()
{
    level endon( "pvtol_crashed" );
    common_scripts\utility::flag_wait( "stinger_objective_active" );
    var_0 = [];
    var_0[var_0.size] = "df_gdn_tanksoverrun";
    var_0[var_0.size] = "df_iln_grabthatstinger";
    var_1 = 0;
    var_2 = 6;
    wait( var_2 );

    for (;;)
    {
        var_1++;

        if ( var_1 >= var_0.size )
            var_1 = 0;

        maps\_utility::smart_radio_dialogue_interrupt( var_0[var_1] );
        var_2 *= 1.5;
        wait( var_2 );
    }
}
