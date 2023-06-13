// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

setup_common( var_0 )
{
    setup_player( var_0 );
    spawn_allies( var_0 );
    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
    setup_objectives();
    var_1 = level.player gettacticalweapon();
    level.player takeweapon( var_1 );
    thread corpse_cleanup();
    thread start_billboard_ads();
    level.df_player_rig_name = "s1_gfl_ump45_viewbody";
    level.player_rig_spawn_function = ::df_baghdad_retrun_player_rig;
    thread monitor_fail_triggers();
    thread delay_set_fall_damage();
    common_scripts\utility::array_thread( level.allies, ::watch_hide_pack_notetracks );
    common_scripts\utility::array_thread( level.allies, ::watch_show_pack_notetracks );
    level.min_weap_clean2 = 65536;
    maps\_utility::add_global_spawn_function( "axis", ::weapon_drop_cleanup );
}

watch_death_endon( var_0, var_1 )
{
    level endon( var_1 );
    self waittill( "death" );
    wait 0.5;
    level notify( var_0 );
}

weapon_drop_cleanup()
{
    var_0 = self.classname + "_" + self.export;
    var_1 = "weap_" + var_0;
    level endon( var_0 );
    thread watch_death_endon( var_0, var_1 );
    self waittill( "weapon_dropped", var_2 );
    level notify( var_1 );

    if ( !isdefined( var_2 ) )
        return;

    var_2 endon( "death" );
    wait 3;

    while ( isdefined( var_2 ) )
    {
        var_3 = var_2.origin - level.player.origin;

        if ( lengthsquared( var_3 ) > level.min_weap_clean2 )
        {
            var_3 = vectornormalize( var_3 );
            var_4 = anglestoforward( level.player.angles );

            if ( vectordot( var_4, var_3 ) < 0.8 )
            {
                var_2 delete();
                break;
            }
        }

        wait 1;
    }
}

watch_hide_pack_notetracks()
{
    self endon( "death" );

    for (;;)
    {
        self waittillmatch( "single anim", "hide_packs" );
        self hidepart( "j_jetpack" );
    }
}

watch_show_pack_notetracks()
{
    self endon( "death" );

    for (;;)
    {
        self waittillmatch( "single anim", "show_packs" );
        self showpart( "j_jetpack" );
    }
}

delay_set_fall_damage()
{
    wait 0.5;
    var_0 = 1536;

    for (;;)
    {
        if ( getdvarint( "bg_falldamagemaxheight" ) != var_0 )
        {
            setsaveddvar( "bg_falldamageminheight", 400 );
            setsaveddvar( "bg_falldamagemaxheight", var_0 );
            level.player.bg_falldamagemaxheight_old = var_0;
            level.player.bg_falldamageminheight_old = 400;
        }

        wait 0.1;
    }
}

corpse_cleanup()
{
    var_0 = 2000;
    var_1 = 65536;
    var_2 = 500;
    level endon( "stop_baghadad_corpse_cleanup" );
    var_3 = ( 0, 0, 0 );

    for (;;)
    {
        var_4 = getcorpsearray();
        var_5 = gettime();
        var_6 = anglestoforward( level.player.angles );

        foreach ( var_8 in var_4 )
        {
            if ( !isdefined( var_8.check_time ) )
            {
                var_8.check_time = var_5 + var_0;
                continue;
            }

            if ( var_8.check_time < var_5 )
            {
                var_3 = var_8.origin - level.player.origin;

                if ( lengthsquared( var_3 ) > var_1 )
                {
                    var_3 = vectornormalize( var_3 );

                    if ( vectordot( var_6, var_3 ) < 0.8 )
                    {
                        var_8 delete();
                        continue;
                    }
                }

                var_8.check_time = var_5 + var_2;
            }
        }

        wait 0.25;
    }
}

#using_animtree("player");

df_baghdad_retrun_player_rig( var_0 )
{
    var_1 = level.df_player_rig_name;

    if ( isdefined( var_0 ) )
        var_1 = var_0;

    var_2 = spawn( "script_model", ( 0, 0, 0 ) );
    var_2.animname = "player_rig";
    var_2 useanimtree( #animtree );
    var_2 setmodel( var_1 );
    return var_2;
}

setup_player( var_0 )
{
    if ( isdefined( var_0 ) )
        var_1 = var_0 + "_start";
    else
        var_1 = level.start_point + "_start";

    var_2 = common_scripts\utility::getstruct( var_1, "targetname" );

    if ( isdefined( var_2 ) )
    {
        level.player setorigin( var_2.origin );
        level.player setangles( var_2.angles );
    }
    else
        iprintlnbold( "can't find startpoint for " + level.start_point );

    level.player.grapple["dist_max"] = 1200;
    level.player.grapple["dist_max_2d"] = 1000;
}

spawn_allies( var_0 )
{
    level.allies = [];
    level.allies[level.allies.size] = spawn_ally( "burke", var_0 );
    level.allies[level.allies.size] = spawn_ally( "ilana", var_0 );
    level.allies[level.allies.size] = spawn_ally( "ilona", var_0 );
    level.allies[0].animname = "gideon";
    level.allies[1].animname = "ilana";
    level.allies[2].animname = "ilona";
}

spawn_ally( var_0, var_1 )
{
    var_2 = undefined;

    if ( !isdefined( var_1 ) )
        var_2 = level.start_point + "_" + var_0;
    else
        var_2 = var_1 + "_" + var_0;

    var_3 = spawn_targetname_at_struct_targetname( var_0, var_2 );

    if ( !isdefined( var_3 ) )
        return undefined;

    var_3 maps\_utility::make_hero();

    if ( !isdefined( var_3.magic_bullet_shield ) )
        var_3 maps\_utility::magic_bullet_shield();

    var_3.canjumppath = 1;
    var_3 pathabilityadd( "grapple" );
    return var_3;
}

spawn_targetname_at_struct_targetname( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_3 = common_scripts\utility::getstruct( var_1, "targetname" );

    if ( isdefined( var_2 ) && isdefined( var_3 ) )
    {
        var_2.origin = var_3.origin;

        if ( isdefined( var_3.angles ) )
            var_2.angles = var_3.angles;

        var_4 = var_2 maps\_utility::spawn_ai();
        return var_4;
    }

    if ( isdefined( var_2 ) )
    {
        var_4 = var_2 maps\_utility::spawn_ai();
        iprintlnbold( "add a script struct called: " + var_1 + " to spawn him in the correct location." );
        var_4 teleport( level.player.origin, level.player.angles );
        return var_4;
    }

    iprintlnbold( "failed to spawn " + var_0 + " at " + var_1 );
    return undefined;
}

should_break_leave_mission_hint()
{
    return !common_scripts\utility::flag( "out_bounds_warn" );
}

monitor_fail_triggers()
{
    level endon( "ignore_fail_triggers" );
    childthread end_mission_out_bounds();
    var_0 = [];
    var_0[var_0.size] = "df_gid_getonpoint";
    var_0[var_0.size] = "df_nox_thisway4";
    var_0[var_0.size] = "df_gid_getbackhere";
    var_0[var_0.size] = "df_nox_getoverhere3";
    var_1 = 0;

    for (;;)
    {
        var_2 = 5;
        common_scripts\utility::flag_wait( "out_bounds_warn" );
        level.player maps\_utility::display_hint( "leave_mission" );

        while ( common_scripts\utility::flag( "out_bounds_warn" ) )
        {
            maps\_utility::smart_radio_dialogue_interrupt( var_0[var_1] );
            var_1++;

            if ( var_1 >= var_0.size )
                var_1 = 0;

            wait( var_2 );
            var_2 *= 1.5;
        }

        wait 4;
    }
}

end_mission_out_bounds()
{
    for (;;)
    {
        var_0 = common_scripts\utility::flag_wait_any_return( "out_bounds_fail", "out_bounds_fail_water" );

        if ( !common_scripts\utility::flag( "ignore_outofbounds_clip" ) )
            break;

        wait 0.05;
    }

    if ( var_0 == "out_bounds_fail_water" )
    {
        var_1 = level.player common_scripts\utility::spawn_tag_origin();
        var_1.angles = level.player getangles();
        var_2 = var_1.angles[0];

        if ( var_2 > 180 || var_2 < 0 )
            var_2 = 0;
        else
            var_2 /= 5;

        var_1.origin += ( 0, 0, var_2 );
        thread player_died_water( var_1 );
        wait 0.33;
    }

    maps\_player_death::set_deadquote( &"df_baghdad_left_mission" );
    maps\_utility::missionfailedwrapper();
}

player_died_water( var_0 )
{
    var_1 = level.player common_scripts\utility::spawn_tag_origin();
    playfx( level._effect["bagh_ambient_waterspl_lg"], var_1.origin, var_1.angles );
    var_2 = -30;

    if ( level.player getstance() != "stand" )
        var_2 = -8;

    var_3 = var_0.origin + ( 0, 0, var_2 );
    var_4 = 0.5;
    var_5 = var_4 - 0.05;
    var_0.angles = level.player getangles();
    var_6 = var_0.angles[0];

    if ( var_6 < 180 )
        var_6 = 0;

    var_7 = ( var_6, var_0.angles[1], var_0.angles[2] );
    var_0 rotateto( var_7, var_4 / 2 );
    level.player playerlinktoabsolute( var_0 );

    while ( var_0.angles[0] < 180 && var_0.angles[0] > 45 )
        wait 0.05;

    var_0 moveto( var_3, var_4, 0.05, var_4 - var_5 );
}

array_spawn_targetname_allow_fail( var_0, var_1 )
{
    var_2 = getentarray( var_0, "targetname" );
    var_3 = array_spawn_allow_fail( var_2, var_1 );
    return var_3;
}

array_spawn_allow_fail( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        var_4.count = 1;
        var_5 = var_4 maps\_utility::spawn_ai( var_1 );

        if ( isdefined( var_5 ) )
            var_2[var_2.size] = var_5;

        if ( level.currentgen )
            wait 0.1;
    }

    return var_2;
}

safe_activate_trigger_with_targetname( var_0 )
{
    var_1 = 64;
    var_2 = getent( var_0, "targetname" );

    if ( isdefined( var_2 ) && !isdefined( var_2.trigger_off ) )
    {
        var_2 maps\_utility::activate_trigger();

        if ( isdefined( var_2.spawnflags ) && var_2.spawnflags & var_1 )
            var_2 common_scripts\utility::trigger_off();
    }
}

ambient_animate( var_0, var_1, var_2, var_3 )
{
    var_4 = undefined;
    var_5 = undefined;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( isdefined( var_2 ) && var_2 == 1 )
    {
        var_6 = maps\_utility::dronespawn_bodyonly( self );
        var_6.spawner = self;
    }
    else
    {
        var_2 = 0;
        var_6 = maps\_utility::spawn_ai();
    }

    if ( isdefined( var_6 ) )
    {
        var_6 endon( "death" );

        if ( var_2 == 0 )
        {
            if ( isdefined( var_1 ) )
                var_6 thread prepare_to_be_shot( var_1, var_3 );

            var_6 maps\_utility::set_allowdeath( 1 );
        }

        if ( isdefined( self.animation ) )
        {
            var_6.animname = "generic";

            if ( var_2 == 0 && var_3 == 1 )
                var_6 maps\_utility::set_generic_idle_anim( "scientist_idle" );

            if ( isdefined( self.target ) )
            {
                var_4 = common_scripts\utility::getstruct( self.target, "targetname" );

                if ( !isdefined( var_4 ) )
                    var_5 = getnode( self.target, "targetname" );

                if ( isdefined( var_4 ) )
                    var_4 thread maps\_anim::anim_generic_loop( var_6, self.animation );

                if ( isdefined( var_5 ) )
                {
                    var_6 maps\_utility::disable_arrivals();
                    var_6 maps\_utility::disable_turnanims();
                    var_6 maps\_utility::disable_exits();
                    var_6 maps\_utility::set_run_anim( self.animation );

                    if ( isdefined( var_0 ) && var_0 == 1 )
                        var_6 thread delete_on_complete( 1 );
                }
            }
            else if ( isarray( level.scr_anim["generic"][self.animation] ) )
                var_6 thread maps\_anim::anim_generic_loop( var_6, self.animation );
            else
            {
                var_6 maps\_utility::disable_turnanims();
                var_6.ignoreall = 1;

                if ( var_2 == 0 )
                    var_6.allowdeath = 1;

                var_6 thread maps\_anim::anim_single_solo( var_6, self.animation );

                if ( isdefined( var_0 ) && var_0 == 1 )
                    var_6 thread delete_on_complete( 0 );
            }
        }
    }

    return var_6;
}

prepare_to_be_shot( var_0, var_1 )
{
    self endon( "death" );
    level waittill( var_0 );
    self.ignoreme = 0;
    self.ignoreall = 0;
    maps\_utility::anim_stopanimscripted();

    if ( var_1 == 1 )
        maps\_utility::set_generic_idle_anim( "scientist_idle" );

    maps\_utility::enable_arrivals();
    maps\_utility::enable_exits();
    maps\_utility::enable_turnanims();
}

delete_on_complete( var_0 )
{
    if ( !var_0 )
    {
        self waittillmatch( "single anim", "end" );
        self notify( "killanimscript" );
    }
    else
        self waittill( "reached_path_end" );

    if ( !raven_player_can_see_ai( self ) )
        self delete();
}

setup_objectives()
{
    level.df_objectives = [];
    level.df_objectives["initial_obj"] = [];
    level.df_objectives["initial_obj"]["obj"] = maps\_utility::obj( "initial_obj" );
    level.df_objectives["initial_obj"]["obj_text"] = &"df_baghdad_start_obj";
    level.df_objectives["initial_obj"]["active"] = 0;
    objective_add( maps\_utility::obj( "initial_obj" ), "invisible", level.df_objectives["initial_obj"]["obj_text"] );
    objective_state_nomessage( maps\_utility::obj( "initial_obj" ), "active" );
    level.df_objectives["follow"] = [];
    level.df_objectives["follow"]["obj"] = maps\_utility::obj( "follow" );
    level.df_objectives["follow"]["ovr"] = &"df_baghdad_follow_objective";
    level.df_objectives["follow"]["obj_text"] = &"df_baghdad_follow_gideon";
    level.df_objectives["follow"]["active"] = 0;
    level.df_objectives["tower"] = [];
    level.df_objectives["tower"]["obj"] = maps\_utility::obj( "tower" );
    level.df_objectives["tower"]["obj_text"] = &"df_baghdad_assault_tower";
    level.df_objectives["tower"]["origin"] = common_scripts\utility::getstruct( "objective_snipers", "targetname" ).origin;
    level.df_objectives["tower"]["active"] = 0;
    level.df_objectives["spidertanks"] = [];
    level.df_objectives["spidertanks"]["obj"] = maps\_utility::obj( "spidertanks" );
    level.df_objectives["spidertanks"]["obj_text"] = &"df_baghdad_destroy_turret_3";
    level.df_objectives["spidertanks"]["ovr"] = &"df_baghdad_destroy";
    level.df_objectives["spidertanks"]["multipleobj"] = 1;
    level.df_objectives["spidertanks"]["active"] = 0;
    level.df_objectives["spidertanks"]["num_alive"] = 3;
    level.df_objectives["spidertanks"]["multi_text"] = [];
    level.df_objectives["spidertanks"]["multi_text"][0] = &"df_baghdad_destroy_turret_0";
    level.df_objectives["spidertanks"]["multi_text"][1] = &"df_baghdad_destroy_turret_1";
    level.df_objectives["spidertanks"]["multi_text"][2] = &"df_baghdad_destroy_turret_2";
    level.df_objectives["spidertanks"]["multi_text"][3] = &"df_baghdad_destroy_turret_3";
    level.df_objectives["barracks"] = [];
    level.df_objectives["barracks"]["obj"] = maps\_utility::obj( "barracks" );
    level.df_objectives["barracks"]["ovr"] = &"df_baghdad_kill";
    level.df_objectives["barracks"]["obj_text"] = &"df_baghdad_destroy_ast_suppressing";
    level.df_objectives["barracks"]["active"] = 0;
    level.df_objectives["link_with_95"] = [];
    level.df_objectives["link_with_95"]["obj"] = maps\_utility::obj( "link_with_95" );
    level.df_objectives["link_with_95"]["ovr"] = &"df_baghdad_regroup";
    level.df_objectives["link_with_95"]["obj_text"] = &"df_baghdad_regroup_menu";
    level.df_objectives["link_with_95"]["origin"] = common_scripts\utility::getstruct( "obj_linkup_95th", "targetname" ).origin;
    level.df_objectives["link_with_95"]["active"] = 0;
    level.df_objectives["street_mechs"] = [];
    level.df_objectives["street_mechs"]["obj"] = maps\_utility::obj( "street_mechs" );
    level.df_objectives["street_mechs"]["ovr"] = &"df_baghdad_kill";
    level.df_objectives["street_mechs"]["obj_text"] = &"df_baghdad_eliminate_ast_units";
    level.df_objectives["street_mechs"]["active"] = 0;
    level.df_objectives["approach_atlas"] = [];
    level.df_objectives["approach_atlas"]["obj"] = maps\_utility::obj( "approach_atlas" );
    level.df_objectives["approach_atlas"]["ovr"] = &"df_baghdad_stinger";
    level.df_objectives["approach_atlas"]["obj_text"] = &"df_baghdad_stinger_obj";
    level.df_objectives["approach_atlas"]["origin"] = common_scripts\utility::getstruct( "use_stinger_objective", "targetname" ).origin;
    level.df_objectives["approach_atlas"]["active"] = 0;
    level.df_objectives["use_turret"] = [];
    level.df_objectives["use_turret"]["obj"] = maps\_utility::obj( "use_turret" );
    level.df_objectives["use_turret"]["obj_text"] = &"df_baghdad_get_on_the_turret";
    level.df_objectives["use_turret"]["active"] = 0;
    level.df_objectives["assault_atlas"] = [];
    level.df_objectives["assault_atlas"]["obj"] = maps\_utility::obj( "assault_atlas" );
    level.df_objectives["assault_atlas"]["obj_text"] = &"df_baghdad_assault_the_atlas_building";
    level.df_objectives["assault_atlas"]["active"] = 0;
}

add_objective( var_0 )
{
    if ( isdefined( level.df_objectives[var_0]["origin"] ) )
        objective_add( level.df_objectives[var_0]["obj"], "active", level.df_objectives[var_0]["obj_text"], level.df_objectives[var_0]["origin"] );
    else
        objective_add( level.df_objectives[var_0]["obj"], "active", level.df_objectives[var_0]["obj_text"] );

    if ( isdefined( level.df_objectives[var_0]["ovr"] ) )
        objective_setpointertextoverride( level.df_objectives[var_0]["obj"], level.df_objectives[var_0]["ovr"] );

    if ( is_true( level.df_objectives[var_0]["multipleobj"] ) )
    {
        if ( isdefined( level.snipergroup ) )
            thread multiple_objectives( var_0 );
    }
}

multiple_objectives( var_0 )
{
    foreach ( var_2 in level.snipergroup ){
        var_2 thread objectivedeathdetection( var_0 );
    }
}

objectivedeathdetection( var_0 )
{
    self endon( "removed" );
    self waittill( "death" );
    reset_character();
    level.snipergroup = common_scripts\utility::array_remove( level.snipergroup, self );
    if ( isdefined( self.ridingvehicle ) && !isdefined( self.ridingvehicle.roof_trigger ) )
        wait 6;

    objective_delete( maps\_utility::obj( var_0 ) );
    initmultiobjectives( var_0, level.snipergroup );

    if ( !isdefined( level.spider_tank_deaths ) )
        level.spider_tank_deaths = 1;
    else
        level.spider_tank_deaths++;

    wait 0.5;
    level notify( "turret_dead_vo" + level.snipergroup.size );
}

reset_character()
{
    aiarray = getaiarray( "axis" );
    foreach (ai in aiarray) 
    {
        ai character\gfl\randomizer_atlas::main();
    }
}

initmultiobjectives( var_0, var_1 )
{
    objective_add( maps\_utility::obj( var_0 ), "current", level.df_objectives["spidertanks"]["obj_text"] );
    objective_setpointertextoverride( maps\_utility::obj( var_0 ), &"df_baghdad_destroy" );
    var_2 = 0;

    foreach ( var_4 in var_1 )
    {
        if ( isdefined( var_4 ) )
        {
            objective_additionalentity( maps\_utility::obj( var_0 ), var_2, var_1[var_2], ( 0, 0, 100 ) );
            var_2++;
        }
    }

    if ( var_2 > 0 )
        level.df_objectives["spidertanks"]["obj_text"] = level.df_objectives[var_0]["multi_text"][var_2 - 1];
}

set_df_objective_active( var_0 )
{
    add_objective( var_0 );
    objective_current( level.df_objectives[var_0]["obj"] );
}

set_df_objective_active_spiderturrets( var_0 )
{
    if ( is_true( level.df_objectives[var_0]["multipleobj"] ) )
    {
        if ( isdefined( level.snipergroup ) )
            thread multiple_objectives( var_0 );
    }

    objective_current( level.df_objectives[var_0]["obj"] );
}

is_true( var_0 )
{
    return isdefined( var_0 ) && var_0;
}

watch_follow_objective()
{
    maps\_utility::objective_complete( level.df_objectives["initial_obj"]["obj"] );
    set_df_objective_active( "follow" );

    if ( isdefined( level.allies[0] ) )
        objective_onentity( level.df_objectives["follow"]["obj"], level.allies[0], ( 0, 0, 72 ) );

    var_0 = common_scripts\utility::getstruct( "ilona_wave_root", "targetname" );
    var_0 thread maps\_anim::anim_loop_solo( level.allies[2], "intro_wave" );
    common_scripts\utility::flag_wait( "flag_reach_ilona_complete" );
    var_0 notify( "stop_loop" );
    level.allies[2] maps\_utility::anim_stopanimscripted();
    common_scripts\utility::flag_wait( "player_on_intro_balcony" );
    maps\_utility::objective_complete( level.df_objectives["follow"]["obj"] );
    common_scripts\utility::flag_set( "intro_finished" );
}

set_snipers_section_clear()
{
    common_scripts\utility::flag_wait_all( "snipers_dead1", "snipers_dead2", "snipers_dead3" );
    common_scripts\utility::flag_set( "snipers_finished" );
}

tower_vo()
{
    level endon( "stop_tower_nags" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_gid_eliminateturrets" );
    wait 0.25;
    maps\_utility::smart_radio_dialogue_interrupt( "df_dav_suppressingfire" );
    wait 7;
    maps\_utility::smart_radio_dialogue_interrupt( "df_dav_tornapart" );
    wait 12;
    maps\_utility::smart_radio_dialogue_interrupt( "df_gid_movemove3" );
    wait 30;
    maps\_utility::smart_radio_dialogue_interrupt( "df_dav_tornapart" );
    wait 40;
    maps\_utility::smart_radio_dialogue_interrupt( "df_gid_movemove3" );
}

ignoreme_for_x( var_0 )
{
    self.ignoreme = 1;
    wait( var_0 );
    self.ignoreme = 0;
}

turret_dead_vo()
{
    level waittill( "turret_dead_vo2" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_nox_turretdown2" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_gid_letshittherest" );

    if ( common_scripts\utility::flag( "snipers_dead3" ) )
    {
        maps\_utility::smart_radio_dialogue_interrupt( "df_nox_eyesonit" );
        wait 0.25;
        maps\_utility::smart_radio_dialogue_interrupt( "df_nox_adjacentbuilding" );
    }

    if ( common_scripts\utility::flag( "snipers_dead2" ) )
    {
        maps\_utility::smart_radio_dialogue_interrupt( "df_nox_southwestcorner" );
        wait 0.5;
        maps\_utility::smart_radio_dialogue_interrupt( "df_nox_adjacentbuilding" );
    }

    if ( common_scripts\utility::flag( "snipers_dead1" ) )
    {
        maps\_utility::smart_radio_dialogue_interrupt( "df_nox_eyesonit" );
        wait 0.25;
        maps\_utility::smart_radio_dialogue_interrupt( "df_nox_southwestcorner" );
    }

    wait 2;
    maps\_utility::smart_radio_dialogue_interrupt( "df_nox_letshitit" );
    level waittill( "turret_dead_vo1" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_nox_turretdown2" );

    if ( common_scripts\utility::flag( "snipers_dead3" ) && common_scripts\utility::flag( "snipers_dead2" ) )
        maps\_utility::smart_radio_dialogue_interrupt( "df_nox_adjacentbuilding" );

    if ( common_scripts\utility::flag( "snipers_dead3" ) && common_scripts\utility::flag( "snipers_dead1" ) )
        maps\_utility::smart_radio_dialogue_interrupt( "df_nox_eyesonit" );

    if ( common_scripts\utility::flag( "snipers_dead1" ) && common_scripts\utility::flag( "snipers_dead2" ) )
        maps\_utility::smart_radio_dialogue_interrupt( "df_nox_southwestcorner" );
}

heli_start_shooting()
{
    self endon( "death" );
    var_0 = level.player;
    var_1 = self;

    foreach ( var_3 in var_1.mgturret )
        var_3 setturretteam( "axis" );

    for (;;)
    {
        foreach ( var_3 in var_1.mgturret )
        {
            var_3 setmode( "manual" );
            var_3 settargetentity( var_0, ( 0, 0, 36 ) );
            var_3 startfiring();
            var_3 common_scripts\utility::delaycall( 2, ::stopfiring );
        }

        wait 4;
    }
}

check_player_in_sniper_zone()
{
    common_scripts\utility::flag_wait( "flag_in_sniper_zone" );
    var_0 = level.player getweaponslistall();

    foreach ( var_2 in var_0 )
    {
        if ( issubstr( var_2, "rsass_silenced" ) )
            level.player switchtoweapon( "rsass_silenced" );
    }
}

check_clearroof_early()
{
    common_scripts\utility::flag_wait( "snipers_cleared_roof" );
    common_scripts\utility::flag_set( "flag_completed_rooftop_early" );
}

get_to_roof_nag()
{
    level endon( "end_get_to_roof_nag" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_ss1_pinneddown" );
    wait 0.2;
    maps\_utility::smart_radio_dialogue_interrupt( "df_dav_needpozdata" );
    common_scripts\utility::flag_set( "flag_head_to_snipers" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_gid_onourway" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_gid_onourway" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_gid_getuphere" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_nox_snipernext" );
}

teleport_ai_rooftop()
{
    var_0 = getnode( "allies0noderoof", "targetname" );
    var_1 = getnode( "allies1noderoof", "targetname" );
    level.allies[0] maps\_utility::teleport_ai( var_0 );
    level.allies[1] maps\_utility::teleport_ai( var_1 );
}

set_flag_in_trigger()
{
    self waittill( "trigger" );

    if ( isdefined( self.script_flag_set ) )
        common_scripts\utility::flag_set( self.script_flag_set );
}

check_player_pickedup_sniper()
{
    level endon( "grabbed_sniper" );

    for (;;)
    {
        var_0 = level.player getweaponslistall();

        foreach ( var_2 in var_0 )
        {
            if ( issubstr( var_2, "iw5_mors_sp_morsscope" ) )
            {
                common_scripts\utility::flag_set( "grabbed_sniper" );
                level notify( "grabbed_sniper" );
                level.player switchtoweapon( "iw5_mors_sp_morsscope" );
            }
        }

        wait 0.05;
    }
}

sniper_objectives()
{
    level.snipergroup = [];
    level.snipergroup[0] = level.sniper_turret1.driver;
    level.snipergroup[1] = level.sniper_turret2.driver;
    level.snipergroup[2] = level.sniper_turret3.driver;
    thread set_snipers_section_clear();
    common_scripts\utility::flag_wait( "tower_helis_death" );
    wait 1;
    safe_activate_trigger_with_targetname( "allies_shift_front1" );
    safe_activate_trigger_with_targetname( "heroes_shift_front1" );
    level.allies[0].ignoresuppression = 1;
    level.allies[1].ignoresuppression = 1;
    level.allies[0] thread ignoreme_for_x( 5 );
    level.allies[1] thread ignoreme_for_x( 5 );
    thread maps\_utility::autosave_tactical();
    set_df_objective_active_spiderturrets( "spidertanks" );
    level.sniper_turret1 maps\_vehicle::godoff();
    level.sniper_turret2 maps\_vehicle::godoff();
    level.sniper_turret3 maps\_vehicle::godoff();
    level.allies[0].ignoresuppression = 0;
    level.allies[1].ignoresuppression = 0;
    initmultiobjectives( "spidertanks", level.snipergroup );
    common_scripts\utility::flag_wait( "player_near_tower" );
    waitframe();
    thread turret_dead_vo();
    thread tower_vo();
    level.sniper_turret1.driver thread check_death_flag();
    level.sniper_turret2.driver thread check_death_flag();
    level.sniper_turret3.driver thread check_death_flag();
    common_scripts\utility::flag_wait_all( "snipers_dead1", "snipers_dead2", "snipers_dead3" );
    level notify( "stop_tower_nags" );

    if ( isdefined( level.spider_tank_deaths ) )
    {
        while ( level.spider_tank_deaths < 3 )
            waitframe();
    }

    maps\_utility::objective_complete( level.df_objectives["spidertanks"]["obj"] );
    common_scripts\utility::flag_set( "barracks_approach_start_section" );
    maps\_utility::delaythread( 3, maps\_utility::autosave_by_name, "turrets_are_dead" );
    wait 2;
    common_scripts\utility::flag_set( "snipers_finished" );
}

check_death_flag()
{
    self waittill( "death" );

    if ( isdefined( self.script_deathflag ) )
        common_scripts\utility::flag_set( self.script_deathflag );
}

barracks_objectives()
{
    common_scripts\utility::flag_wait( "snipers_finished" );

    if ( isdefined( level ) && isdefined( level.start_point ) && level.start_point == "dnabomb" )
        return;

    if ( !common_scripts\utility::flag( "barracks_approach_start_section" ) )
        common_scripts\utility::flag_wait( "barracks_approach_start_section" );

    set_df_objective_active( "link_with_95" );

    if ( !common_scripts\utility::flag( "obj_update_95th" ) )
        common_scripts\utility::flag_wait( "obj_update_95th" );

    maps\_utility::objective_complete( maps\_utility::obj( "link_with_95" ) );
    level notify( "linked_with_95th" );

    if ( !common_scripts\utility::flag( "street_mechs_spawned" ) )
        common_scripts\utility::flag_wait( "street_mechs_spawned" );

    level.mechs_living = 3;
    set_df_objective_active( "street_mechs" );
    thread mech_obj_loop();
    common_scripts\utility::flag_wait_all( "street_mech4_died", "street_mech3_died", "street_mech_died" );
    maps\_utility::objective_complete( maps\_utility::obj( "street_mechs" ) );
    level notify( "street_mechs_handled" );
    level waittill( "start_stinger_objective" );
    thread handle_stinger_objective();
    maps\_utility::delaythread( 3, maps\_utility::autosave_by_name, "mechs_are_dead" );
}

mech_obj_loop()
{
    level endon( "street_mechs_handled" );

    for (;;)
    {
        level waittill( "str_mech_spawned" );

        if ( level.streetmechs.size )
        {
            for ( var_0 = 0; var_0 < level.streetmechs.size; var_0++ )
            {
                objective_additionalentity( level.df_objectives["street_mechs"]["obj"], var_0, level.streetmechs[var_0], ( 0, 0, 81 ) );
                level.streetmechs[var_0] thread mech_death_update_objective();
            }
        }
    }
}

mech_damage_end_support()
{
    level endon( "linked_with_95th" );
    self endon( "death" );

    for (;;)
    {
        waitframe();
        self waittill( "damage", var_0, var_1 );

        if ( isdefined( var_1 ) && isplayer( var_1 ) )
        {
            if ( !common_scripts\utility::flag( "obj_update_95th" ) )
            {
                common_scripts\utility::flag_set( "obj_update_95th" );
                break;
            }
            else
                break;
        }
    }
}

mech_death_update_objective()
{
    self notify( "stop_checking" );
    self endon( "stop_checking" );

    if ( isalive( self ) )
    {
        self waittill( "death" );
        thread mech_death_save();
        level.mechs_living--;
        level.streetmechs = maps\_utility::array_removedead( level.streetmechs );

        if ( level.mechs_living > 0 )
        {
            objective_delete( level.df_objectives["street_mechs"]["obj"] );
            set_df_objective_active( "street_mechs" );

            if ( level.streetmechs.size )
            {
                for ( var_0 = 0; var_0 < level.streetmechs.size; var_0++ )
                {
                    if ( isdefined( level.streetmechs[var_0] ) )
                        objective_additionalentity( level.df_objectives["street_mechs"]["obj"], var_0, level.streetmechs[var_0], ( 0, 0, 81 ) );
                }
            }
        }
    }
}

mech_death_save()
{
    if ( isdefined( level.player.grapple_mech_no_save ) && level.player.grapple_mech_no_save )
    {
        while ( level.player.grapple_mech_no_save )
            waitframe();
    }

    maps\_utility::autosave_by_name_silent( "mech_death" );
}

handle_stinger_objective()
{
    common_scripts\utility::flag_set( "stinger_objective_active" );
    var_0 = maps\_shg_utility::hint_button_position( "use", level.df_objectives["approach_atlas"]["origin"], 82 );
    set_df_objective_active( "approach_atlas" );
    common_scripts\utility::flag_wait( "pvtol_crashed" );
    objective_position( maps\_utility::obj( "approach_atlas" ), ( 0, 0, 0 ) );
    var_0 maps\_shg_utility::hint_button_clear();
}

handle_finale_objectives( var_0 )
{
    set_df_objective_active( "approach_atlas" );
    objective_onentity( level.df_objectives["approach_atlas"]["obj"], var_0, ( -36, 0, 60 ) );
    common_scripts\utility::flag_wait( "player_on vtol" );
    maps\_utility::objective_complete( level.df_objectives["approach_atlas"]["obj"] );
    set_df_objective_active( "use_turret" );
    objective_onentity( level.df_objectives["use_turret"]["obj"], var_0.mgturret[0], ( -40, 0, 6 ) );
    common_scripts\utility::flag_wait( "player_on_vtol_turret" );
    maps\_utility::objective_complete( level.df_objectives["use_turret"]["obj"] );
    set_df_objective_active( "assault_atlas" );
}

start_billboard_ads()
{
    if ( level.start_point != "intro" )
        thread maps\_utility::notify_delay( "intro_pod_anims_finished", 3 );

    level waittill( "intro_pod_anims_finished" );
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    cinematicingameloopresident( "nb_ads" );
}

hide_for_capture()
{
    level.hidden_for_capture = 1;
    var_0 = getentarray( "hide_for_capture", "targetname" );
    common_scripts\utility::array_call( var_0, ::hide );
}

raven_player_can_see_ai( var_0, var_1 )
{
    var_2 = gettime();

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( isdefined( var_0.playerseesmetime ) && var_0.playerseesmetime + var_1 >= var_2 )
        return var_0.playerseesme;

    var_0.playerseesmetime = var_2;

    if ( !common_scripts\utility::within_fov( level.player.origin, level.player.angles, var_0.origin, 0.766 ) )
    {
        var_0.playerseesme = 0;
        return 0;
    }

    var_3 = level.player geteye();
    var_4 = var_0.origin;

    if ( sighttracepassed( var_3, var_4, 0, level.player ) )
    {
        var_0.playerseesme = 1;
        return 1;
    }

    var_5 = var_0 geteye();

    if ( sighttracepassed( var_3, var_5, 0, level.player ) )
    {
        var_0.playerseesme = 1;
        return 1;
    }

    var_6 = ( var_5 + var_4 ) * 0.5;

    if ( sighttracepassed( var_3, var_6, 0, level.player ) )
    {
        var_0.playerseesme = 1;
        return 1;
    }

    var_0.playerseesme = 0;
    return 0;
}

on_alert_go_volume( var_0 )
{
    self endon( "death" );

    if ( !isdefined( self.script_parameters ) )
    {
        iprintlnbold( "guy with no script_parameters sent to on_alert_go_volume" );
        return;
    }

    if ( !common_scripts\utility::flag( var_0 ) )
    {
        self.old_maxsightdistsqrd = self.maxsightdistsqrd;
        self.maxsightdistsqrd = 262144;
        thread catch_death_notify();
        thread catch_damage_notify();
        thread catch_got_enemy();
        thread catch_level_notify( var_0 );
        self addaieventlistener( "grenade danger" );
        self addaieventlistener( "projectile_impact" );
        self addaieventlistener( "silenced_shot" );
        self addaieventlistener( "bulletwhizby" );
        self addaieventlistener( "gunshot" );
        self addaieventlistener( "gunshot_teammate" );
        self addaieventlistener( "explode" );
        var_1 = common_scripts\utility::waittill_any_return( "enemy", "ai_event", "death_by_player", "damage_by_player", "got_enemy", var_0 );
        self.maxsightdistsqrd = self.old_maxsightdistsqrd;
        maps\_utility::anim_stopanimscripted();
        wait 0.05;

        if ( !common_scripts\utility::flag( var_0 ) )
        {
            common_scripts\utility::flag_set( var_0 );
            level notify( "alert_inert_allies" );
        }
    }

    var_2 = getent( self.script_parameters, "targetname" );

    if ( !isdefined( var_2 ) )
    {
        iprintlnbold( "guy could not find goal vol " + self.script_parameters );
        var_2 = getent( "snipers_vol", "script_noteworthy" );
    }

    self setgoalvolumeauto( var_2 );
}

catch_death_notify()
{
    self waittill( "death", var_0 );

    if ( isdefined( var_0 ) && isplayer( var_0 ) )
        self notify( "death_by_player" );
}

catch_level_notify( var_0 )
{
    self endon( "death" );
    level waittill( var_0 );
    self notify( var_0 );
}

catch_damage_notify()
{
    self endon( "death" );
    self waittill( "damage", var_0, var_1 );

    if ( isdefined( var_1 ) && isplayer( var_1 ) )
        self notify( "damage_by_player" );
}

catch_got_enemy()
{
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self.enemy ) )
        {
            if ( self.enemy == level.player )
                break;
        }

        wait 0.05;
    }

    self notify( "got_enemy" );
}

_stop_mech_hunt_baghdad()
{
    self notify( "stop_mhunt_bhavior" );
}

_mech_hunt_baghdad( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "removed" );
    self endon( "stop_mhunt_bhavior" );
    self notify( "stop_generic_attacking" );
    self.old_attributes = [];
    self.old_attributes["maxfaceenemydist"] = self.maxfaceenemydist;
    self.old_attributes["standingturnrate"] = self.standingturnrate;
    self.old_attributes["walkingturnrate"] = self.walkingturnrate;
    self.old_attributes["runingturnrate"] = self.runingturnrate;
    self.old_attributes["pathenemylookahead"] = self.pathenemylookahead;
    self.old_attributes["moveplaybackrate"] = self.moveplaybackrate;
    self.walkdist = 2048;
    self.pathenemyfightdist = 512;
    self.usechokepoints = 0;

    if ( !isdefined( var_2 ) )
        self.gradius = 512;
    else
        self.gradius = var_2;

    if ( !isdefined( var_3 ) )
        self.gheight = 81;
    else
        self.gheight = var_3;

    if ( isdefined( var_1 ) )
        var_1 = 1;

    thread atrrestoremech();

    if ( isdefined( var_0 ) )
        maps\_utility::set_favoriteenemy( var_0 );

    childthread mech_hunt_alter_turnrates();

    if ( isdefined( var_1 ) && var_1 )
        childthread mech_corral_alt( var_1 );
    else
        childthread mech_corral_alt( undefined );
}

mech_hunt_alter_turnrates()
{
    for (;;)
    {
        waitframe();

        if ( isdefined( self ) && isdefined( self.enemy ) && isplayer( self.enemy ) )
        {
            var_0 = vectornormalize( level.player.origin - self.origin );
            var_1 = anglestoforward( self gettagangles( "tag_flash" ) );
            var_2 = vectordot( var_1, var_0 );

            if ( var_2 <= cos( 45 ) )
            {
                if ( self.standingturnrate == self.old_attributes["standingturnrate"] || self.walkingturnrate == self.old_attributes["walkingturnrate"] || self.runingturnrate == self.old_attributes["runingturnrate"] || self.moveplaybackrate == self.old_attributes["moveplaybackrate"] )
                {
                    self.standingturnrate *= 0.75;
                    self.walkingturnrate *= 0.75;
                    self.runingturnrate *= 0.75;
                    self.moveplaybackrate = 0.8;

                    for (;;)
                    {
                        waitframe();
                        var_0 = vectornormalize( level.player.origin - self.origin );
                        var_1 = anglestoforward( self gettagangles( "tag_flash" ) );
                        var_2 = vectordot( var_1, var_0 );

                        if ( var_2 >= cos( 45 ) )
                        {
                            self.standingturnrate = self.old_attributes["standingturnrate"];
                            self.walkingturnrate = self.old_attributes["walkingturnrate"];
                            self.runingturnrate = self.old_attributes["runingturnrate"];
                            self.moveplaybackrate = self.old_attributes["moveplaybackrate"];
                            break;
                        }
                    }
                }
            }

            continue;
        }

        if ( self.standingturnrate != self.old_attributes["standingturnrate"] || self.walkingturnrate != self.old_attributes["walkingturnrate"] || self.runingturnrate != self.old_attributes["runingturnrate"] || self.moveplaybackrate != self.old_attributes["moveplaybackrate"] )
        {
            self.standingturnrate = self.old_attributes["standingturnrate"];
            self.walkingturnrate = self.old_attributes["walkingturnrate"];
            self.runingturnrate = self.old_attributes["runingturnrate"];
            self.moveplaybackrate = self.old_attributes["moveplaybackrate"];
        }
    }
}

mech_corral_alt( var_0 )
{
    var_1 = spawnstruct();
    var_2 = [];
    waitframe();

    if ( isdefined( var_0 ) )
        childthread favrandom();

    for (;;)
    {
        waitframe();
        var_2 = [];
        var_2 = getaiarray( "allies" );
        var_2[var_2.size] = level.player;
        var_2 = maps\_utility::array_removedead( var_2 );
        var_1.origin = maps\_utility::get_average_origin( var_2 );
        var_3 = [];
        var_3 = getnodesinradiussorted( var_1.origin, 1024, 0 );

        if ( var_3.size )
        {
            var_4 = 0;

            for (;;)
            {
                waitframe();

                if ( isdefined( self.enemy ) )
                {
                    var_5 = self.enemy getnearestnode();

                    if ( !isdefined( var_5 ) )
                        continue;

                    if ( nodesvisible( var_3[var_4], var_5 ) )
                    {
                        self setgoalpos( var_3[var_4].origin );
                        self.goalheight = self.gheight;
                        self.goalradius = self.gradius;
                        self.seeking_path = 1;
                        break;
                    }
                    else
                    {
                        var_4++;

                        if ( var_4 > var_3.size )
                            break;
                    }
                }
            }

            if ( self.seeking_path )
            {
                common_scripts\utility::waittill_any_timeout( 4, "goal" );
                self.seeking_path = 0;
            }
        }
    }
}

favrandom()
{
    self notify( "stop_fav_random" );
    self endon( "stop_fav_random" );
    self endon( "death" );
    self endon( "removed" );
    self.fav_random_switch = 1;

    for (;;)
    {
        if ( isdefined( self.fav_random_switch ) && self.fav_random_switch )
        {
            var_0 = getaiarray( "allies" );
            var_0[var_0.size] = level.player;
            var_1 = randomintrange( 4, 6 );
            var_2 = common_scripts\utility::random( var_0 );

            if ( isalive( var_2 ) && issentient( var_2 ) )
                maps\_utility::set_favoriteenemy( var_2 );

            var_2 common_scripts\utility::waittill_any_timeout( var_1, "death", "removed" );
        }

        waitframe();
    }
}

atrrestoremech()
{
    common_scripts\utility::waittill_any( "stop_mdefensive_bhavior", "stop_mhunt_bhavior" );
    self.maxfaceenemydist = self.old_attributes["maxfaceenemydist"];
    self.standingturnrate = self.old_attributes["standingturnrate"];
    self.walkingturnrate = self.old_attributes["walkingturnrate"];
    self.runingturnrate = self.old_attributes["runingturnrate"];
    self.pathenemylookahead = self.old_attributes["pathenemylookahead"];
    self.moveplaybackrate = self.old_attributes["moveplaybackrate"];
}

tff_cleanup_vehicle( var_0 )
{
    if ( !isdefined( self ) || isremovedentity( self ) )
        return;

    var_1 = "";

    switch ( var_0 )
    {
        case "intro":
            var_1 = "tff_pre_intro_to_middle";
            break;
        case "middle":
            var_1 = "tff_pre_middle_to_outro";
            break;
    }

    if ( var_1 == "" )
        return;

    level waittill( var_1 );

    if ( isarray( self ) )
    {
        foreach ( var_3 in self )
        {
            if ( !isdefined( var_3 ) || isremovedentity( var_3 ) )
                continue;

            var_3 maps\_vehicle_code::_freevehicle();
            var_3 delete();
        }
    }
    else
    {
        maps\_vehicle_code::_freevehicle();
        self delete();
    }
}
