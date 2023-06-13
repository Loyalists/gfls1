// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

df_baghdad_combat_pre_load()
{
    common_scripts\utility::flag_init( "tank_finished" );
    common_scripts\utility::flag_init( "barracks_finished" );
    common_scripts\utility::flag_init( "snipers_finished" );
    common_scripts\utility::flag_init( "sniper_support_finished" );
    common_scripts\utility::flag_init( "intro_finished" );
    common_scripts\utility::flag_init( "dnabomb_finished" );
    common_scripts\utility::flag_init( "turrets_dead" );
    common_scripts\utility::flag_init( "completed_snipers" );
    common_scripts\utility::flag_init( "completed_sniper_support" );
    common_scripts\utility::flag_init( "start_sniper_combat" );
    common_scripts\utility::flag_init( "grabbed_sniper" );
    common_scripts\utility::flag_init( "cleared_bridge1_threat" );
    common_scripts\utility::flag_init( "snipers_cleared_roof" );
    common_scripts\utility::flag_init( "destroy_enemy_tank" );
    common_scripts\utility::flag_init( "ally_intro_tank_bombard" );
    common_scripts\utility::flag_init( "tower_helis_death" );
    common_scripts\utility::flag_init( "flag_intro_vtol_stop" );
    common_scripts\utility::flag_init( "flag_spawn_intro_right_allies" );
    common_scripts\utility::flag_init( "flag_completed_rooftop_early" );
    common_scripts\utility::flag_init( "flag_in_sniper_zone" );
    common_scripts\utility::flag_init( "flag_spawn_wave1b" );
    common_scripts\utility::flag_init( "VTOL_pilot_shot" );
    common_scripts\utility::flag_init( "intro_heli_stop_firing" );
    common_scripts\utility::flag_init( "intro_heli_start_firing" );
    common_scripts\utility::flag_init( "intro_heli_rpg_juke" );
    common_scripts\utility::flag_init( "intro_heli_rpg_death" );
    common_scripts\utility::flag_init( "flag_allies_frontline2" );
    common_scripts\utility::flag_init( "flag_allies_frontline3" );
    common_scripts\utility::flag_init( "flag_allies_frontline4" );
    precacheitem( "f15_missile" );
    precacheitem( "f15_20mm" );
    precacheitem( "rpg_player" );
}

setup_snipers()
{
    maps\df_baghdad_code::setup_common();
}

setup_tank()
{
    maps\df_baghdad_code::setup_common();
}

begin_barracks()
{
    common_scripts\utility::flag_wait( "barracks_finished" );
}

begin_snipers()
{
    common_scripts\utility::flag_wait( "snipers_finished" );
}

begin_tank()
{
    common_scripts\utility::flag_wait( "tank_finished" );
}

ambient_combat_axis()
{
    thread maps\df_baghdad_ambient::a10_spawn_funcs();
    maps\_utility::array_spawn_function_noteworthy( "guy_can_jump", ::guy_can_jump );
    maps\_utility::array_spawn_function_noteworthy( "cleanup_guys_snipers_finished", ::wait_for_cleanup );
    thread sniper_combat_setup();
    thread setup_threatbias_combat();
    thread maps\df_baghdad_ambient::base_array_ambient_dogfight_1();

    if ( level.nextgen )
    {
        thread maps\df_baghdad_ambient::base_array_ambient_dogfight_2();
        thread maps\df_baghdad_ambient::base_array_ambient_dogfight_3();
    }

    thread maps\df_baghdad_ambient::base_array_ambient_dogfight_4();
}

kickoff_sniper_combat()
{
    common_scripts\utility::flag_wait( "player_at_meetup" );
    common_scripts\utility::flag_set( "start_sniper_combat" );
}

setup_threatbias_combat()
{
    createthreatbiasgroup( "tower_guys" );
    createthreatbiasgroup( "front1_axis" );
    createthreatbiasgroup( "front1_allies" );
    createthreatbiasgroup( "player" );
    createthreatbiasgroup( "heroes" );
    createthreatbiasgroup( "rpgs_intro" );
    level.player setthreatbiasgroup( "player" );
    setignoremegroup( "front1_allies", "tower_guys" );
}

handle_tank_obj( var_0 )
{
    var_0 endon( "death" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "destroy_enemy_tank" );
        wait 0.5;
        var_0 notify( "death" );
        wait 24;
        common_scripts\utility::flag_set( "resume_west_bridge" );
        common_scripts\utility::flag_clear( "stopped_west_bridge" );
        common_scripts\utility::flag_wait( "stopped_south_bridge" );
        wait 4;
        common_scripts\utility::flag_set( "resume_south_bridge" );
        common_scripts\utility::flag_clear( "stopped_south_bridge" );
    }
}

debug_grapplep()
{
    self endon( "death" );

    for (;;)
        wait 0.05;
}

intro_heli()
{
    common_scripts\utility::flag_wait( "player_at_meetup" );
    var_0 = "heli_center_loop";
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "heli_intro_combat" );
    var_1 maps\_vehicle::godon();
    var_1 endon( "death" );
    var_1 thread heli_shoot_allies( level.intro_ally_tank );
    var_1 waittill( "unloading" );
    maps\_grapple::grapple_magnet_register( var_1, "TAG_GRAPPLE_FR", ( 0, 0, 0 ), "grappled_heli", undefined, undefined, level.scr_anim["player_rig"]["grapple_warbird_l"] );
    maps\_grapple::grapple_magnet_register( var_1, "TAG_GRAPPLE_BR", ( 0, 0, 0 ), "grappled_heli", undefined, undefined, level.scr_anim["player_rig"]["grapple_warbird_r"] );
}

heli_shoot_allies( var_0 )
{
    self endon( "death" );
    self waittill( "unloading" );

    foreach ( var_2 in self.mgturret )
    {
        var_2 setmode( "manual" );
        var_2 settargetentity( var_0 );
        var_2 startfiring();
        var_2 common_scripts\utility::delaycall( 4, ::stopfiring );
    }

    self waittill( "unloaded" );
    wait 3;
    self.delete_on_death = 1;

    if ( isdefined( var_0 ) )
        var_0 notify( "death" );

    var_4 = getentarray( "intro_axis_shootat", "targetname" );
    var_5 = 0;

    foreach ( var_2 in self.mgturret )
    {
        var_2 startfiring();
        var_2 settargetentity( var_4[var_5] );
        var_7 = getent( var_4[var_5].target, "targetname" );
        var_4[var_5] moveto( var_7.origin, 6, 3, 0.1 );
        var_5++;
    }

    wait 6;
    maps\_vehicle::godoff();
    self notify( "death" );
}

player_grapple_into_vehicle( var_0, var_1, var_2 )
{
    level.player unlink();
    level.player disableweapons();
    var_3 = maps\_utility::spawn_anim_model( "player_rig" );
    var_3 linkto( var_2, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_3 maps\_anim::anim_first_frame_solo( var_3, var_1 );
    level.player playerlinktoblend( var_3, "tag_player", 0.25, 0.1, 0.1 );
    wait 0.25;
    level.player playerlinktodelta( var_3, "tag_player", 1.0, 25, 25, 25, 25, 1 );
    var_3 maps\_anim::anim_single_solo( var_3, var_1 );
    level.player unlink();
    var_3 delete();
    level.player enableweapons();
}

ambient_combat_allies()
{
    level.intro_ally_tank = getent( "ally_intro_offensive", "targetname" ) maps\_vehicle::spawn_vehicle_and_gopath();
    thread intro_combat_tank( level.intro_ally_tank );
    maps\_utility::delaythread( 8, ::intro_ally_heli );
}

intro_ally_heli()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "allies_intro_heli1" );
    soundscripts\_snd::snd_message( "aud_avs_intro_allies_1", var_0 );
    var_0 thread maps\df_baghdad_fx::intro_warbird_wash_handler();
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "allies_intro_heli2" );
    soundscripts\_snd::snd_message( "aud_avs_intro_allies_2", var_1 );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "allies_intro_heli3" );
    var_3 = missile_createrepulsorent( var_0, 6000, 2000 );
    waitframe();
    thread handle_cloaking( var_0, 7.25 );
    thread handle_cloaking( var_1, 10 );
    var_1 thread single_ally_heli( "ally_bridge_heli_fire", "intro_heli_start_firing", "intro_heli_stop_firing" );
    var_1 thread rpg_juke( var_2 );
    var_2.preferred_crash_style = 3;
    var_4 = missile_createattractorent( var_2, 2000, 2000, undefined, 0, ( 0, 0, 8 ) );
    common_scripts\utility::flag_wait( "player_at_meetup" );
    wait 1.5;
    var_1.preferred_crash_style = 3;
    var_1.enablerocketdeath = 1;
    var_1 thread single_heli_tower( "towerheli2_spot" );
}

intro_helis_background()
{
    wait 2;
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname( "intro_helis_background" );
}

handle_cloaking( var_0, var_1 )
{
    var_0 thread vehicle_scripts\_xh9_warbird::cloak_warbird();
    wait( var_1 );
    var_0 thread vehicle_scripts\_xh9_warbird::uncloak_warbird( 1 );
}

rpg_juke( var_0 )
{
    common_scripts\utility::flag_wait( "intro_heli_start_firing" );
    wait 1.3;
    var_1 = getent( "intro_missile_strike_start", "targetname" );
    var_2 = var_1.origin;
    var_3 = getent( "intro_missile_strike_end", "targetname" );
    var_4 = var_3.origin;
    var_5 = missile_createattractorent( var_0, 256, 6000, undefined, 0 );
    var_6 = magicbullet( "mobile_turret_missile", var_2, var_4 );
    var_6 missile_settargetent( var_3 );
    var_6 missile_setflightmodedirect();
    wait 0.5;
    common_scripts\_exploder::exploder( 335 );
}

rocket_kill_watcher()
{
    self waittill( "reached_dynamic_path_end" );
    thread vtol_rocket_death();
}

heli_strafe( var_0 )
{
    common_scripts\utility::flag_wait( "intro_heli_strafe" );
    self endon( "death" );
    maps\_vehicle::godoff();
    var_1 = 2;
    var_2 = var_1 + 1.5;
    var_3 = getent( var_0, "targetname" );
    self setlookatent( var_3 );

    for (;;)
    {
        var_4 = var_3;

        for ( var_5 = 0; var_5 < 2; var_5++ )
        {
            var_6 = self.mgturret[var_5];
            var_6 setmode( "manual" );
            var_6 settargetentity( var_4, ( 0, 0, 36 ) );
            var_6 startfiring();
            var_6 common_scripts\utility::delaycall( var_1, ::stopfiring );
        }

        wait( var_2 );
    }
}

vtol_rocket_death()
{
    self endon( "death" );
    var_0 = getentarray( "intro_heli_crash_locs", "targetname" );
    var_0 common_scripts\utility::array_randomize( var_0 );
    self.preferred_crash_location = var_0;
    wait( randomfloatrange( 0.2, 0.3 ) );
    var_1 = self;
    var_2 = getent( "intro_missile_strike_start", "targetname" );
    var_3 = self;
    var_4 = var_2.origin;
    var_5 = var_3.origin;
    var_6 = magicbullet( "mobile_turret_missile", var_4, var_5 );
    var_6 missile_settargetent( var_3 );
    var_6 missile_setflightmodedirect();
    var_6 waittill( "death" );
}

wait_heli_uncloak( var_0 )
{
    level waittill( "intro_uncloak" );
    wait( var_0 );
    thread vehicle_scripts\_xh9_warbird::uncloak_warbird( 3 );
    self notify( "intro_uncloaking" );
}

single_ally_heli( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3 = getent( var_0, "script_noteworthy" );
    var_4 = self.mgturret[0];
    var_4 setmode( "manual" );
    var_4 settargetentity( var_3 );
    common_scripts\utility::flag_wait( var_1 );
    var_4 startfiring();
    common_scripts\utility::flag_wait( var_2 );
    var_4 stopfiring();
}

single_heli_tower( var_0 )
{
    self endon( "death" );
    self.preferred_crash_style = 3;
    self.enablerocketdeath = 1;
    wait( randomfloatrange( 1.1, 2.1 ) );
    var_1 = getent( var_0, "script_noteworthy" );
    var_2 = self.mgturret[0];
    var_2 setmode( "manual" );
    var_2 settargetentity( var_1 );
    var_2 startfiring();
    wait( randomintrange( 2, 4 ) );

    if ( self.script_parameters == "death1" )
        thread heli_tower_death();

    if ( self.script_parameters == "death2" )
        thread heli_tower_death2();
}

heli_tower_death()
{
    self endon( "death" );
    wait( randomfloatrange( 0.2, 0.3 ) );
    var_0 = self;
    var_1 = getent( "tower_missile_start", "targetname" );
    var_2 = self;
    var_3 = var_1.origin;
    var_4 = var_2.origin;
    var_5 = magicbullet( "mobile_turret_missile", var_3, var_4 );
    var_5 missile_settargetent( var_2 );
    var_5 missile_setflightmodedirect();
    var_5 waittill( "death" );
    self kill();
}

heli_tower_death2()
{
    self endon( "death" );
    var_0 = getent( "VTOL_crash_location", "targetname" );
    self.preferred_crash_location = var_0;
    self.preferred_crash_style = -1;
    wait( randomfloatrange( 1.1, 2.1 ) );
    var_1 = self;
    var_2 = getent( "tower_missile_start", "targetname" );
    var_3 = self;
    var_4 = var_2.origin;
    var_5 = var_3.origin;
    var_6 = magicbullet( "mobile_turret_missile", var_4, var_5 );
    var_6 missile_settargetent( var_3 );
    var_6 missile_setflightmodedirect();
    var_6 waittill( "death" );
    self kill();
}

intro_combat_tank( var_0 )
{
    common_scripts\utility::flag_wait( "flag_spawn_intro_right_allies" );
    var_1 = getent( "tower_missile_start", "targetname" );
    var_2 = var_0;
    var_3 = var_1.origin;
    var_4 = var_2.origin;
    var_5 = magicbullet( "mobile_turret_missile", var_3, var_4 );
    var_5 missile_settargetent( var_2 );
    var_5 missile_setflightmodedirect();
    var_5 waittill( "death" );
    var_0 kill();
}

wait_and_fire( var_0, var_1 )
{
    self endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_2 = 1;

    while ( var_2 )
    {
        var_2 = var_1;
        self waittill( var_0 );
        var_3 = getent( var_0, "script_noteworthy" );
        self setturrettargetent( var_3 );
        wait 0.3;
        self fireweapon();
    }
}

handle_drone_group( var_0 )
{
    level endon( "stop_drones" );
    var_1 = gettime();
    wait 1;
    var_2 = var_0 + "_exclusion_vol";
    var_3 = getent( var_2, "targetname" );

    if ( !isdefined( level.converts ) )
        level.converts = [];

    for (;;)
    {
        common_scripts\utility::flag_waitopen( "flag_team_inside_barracks" );
        var_1 = gettime() + 12000;

        if ( !isdefined( var_3 ) || !ispointinvolume( level.player.origin, var_3 ) )
        {
            level.converts[var_0] = [];
            var_4 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( var_0, 1 );

            foreach ( var_6 in var_4 )
            {
                var_6.in_combat_zone = 0;
                var_6.group_map = var_0;
                level thread handle_ambient_drone( var_6 );
            }

            maps\_utility::waittill_dead( var_4 );

            if ( level.converts[var_0].size )
            {
                level.converts[var_0] = maps\_utility::array_removedead( level.converts[var_0] );

                if ( level.converts[var_0].size )
                {
                    maps\_utility::waittill_dead( level.converts[var_0] );

                    if ( var_1 < gettime() )
                        var_1 = gettime();

                    var_1 += 8000;
                }
            }
        }
        else
            var_1 = gettime() + 2000;

        var_8 = ( var_1 - gettime() ) / 1000.0;

        if ( var_8 < 0.1 )
            var_8 = 0.1;

        wait( randomfloatrange( var_8, var_8 + 8 ) );
    }
}

watch_player_shot_me()
{
    self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

    if ( isdefined( var_1 ) && isplayer( var_1 ) )
    {
        if ( isdefined( self ) )
            thread wake_nearby_drones( self.origin, 128 );
    }
}

handle_ambient_drone( var_0 )
{
    var_0 thread watch_player_shot_me();

    for (;;)
    {
        var_1 = var_0 common_scripts\utility::waittill_any_return_no_endon_death( "goal", "player_nearby", "enter_combat", "death" );

        if ( var_1 == "goal" )
        {
            if ( isdefined( var_0.script_parameters ) && var_0.script_parameters == "end_loop_patrol" )
            {
                var_0 notify( "drone_stop" );
                var_0 thread maps\_drone::drone_move();
                continue;
            }

            var_0.in_combat_zone = 1;
            wait( randomfloatrange( 2, 12 ) );

            if ( isdefined( var_0 ) )
                var_0 kill();

            wait 20;

            if ( isdefined( var_0 ) )
                var_0 delete();
        }

        break;
    }
}

handle_combat_runners()
{
    var_0 = getentarray( "south_bridge_runner", "targetname" );
    common_scripts\utility::array_thread( var_0, ::handle_runner_spawner );
}

handle_runner_spawner()
{
    for (;;)
    {
        self.count = 99;
        var_0 = maps\_utility::spawn_ai( 1 );

        if ( !isdefined( var_0 ) )
        {
            wait 1;
            continue;
        }

        var_0.drone_move_callback = ::check_drone_callback;
        var_0.in_combat_zone = 1;
        var_1 = var_0 common_scripts\utility::waittill_any_return_no_endon_death( "death", "hit_kill_trigger" );

        if ( var_1 == "hit_kill_trigger" )
        {
            wait( randomfloatrange( 0.2, 20 ) );

            if ( isdefined( var_0 ) )
                var_0 kill();
        }

        level thread watch_to_delete( var_0 );
        wait( randomfloatrange( 4, 10 ) );
    }
}

watch_to_delete( var_0 )
{
    wait 20;

    if ( isdefined( var_0 ) )
        var_0 delete();
}

check_drone_callback()
{
    if ( isdefined( self.cur_node ) && isdefined( self.cur_node["script_noteworthy"] ) && self.cur_node["script_noteworthy"] == "kill_drone" )
        self notify( "hit_kill_trigger" );
}

convert_drones_near_player()
{
    wait 5;
    var_0 = 262144;

    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_team_inside_barracks" ) )
        {
            wait 2;
            continue;
        }

        var_1 = sortbydistance( level.drones["axis"].array, level.player.origin );
        var_2 = 0;

        for ( var_3 = lengthsquared( var_1[var_2].origin - level.player.origin ); var_3 < var_0 && var_2 < var_1.size; var_2++ )
            var_3 = lengthsquared( var_1[var_2].origin - level.player.origin );

        for ( var_4 = 0; var_4 < var_2; var_4++ )
        {
            var_5 = var_1[var_4];

            if ( isdefined( var_5 ) )
            {
                var_6 = abs( level.player.origin[2] - var_5.origin[2] );

                if ( var_6 < 128 && common_scripts\utility::within_fov( var_5.origin, var_5.angles, level.player.origin, 0.707 ) )
                {
                    var_5 thread wake_nearby_drones( var_5.origin, 128 );
                    break;
                }
                else
                {

                }
            }
        }

        wait 0.5;
    }
}

wake_nearby_drones( var_0, var_1 )
{
    var_2 = sortbydistance( level.drones["axis"].array, var_0 );
    var_3 = getaiarray().size;
    var_4 = 28 - var_3;
    var_5 = var_1 * var_1;
    var_6 = 0;

    for ( var_7 = 0; var_6 < var_5 && var_4 > 0 && var_7 < var_2.size; var_4-- )
    {
        var_6 = lengthsquared( var_2[var_7].origin - var_0 );
        var_2[var_7].dist_ratio_hitguy = var_6 / var_5 * 100;
        var_7++;
    }

    thread swap_drones_attack_player( var_2, var_7 );
    level.always_wake_drones = 1;
    var_8 = 0;

    if ( !isdefined( level.always_wake_drones ) )
    {
        level.always_wake_drones = 1;
        var_9 = [];

        foreach ( var_11 in level.drones["axis"].array )
        {
            if ( isdefined( var_11.script_parameters ) && var_11.script_parameters == "always_wakeup" )
                var_9[var_9.size] = var_11;
        }

        if ( var_9.size )
            thread swap_drones_attack_player( var_9, var_9.size );
    }
}

swap_drones_attack_player( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_3 = var_0[var_2];

        if ( isdefined( var_3 ) )
        {
            var_4 = var_3.dist_ratio_hitguy;

            if ( isdefined( var_3.in_combat_zone ) && var_3.in_combat_zone )
            {
                var_4 = 90;

                if ( self == var_3 )
                    var_4 = 50;
            }

            if ( randomfloat( 100 ) < var_4 )
                continue;

            var_5 = var_3.group_map;
            var_6 = maps\_utility::swap_drone_to_ai( var_3 );

            if ( isdefined( var_6 ) )
            {
                if ( isdefined( var_5 ) && isdefined( level.converts[var_5] ) )
                    level.converts[var_5][level.converts[var_5].size] = var_6;

                thread reset_ai_from_drone( var_6 );
            }
        }
    }
}

reset_ai_from_drone( var_0 )
{
    var_0.canjumppath = 1;
    var_0 notify( "stop_going_to_node" );
    var_0.goalradius = 256;
    var_0 setgoalpos( var_0.origin );
    var_0 maps\_utility::set_favoriteenemy( level.player );
}

sniper_combat_setup()
{
    common_scripts\utility::flag_wait( "player_at_meetup" );
    thread maps\df_baghdad_snipers::handle_sniper_turrets();
    level notify( "player_at_meetup" );
    level.allies[0].ignoreall = 0;
    level.allies[1].ignoreall = 0;
    thread check_trigger_flagset( "trig_allies_frontline2" );
    thread check_trigger_flagset( "trig_allies_frontline3" );
    thread check_trigger_flagset( "trig_intro_colors_street2" );
    thread tower_combat_wave3();
    thread tower_combat_wave4();
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "allies_intro_towerheli2" );
    var_0 thread single_heli_tower( "towerheli2_spot" );
    level.wave1 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "sniper_setup_post_intro", 1 );
    thread initial_enemies_wave1();

    foreach ( var_2 in level.wave1 )
    {
        var_2.canjumppath = 1;
        var_2 thread wait_for_cleanup();
    }

    maps\_utility::autosave_by_name_silent( "wave1initial" );
}

cleanup_on_flag()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "flag_allies_frontline2" );

    if ( isdefined( self ) && isalive( self ) )
        self kill();
}

switch_rpg_weapon()
{
    if ( isdefined( self ) && isalive( self ) )
        maps\_utility::forceuseweapon( "bagh_mahem_cheaptrail" );
}

initial_enemies_wave1()
{
    common_scripts\utility::flag_wait( "flag_spawn_wave1b" );
    level.introwave1 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "sniper_setup_post_introwave1", 1 );

    foreach ( var_1 in level.introwave1 )
    {
        if ( isalive( var_1 ) )
        {
            var_1.canjumppath = 3;
            var_1 thread wait_for_cleanup();
        }
    }

    var_3 = common_scripts\utility::array_combine( level.wave1, level.introwave1 );
    maps\df_baghdad_barracks_utility::ai_array_killcount_flag_set( var_3, int( var_3.size * 0.6 ), "flag_allies_frontline2" );
}

wait_for_cleanup()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "snipers_finished" );

    if ( isdefined( self ) && isalive( self ) )
        self delete();
}

guy_can_jump()
{
    self.canjumppath = 2;
}

start_drone_spawns()
{
    var_0 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "drone_wave1", 1 );

    foreach ( var_2 in var_0 )
        var_2 thread delete_path_end();
}

spawn_wave1b()
{
    common_scripts\utility::flag_wait( "flag_spawn_wave1b" );
    thread start_drone_spawns();
}

tower_combat_wave3()
{
    common_scripts\utility::flag_wait( "flag_allies_frontline2" );
    thread maps\df_baghdad_barracks_utility::retreat_from_vol_to_vol( "vol_allies_frontline2", "vol_allies_frontline3" );
    thread maps\df_baghdad_barracks_utility::retreat_from_vol_to_vol( "vol_left_enemies2", "goal_front_snipers" );
    maps\_utility::delaythread( 0.5, maps\df_baghdad_barracks_utility::retreat_from_vol_to_vol, "vol_post_introwave1", "vol_allies_frontline3" );
    maps\_utility::delaythread( 15, maps\df_baghdad_barracks_utility::retreat_from_vol_to_vol, "vol_allies_frontline2b", "vol_allies_frontline3" );
    maps\_utility::activate_trigger_with_targetname( "allies_shift_front1" );
    var_0 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "sniper_setup_post_intro_fl3", 1 );

    foreach ( var_2 in var_0 )
    {
        if ( isalive( var_2 ) )
        {
            var_2 setthreatbiasgroup( "front1_allies" );
            var_2 thread wait_for_cleanup();
            var_2.canjumppath = 1;
        }
    }

    maps\df_baghdad_barracks_utility::ai_array_killcount_flag_set( var_0, var_0.size, "flag_allies_frontline3" );
    waitframe();
    maps\_utility::autosave_by_name_silent( "wave3save" );
}

tower_combat_wave4()
{
    common_scripts\utility::flag_wait( "flag_allies_frontline3" );
    maps\_utility::activate_trigger_with_targetname( "trig_allies_frontline3" );
    level notify( "stop_fl3_infinite" );
    thread move_allies_to_upper();
    thread maps\df_baghdad_barracks_utility::retreat_from_vol_to_vol( "vol_allies_frontline3", "goal_front_snipers" );
    waitframe();
    maps\_utility::autosave_by_name_silent( "wave4save" );
}

move_allies_to_upper()
{
    common_scripts\utility::flag_wait( "player_near_tower" );
    maps\_utility::activate_trigger_with_targetname( "trig_color_allies_to_platform" );
    waitframe();
    maps\_utility::autosave_by_name_silent( "wavecompleted" );
}

check_trigger_flagset( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    var_1 waittill( "trigger" );

    if ( isdefined( var_1.script_flag_set ) )
        common_scripts\utility::flag_set( var_1.script_flag_set );
}

delete_path_end()
{
    self waittill( "reached_path_end" );

    if ( isdefined( self ) )
        self delete();
}
