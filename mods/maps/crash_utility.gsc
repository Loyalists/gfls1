// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

setup_player()
{
    var_0 = level.start_point + "_player_start";
    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );

    if ( isdefined( var_1 ) )
    {
        level.player setorigin( var_1.origin );

        if ( isdefined( var_1.angles ) )
            level.player setangles( var_1.angles );
        else
            iprintlnbold( "Your script_struct " + level.start_point + "_start has no angles! Set some." );
    }
    else
    {

    }
}

setup_allies()
{
    level.cormack = spawn_ally( "cormack" );
    level.cormack.canjumppath = 1;

    // if ( level.start_point == "skyjack" || level.start_point == "crash_site" )
    //     level.cormack setmodel( "body_hero_cormack_sentinel_halo_jetpack" );

    if ( level.start_point != "skyjack" && level.start_point != "crash_site" )
    {
        level.ilana = spawn_ally( "ilana" );
        level.ilana.canjumppath = 1;
        level.ilana.animname = "ilana";
    }

    if ( level.start_point == "vtol_takedown" || level.start_point == "avalanche" )
    {
        level.gideon = spawn_ally( "gideon" );
        level.gideon.canjumppath = 1;
        level.gideon.animname = "gideon";
    }
}

spawn_ally( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        var_2 = var_1;
    else
        var_2 = level.start_point + "_" + var_0;

    var_3 = spawn_ally_at_struct( var_0, var_2 );

    if ( !isdefined( var_3 ) )
        return undefined;

    var_3 maps\_utility::make_hero();

    if ( !isdefined( var_3.magic_bullet_shield ) )
        var_3 thread maps\_utility::magic_bullet_shield();

    var_3.animname = var_0;

    if ( var_0 != "cormack" )
        var_3 thread maps\crash_fx::cold_breath();

    return var_3;
}

spawn_ally_at_struct( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_3 = common_scripts\utility::getstruct( var_1, "targetname" );

    if ( isdefined( var_2 ) && isdefined( var_3 ) )
    {
        var_2.origin = var_3.origin;

        if ( isdefined( var_3.angles ) )
            var_2.angles = var_3.angles;

        var_4 = var_2 maps\_utility::spawn_ai( 1 );
        return var_4;
    }

    if ( isdefined( var_2 ) )
    {
        var_4 = var_2 maps\_utility::spawn_ai( 1 );
        iprintlnbold( "Add a script struct called: " + var_1 + " to spawn ally in the correct location." );
        var_4 teleport( level.player.origin, level.player.angles );
        return var_4;
    }

    iprintlnbold( "Failed to spawn " + var_0 + ".  No spawner exists." );
    return undefined;
}

spawn_enemy_array_at_structs( var_0, var_1 )
{
    var_2 = getentarray( var_0, "targetname" );
    var_3 = common_scripts\utility::getstructarray( var_1, "targetname" );
    var_4 = [];

    if ( isdefined( var_2[0] ) && isdefined( var_3[0] ) )
    {
        for ( var_5 = 0; var_5 < var_2.size; var_5++ )
        {
            var_2[var_5].origin = var_3[var_5].origin;

            if ( isdefined( var_3[var_5].angles ) )
                var_2[var_5].angles = var_3[var_5].angles;

            var_4[var_5] = var_2[var_5] maps\_utility::spawn_ai( 1 );
            common_scripts\utility::add_to_array( var_4, var_4[var_5] );
        }

        return var_4;
    }

    if ( isdefined( var_2[0] ) )
    {
        iprintlnbold( "Failed to spawn " + var_0 + ".  A spawner exists but there is no struct." );
        return undefined;
    }
    else
    {
        iprintlnbold( "Failed to spawn " + var_0 + ".  No spawners or structs exists." );
        return undefined;
    }
}

_hint_stick_update_string( var_0, var_1 )
{
    var_2 = var_1 + var_0;
    var_3 = level.trigger_hint_func[var_2];
    level.hint_breakfunc = var_3;
}

_hint_stick_update_breakfunc( var_0, var_1 )
{
    var_2 = var_1 + var_0;
    var_3 = level.trigger_hint_string[var_2];
    level.current_hint settext( var_3 );
}

hint_update_config_change( var_0 )
{
    level notify( "hint_change_config" );
    level endon( "hint_change_config" );
    var_1 = undefined;

    if ( level.player common_scripts\utility::is_player_gamepad_enabled() )
        var_1 = "_gamepad";
    else
        var_1 = "_keyboard";

    while ( isdefined( level.current_hint ) )
    {
        if ( level.player common_scripts\utility::is_player_gamepad_enabled() )
            var_2 = "_gamepad";
        else
            var_2 = "_keyboard";

        if ( var_2 != var_1 )
        {
            var_1 = var_2;
            _hint_stick_update_string( var_1, var_0 );
            _hint_stick_update_breakfunc( var_1, var_0 );
        }

        waitframe();
    }
}

ai_array_killcount_flag_set( var_0, var_1, var_2, var_3 )
{
    maps\_utility::waittill_dead_or_dying( var_0, var_1, var_3 );
    common_scripts\utility::flag_set( var_2 );
}

temp_dialogue( var_0, var_1, var_2 )
{
    level notify( "temp_dialogue", var_0, var_1, var_2 );
    level endon( "temp_dialogue" );

    if ( !isdefined( var_2 ) )
        var_2 = 4;

    if ( isdefined( level.tmp_subtitle ) )
    {
        level.tmp_subtitle destroy();
        level.tmp_subtitle = undefined;
    }

    level.tmp_subtitle = newhudelem();
    level.tmp_subtitle.x = 0;
    level.tmp_subtitle.y = -64;
    level.tmp_subtitle settext( "^2" + var_0 + ": ^7" + var_1 );
    level.tmp_subtitle.fontscale = 1.46;
    level.tmp_subtitle.alignx = "center";
    level.tmp_subtitle.aligny = "middle";
    level.tmp_subtitle.horzalign = "center";
    level.tmp_subtitle.vertalign = "bottom";
    level.tmp_subtitle.sort = 1;
    wait(var_2);
    thread temp_dialogue_fade();
}

temp_dialogue_fade()
{
    level endon( "temp_dialogue" );

    for ( var_0 = 1.0; var_0 > 0.0; var_0 -= 0.1 )
    {
        level.tmp_subtitle.alpha = var_0;
        wait 0.05;
    }

    level.tmp_subtitle destroy();
}

disable_awareness()
{
    self.ignoreall = 1;
    self.dontmelee = 1;
    self.ignoresuppression = 1;
    self.suppressionwait_old = self.suppressionwait;
    self.suppressionwait = 0;
    maps\_utility::disable_surprise();
    self.ignorerandombulletdamage = 1;
    maps\_utility::disable_bulletwhizbyreaction();
    maps\_utility::disable_pain();
    self.grenadeawareness = 0;
    self.ignoreme = 1;
    maps\_utility::enable_dontevershoot();
    self.disablefriendlyfirereaction = 1;
    self.dodangerreact = 0;
}

enable_awareness()
{
    self.ignoreall = 0;
    self.dontmelee = undefined;
    self.ignoresuppression = 0;
    self.suppressionwait = self.suppressionwait_old;
    self.suppressionwait_old = undefined;
    maps\_utility::enable_surprise();
    self.ignorerandombulletdamage = 0;
    maps\_utility::enable_bulletwhizbyreaction();
    maps\_utility::enable_pain();
    self.grenadeawareness = 1;
    self.ignoreme = 0;
    maps\_utility::disable_dontevershoot();
    self.disablefriendlyfirereaction = undefined;
    self.dodangerreact = 1;
}

equip_microwave_grenade()
{
    self.grenadeweapon = "microwave_grenade";
    self.grenadeammo = 2;
}

cormack_helmet_open( var_0 )
{
    var_0 thread set_helmet_open();
    var_0 notify( "stop personal effect" );
    var_0 thread maps\crash_fx::cold_breath();
}

cormack_helmet_close( var_0 )
{
    var_0 thread set_helmet_closed();
    var_0 notify( "stop personal effect" );
}

#using_animtree("generic_human");

set_helmet_open( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.2;

    self setanimknobrestart( %sentinel_halo_helmet_open, 1, var_0 );
    self.helmet_open = 1;
    wait 0.25;
}

set_helmet_closed( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.2;

    self setanimrestart( %sentinel_halo_helmet_close, 1, var_0 );
    self.helmet_open = 0;
    wait 0.75;
}

clear_additive_helmet_anim( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.5;

    self clearanim( %s1_halo_helmet, 0 );
}

player_exo_enable()
{
    level.player thread maps\_player_exo::player_exo_activate();
}

player_exo_disable()
{
    level.player thread maps\_player_exo::player_exo_deactivate();
}

exo_temp_high_altitude()
{
    level endon( "skyjack_done" );
    wait 1;
    var_0 = 19.5;
    var_1 = 10;

    for (;;)
    {
        var_2 = 0;
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_reheat, var_0 );

        while ( var_2 <= var_0 )
        {
            wait 0.05;
            var_2 += 0.05;
        }

        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, var_1 );
        level.player thread maps\crash_exo_temperature::activate_heater();

        for ( var_2 = 0; var_2 <= var_1; var_2 += 0.05 )
            wait 0.05;

        level.player thread maps\crash_exo_temperature::deactivate_heater();
    }
}

exo_temp_outdoor()
{
    level endon( "moved_indoors" );
    var_0 = 39;
    var_1 = 10;

    for (;;)
    {
        var_2 = 0;
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_reheat, var_0 );

        while ( var_2 <= var_0 )
        {
            wait 0.05;
            var_2 += 0.05;
        }

        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, var_1 );
        level.player thread maps\crash_exo_temperature::activate_heater();

        for ( var_2 = 0; var_2 <= var_1; var_2 += 0.05 )
            wait 0.05;

        level.player thread maps\crash_exo_temperature::deactivate_heater();
    }
}

exo_temp_narrow_cave()
{
    level endon( "player_starting_uw_breach" );
    level endon( "combat_cave_done" );
    level.player thread maps\crash_exo_temperature::set_external_temperature_over_time( -3.2, 90 );

    for (;;)
    {
        while ( !isdefined( level.player.swimming ) )
        {
            if ( common_scripts\utility::flag( "narrow_cave_underwater" ) )
            {
                level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( 85, 2 );
                level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 2 );
                common_scripts\utility::flag_clear( "narrow_cave_underwater" );
            }

            wait 0.05;
        }

        while ( isdefined( level.player.swimming ) )
        {
            if ( level.player.swimming == "underwater" )
            {
                if ( !common_scripts\utility::flag( "narrow_cave_underwater" ) )
                {
                    level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( 65, 8 );
                    level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 92.5, 8 );
                    common_scripts\utility::flag_set( "narrow_cave_underwater" );
                }
            }

            wait 0.05;
        }
    }
}

handle_objective_marker_skyjack( var_0, var_1, var_2 )
{
    var_3 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 200;

    var_4 = getent( "skyjack_charge_trigger", "targetname" );
    var_5 = var_0 maps\_shg_utility::hint_button_position( "x", var_0.origin, undefined, var_2, undefined, var_4 );
    common_scripts\utility::flag_wait( var_1 );
    var_5 maps\_shg_utility::hint_button_clear();
}

handle_objective_marker( var_0, var_1, var_2, var_3 )
{
    var_4 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 200;

    if ( isdefined( var_3 ) )
    {
        var_5 = getent( var_3, "targetname" );
        var_6 = var_0 maps\_shg_utility::hint_button_position( "x", var_0.origin, undefined, var_2, undefined, var_5 );
    }
    else
        var_6 = var_0 maps\_shg_utility::hint_button_trigger( "x", var_2 );

    common_scripts\utility::flag_wait( var_1 );
    var_6 maps\_shg_utility::hint_button_clear();
}

handle_objective_marker_movable( var_0, var_1, var_2 )
{
    var_3 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 200;

    var_4 = getent( "end_cargo_trigger", "targetname" );
    var_5 = var_0 maps\_shg_utility::hint_button_tag( "x", "tag_origin", undefined, var_2, undefined, var_4 );
    common_scripts\utility::flag_wait( var_1 );

    if ( isdefined( var_5 ) )
        var_5 maps\_shg_utility::hint_button_clear();
}

nag_until_flag( var_0, var_1, var_2, var_3, var_4 )
{
    if ( common_scripts\utility::flag( var_1 ) )
        return;

    var_5 = -1;
    var_6 = var_2;

    for ( var_7 = var_3; !common_scripts\utility::flag( var_1 ); var_3 = clamp( var_3, var_7, var_7 + var_4 * 3 ) )
    {
        var_8 = randomfloatrange( var_2, var_3 );
        wait(var_8);
        var_9 = randomint( var_0.size );

        if ( var_9 == var_5 )
        {
            var_9++;

            if ( var_9 >= var_0.size )
                var_9 = 0;
        }

        var_10 = var_0[var_9];

        if ( common_scripts\utility::flag( var_1 ) )
            break;

        thread maps\_utility::smart_radio_dialogue( var_10 );
        var_5 = var_9;
        var_2 += var_4;
        var_2 = clamp( var_2, var_6, var_6 + var_4 * 3 );
        var_3 += var_4;
    }
}

stop_walk_and_clear_dialogue()
{
    level.cormack maps\_utility::clear_run_anim();
    level.ilana maps\_utility::clear_run_anim();
    level notify( "temp_dialogue" );

    if ( isdefined( level.tmp_subtitle ) )
        temp_dialogue_fade();
}

temp_friendly_squad_casual_walk()
{
    iprintln( "casual walk on" );
    level.cormack.animname = "cormack";
    level.ilana.animname = "ilana";
    level.cormack maps\_utility::set_run_anim( "casual_walk" );
    level.cormack maps\_utility::disable_arrivals();
    level.cormack maps\_utility::disable_exits();
    level.ilana maps\_utility::set_run_anim( "casual_walk" );
    level.ilana maps\_utility::disable_arrivals();
    level.ilana maps\_utility::disable_exits();
}

set_main_vol_and_retreat_vol( var_0, var_1, var_2, var_3 )
{
    move_wave( var_0, var_1 );
    thread retreat_volume( var_0, var_2, var_3 );
}

retreat_volume( var_0, var_1, var_2 )
{
    var_3 = maps\_utility::get_living_ai_array( var_0, "script_noteworthy" );
    maps\_utility::waittill_dead_or_dying( var_3, var_2 );
    var_3 = maps\_utility::get_living_ai_array( var_0, "script_noteworthy" );

    if ( isstring( var_1 ) )
        var_1 = getent( var_1, "targetname" );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
        var_3[var_4] setgoalvolumeauto( var_1 );
}

retreat_volume_and_set_flag( var_0, var_1, var_2, var_3 )
{
    retreat_volume( var_0, var_1, var_2 );

    if ( !isdefined( var_3 ) )
        return;

    if ( common_scripts\utility::flag_exist( var_3 ) )
        common_scripts\utility::flag_set( var_3 );
    else
    {

    }
}

move_wave( var_0, var_1 )
{
    var_2 = maps\_utility::get_living_ai_array( var_0, "script_noteworthy" );
    var_3 = getent( var_1, "targetname" );

    for ( var_4 = 0; var_4 < var_2.size; var_4++ )
        var_2[var_4] setgoalvolumeauto( var_3 );
}

move_wave_random( var_0, var_1 )
{
    var_2 = maps\_utility::get_living_ai_array( var_0, "script_noteworthy" );
    var_3 = getent( var_1, "targetname" );

    for ( var_4 = 0; var_4 < var_2.size; var_4++ )
    {
        var_2[var_4] setgoalvolumeauto( var_3 );
        var_2[var_4].pathrandompercent = 100;
    }
}

enemy_drop_traversal( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_3 = var_2 maps\_utility::spawn_ai( 1 );
    var_4 = common_scripts\utility::getstruct( var_1, "targetname" );
    var_3.animname = "enemy_drop";
    var_3.canjumppath = 1;
    var_3.ignoresuppression = 1;
    var_3 maps\_utility::set_allowdeath( 1 );
    var_4 thread maps\_anim::anim_single_solo( var_3, "drop_512" );
    var_3 thread enemy_drop_fx();
    return var_3;
}

enemy_drop_fx()
{
    self endon( "death" );
    wait 1.16;
    playfxontag( level._effect["crash_goliath_foot"], self, "tag_origin" );
}

cleanup_enemies( var_0, var_1 )
{
    var_2 = maps\_utility::get_living_ai_array( var_0, "script_noteworthy" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    foreach ( var_4 in var_2 )
    {
        if ( maps\_utility::player_can_see_ai( var_4 ) )
        {
            if ( var_1 )
                var_4 delete();

            continue;
        }

        var_4 delete();
    }
}

cleanupweaponsonground()
{
    var_0 = getentarray();

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.classname ) && issubstr( var_2.classname, "weapon_" ) )
            var_2 delete();
    }
}

ally_advance_ahead_upon_killing_group( var_0, var_1, var_2, var_3, var_4 )
{
    maps\_utility::waittill_dead( var_0, var_1 );
    iprintln( "dead moving up" );
    var_5 = undefined;

    if ( isdefined( var_2 ) )
    {
        var_5 = getent( var_2, "targetname" );

        if ( isdefined( var_5 ) )
        {
            maps\_utility::activate_trigger_with_targetname( var_2 );
            return;
        }
        else
            iprintln( "trig not available" );
    }

    if ( isdefined( var_3 ) )
    {
        var_5 = getent( var_2, "targetname" );

        if ( isdefined( var_5 ) )
        {
            maps\_utility::activate_trigger_with_targetname( var_2 );
            return;
        }
    }

    if ( isdefined( var_4 ) )
    {
        var_5 = getent( var_2, "targetname" );

        if ( isdefined( var_5 ) )
        {
            maps\_utility::activate_trigger_with_targetname( var_2 );
            return;
        }
    }
}

kill_enemies( var_0 )
{
    var_1 = maps\_utility::get_living_ai_array( var_0, "script_noteworthy" );

    foreach ( var_3 in var_1 )
        var_3 kill();
}

spawn_wave_stagger( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_3 = [];
    var_4 = getentarray( var_0, "targetname" );

    for ( var_5 = 0; var_5 < var_4.size; var_5++ )
    {
        var_3[var_5] = var_4[var_5] maps\_utility::spawn_ai( 1 );
        wait(var_1);
    }

    return var_3;
}

warbird_shooting_think( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    level.player endon( "death" );
    self endon( "death" );
    self.mgturret[0] setmode( "manual" );
    self.mgturret[1] setmode( "manual" );

    if ( !maps\_utility::ent_flag_exist( "fire_turrets" ) )
        maps\_utility::ent_flag_init( "fire_turrets" );

    maps\_utility::ent_flag_set( "fire_turrets" );
    thread warbird_fire_init_monitor();

    for (;;)
    {
        self waittill( "warbird_fire" );

        if ( !isdefined( var_3 ) )
        {
            thread warbird_fire_init( var_0, var_1, var_2 );
            continue;
        }

        if ( !isdefined( var_4 ) )
        {
            thread warbird_ground_fire_init( var_0, var_1, var_2 );
            continue;
        }

        thread warbird_ground_fire_no_enemy_init( var_0, var_1, var_2, var_5 );
    }
}

warbird_fire_init( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3 = self.mgturret[0];
    var_4 = self.mgturret[1];

    if ( !isdefined( var_2 ) )
        var_2 = 1.25;

    while ( maps\_utility::ent_flag( "fire_turrets" ) )
    {
        var_5 = getaiarray( "allies" );

        if ( !maps\_utility::ent_flag_exist( "dont_shoot_player" ) || !maps\_utility::ent_flag( "dont_shoot_player" ) )
        {
            var_6 = 90;

            if ( randomint( 100 ) <= var_6 )
                var_5 = common_scripts\utility::array_add( var_5, level.player );
        }

        var_7 = [];

        foreach ( var_9 in var_5 )
        {
            if ( isdefined( var_9.ignoreme ) && var_9.ignoreme )
                continue;
            else
                var_7[var_7.size] = var_9;
        }

        var_7 = sortbydistance( var_7, self.origin );
        var_11 = undefined;

        foreach ( var_9 in var_7 )
        {
            if ( !isdefined( var_9 ) )
                continue;

            if ( !isalive( var_9 ) )
                continue;

            if ( isdefined( var_0 ) && var_0 )
            {
                var_13 = self.mgturret[0] gettagorigin( "tag_flash" );
                var_14 = var_9 geteye();
                var_15 = vectornormalize( var_14 - var_13 );
                var_16 = var_14 + var_15 * 20;

                if ( !sighttracepassed( var_16, var_14, 0, var_9, self.mgturret[0] ) )
                    continue;
            }

            var_11 = var_9;
            break;
        }

        if ( isdefined( var_11 ) )
        {
            var_3 settargetentity( var_11 );
            var_4 settargetentity( var_11 );
            var_3 turretfireenable();
            var_4 turretfireenable();
            var_3 startfiring();
            var_4 startfiring();
            warbird_wait_for_fire_target_done( var_11, var_0, var_1 );
            var_3 cleartargetentity();
            var_4 cleartargetentity();
            var_3 turretfiredisable();
            var_4 turretfiredisable();
        }

        wait(var_2);
    }

    var_3 turretfiredisable();
    var_4 turretfiredisable();
}

warbird_ground_fire_init( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3 = self.mgturret[0];
    var_4 = self.mgturret[1];

    if ( !isdefined( var_2 ) )
        var_2 = 1.25;

    while ( maps\_utility::ent_flag( "fire_turrets" ) )
    {
        var_5 = common_scripts\utility::getstructarray( "warbird_fire_targets", "targetname" );
        var_5 = sortbydistance( var_5, self.origin );
        var_6 = getaiarray( "allies" );

        if ( !maps\_utility::ent_flag_exist( "dont_shoot_player" ) || !maps\_utility::ent_flag( "dont_shoot_player" ) )
        {
            var_7 = 90;

            if ( randomint( 100 ) <= var_7 )
                var_6 = common_scripts\utility::array_add( var_6, level.player );
        }

        var_8 = [];

        foreach ( var_10 in var_6 )
        {
            if ( isdefined( var_10.ignoreme ) && var_10.ignoreme )
                continue;
            else
                var_8[var_8.size] = var_10;
        }

        var_8 = sortbydistance( var_8, self.origin );
        var_12 = undefined;

        foreach ( var_10 in var_8 )
        {
            if ( !isdefined( var_10 ) )
                continue;

            if ( !isalive( var_10 ) )
                continue;

            if ( isdefined( var_0 ) && var_0 )
            {
                var_14 = self.mgturret[0] gettagorigin( "tag_flash" );
                var_15 = var_10 geteye();
                var_16 = vectornormalize( var_15 - var_14 );
                var_17 = var_15 + var_16 * 20;

                if ( !sighttracepassed( var_17, var_15, 0, var_10, self.mgturret[0] ) )
                    continue;
            }

            var_12 = var_10;
            break;
        }

        if ( isdefined( var_12 ) )
        {
            var_19 = var_5[0] common_scripts\utility::spawn_tag_origin();
            var_3 settargetentity( var_19 );
            var_4 settargetentity( var_19 );
            var_3 turretfireenable();
            var_4 turretfireenable();
            var_3 startfiring();
            var_4 startfiring();
            var_20 = distance2d( var_19.origin, var_12.origin );
            var_21 = var_20 / 275;
            var_21 = maps\_utility::round_float( var_21, 2 );
            var_22 = 0;

            while ( var_22 < var_21 )
            {
                var_19 moveto( var_12.origin + ( 0, 0, 16 ), var_21 - var_22 );
                var_22 += 0.05;
                wait 0.05;
            }

            var_3 settargetentity( var_12 );
            var_4 settargetentity( var_12 );
            warbird_wait_for_fire_target_done( var_12, var_0, var_1 );
            var_3 cleartargetentity();
            var_4 cleartargetentity();
            var_3 turretfiredisable();
            var_4 turretfiredisable();
            var_19 delete();
        }

        wait(var_2);
    }

    var_3 turretfiredisable();
    var_4 turretfiredisable();
}

warbird_ground_fire_no_enemy_init( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_4 = self.mgturret[0];
    var_5 = self.mgturret[1];

    if ( !isdefined( var_2 ) )
        var_2 = 1.25;

    var_6 = common_scripts\utility::getstructarray( "warbird_fire_targets", "targetname" );
    var_6 = sortbydistance( var_6, self.origin );
    var_7 = var_6[0] common_scripts\utility::spawn_tag_origin();

    if ( isdefined( var_6[0].target ) )
        var_8 = common_scripts\utility::getstruct( var_6[0].target, "targetname" );
    else
    {
        var_8 = var_6[0] common_scripts\utility::spawn_tag_origin();
        var_9 = anglestoforward( self.angles );
        var_8.origin += ( var_9[0] * 500, var_9[1] * 500, 0 );
    }

    var_4 settargetentity( var_7 );
    var_5 settargetentity( var_7 );
    var_4 turretfireenable();
    var_5 turretfireenable();
    var_4 startfiring();
    var_5 startfiring();

    if ( !isdefined( var_3 ) )
        var_3 = 275;

    var_10 = distance2d( var_7.origin, var_8.origin );
    var_11 = var_10 / var_3;
    var_11 = maps\_utility::round_float( var_11, 2 );
    var_12 = 0;

    while ( var_12 < var_11 )
    {
        var_7 moveto( var_8.origin, var_11 - var_12 );
        var_12 += 0.05;
        wait 0.05;
    }

    if ( !maps\_utility::ent_flag_exist( "turret_hit_target" ) )
        maps\_utility::ent_flag_init( "turret_hit_target" );

    maps\_utility::ent_flag_set( "turret_hit_target" );
    var_4 cleartargetentity();
    var_5 cleartargetentity();
    var_4 turretfiredisable();
    var_5 turretfiredisable();
    var_7 delete();
}

warbird_fire_init_monitor()
{
    self endon( "death" );
    self waittill( "warbird_stop_firing" );
    maps\_utility::ent_flag_clear( "fire_turrets" );
}

warbird_wait_for_fire_target_done( var_0, var_1, var_2 )
{
    var_0 endon( "death" );

    if ( !maps\_utility::ent_flag( "fire_turrets" ) )
        return;

    self endon( "fire_turrets" );

    if ( !isdefined( var_2 ) )
    {
        if ( var_0 == level.player )
            var_2 = 0.6;
        else
            var_2 = 3;
    }

    var_3 = 0;

    while ( var_3 < var_2 )
    {
        if ( isdefined( var_1 ) && var_1 )
        {
            var_4 = self.mgturret[0] gettagorigin( "tag_flash" );
            var_5 = var_0 geteye();
            var_6 = vectornormalize( var_5 - var_4 );
            var_7 = var_4 + var_6 * 20;

            if ( !sighttracepassed( var_7, var_5, 0, var_0, self.mgturret[0] ) )
                return;
        }

        var_3 += 0.3;
        wait 0.3;
    }
}

disable_exo_melee()
{
    maps\_player_exo::player_exo_remove_single( "exo_melee" );
}

enable_exo_melee()
{
    maps\_player_exo::player_exo_add_single( "exo_melee" );
}

mech_fire_rockets_special( var_0 )
{
    self endon( "death" );
    var_1 = 48;
    var_2 = 64;
    var_3 = 3;
    var_4 = 6;
    var_5 = 100;
    var_6 = 24;
    var_7 = 0.1;
    var_8 = 0.4;
    var_9 = 12;
    var_10 = "tag_rocket";
    var_11 = 0.2;
    var_12 = randomintrange( var_3 + 1, var_4 + 1 );
    var_13 = 20;
    var_14 = 20;
    var_15 = 16;

    for ( var_16 = 1; var_16 < var_12; var_16++ )
    {
        var_17 = var_10 + var_16;
        var_18 = self gettagorigin( var_17 );
        var_19 = self gettagangles( var_17 );
        var_20 = anglestoforward( var_19 );
        var_20 = vectornormalize( var_20 );
        var_21 = randomintrange( -1 * var_13, var_13 );
        var_22 = randomintrange( -1 * var_14, var_14 );
        var_23 = randomintrange( -1 * var_15, var_15 );
        var_24 = var_18 + var_20 * var_6;
        var_25 = var_18 + ( var_20 * var_5 + ( var_21, var_22, var_23 ) );
        var_26 = magicbullet( "mech_rocket_deploy", var_24, var_25 );
        playfx( level.mech_fx["rocket_muzzle_flash"], var_18, var_20, ( 0, 0, 1 ) );

        if ( isdefined( var_26 ) )
        {
            var_27 = randomfloatrange( var_7, var_8 );
            var_26 thread maps\_mech::mech_rocket_deploy_projectile_think( self, var_0, var_27 );
        }

        wait 0.05;
    }

    wait 0.25;
}

fly_in_hud()
{
    setsaveddvar( "cg_cinematicfullscreen", "1" );
    setsaveddvar( "cg_cinematicCanPause", "1" );
    level.player thread fly_in_hud_overlay( undefined, undefined, undefined, 1, 0, 0 );
    cinematicingameloopresident( "crash_jumpHUD_loop" );
    common_scripts\utility::flag_wait( "start_hud" );
    cinematicingame( "crash_jumpHUD", 0, 1.0, 1 );
    wait 1;
    level.player thread thermal_with_nvg();
    level.player setclutforplayer( "clut_crash_hud", 0 );
    level.player lightsetforplayer( "crash_skyjack" );
    maps\_utility::vision_set_fog_changes( "crash_skyjack", 0 );
    waitframe();

    if ( level.nextgen )
        level.player notify( "sonar_vision" );

    wait 29.5;
    level.player notify( "sonar_vision" );
    killfxontag( level._effect["fx_crash_hud_flare"], level.crashing_plane, "body_animate_jnt" );
    level.crashing_plane hudoutlinedisable();
    level.player setclutforplayer( "clut_crash_crash_site", 0 );
    maps\_utility::vision_set_fog_changes( "crash_crash_site_cinematic", 0 );
    level.player lightsetforplayer( "crash_crash_site" );
    waitframe();
    level.player notify( "flag_end_sonar_vision" );
    wait 1.25;
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    setsaveddvar( "cg_cinematicCanPause", "0" );
}

fly_in_hud_overlay( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = newclienthudelem( self );
    var_6.x = var_4;
    var_6.y = var_5;
    var_6 setshader( "jump_hud_vignette", 640, 480 );
    var_6.alignx = "left";
    var_6.aligny = "top";
    var_6.sort = 1;
    var_6.foreground = 0;
    var_6.horzalign = "fullscreen";
    var_6.vertalign = "fullscreen";
    var_6.alpha = 1;
    var_7 = 0;
    level.player waittill( "flag_end_sonar_vision" );
    var_6.alpha = 0;
    var_6 destroy();
}

mark_enemies()
{
    level.player endon( "sonar_vision_off" );
    common_scripts\utility::flag_wait( "begin_crash_site_lighting" );
    wait 3;

    for (;;)
    {
        if ( isdefined( level.crashing_plane ) )
            level.crashing_plane hudoutlineenable( 4, 0, 0 );

        wait 0.1;
    }
}

give_night_vision()
{
    level endon( "flag_end_sonar_vision" );
    level.player setweaponhudiconoverride( "actionslot4", "dpad_icon_nvg" );
    level.player notifyonplayercommand( "sonar_vision", "+actionslot 4" );
    level.player thread thermal_with_nvg();
}

is_sonar_vision_allowed()
{
    var_0 = level.player getcurrentweapon();

    if ( weaponhasthermalscope( var_0 ) && level.player playerads() > 0 )
        return 0;

    return 1;
}

disable_sonar_when_not_allowed()
{
    level.player endon( "sonar_vision_off" );

    for (;;)
    {
        if ( !is_sonar_vision_allowed() )
            break;

        waitframe();
    }

    sonar_off();
}

thermal_with_nvg()
{
    level endon( "flag_end_sonar_vision" );
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;

    if ( level.nextgen )
    {
        for (;;)
        {
            self waittill( "sonar_vision" );

            if ( !is_sonar_vision_allowed() )
                continue;

            if ( !isdefined( level.player.sonar_vision ) || !level.player.sonar_vision )
            {
                sonar_on();
                childthread disable_sonar_when_not_allowed();
                continue;
            }

            sonar_off();
        }
    }
}

sonar_save_and_set_dvars()
{
    if ( !isdefined( level.player.sonarvisionsaveddvars ) )
        level.player.sonarvisionsaveddvars = [];

    level.player.sonarvisionsaveddvars["r_hudoutlineenable"] = getdvarint( "r_hudoutlineenable", 1 );
    level.player.sonarvisionsaveddvars["r_hudoutlinepostmode"] = getdvar( "r_hudoutlinepostmode", 0 );
    level.player.sonarvisionsaveddvars["r_hudoutlinehaloblurradius"] = getdvarfloat( "r_hudoutlinehaloblurradius", 1 );
    level.player.sonarvisionsaveddvars["r_hudoutlinehalolumscale"] = getdvarfloat( "r_hudoutlinehalolumscale", 1 );
    level.player.sonarvisionsaveddvars["r_hudoutlinehalowhen"] = getdvar( "r_hudoutlinehalowhen", 1 );
    setsaveddvar( "r_hudoutlineenable", 1 );
    setsaveddvar( "r_hudoutlinepostmode", 2 );
    setsaveddvar( "r_hudoutlinehaloblurradius", 0.7 );
    setsaveddvar( "r_hudoutlinehalolumscale", 2 );
    setsaveddvar( "r_hudoutlinehalowhen", 0 );
    level.player.sonarvisionsaveddvars["r_ssrBlendScale"] = getdvarfloat( "r_ssrBlendScale", 1.0 );
    setsaveddvar( "r_ssrBlendScale", 0.0 );
}

sonar_reset_dvars()
{
    if ( isdefined( level.player.sonarvisionsaveddvars ) )
    {
        setsaveddvar( "r_hudoutlineenable", level.player.sonarvisionsaveddvars["r_hudoutlineenable"] );
        setsaveddvar( "r_hudoutlinepostmode", level.player.sonarvisionsaveddvars["r_hudoutlinepostmode"] );
        setsaveddvar( "r_hudoutlinehaloblurradius", level.player.sonarvisionsaveddvars["r_hudoutlinehaloblurradius"] );
        setsaveddvar( "r_hudoutlinehalolumscale", level.player.sonarvisionsaveddvars["r_hudoutlinehalolumscale"] );
        setsaveddvar( "r_hudoutlinehalowhen", level.player.sonarvisionsaveddvars["r_hudoutlinehalowhen"] );
        setsaveddvar( "r_ssrBlendScale", level.player.sonarvisionsaveddvars["r_ssrBlendScale"] );
    }
}

sonar_on()
{
    level.overlaysonar = create_hud_sonar_overlay( 0, 1 );
    sonar_save_and_set_dvars();
    thread mark_enemies();
    var_0 = 0.05;

    if ( level.currentgen )
        var_0 = 0;

    soundscripts\_snd::snd_message( "aud_sonar_vision_on" );
    level.player.sonar_vision = 1;
    level notify( "sonar_update" );
}

sonar_off()
{
    var_0 = 0.05;

    if ( level.currentgen )
        var_0 = 0;

    level.player lightsetoverrideenableforplayer( var_0 );
    level.player setclutoverridedisableforplayer( var_0 );
    soundscripts\_snd::snd_message( "aud_sonar_vision_off" );
    level.player.sonar_vision = 0;
    level notify( "sonar_update" );

    if ( isdefined( level.overlay ) )
        level.overlay destroy();

    if ( isdefined( level.overlaythreat ) )
        level.overlaythreat destroy();

    if ( isdefined( level.overlaysonar ) )
        level.overlaysonar destroy();

    sonar_reset_dvars();

    foreach ( var_2 in getaiarray( "axis", "allies" ) )
    {
        if ( isdefined( var_2.hudoutlineenabledbysonarvision ) )
        {
            var_2 hudoutlinedisable();
            var_2.hudoutlineenabledbysonarvision = undefined;
        }
    }

    level.player notify( "sonar_vision_off" );
}

create_hud_nvg_overlay( var_0, var_1, var_2 )
{
    var_3 = newhudelem();
    var_3.x = 0;
    var_3.y = 0;
    var_3.sort = var_1;
    var_3.horzalign = "fullscreen";
    var_3.vertalign = "fullscreen";
    var_3.alpha = var_2;
    var_3 setshader( var_0, 640, 480 );
    return var_3;
}

create_hud_sonar_overlay( var_0, var_1 )
{
    var_2 = newhudelem();
    var_2.x = 0;
    var_2.y = 0;

    if ( level.currentgen )
        var_2.color = ( 1, 0.6, 0.2 );
    else
        var_2.color = ( 0.1, 0.1, 1 );

    var_2.sort = var_0;
    var_2.horzalign = "fullscreen";
    var_2.vertalign = "fullscreen";
    var_2.alpha = var_1;
    var_2 setsonarvision( 10 );
    return var_2;
}

create_hud_threat_overlay( var_0, var_1 )
{
    var_2 = newhudelem();
    var_2.x = 0;
    var_2.y = 0;
    var_2.color = ( 1, 0.1, 0.1 );
    var_2.sort = var_0;
    var_2.horzalign = "fullscreen";
    var_2.vertalign = "fullscreen";
    var_2.alpha = var_1;
    var_2 setradarhighlight( -1 );
    return var_2;
}
