// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

goto_node( var_0, var_1, var_2 )
{
    self endon( "stop_goto_node" );

    if ( !isdefined( var_2 ) )
        var_2 = 16;

    maps\_utility::set_goal_radius( var_2 );

    if ( isstring( var_0 ) )
        var_3 = getnode( var_0, "script_noteworthy" );
    else
        var_3 = var_0;

    if ( isdefined( var_3 ) )
        maps\_utility::set_goal_node( var_3 );
    else
    {
        var_3 = common_scripts\utility::getstruct( var_0, "script_noteworthy" );
        maps\_utility::set_goal_pos( var_3.origin );
    }

    if ( var_1 )
        self waittill( "goal" );
}

ally_move_dynamic_speed()
{
    self notify( "start_dynamic_run_speed" );
    self endon( "death" );
    self endon( "stop_dynamic_run_speed" );
    self endon( "start_dynamic_run_speed" );

    if ( maps\_utility::ent_flag_exist( "_stealth_custom_anim" ) )
        maps\_utility::ent_flag_waitopen( "_stealth_custom_anim" );

    self.run_speed_state = "";
    ally_reset_dynamic_speed();
    var_0 = 144;
    var_1 = [ "sprint", "run" ];
    var_2 = [];
    var_2["player_sprint"]["sprint"][0] = 225 * var_0;
    var_2["player_sprint"]["sprint"][1] = 900 * var_0;
    var_2["player_sprint"]["run"][0] = 900 * var_0;
    var_2["player_sprint"]["run"][1] = 900 * var_0;
    var_2["player_run"]["sprint"][0] = 225 * var_0;
    var_2["player_run"]["sprint"][1] = 400 * var_0;
    var_2["player_run"]["run"][0] = 400 * var_0;
    var_2["player_run"]["run"][1] = 625 * var_0;
    var_2["player_crouch"]["run"][0] = 4 * var_0;
    var_2["player_crouch"]["run"][1] = 100 * var_0;
    var_3 = 123;
    var_4 = 189;
    var_5 = 283;

    for (;;)
    {
        wait 0.2;

        if ( isdefined( self.force_run_speed_state ) )
        {
            ally_dynamic_run_set( self.force_run_speed_state );
            continue;
        }

        var_6 = vectornormalize( anglestoforward( self.angles ) );
        var_7 = vectornormalize( self.origin - level.player.origin );
        var_8 = vectordot( var_6, var_7 );
        var_9 = distancesquared( self.origin, level.player.origin );

        if ( isdefined( self.cqbwalking ) && self.cqbwalking )
            self.moveplaybackrate = 1;

        if ( common_scripts\utility::flag_exist( "_stealth_spotted" ) && common_scripts\utility::flag( "_stealth_spotted" ) )
        {
            ally_dynamic_run_set( "run" );
            continue;
        }

        if ( var_8 < -0.25 && var_9 > 225 * var_0 )
        {
            ally_dynamic_run_set( "sprint" );
            continue;
        }

        var_10 = level.player getvelocity();
        var_11 = length( var_10 );
        var_12 = "";

        if ( var_11 < var_3 )
            var_12 = "player_crouch";
        else if ( var_11 < var_4 )
            var_12 = "player_run";
        else
            var_12 = "player_sprint";

        var_13 = var_2[var_12];
        var_14 = 0;

        foreach ( var_16 in var_1 )
        {
            if ( isdefined( var_13[var_16] ) )
            {
                if ( var_9 < var_13[var_16][0] || self.run_speed_state == var_16 && var_9 < var_13[var_16][1] )
                {
                    ally_dynamic_run_set( var_16 );
                    var_14 = 1;
                    break;
                }
            }
        }

        if ( var_14 )
            continue;

        ally_dynamic_run_set( "jog_slow" );
    }
}

ally_stop_dynamic_speed()
{
    self endon( "death" );
    self notify( "stop_dynamic_run_speed" );
    ally_reset_dynamic_speed();
}

ally_reset_dynamic_speed()
{
    self endon( "death" );
    maps\_utility::disable_cqbwalk();
    self.moveplaybackrate = 1;
    maps\_utility::clear_run_anim();
    self notify( "stop_loop" );
}

ally_dynamic_run_set( var_0 )
{
    if ( self.run_speed_state == var_0 )
        return;

    self.run_speed_state = var_0;

    switch ( var_0 )
    {
        case "sprint":
            if ( isdefined( self.cqbwalking ) && self.cqbwalking )
                self.moveplaybackrate = 1;
            else
                self.moveplaybackrate = 1;

            maps\_utility::set_generic_run_anim( "DRS_sprint" );
            maps\_utility::disable_cqbwalk();
            self notify( "stop_loop" );
            break;
        case "run":
            self.moveplaybackrate = 1.1;
            maps\_utility::clear_run_anim();
            maps\_utility::disable_cqbwalk();
            self notify( "stop_loop" );
            break;
        case "jog":
            self.moveplaybackrate = 1;
            maps\_utility::set_generic_run_anim( "DRS_combat_jog" );
            maps\_utility::disable_cqbwalk();
            self notify( "stop_loop" );
            break;
        case "jog_slow":
            self.moveplaybackrate = 0.9;
            maps\_utility::disable_cqbwalk();
            self notify( "stop_loop" );
            break;
    }
}

teleport_to_scriptstruct( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0, "script_noteworthy" );
    level.player setorigin( var_1.origin );

    if ( isdefined( var_1.angles ) )
        level.player setangles( var_1.angles );

    var_2 = getentarray( "hero", "script_noteworthy" );

    foreach ( var_4 in var_2 )
    {
        if ( isspawner( var_4 ) )
            var_2 = common_scripts\utility::array_remove( var_2, var_4 );
    }

    var_6 = common_scripts\utility::getstructarray( var_1.target, "targetname" );

    for ( var_7 = 0; var_7 < var_2.size; var_7++ )
    {
        if ( var_7 < var_6.size )
        {
            var_2[var_7] forceteleport( var_6[var_7].origin, var_6[var_7].angles );
            var_2[var_7] setgoalpos( var_6[var_7].origin );
            continue;
        }

        var_2[var_7] forceteleport( level.player.origin, level.player.angles );
        var_2[var_7] setgoalpos( level.player.origin );
    }
}

cleanup_ai_with_script_noteworthy( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 512;

    var_2 = [];

    foreach ( var_4 in getentarray( var_0, "script_noteworthy" ) )
    {
        if ( isspawner( var_4 ) )
        {
            var_4 delete();
            continue;
        }

        var_2[var_2.size] = var_4;
    }

    thread maps\_utility::ai_delete_when_out_of_sight( var_2, var_1 );
}

delete_spawners( var_0 )
{
    if ( !isarray( var_0 ) )
        var_0 = [ var_0 ];

    foreach ( var_2 in var_0 )
    {
        foreach ( var_4 in getentarray( var_2, "script_noteworthy" ) )
        {
            if ( isspawner( var_4 ) )
                var_4 delete();
        }
    }
}

warbird_shooting_think( var_0 )
{
    level.player endon( "death" );
    self endon( "death" );
    self.mgturret[0] setmode( "manual" );
    self.mgturret[1] setmode( "manual" );

    if ( !maps\_utility::ent_flag_exist( "fire_turrets" ) )
        maps\_utility::ent_flag_init( "fire_turrets" );

    maps\_utility::ent_flag_set( "fire_turrets" );
    thread warbird_fire_monitor();

    for (;;)
    {
        self waittill( "warbird_fire" );
        thread warbird_fire( var_0 );
    }
}

warbird_fire( var_0 )
{
    self endon( "death" );
    var_1 = self.mgturret[0];
    var_2 = self.mgturret[1];
    var_3 = 3;

    while ( maps\_utility::ent_flag( "fire_turrets" ) )
    {
        var_4 = getaiarray( "allies" );

        if ( !maps\_utility::ent_flag_exist( "dont_shoot_player" ) || !maps\_utility::ent_flag( "dont_shoot_player" ) )
        {
            var_5 = 33;

            if ( randomint( 100 ) <= var_5 )
                var_4 = common_scripts\utility::array_add( var_4, level.player );
        }

        var_6 = [];

        foreach ( var_8 in var_4 )
        {
            if ( isdefined( var_8.ignoreme ) && var_8.ignoreme )
                continue;
            else
                var_6[var_6.size] = var_8;
        }

        var_6 = sortbydistance( var_6, self.origin );
        var_10 = undefined;

        foreach ( var_8 in var_6 )
        {
            if ( !isdefined( var_8 ) )
                continue;

            if ( !isalive( var_8 ) )
                continue;

            if ( isdefined( var_0 ) && var_0 )
            {
                var_12 = self.mgturret[0] gettagorigin( "tag_flash" );
                var_13 = var_8 geteye();
                var_14 = vectornormalize( var_13 - var_12 );
                var_15 = var_13 + var_14 * 20;

                if ( !sighttracepassed( var_15, var_13, 0, var_8, self.mgturret[0] ) )
                    continue;
            }

            var_10 = var_8;
            break;
        }

        if ( isdefined( var_10 ) )
        {
            var_1 settargetentity( var_10 );
            var_2 settargetentity( var_10 );
            var_1 turretfireenable();
            var_2 turretfireenable();
            var_1 startfiring();
            var_2 startfiring();
            wait_for_warbird_fire_target_done( var_10, var_0 );
            var_1 cleartargetentity();
            var_2 cleartargetentity();
            var_1 turretfiredisable();
            var_2 turretfiredisable();
        }

        wait(var_3);
    }

    var_1 turretfiredisable();
    var_2 turretfiredisable();
}

wait_for_warbird_fire_target_done( var_0, var_1 )
{
    var_0 endon( "death" );

    if ( !maps\_utility::ent_flag( "fire_turrets" ) )
        return;

    self endon( "fire_turrets" );

    if ( var_0 == level.player )
        var_2 = 0.6;
    else
        var_2 = 3;

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

warbird_fire_monitor()
{
    self endon( "death" );
    self waittill( "warbird_stop_firing" );
    maps\_utility::ent_flag_clear( "fire_turrets" );
}

add_enemy_flashlight()
{
    playfxontag( common_scripts\utility::getfx( "flashlight_ai" ), self, "tag_flash" );
    self.have_flashlight = 1;
}

assign_cloak_model( var_0 )
{
    self.cloakedmodel = var_0;
    self.defaultmodel = self.model;
}

cloak_on( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( !isdefined( var_1 ) )
        var_1 = 0.75;

    var_2 = 0;
    self setmodel( self.cloakedmodel );

    if ( issubstr( self.model, "burke" ) || issubstr( self.model, "knox" ) )
    {
        wait 0.05;
        self overridematerial( "mtl_burke_sentinel_covert_headgear_a", "mc/mtl_burke_sentinel_covert_headgear_a_cloak" );
    }

    if ( issubstr( self.model, "cormack" ) )
    {
        wait 0.05;
        self overridematerial( "mtl_cormack_sentinel_covert_headgear_a", "mc/mtl_cormack_sentinel_covert_headgear_a_cloak" );
    }

    self drawpostresolve();
    self setmaterialscriptparam( 0.0, var_1 );
    soundscripts\_snd::snd_message( "npc_cloak_enable" );

    if ( var_0 )
        cloak_stencil_on();

    self.cloak = "on";
    wait 0.1;
    maps\_cloak::set_cloak_material_for_npc_weapon();
}

turn_on_the_cloak_effect_wallclimb()
{
    level._cloaked_stealth_settings.cloak_on = 1;
    soundscripts\_snd::snd_message( "exo_cloak_enable" );

    if ( level._cloaked_stealth_settings.visibility_range_version == 1 )
        maps\_stealth_utility::stealth_detect_ranges_set( level._cloaked_stealth_settings.ranges["cloak_on_hidden"], level._cloaked_stealth_settings.ranges["cloak_on_spotted"] );

    thread maps\_cloak::cloak_vm_weapon_blend();

    if ( isdefined( level.scr_model["player_rig"] ) )
        level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";

    if ( isdefined( level.player_rig ) )
    {
        level.player_rig setmaterialscriptparam( 1.0, 0.0 );
        level.player_rig setmodel( level.scr_model["player_rig"] );
        wait 0.05;
        level.player_rig drawpostresolve();
        level.player_rig setmaterialscriptparam( 1.0, 0.0 );
        wait 0.05;
        level.player_rig setmaterialscriptparam( 0.0, 0.75 );
        level.player_rig hudoutlineenable( 0 );
    }
}

cloak_stencil_on( var_0 )
{
    thread maps\_cloak::setalertstencilstate( var_0 );
}

cloak_off( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1.0;

    var_1 = 0;
    soundscripts\_snd::snd_message( "npc_cloak_disable" );
    self setmaterialscriptparam( 1.0, var_0 );
    wait(var_0);
    self overridematerialreset();
    self drawpostresolveoff();

    if ( issubstr( self.name, "Knox" ) )
    {
        if ( isdefined( level.rope_knox ) && isdefined( level.carabiner_knox ) )
        {
            level.rope_knox cloak_off_rope();
            level.carabiner_knox cloak_off_rope( 0.2 );
        }
    }

    self setmodel( self.defaultmodel );
    thread maps\_cloak::clearalertstencilstate();
    self.cloak = "off";
}

cloak_off_rope( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1.0;

    self setmaterialscriptparam( 1.0, var_0 );
    self overridematerialreset();
    self drawpostresolveoff();
}

am_i_moving()
{
    wait 0.1;
    var_0 = maps\_shg_utility::get_differentiated_velocity();

    if ( length( var_0 ) != 0 )
        return 1;
    else
        return 0;
}

any_enemy_is_able_to_attack()
{
    if ( common_scripts\utility::flag( "_stealth_spotted" ) )
    {
        foreach ( var_1 in getaispeciesarray( "bad_guys", "all" ) )
        {
            if ( var_1.alertlevel == "combat" && isdefined( var_1.enemy ) && var_1 cansee( var_1.enemy ) )
                return 1;
        }
    }

    return 0;
}

prevent_friendly_from_shooting_during_stealth()
{
    var_0 = 0.3;

    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_obj_bio_weapons_04" ) || common_scripts\utility::flag( "flag_post_breach_patrol_alerted" ) )
        {
            self.dontevershoot = undefined;
            maps\_utility::set_ignoreall( 0 );
            return;
        }

        if ( !common_scripts\utility::flag( "_stealth_enabled" ) || any_enemy_is_able_to_attack() )
        {
            self.dontevershoot = undefined;
            maps\_utility::set_ignoreall( 0 );
        }
        else
        {
            self.dontevershoot = 1;
            maps\_utility::set_ignoreall( 1 );
        }

        wait(var_0);
    }
}

do_scanner_sounds()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = line_segment_end_point( self.scanner_origin, self.scanner_yaw, self.scanner_tilt, self.cone_length );
        var_1 = bullettrace( self.scanner_origin, var_0, 1 );
        var_2 = var_1["position"];
        self notify( "update_seeker_audio", var_2 );
        wait 0.05;
    }
}

do_scanner_fx()
{
    self endon( "death" );
    var_0 = 0;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_5 = common_scripts\utility::spawn_tag_origin();
    playfxontag( common_scripts\utility::getfx( self.fx_target_none ), var_5, "tag_origin" );
    thread do_scanner_death( var_5 );

    for (;;)
    {
        update_vfx_tags( self.scanner_origin, self.scanner_yaw, self.scanner_tilt, self.vertical_cone_range, self.horizontal_cone_range, var_1, var_2, var_3, var_4, var_5 );

        if ( var_0 )
        {
            if ( isdefined( self.scanner_cone_inside_ents ) && self.scanner_cone_inside_ents.size == 0 || !isdefined( self.scanner_cone_inside_ents ) && !level.player_is_in_scanner_cone )
            {
                var_0 = 0;
                playfxontag( common_scripts\utility::getfx( self.fx_target_none ), var_5, "tag_origin" );
                stopfxontag( common_scripts\utility::getfx( self.fx_target_locked ), var_5, "tag_origin" );
                self notify( "update_fixed_scanner_audio", 0 );
            }
        }
        else if ( isdefined( self.scanner_cone_inside_ents ) && self.scanner_cone_inside_ents.size > 0 || !isdefined( self.scanner_cone_inside_ents ) && level.player_is_in_scanner_cone )
        {
            var_0 = 1;
            playfxontag( common_scripts\utility::getfx( self.fx_target_locked ), var_5, "tag_origin" );
            stopfxontag( common_scripts\utility::getfx( self.fx_target_none ), var_5, "tag_origin" );
            self notify( "update_fixed_scanner_audio", 1 );
        }

        wait 0.05;
    }
}

attach_fixed_scanner( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self.scanner_cone_inside_ents = [];
    stopfxontag( common_scripts\utility::getfx( var_5 ), self, "tag_fx" );
    self endon( "death" );

    if ( self.health < 0 )
        return;

    self.scanner_origin = self gettagorigin( "tag_fx" );
    self.scanner_yaw = var_2;
    self.scanner_tilt = var_3;
    self.cone_length = var_0;
    self.horizontal_cone_range = var_1;
    self.vertical_cone_range = var_1;
    self.fx_target_locked = var_4;
    self.fx_target_none = var_5;
    thread do_scanner_fx();

    if ( 0 )
        thread do_tuning();

    thread draw_scanner_cone_loop();
    thread maps\_shg_utility::make_emp_vulnerable();
    self.emp_death_function = ::scanner_monitor_emp_damage;
    self makeentitysentient( "axis" );
    var_6 = getaiarray( "allies" );
    var_6[var_6.size] = level.player;

    for (;;)
    {
        foreach ( var_8 in var_6 )
        {
            if ( !isalive( var_8 ) )
            {
                var_6 = maps\_utility::array_removedead( var_6 );
                remove_dead_bodies_from_cone( var_6 );
                continue;
            }

            var_9 = var_8 getentitynumber();
            var_10 = var_8 getpointinbounds( 0, 0, 0 );
            var_11 = in_scanner_cone( var_10, self.scanner_origin, self.scanner_yaw, self.scanner_tilt, self.cone_length, self.horizontal_cone_range );

            if ( var_11 )
            {
                if ( !isdefined( self.scanner_cone_inside_ents[var_9] ) )
                {
                    self.scanner_cone_inside_ents[var_9] = 1;
                    handle_actor_enter_scanner( var_8 );
                }
            }
            else if ( isdefined( self.scanner_cone_inside_ents[var_9] ) )
                self.scanner_cone_inside_ents[var_9] = undefined;

            if ( var_9 == level.player getentitynumber() )
                level.player_is_in_scanner_cone = var_11;
        }

        wait 0.25;
    }
}

scanner_monitor_emp_damage()
{
    self notify( "damage", 9999999, self, ( 0, 0, 0 ), self.origin, "MOD_EXPLOSIVE", "", "" );
    self notify( "death" );
}

handle_actor_enter_scanner( var_0 )
{
    if ( var_0 getentitynumber() == level.player getentitynumber() )
    {
        maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
        var_0 shellshock( "flashbang", 3 );
    }
    else
    {
        var_0 cloak_off();
        var_0 maps\_utility::flashbangstart( 2.0 );
    }
}

do_scanner_death( var_0 )
{
    self waittill( "death" );

    if ( issentient( self ) )
        self freeentitysentient();

    stopfxontag( common_scripts\utility::getfx( self.fx_target_none ), var_0, "tag_origin" );
    stopfxontag( common_scripts\utility::getfx( self.fx_target_locked ), var_0, "tag_origin" );
}

remove_dead_bodies_from_cone( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( self.scanner_cone_inside_ents[var_3 getentitynumber()] ) )
            var_1[var_3 getentitynumber()] = 1;
    }

    self.scanner_cone_inside_ents = var_1;
}

draw_scanner_cone_loop()
{
    self endon( "death" );

    for (;;)
    {
        draw_scanner_cone( self.scanner_cone_inside_ents.size, self.scanner_origin, self.scanner_yaw, self.scanner_tilt, self.scanner_origin, self.scanner_origin, self.cone_length, self.horizontal_cone_range, self.horizontal_cone_range );
        wait 0.05;
    }
}

do_tuning()
{
    for (;;)
    {
        if ( level.player buttonpressed( "DPAD_UP" ) )
            self.scanner_tilt -= 1.0;

        if ( level.player buttonpressed( "DPAD_DOWN" ) )
            self.scanner_tilt += 1.0;

        if ( level.player buttonpressed( "DPAD_LEFT" ) )
            self.scanner_yaw -= 1.0;

        if ( level.player buttonpressed( "DPAD_RIGHT" ) )
            self.scanner_yaw += 1.0;

        if ( level.player buttonpressed( "BUTTON_X" ) )
        {
            self.horizontal_cone_range -= 0.1;
            self.vertical_cone_range -= 0.1;
        }

        if ( level.player buttonpressed( "BUTTON_Y" ) )
        {
            self.horizontal_cone_range += 0.1;
            self.vertical_cone_range += 0.1;
        }

        if ( level.player buttonpressed( "BUTTON_LSTICK" ) )
            self.cone_length -= 10.0;

        if ( level.player buttonpressed( "BUTTON_RSTICK" ) )
            self.cone_length += 10.0;

        var_0 = " tilt:" + self.scanner_tilt + " yaw:" + self.scanner_yaw + " range:" + self.horizontal_cone_range + " length:" + self.cone_length;

        if ( level.player buttonpressed( "DPAD_UP" ) || level.player buttonpressed( "DPAD_DOWN" ) || level.player buttonpressed( "DPAD_LEFT" ) || level.player buttonpressed( "DPAD_RIGHT" ) || level.player buttonpressed( "BUTTON_X" ) || level.player buttonpressed( "BUTTON_Y" ) || level.player buttonpressed( "BUTTON_LSTICK" ) || level.player buttonpressed( "BUTTON_RSTICK" ) )
        {

        }

        waitframe();
    }
}

enable_all_fixed_scanners()
{
    level.camera_array = getentarray( "camera_breach", "script_noteworthy" );
    var_0 = getentarray( "camera_scanner_interior", "script_noteworthy" );
    level.camera_array = common_scripts\utility::array_combine( level.camera_array, var_0 );
    var_0 = undefined;
    common_scripts\utility::array_thread( level.camera_array, ::camera_scanner_think );
}

camera_scanner_think()
{
    var_0 = undefined;

    if ( isdefined( self.target ) )
    {
        var_0 = getent( self.target, "targetname" );
        var_0 enableaimassist();
        var_0.maxhealth = 1;
        var_0 setnormalhealth( var_0.maxhealth );
        target_set( var_0, ( 0, 0, -80 ) );
        target_setjavelinonly( var_0, 1 );
    }

    if ( !isdefined( self.scanner_cone_inside_ents ) )
        thread attach_fixed_scanner( 300, 60, angleclamp( 180 + self.angles[1] ), self.angles[0], "camera_fixed_scanner", "camera_fixed_scanner_search" );

    soundscripts\_snd::snd_message( "start_fixed_scanner_audio" );
    self waittill( "death" );

    if ( common_scripts\utility::flag( "flag_facility_breach_complete" ) )
        thread maps\lab_vo::camera_scanner_interior_killed();

    if ( isdefined( var_0 ) )
        var_0 delete();
}

disable_all_fixed_scanners()
{
    if ( isdefined( level.camera_array ) )
    {
        foreach ( var_1 in level.camera_array )
        {
            if ( isdefined( var_1.scanner_cone_inside_ents ) )
                self notify( "death" );

            var_1 notify( "stop_fixed_scanner_audio" );
        }
    }
}

do_vehicle_scanner_tuning()
{
    for (;;)
    {
        if ( level.player buttonpressed( "DPAD_UP" ) )
            self.scanner_tilt -= 1.0;

        if ( level.player buttonpressed( "DPAD_DOWN" ) )
            self.scanner_tilt += 1.0;

        if ( level.player buttonpressed( "BUTTON_LSTICK" ) )
            self.cone_length -= 10.0;

        if ( level.player buttonpressed( "BUTTON_RSTICK" ) )
            self.cone_length += 10.0;

        if ( level.player buttonpressed( "DPAD_LEFT" ) )
            self.scanner_offset_from_vehicle_facing -= 1.0;

        if ( level.player buttonpressed( "DPAD_RIGHT" ) )
            self.scanner_offset_from_vehicle_facing += 1.0;

        if ( level.player buttonpressed( "BUTTON_X" ) )
            self.sweep_range -= 0.1;

        if ( level.player buttonpressed( "BUTTON_Y" ) )
            self.sweep_range += 0.1;

        var_0 = " tilt:" + self.scanner_tilt + " offset:" + self.scanner_offset_from_vehicle_facing + " range:" + self.sweep_range + " length:" + self.cone_length;
        wait 0.05;
    }
}

attach_scanner( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 )
{
    if ( !isdefined( level.player_is_in_scanner_cone ) )
        level.player_is_in_scanner_cone = 0;

    var_13 = 120;
    var_14 = 1;
    var_15 = var_14 * anglestoforward( self.angles );
    self.scanner_origin = self.origin + ( 0, 0, var_13 ) + var_15;
    self.scanner_tilt = var_9;
    self.sweep_range = var_4;
    self.vertical_cone_range = var_1;
    self.horizontal_cone_range = var_2;
    self.cone_length = var_0;
    self.scanner_offset_from_vehicle_facing = var_3;
    self.fx_target_locked = var_11;
    self.fx_target_none = var_12;
    init_scanner_yaw( self.sweep_range );
    thread do_scanner_fx();
    thread do_scanner_sounds();
    var_16 = 0;
    var_17 = 166;
    var_18 = 0;
    var_19 = 102;
    start_sweep_mode_func();

    for (;;)
    {
        var_15 = var_14 * anglestoforward( self.angles );
        self.scanner_origin = self.origin + ( 0, 0, var_13 ) + var_15;
        var_20 = level.player getpointinbounds( 0, 0, 0 );

        if ( self.scanner_mode == 0 )
        {
            update_scanner_yaw_in_sweep_mode( self.scanner_offset_from_vehicle_facing, self.sweep_range, var_5, var_6, var_7, var_8 );
            level.player_is_in_scanner_cone = in_scanner_cone( var_20, self.scanner_origin, self.scanner_yaw, self.scanner_tilt, var_0, var_2 );

            if ( level.player_is_in_scanner_cone )
            {
                common_scripts\utility::flag_set( "_stealth_spotted" );
                maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
                exit_sweep_mode_func();
                enter_track_player_mode_func();
            }
        }
        else if ( self.scanner_mode == 1 )
        {
            level.player_is_in_scanner_cone = in_scanner_cone( var_20, self.scanner_origin, self.scanner_yaw, self.scanner_tilt, var_0, var_2 );

            if ( level.player_is_in_scanner_cone )
                update_scanner_direction_in_track_player_mode( var_20, self.scanner_origin );
            else
                enter_lost_player_mode_func();
        }
        else if ( self.scanner_mode == 2 )
        {
            if ( self.state_timer > 0 )
                self.state_timer -= 0.05;
            else
                enter_return_to_sweep_mode_func();
        }
        else if ( self.scanner_mode == 3 )
        {
            level.player_is_in_scanner_cone = in_scanner_cone( var_20, self.scanner_origin, self.scanner_yaw, self.scanner_tilt, var_0, var_2 );

            if ( level.player_is_in_scanner_cone )
            {
                maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
                exit_return_to_sweep_mode_func();
                enter_track_player_mode_func();
            }
            else
            {
                var_21 = update_scanner_yaw_returning_to_sweep_mode( self.scanner_offset_from_vehicle_facing, self.sweep_range, var_5, var_9, var_10 );

                if ( var_21 )
                {
                    exit_return_to_sweep_mode_func();
                    enter_sweep_mode_func();
                }
            }
        }

        var_16 += var_17;

        if ( var_16 > 360 )
            var_16 -= 360;

        var_18 += var_19;

        if ( var_18 > 360 )
            var_18 -= 360;

        if ( 0 )
            draw_scanner_cone( level.player_is_in_scanner_cone, self.scanner_origin, self.scanner_yaw, self.scanner_tilt, var_16, var_18, self.cone_length, self.vertical_cone_range, self.horizontal_cone_range );

        wait 0.05;
    }
}

precache_scanner_turret()
{
    var_0 = "scanner_vrap_turret";
    var_1 = "weapon_pitbull_turret";
    precachemodel( var_1 );
    precacheturret( var_0 );
}

attach_scanner_turret()
{
    if ( !isdefined( level.player_is_in_scanner_cone ) )
        level.player_is_in_scanner_cone = 0;

    var_0 = "scanner_vrap_turret";
    var_1 = "tag_turret";
    var_2 = "weapon_pitbull_turret";
    var_3 = undefined;
    var_4 = "auto_ai";
    var_5 = 0.2;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = spawnturret( "misc_turret", ( 0, 0, 0 ), var_0 );
    var_9 linkto( self, var_1, ( 0, 0, 0 ), ( 0, -1 * var_7, 0 ) );
    var_9 setmodel( var_2 );
    var_9.angles = self.angles;
    var_9.isvehicleattached = 1;
    var_9.ownervehicle = self;
    var_9.script_team = self.script_team;
    var_9 thread maps\_mgturret::burst_fire_unmanned();
    var_9 makeunusable();
    maps\_vehicle_code::set_turret_team( var_9 );
    maps\_mgturret::mg42_setdifficulty( var_9, maps\_utility::getdifficulty() );
    var_9.script_fireondrones = var_8;
    var_9.deletedelay = var_5;
    var_9.maxrange = var_3;
    var_9 setdefaultdroppitch( var_6 );
    var_9 maps\_vehicle_code::turret_set_default_on_mode( var_4 );
    var_9 setmode( var_9.defaultonmode );
    var_9 startbarrelspin();
    var_10 = 1.5;
    var_11 = 0.1;
    var_12 = 2.0;

    for (;;)
    {
        var_13 = var_9 getmode();

        if ( level.player_is_in_scanner_cone == 1 )
        {
            if ( var_13 != "manual" )
            {
                self playloopsound( "seeker_alarm_lp" );
                wait(var_12);
                self stoploopsound( "seeker_alarm_lp" );
                var_9 setmode( "manual" );
                var_9 settargetentity( level.player );
            }

            var_9 waittill( "turret_on_target" );

            for ( var_14 = var_10; var_14 > 0.0; var_14 -= var_11 )
            {
                var_9 shootturret();
                wait(var_11);
            }
        }
        else if ( var_13 != "auto_ai" )
        {
            var_9 setmode( "auto_ai" );
            var_9 cleartargetentity( level.player );
        }

        wait 0.1;
    }
}

start_sweep_mode_func()
{
    self.scanner_mode = 0;
    soundscripts\_snd::snd_message( "start_seeker_audio" );
    init_scanner_yaw( self.sweep_range );
}

enter_sweep_mode_func()
{
    self.scanner_mode = 0;
    init_scanner_yaw( self.sweep_range );
}

exit_sweep_mode_func()
{

}

enter_track_player_mode_func()
{
    self notify( "stop_seeker_audio" );
    self.scanner_mode = 1;
    var_0 = level.player.origin;

    if ( isdefined( self.script_stealthgroup ) && isdefined( level._stealth.group.groups[maps\_utility::string( self.script_stealthgroup )] ) )
    {
        var_1 = maps\_stealth_shared_utilities::group_get_ai_in_group( maps\_utility::string( self.script_stealthgroup ) );

        foreach ( var_4, var_3 in var_1 )
        {
            if ( var_3 == self )
                continue;

            if ( isdefined( var_3.enemy ) || isdefined( var_3.favoriteenemy ) )
                continue;

            var_3 notify( "heard_alarm", var_0 );
        }
    }
}

enter_lost_player_mode_func()
{
    self.scanner_mode = 2;
    self.state_timer = 2.4;
}

enter_return_to_sweep_mode_func()
{
    soundscripts\_snd::snd_message( "start_seeker_audio" );
    self.scanner_mode = 3;
}

exit_return_to_sweep_mode_func()
{

}

init_scanner_yaw( var_0 )
{
    self.scanner_yaw = -41;
    self.scanner_local_yaw = -0.5 * var_0;
    self.scanner_local_velocity = 0.0;
    self.scanner_pause_timer = 0;
    self.scanner_sweep_direction = 1;
}

update_scanner_yaw_in_sweep_mode( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = 0.65;

    if ( self.scanner_pause_timer > 0 )
        self.scanner_pause_timer -= 0.05;
    else if ( self.scanner_sweep_direction > 0.0 )
    {
        var_7 = 0.5 * self.scanner_local_velocity * self.scanner_local_velocity / var_4;

        if ( self.scanner_local_yaw + var_7 > 0.5 * var_1 )
        {
            self.scanner_local_velocity -= 0.05 * var_4;

            if ( self.scanner_local_velocity < 0.0 )
                self.scanner_local_velocity = 0.0;
        }
        else
        {
            self.scanner_local_velocity += 0.05 * var_3;

            if ( self.scanner_local_velocity > var_2 )
                self.scanner_local_velocity = var_2;
        }

        self.scanner_local_yaw += 0.05 * self.scanner_local_velocity;

        if ( self.scanner_local_yaw > var_1 * ( var_6 - 0.5 ) )
        {
            if ( !common_scripts\utility::flag( "flag_seeker_cone_safe_right" ) )
                common_scripts\utility::flag_set( "flag_seeker_cone_safe_right" );
        }

        if ( self.scanner_local_velocity <= 0.0 )
        {
            self.scanner_pause_timer = var_5;
            self.scanner_sweep_direction = -1;
            common_scripts\utility::flag_clear( "flag_seeker_cone_safe_right" );
        }
    }
    else
    {
        var_7 = 0.5 * self.scanner_local_velocity * self.scanner_local_velocity / var_4;

        if ( self.scanner_local_yaw - var_7 < -0.5 * var_1 )
        {
            self.scanner_local_velocity += 0.05 * var_4;

            if ( self.scanner_local_velocity > 0.0 )
                self.scanner_local_velocity = 0.0;
        }
        else
        {
            self.scanner_local_velocity -= 0.05 * var_3;

            if ( self.scanner_local_velocity < -1 * var_2 )
                self.scanner_local_velocity = -1 * var_2;
        }

        self.scanner_local_yaw += 0.05 * self.scanner_local_velocity;

        if ( self.scanner_local_yaw < var_1 * ( 0.5 - var_6 ) )
        {
            if ( !common_scripts\utility::flag( "flag_seeker_cone_safe_left" ) )
                common_scripts\utility::flag_set( "flag_seeker_cone_safe_left" );
        }

        if ( self.scanner_local_velocity >= 0.0 )
        {
            self.scanner_pause_timer = var_5;
            self.scanner_sweep_direction = 1;
            common_scripts\utility::flag_clear( "flag_seeker_cone_safe_left" );
        }
    }

    var_8 = self.angles[1];
    self.scanner_yaw = var_8 - var_0 + self.scanner_local_yaw;
}

update_scanner_direction_in_track_player_mode( var_0, var_1 )
{
    var_2 = var_0 - var_1;
    var_3 = angleclamp360( var_2[1], var_2[0] );
    var_4 = length2d( var_2 );
    var_5 = angleclamp360( var_2[2], var_4 );
    self.scanner_tilt = var_5;
    self.scanner_yaw = var_3;
}

update_scanner_yaw_returning_to_sweep_mode( var_0, var_1, var_2, var_3, var_4 )
{
    self.scanner_pause_timer = 0;
    var_5 = self.angles[1];
    var_6 = var_5 - var_0 - 0.5 * var_1;
    var_7 = var_6 - self.scanner_yaw;
    var_8 = 0;

    if ( var_7 > 1 )
        self.scanner_yaw += 0.05 * var_2;
    else if ( var_7 < -1 )
        self.scanner_yaw -= 0.05 * var_2;
    else
    {
        var_8 = 1;
        self.scanner_yaw = var_6;
    }

    self.scanner_local_yaw = self.scanner_yaw - var_5 + var_0;
    var_9 = var_3 - self.scanner_tilt;
    var_10 = 0;

    if ( var_9 > 1 )
        self.scanner_tilt += 0.05 * var_4;
    else if ( var_9 < -1 )
        self.scanner_tilt -= 0.05 * var_4;
    else
    {
        var_10 = 1;
        self.scanner_tilt = var_3;
    }

    return var_8 && var_10;
}

yaw_tilt_to_direction_vector( var_0, var_1 )
{
    var_2 = cos( var_1 );
    return ( cos( var_0 ) * var_2, sin( var_0 ) * var_2, sin( var_1 ) );
}

line_segment_end_point( var_0, var_1, var_2, var_3 )
{
    return var_0 + var_3 * yaw_tilt_to_direction_vector( var_1, var_2 );
}

update_vfx_tags( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_5.origin = var_0;
    var_6.origin = var_0;
    var_7.origin = var_0;
    var_8.origin = var_0;
    var_9.origin = var_0;
    var_5.angles = vectortoangles( yaw_tilt_to_direction_vector( var_1 - var_4 / 2, var_2 + var_3 / 2 ) );
    var_6.angles = vectortoangles( yaw_tilt_to_direction_vector( var_1 + var_4 / 2, var_2 - var_3 / 2 ) );
    var_7.angles = vectortoangles( yaw_tilt_to_direction_vector( var_1 - var_4 / 2, var_2 - var_3 / 2 ) );
    var_8.angles = vectortoangles( yaw_tilt_to_direction_vector( var_1 + var_4 / 2, var_2 + var_3 / 2 ) );
    var_9.angles = vectortoangles( yaw_tilt_to_direction_vector( var_1, var_2 ) );
}

draw_scanner_cone( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{

}

in_scanner_cone( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = var_0 - var_1;

    if ( lengthsquared( var_6 ) > var_4 * var_4 )
        return 0;

    var_7 = line_segment_end_point( var_1, var_2, var_3, var_4 );
    var_8 = var_7 - var_1;
    var_9 = cos( 0.5 * var_5 );

    if ( vectordot( vectornormalize( var_6 ), vectornormalize( var_8 ) ) <= var_9 )
        return 0;

    var_10 = 0;
    var_11 = bullettrace( var_1, var_0, var_10, self );

    if ( var_11["fraction"] < 1.0 )
        return 0;

    return 1;
}

player_looking_in_direction_2d( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0.8;

    var_4 = maps\_utility::get_player_from_self();
    var_5 = var_4 geteye();
    var_6 = vectortoangles( var_0 - var_5 );
    var_7 = anglestoforward( var_6 );
    var_8 = var_4 getangles();
    var_9 = anglestoforward( var_8 );
    var_7 = vectornormalize( ( var_7[0], var_7[1], 0 ) );
    var_9 = vectornormalize( ( var_9[0], var_9[1], 0 ) );
    var_10 = vectordot( var_7, var_9 );

    if ( var_10 < var_1 )
        return 0;

    if ( isdefined( var_2 ) )
        return 1;

    var_11 = bullettrace( var_0, var_5, 0, var_3 );
    return var_11["fraction"] == 1;
}

enable_takedown_hint( var_0, var_1, var_2 )
{
    self notify( "enable_takedown_hint_called" );
    self endon( "enable_takedown_hint_called" );
    level endon( "flag_se_vehicle_takedown_01_failed" );
    self endon( "takedown_failed" );
    var_3 = var_1 * var_1;

    if ( !isdefined( level.melee_hint_displayed ) )
        level.melee_hint_displayed = 0;

    if ( !common_scripts\utility::flag_exist( "flag_disable_takedown_hint" ) )
        common_scripts\utility::flag_init( "flag_disable_takedown_hint" );
    else
        common_scripts\utility::flag_clear( "flag_disable_takedown_hint" );

    level.melee_pressed = 0;
    level.should_display_melee_hint = 0;

    while ( !level.melee_pressed )
    {
        if ( common_scripts\utility::flag( "flag_disable_takedown_hint" ) )
        {
            if ( level.melee_hint_displayed )
                level.should_display_melee_hint = 0;

            common_scripts\utility::flag_clear( "flag_disable_takedown_hint" );
            return;
        }

        var_4 = distance2dsquared( var_0.origin, level.player.origin );

        if ( level.melee_hint_displayed )
        {
            if ( var_4 > var_3 + 10 )
                level.should_display_melee_hint = 0;

            if ( isdefined( level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim ) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1 )
                level.should_display_melee_hint = 0;

            if ( isdefined( var_2 ) && var_2 )
            {
                var_5 = var_0 geteye();
                var_6 = 0.9;

                if ( !level.player player_looking_in_direction_2d( var_5, var_6, 1 ) )
                    level.should_display_melee_hint = 0;
            }
        }
        else if ( var_4 <= var_3 )
        {
            var_7 = 1;

            if ( isdefined( level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim ) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1 )
                var_7 = 0;

            if ( isdefined( var_2 ) && var_2 )
            {
                var_5 = var_0 geteye();
                var_6 = 0.9;

                if ( !level.player player_looking_in_direction_2d( var_5, var_6, 1 ) )
                    var_7 = 0;
            }

            if ( var_7 )
            {
                level.should_display_melee_hint = 1;
                level.melee_hint_displayed = 1;
                level.player allowmelee( 0 );
                maps\_utility::display_hint_timeout( "takedown_hint", undefined );
            }
        }

        wait 0.05;
    }

    self notify( "player_completed_takedown" );
}

display_takedown_world_prompt_on_enemy( var_0 )
{
    level endon( "se_takedown_01_failed" );
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = ( -8039, 5301, -179 );

    while ( distance( self.origin, var_1.origin ) > 200 )
        wait 0.5;

    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.origin = self.origin + ( 0, 0, 52 );
    var_2 linkto( self, "tag_origin" );
    var_2 thread activate_takedown_world_prompt_on_enemy( var_0 );
}

activate_takedown_world_prompt_on_enemy( var_0 )
{
    var_1 = maps\_shg_utility::hint_button_tag( "melee", "tag_origin", 100, 200 );
    common_scripts\utility::waittill_any_ents( var_0, "player_completed_takedown", level, "flag_disable_takedown_hint" );
    var_1 maps\_shg_utility::hint_button_clear();
}

activate_takedown_world_prompt_on_truck_enemy( var_0 )
{
    var_1 = maps\_shg_utility::hint_button_tag( "melee", "j_neck", 100, 200 );
    common_scripts\utility::waittill_any_ents( var_0, "player_completed_takedown", level, "flag_disable_takedown_hint", self, "takedown_failed", level, "flag_se_vehicle_takedown_01_failed" );
    var_1 maps\_shg_utility::hint_button_clear();
}

takedown_hint_off()
{
    var_0 = 0;

    if ( level.player meleebuttonpressed() )
    {
        level.melee_pressed = 1;
        var_0 = 1;
    }

    if ( !level.should_display_melee_hint )
    {
        if ( !isdefined( level.player.disable_melee ) )
            level.player allowmelee( 1 );

        var_0 = 1;
    }

    if ( var_0 )
    {
        level.melee_hint_displayed = 0;
        return 1;
    }

    return 0;
}

disable_trigger_while_player_animating( var_0 )
{
    level endon( var_0 );

    for (;;)
    {
        if ( isdefined( level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim ) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1 )
        {
            if ( !isdefined( self.trigger_off ) )
                common_scripts\utility::trigger_off();
        }
        else if ( isdefined( self.trigger_off ) )
            common_scripts\utility::trigger_on();

        wait 0.05;
    }
}

bloody_death( var_0, var_1 )
{
    self endon( "death" );

    if ( !issentient( self ) || !isalive( self ) )
        return;

    if ( isdefined( self.bloody_death ) && self.bloody_death )
        return;

    self.bloody_death = 1;

    if ( isdefined( var_0 ) )
        wait(randomfloat( var_0 ));

    var_2 = [];
    var_2[0] = "j_hip_le";
    var_2[1] = "j_hip_ri";
    var_2[2] = "j_head";
    var_2[3] = "j_spine4";
    var_2[4] = "j_elbow_le";
    var_2[5] = "j_elbow_ri";
    var_2[6] = "j_clavicle_le";
    var_2[7] = "j_clavicle_ri";
    var_3 = getdvarint( "cg_fov" );

    for ( var_4 = 0; var_4 < 3 + randomint( 5 ); var_4++ )
    {
        var_5 = randomintrange( 0, var_2.size );
        thread bloody_death_fx( var_2[var_5], undefined );
        wait(randomfloat( 0.1 ));

        if ( isdefined( var_1 ) && isai( var_1 ) && isalive( var_1 ) )
        {
            if ( !level.player worldpointinreticle_circle( var_1.origin, var_3, 500 ) )
                var_1 shootblank();
        }
    }

    self dodamage( self.health + 50, self.origin );
}

bloody_death_fx( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level._effect["flesh_hit"];

    playfxontag( var_1, self, var_0 );
}

spawn_player_rig( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "player_rig";

    if ( !isdefined( var_1 ) )
        var_1 = level.player.origin;

    var_2 = maps\_utility::spawn_anim_model( var_0 );

    if ( maps\_cloak::is_player_cloaked() )
        var_2 maps\_cloak::set_cloak_on_model();

    return var_2;
}

ai_toggle_cloak_animate( var_0, var_1, var_2 )
{
    if ( common_scripts\utility::flag( "flag_logging_road_loud_combat" ) )
        return;

    level endon( "flag_logging_road_loud_combat" );

    if ( !isdefined( var_2 ) )
        var_2 = self.approachtype;

    var_3 = "";

    if ( issubstr( var_2, "right" ) )
        var_3 = "cornercrouch_right_cloak_toggle";
    else if ( issubstr( var_2, "left" ) )
        var_3 = "cornercrouch_left_cloak_toggle";
    else
        var_3 = "crouch_exposed_cloak_toggle";

    thread maps\lab_vo::ai_toggle_cloak_start_vo( var_0 );
    maps\_anim::anim_single_solo( self, var_3 );
    wait 1.5;
    maps\_anim::anim_single_solo( self, var_3 );
    thread maps\lab_vo::ai_toggle_cloak_complete_vo( var_1 );
}

ai_toggle_cloak( var_0 )
{
    if ( !isdefined( var_0.cloak ) || var_0.cloak == "off" )
        var_0 thread cloak_on();
    else
        var_0 cloak_off();
}

activate_trigger_when_player_jumps()
{
    self endon( "trigger" );
    self endon( "death" );

    for (;;)
    {
        if ( level.player istouching( self ) && !level.player isonground() )
            self notify( "trigger" );

        wait 0.05;
    }
}

spawn_metrics_init()
{
    level.spawn_metrics_spawn_count = [];
    level.spawn_metrics_death_count = [];
    maps\_utility::add_global_spawn_function( "axis", ::spawn_metrics_spawn_func );

    foreach ( var_1 in getaiarray( "axis" ) )
    {
        if ( !isspawner( var_1 ) && isalive( var_1 ) )
            var_1 spawn_metrics_spawn_func();
    }
}

spawn_metrics_spawn_func()
{
    if ( !isai( self ) )
        return;

    if ( isdefined( self.script_noteworthy ) )
    {
        if ( isdefined( level.spawn_metrics_spawn_count[self.script_noteworthy] ) )
            level.spawn_metrics_spawn_count[self.script_noteworthy] += 1;
        else
            level.spawn_metrics_spawn_count[self.script_noteworthy] = 1;

        thread spawn_metrics_death_watcher();
    }
}

spawn_metrics_death_watcher()
{
    var_0 = self.script_noteworthy;
    self waittill( "death" );

    if ( isdefined( level.spawn_metrics_death_count[var_0] ) )
        level.spawn_metrics_death_count[var_0] += 1;
    else
        level.spawn_metrics_death_count[var_0] = 1;
}

spawn_metrics_number_spawned( var_0 )
{
    if ( isarray( var_0 ) )
    {
        var_1 = 0;

        foreach ( var_3 in var_0 )
            var_1 += spawn_metrics_number_spawned( var_3 );

        return var_1;
    }

    if ( isdefined( level.spawn_metrics_spawn_count[var_0] ) )
        return level.spawn_metrics_spawn_count[var_0];
    else
        return 0;
}

spawn_metrics_number_died( var_0 )
{
    if ( isarray( var_0 ) )
    {
        var_1 = 0;

        foreach ( var_3 in var_0 )
            var_1 += spawn_metrics_number_died( var_3 );

        return var_1;
    }

    if ( isdefined( level.spawn_metrics_death_count[var_0] ) )
        return level.spawn_metrics_death_count[var_0];
    else
        return 0;
}

spawn_metrics_number_alive( var_0 )
{
    return spawn_metrics_number_spawned( var_0 ) - spawn_metrics_number_died( var_0 );
}

spawn_metrics_waittill_count_reaches( var_0, var_1, var_2 )
{
    if ( !isarray( var_1 ) )
        var_1 = [ var_1 ];

    waittillframeend;

    for (;;)
    {
        var_3 = 0;

        foreach ( var_5 in var_1 )
            var_3 += spawn_metrics_number_alive( var_5 );

        if ( var_3 <= var_0 )
            break;

        wait 1;
    }
}

spawn_metrics_waittill_deaths_reach( var_0, var_1, var_2 )
{
    if ( !isarray( var_1 ) )
        var_1 = [ var_1 ];

    for (;;)
    {
        var_3 = 0;

        foreach ( var_5 in var_1 )
            var_3 += spawn_metrics_number_died( var_5 );

        if ( var_3 >= var_0 )
            break;

        wait 1;
    }
}

move_hovertank_to_start( var_0 )
{
    var_1 = getent( "hovertank", "targetname" );
    var_2 = common_scripts\utility::getstruct( var_0, "script_noteworthy" );
    var_1.origin = var_2.origin;

    if ( isdefined( var_2.angles ) )
        var_1.angles = var_2.angles;
}

kill_when_player_not_looking()
{
    self endon( "death" );

    for (;;)
    {
        if ( !maps\_utility::player_looking_at( self.origin ) )
        {
            bloody_death();
            break;
        }

        wait 1;
    }
}

can_tip_think()
{
    self endon( "death" );
    var_0 = 200;
    var_1 = 135;
    var_2 = spawn( "trigger_radius", self.origin, 0, var_0, 196 );
    var_3 = level.player;
    var_4 = 1;
    var_5 = 0.05;
    var_6 = 1;
    var_7 = 3;
    var_8 = 200;
    var_9 = 300;

    for (;;)
    {
        var_2 waittill( "trigger", var_10 );

        if ( var_10 != var_3 )
            continue;

        var_11 = spawn( "script_origin", self.origin );
        var_11.angles = vectortoangles( self.origin - level.player.origin );
        var_12 = 0;

        if ( isdefined( level.player.driving_hovertank ) )
            var_12 = level.player.driving_hovertank vehicle_getvelocity();
        else
            var_12 = level.player getvelocity();

        var_4 = var_6 + ( var_7 - var_6 ) * ( 1 - length( var_12 ) / var_8 );

        if ( var_4 < var_6 )
            var_4 = var_6;
        else if ( var_4 > var_7 )
            var_4 = var_7;

        self linkto( var_11 );
        var_11 rotateto( ( var_1, var_11.angles[1], var_11.angles[2] ), var_4 );
        var_11 movez( -1 * var_9, var_4 );
        earthquake( 0.25, var_4, self.origin, 300 );
        level.player playrumbleonentity( "damage_heavy" );
        wait(var_4);
        var_11 delete();
        var_2 delete();
        self delete();
    }
}

script_destructible_tree_think()
{
    var_0 = self;
    self endon( "stop_thinking" );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5 );

        if ( var_2 == level.player )
            break;
    }

    var_0 = spawn( "script_model", self.origin );

    if ( isdefined( self.angles ) )
        var_0.angles = self.angles;

    var_0 setmodel( "lab_tank_battle_sequoia_02_1b" );
    var_6 = spawn( "script_model", self.origin + ( 0, 0, 96 ) );

    if ( isdefined( self.angles ) )
        var_6.angles = self.angles;

    var_6 setmodel( "lab_tank_battle_sequoia_02_1t" );
    var_7 = angleclamp360( var_4[1] - var_6.origin[1], var_4[0] - var_6.origin[0] ) + 180;

    if ( var_7 > 360 )
        var_7 -= 360;

    var_8 = ( var_4[0] - var_6.origin[0], var_4[1] - var_6.origin[1], 0 );
    var_9 = vectortoangles( var_8 );
    var_10 = anglestoforward( var_3 );
    var_11 = anglestoup( var_3 );
    playfx( common_scripts\utility::getfx( "tree_explosion" ), var_4, var_10, var_11 );
    var_12 = cos( 45 );
    var_13 = sin( 45 );
    var_14 = 10;
    var_15 = 1.5;
    var_16 = 3.5;
    var_17 = randomintrange( var_14 * -1, var_14 );
    var_18 = randomintrange( var_14 * -1, var_14 );
    var_19 = abs( var_17 ) + abs( var_18 );
    var_20 = var_19 / var_14 * 2 * ( var_16 - var_15 ) + var_15;
    var_6 rotateby( ( var_17, 0, var_18 ), var_20, 0, var_20 );
}

log_pile_scripted_think()
{
    self setcandamage( 1 );
    var_0 = 0;

    while ( !var_0 )
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( var_2 != level.player )
            continue;

        common_scripts\utility::flag_set( "flag_log_pile_scripted_destroyed" );
        soundscripts\_snd::snd_message( "log_pile_collapse", self );
        var_0 = 1;
        var_10 = common_scripts\utility::get_target_ent();

        foreach ( var_12 in getaiarray( "axis" ) )
        {
            var_12 kill();
            var_12 startragdoll();
        }

        physicsexplosionsphere( self.origin, 200, 199, 50 );
        wakeupphysicssphere( self.origin, 900 );
    }

    self delete();
}

destructible_trailer_collision_think()
{
    self setcandamage( 1 );
    thread destructible_trailer_collision_destroy_when_player_close();
    var_0 = 0;

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_ENERGY" || var_1 < 10 )
            continue;
        else
            break;
    }

    wakeupphysicssphere( var_4, 80 );
    physicsexplosionsphere( var_4, 80, 79, 10 );
    soundscripts\_snd::snd_message( "tank_shack_destruct", var_4 );
    self delete();
}

destructible_trailer_collision_destroy_when_player_close()
{
    self endon( "death" );
    var_0 = 200;
    var_1 = var_0 * var_0;
    var_2 = spawn( "trigger_radius", self.origin + ( 0, 0, -100 ), 0, 250, 300 );
    var_2 waittill( "trigger", var_3 );
    self notify( "damage", 50, var_3, var_3.origin - self.origin, self.origin, "MOD_EXPLOSIVE" );
    earthquake( 0.25, 0.25, var_3.origin, 300 );
    var_3 playrumbleonentity( "damage_heavy" );
}

large_propane_tank_think()
{
    var_0 = self.origin;
    self waittill( "death" );
    physicsexplosionsphere( var_0, 900, 850, 60 );
    wakeupphysicssphere( var_0, 900 );
}

hovertank_enemy_outline( var_0 )
{
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        var_0 = 4;

    thread clear_enemy_outline_on_death();
    self.highlight = 0;
    self.highlight_forced = 0;
    thread manage_highlight( var_0 );
    thread highlight_when_weapon_fired( var_0 );
    var_1 = ( 0, 0, 32 );

    if ( isai( self ) )
        hovertank_enemy_outline_ai();
    else
        hovertank_enemy_outline_vehicle();
}

hovertank_enemy_outline_ai()
{
    self endon( "death" );

    while ( !target_istarget( self ) )
        wait 0.05;

    for (;;)
    {
        if ( target_isincircle( self, level.hovertank_player, 75, 60 ) )
        {
            self.highlight = 1;
            self notify( "highlight_change" );
        }
        else
        {
            self.highlight = 0;
            self notify( "highlight_change" );
        }

        wait 0.05;
    }
}

hovertank_enemy_outline_offset()
{
    var_0 = ( 0, 0, 0 );

    switch ( self.classname )
    {
        case "script_vehicle_xh9_warbird_low_heavy_turret":
        case "script_vehicle_vrap_physics":
        case "script_vehicle_ft101_tank_physics":
            var_0 = ( 0, 0, 64 );
            break;
        case "script_vehicle_littlebird_atlas_bench":
            var_0 = ( 0, 0, -64 );
            break;
        default:
            break;
    }

    return var_0;
}

hovertank_enemy_outline_vehicle()
{
    var_0 = hovertank_enemy_outline_offset();

    for (;;)
    {
        if ( level.player worldpointinreticle_circle( self.origin + var_0, 75, 60 ) )
        {
            self.highlight = 1;
            self notify( "highlight_change" );
        }
        else
        {
            self.highlight = 0;
            self notify( "highlight_change" );
        }

        wait 0.05;
    }
}

hovertank_setup_hint_data()
{
    var_0 = gettime();
    var_1 = spawnstruct();
    level.player.hovertank_weapon_hint_data = var_1;
    var_1.kill_counts = [];
    var_1.kill_goals = [];
    var_1.last_hint_times_ms = [];
    var_1.last_kill_times_ms = [];
    var_1.minimum_in_sights_needed = [];
    var_1.amount_in_sights = [];
    var_1.in_sights_timestamp = [];
    var_1.required_aiming_time_s = 2;
    var_1.delay_from_any_hint_s = 5;
    var_1.delay_from_same_hint_s = 15;
    var_1.delay_from_kill_s = 30;
    var_1.higher_priority_expiration_time_s = 2;
    var_1.hint_duration_s = 5;
    var_1.vehicle_sights_radius = 60;
    var_1.kill_goals["emp"] = 2;
    var_1.kill_goals["cannon"] = 2;
    var_1.kill_goals["missile"] = 15;
    var_1.minimum_in_sights_needed["missile"] = 4;
    var_1.amount_in_sights["missile"] = 0;
    var_1.in_sights_timestamp["missile"] = 0;
    var_1.thread_delay_s = 0.1;
    var_1.last_aim_type = "";
    var_1.last_aim_priority = 0;
    var_1.last_aim_time_ms = var_0;
    var_1.current_target_aim_begin_time_ms = var_0;
    var_1.last_hint_time_any_ms = var_0 - var_1.delay_from_any_hint_s * 1000;
    var_2 = [];
    var_2[var_2.size] = "missile";
    var_2[var_2.size] = "cannon";
    var_2[var_2.size] = "emp";

    for ( var_3 = 0; var_3 < var_2.size; var_3 += 1 )
    {
        var_4 = var_2[var_3];
        var_1.kill_counts[var_4] = 0;
        var_1.last_hint_times_ms[var_4] = var_0 - var_1.delay_from_same_hint_s * 1000;
        var_1.last_kill_times_ms[var_4] = var_0 - var_1.delay_from_kill_s * 1000;
        common_scripts\utility::flag_init( "hint_proficient_" + var_4 );
    }

    level maps\_utility::waittillthread( "hovertank_end", ::hovertank_destroy_hint_data );
}

hovertank_destroy_hint_data()
{
    level.player.hovertank_weapon_hint_data = undefined;
}

hovertank_hint_enemy_kill_tracking( var_0 )
{
    level endon( "hovertank_end" );
    level endon( "hint_proficient_" + var_0 );

    if ( common_scripts\utility::flag( "hint_proficient_" + var_0 ) )
        return;

    self waittill( "death", var_1, var_2, var_3 );

    if ( !isdefined( var_1 ) || var_1 != level.player )
        return;

    var_4 = 0;

    if ( !isdefined( var_3 ) )
        var_4 = 1;
    else
    {
        switch ( var_0 )
        {
            case "cannon":
                var_4 = issubstr( var_3, "cannon" );
                break;
            case "emp":
                var_4 = issubstr( var_3, "antiair" );
                break;
            case "missile":
                var_4 = issubstr( var_3, "missile" );
                break;
            default:
                var_4 = 0;
                break;
        }
    }

    hovertank_hint_stop( var_0 );

    if ( var_4 )
    {
        var_5 = level.player.hovertank_weapon_hint_data;
        var_5.kill_counts[var_0] += 1;
        var_5.last_kill_times_ms[var_0] = gettime();

        if ( var_5.kill_counts[var_0] >= var_5.kill_goals[var_0] )
            common_scripts\utility::flag_set( "hint_proficient_" + var_0 );
    }
}

hovertank_aimed_enemy_vehicle_weapon_hint( var_0, var_1 )
{
    hovertank_aimed_enemy_weapon_hint( var_0, var_1, ::hovertank_hint_vehicle_in_sights );
}

hovertank_aimed_enemy_ai_weapon_hint( var_0, var_1 )
{
    hovertank_aimed_enemy_weapon_hint( var_0, var_1, ::hovertank_hint_ai_in_sights );
}

hovertank_aimed_enemy_weapon_hint( var_0, var_1, var_2 )
{
    self endon( "death" );
    level endon( "hovertank_end" );
    level endon( "hint_proficient_" + var_1 );

    if ( !isdefined( level.player.hovertank_weapon_hint_data ) )
        return;

    var_3 = level.player.hovertank_weapon_hint_data;
    thread hovertank_hint_enemy_kill_tracking( var_1 );

    if ( common_scripts\utility::flag( "hint_proficient_" + var_1 ) )
        return;

    for (;;)
    {
        var_4 = gettime();
        var_5 = var_3.last_aim_priority > var_0;
        var_6 = var_4 - var_3.last_aim_time_ms > var_3.higher_priority_expiration_time_s * 1000;
        var_7 = var_1 == var_3.last_aim_type && var_4 - var_3.last_aim_time_ms <= var_3.thread_delay_s * 1000 && !isdefined( var_3.minimum_in_sights_needed[var_1] );

        if ( !var_7 && ( !var_5 || var_6 ) && [[ var_2 ]]() )
        {
            var_3.last_aim_time_ms = var_4;
            var_3.last_aim_priority = var_0;
            var_8 = 1;

            if ( isdefined( var_3.minimum_in_sights_needed[var_1] ) )
            {
                if ( var_4 - var_3.in_sights_timestamp[var_1] < var_3.thread_delay_s * 1000 )
                    var_3.amount_in_sights[var_1] += 1;
                else
                {
                    var_3.in_sights_timestamp[var_1] = var_4;
                    var_3.amount_in_sights[var_1] = 1;
                }

                var_8 = var_3.amount_in_sights[var_1] == var_3.minimum_in_sights_needed[var_1];
            }

            if ( var_1 == var_3.last_aim_type )
            {
                if ( var_8 )
                {
                    if ( var_6 )
                        var_3.current_target_aim_begin_time_ms = var_4;

                    var_9 = var_4 - var_3.current_target_aim_begin_time_ms > var_3.required_aiming_time_s * 1000;
                    var_10 = var_4 - var_3.last_kill_times_ms[var_1] < var_3.delay_from_kill_s * 1000;
                    var_11 = var_4 - var_3.last_hint_times_ms[var_1] < var_3.delay_from_same_hint_s * 1000 || var_4 - var_3.last_hint_time_any_ms < var_3.delay_from_any_hint_s * 1000;

                    if ( var_9 && !var_11 && !var_10 )
                        hovertank_weapon_hint( var_1 );
                }
            }
            else
            {
                var_3.last_aim_type = var_1;
                var_3.current_target_aim_begin_time_ms = var_4;
            }
        }

        wait(var_3.thread_delay_s);
    }
}

hovertank_hint_vehicle_in_sights()
{
    var_0 = hovertank_enemy_outline_offset();

    if ( !level.player worldpointinreticle_circle( self.origin + var_0, 75, level.player.hovertank_weapon_hint_data.vehicle_sights_radius ) )
        return 0;

    var_1 = level.player geteye();
    var_2 = sighttracepassed( self.origin + var_0, var_1, 0, self, level.player );
    return var_2;
}

hovertank_hint_ai_in_sights()
{
    return self.highlight;
}

manage_highlight( var_0 )
{
    self endon( "death" );
    self endon( "end_highlight" );
    level endon( "hovertank_end" );
    thread manage_highlight_end();

    for (;;)
    {
        self waittill( "highlight_change" );

        if ( self.highlight || self.highlight_forced )
        {
            self hudoutlineenable( var_0, 1 );
            continue;
        }

        if ( !self.highlight_forced )
        {
            self hudoutlinedisable();
            self hudoutlineenable( 0, 0 );
        }
    }
}

manage_highlight_end()
{
    self endon( "death" );
    self endon( "hovertank_end" );
    self waittill( "end_highlight" );
    turn_off_highlight();
}

highlight_when_weapon_fired( var_0 )
{
    self endon( "death" );
    level endon( "hovertank_end" );
    var_1 = 3;

    for (;;)
    {
        common_scripts\utility::waittill_any( "shooting", "weapon_fired" );
        thread force_highlight( var_0, var_1 );
    }
}

force_highlight( var_0, var_1 )
{
    self endon( "death" );
    level endon( "hovertank_end" );
    self endon( "end_highlight" );
    self notify( "force_highlight" );
    self endon( "force_highlight" );
    self.highlight_forced = 1;
    wait(var_1);
    self.highlight_forced = 0;
}

turn_on_highlight( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
    {
        self.highlight_forced = 1;
        var_2 = 0;
        var_3 = 0.05;

        while ( var_2 < var_1 )
        {
            self hudoutlineenable( var_0, 1 );
            self.highlight = 1;
            var_2 += var_3;
            wait(var_3);
        }

        self hudoutlinedisable();
        self hudoutlineenable( 0, 0 );
        self.highlight = 0;
        self.highlight_forced = 0;
    }
    else if ( !self.highlight )
    {
        self hudoutlineenable( var_0, 1 );
        self.highlight = 1;
    }
}

turn_off_highlight()
{
    if ( self.highlight || self.highlight_forced )
    {
        self hudoutlinedisable();
        self hudoutlineenable( 0, 0 );
    }
}

clear_enemy_outline_on_death()
{
    common_scripts\utility::waittill_any_ents( self, "death", level, "hovertank_end" );

    if ( isdefined( self ) )
    {
        self hudoutlinedisable();
        self hudoutlineenable( 0, 0 );
    }
}

warbird_heavy_shooting_think( var_0 )
{
    level.player endon( "death" );
    self endon( "death" );
    self.mgturret[0] setmode( "manual" );
    self.mgturret[1] setmode( "manual" );

    if ( !maps\_utility::ent_flag_exist( "fire_turrets" ) )
        maps\_utility::ent_flag_init( "fire_turrets" );

    maps\_utility::ent_flag_set( "fire_turrets" );
    thread warbird_heavy_fire_monitor();

    for (;;)
    {
        self waittill( "warbird_fire" );
        maps\_utility::ent_flag_set( "fire_turrets" );
        thread warbird_heavy_fire( var_0 );
        self waittill( "warbird_stop_firing" );
        maps\_utility::ent_flag_clear( "fire_turrets" );
    }
}

warbird_heavy_fire( var_0 )
{
    self endon( "death" );
    var_1 = self.mgturret[0];
    var_2 = self.mgturret[1];
    var_1 notify( "stop_burst_fire_unmanned" );
    var_2 notify( "stop_burst_fire_unmanned" );
    var_3 = 0.4;
    var_4 = var_3 / 2;
    var_1 thread burst_fire_warbird( var_3, 0 );
    var_2 thread burst_fire_warbird( var_3, var_4 );
    var_5 = common_scripts\utility::get_enemy_team( self.script_team );

    while ( maps\_utility::ent_flag( "fire_turrets" ) )
    {
        var_6 = getaiarray( var_5 );

        if ( isdefined( level.flying_attack_drones ) )
            var_7 = level.flying_attack_drones;
        else
            var_7 = [];

        if ( isdefined( level.drones ) && isdefined( level.drones[var_5].array ) )
            var_6 = common_scripts\utility::array_combine( var_6, level.drones[var_5].array );

        if ( var_5 == level.player.team )
            var_6 = common_scripts\utility::array_add( var_6, level.player );

        var_6 = common_scripts\utility::array_combine( var_6, var_7 );
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
                var_17 = var_14 + var_16 * 20;

                if ( !sighttracepassed( var_17, var_15, 0, var_10, self.mgturret[0] ) )
                    continue;
            }

            var_12 = var_10;
            break;
        }

        if ( isdefined( var_12 ) )
        {
            var_1 settargetentity( var_12 );
            var_2 settargetentity( var_12 );
            var_1 turretfireenable();
            var_2 turretfireenable();
            var_1 startfiring();
            var_2 startfiring();
            wait_for_warbird_fire_target_done( var_12, var_0 );
            var_1 notify( "stop_firing" );
            var_2 notify( "stop_firing" );
            var_1 cleartargetentity();
            var_2 cleartargetentity();
            var_1 turretfiredisable();
            var_2 turretfiredisable();
        }

        wait 0.05;
    }

    var_1 turretfiredisable();
    var_2 turretfiredisable();
}

warbird_heavy_fire_monitor()
{
    self endon( "death" );
    self waittill( "warbird_stop_firing" );
    maps\_utility::ent_flag_clear( "fire_turrets" );
}

burst_fire_warbird( var_0, var_1 )
{
    self endon( "death" );
    self endon( "stop_burst_fire_warbird" );
    var_2 = 1;
    var_3 = 1;
    var_4 = 1;
    var_5 = 1;
    var_6 = gettime();
    var_7 = "start";

    for (;;)
    {
        var_8 = ( var_6 - gettime() ) * 0.001;

        if ( self isfiringturret() && var_8 <= 0 )
        {
            if ( var_7 != "fire" )
            {
                var_7 = "fire";
                thread doshoottuned( var_0, var_1 );
            }

            var_8 = var_4 + randomfloat( var_5 );
            thread turrettimer( var_8 );
            self waittill( "turretstatechange" );
            var_8 = var_2 + randomfloat( var_3 );
            var_6 = gettime() + int( var_8 * 1000 );
            continue;
        }

        if ( var_7 != "aim" )
            var_7 = "aim";

        thread turrettimer( var_8 );
        self waittill( "turretstatechange" );
    }
}

doshoottuned( var_0, var_1 )
{
    self endon( "death" );
    self endon( "turretstatechange" );

    if ( isdefined( var_1 ) && var_1 > 0 )
        wait(var_1);

    for (;;)
    {
        self shootturret();
        wait(var_0);
    }
}

turrettimer( var_0 )
{
    if ( var_0 <= 0 )
        return;

    self endon( "turretstatechange" );
    wait(var_0);

    if ( isdefined( self ) )
        self notify( "turretstatechange" );
}

destroy_self_when_nuked()
{
    self endon( "death" );

    for (;;)
    {
        if ( getdvar( "debug_nuke" ) == "on" )
            self dodamage( self.health + 99999, ( 0, 0, -500 ), level.player );

        wait 0.05;
    }
}

delete_on_notify( var_0, var_1 )
{
    var_0 waittill( var_1 );
    self delete();
}

trigger_spawn_and_set_flag_think()
{
    var_0 = undefined;

    if ( isdefined( self.script_flag ) )
    {
        var_0 = self.script_flag;

        if ( !isdefined( level.flag[var_0] ) )
            common_scripts\utility::flag_init( var_0 );
    }

    self waittill( "trigger", var_1 );

    if ( isdefined( self.script_delay ) )
        maps\_utility::script_delay();

    if ( isdefined( var_0 ) )
        common_scripts\utility::flag_set( var_0, var_1 );

    var_2 = getentarray( self.target, "targetname" );
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        if ( var_5.code_classname == "script_vehicle" )
        {
            if ( isdefined( var_5.script_moveoverride ) && var_5.script_moveoverride == 1 || !isdefined( var_5.target ) )
                var_3[var_3.size] = maps\_vehicle::vehicle_spawn( var_5 );
            else
                var_3[var_3.size] = var_5 maps\_vehicle::spawn_vehicle_and_gopath();

            continue;
        }

        var_5 thread maps\_spawner::trigger_spawner_spawns_guys();
    }

    if ( var_3.size > 0 )
        thread tank_section_vehicles_spawned( var_3, var_0 );
}

trigger_set_and_clear_flag_think()
{
    var_0 = undefined;

    if ( isdefined( self.script_flag ) )
    {
        var_0 = self.script_flag;

        if ( !isdefined( level.flag[var_0] ) )
            common_scripts\utility::flag_init( var_0 );
    }

    var_1 = undefined;

    if ( isdefined( self.script_flag_clear ) )
    {
        var_1 = self.script_flag_clear;

        if ( !isdefined( level.flag[var_1] ) )
            common_scripts\utility::flag_init( var_1 );
    }

    for (;;)
    {
        self waittill( "trigger", var_2 );

        if ( isdefined( self.script_delay ) )
            maps\_utility::script_delay();

        if ( isdefined( var_0 ) )
            common_scripts\utility::flag_set( var_0, var_2 );

        if ( isdefined( var_1 ) )
            common_scripts\utility::flag_clear( var_1 );

        wait 0.05;
    }
}

tank_section_vehicles_spawned( var_0, var_1 )
{
    soundscripts\_snd::snd_message( "aud_tank_section_vehicles_spawned", var_0, var_1 );

    if ( isdefined( var_1 ) )
    {
        switch ( var_1 )
        {
            case "flag_tank_road_enemy_tank":
                thread maps\lab_vo::tank_road_enemy_tank_dialogue( var_0[0] );
                break;
            case "flag_tank_field_warbird_and_littlebird":
                var_2 = [];

                foreach ( var_4 in var_0 )
                {
                    if ( !issubstr( var_4.classname, "vrap" ) )
                        var_2[var_2.size] = var_4;
                }

                thread maps\lab_vo::tank_field_choppers_dialogue( var_2 );
                break;
            default:
                break;
        }
    }
}

right_swing_pressed()
{
    var_0 = "BUTTON_RTRIG";

    if ( !level.console && !level.player common_scripts\utility::is_player_gamepad_enabled() )
        return level.player adsbuttonpressed( 1 );

    return level.player buttonpressed( var_0 );
}

left_swing_pressed()
{
    var_0 = "BUTTON_LTRIG";

    if ( !level.console && !level.player common_scripts\utility::is_player_gamepad_enabled() )
        return level.player attackbuttonpressed();

    return level.player buttonpressed( var_0 );
}

break_left_climb_hint()
{
    if ( common_scripts\utility::flag( "flag_cloak_fail_kill_player" ) )
        return 1;

    if ( isdefined( level.player.waiting_on_left_swing ) && level.player.waiting_on_left_swing == 0 )
        return 1;
    else
        return 0;
}

break_right_climb_hint()
{
    if ( common_scripts\utility::flag( "flag_cloak_fail_kill_player" ) )
        return 1;

    if ( isdefined( level.player.waiting_on_right_swing ) && level.player.waiting_on_right_swing == 0 )
        return 1;
    else
        return 0;
}

break_both_climb_hint()
{
    if ( isdefined( level.player.waiting_on_left_swing ) && level.player.waiting_on_left_swing == 0 && isdefined( level.player.waiting_on_right_swing ) && level.player.waiting_on_right_swing == 0 )
        return 1;
    else
        return 0;
}

get_rt_button_info()
{
    if ( !level.player usinggamepad() )
        return "ads";

    var_0 = getbuttonsconfig();

    if ( issubstr( getbuttonsconfig(), "lefty" ) )
    {
        if ( level.ps3 || issubstr( var_0, "alt" ) )
            return "smoke";
        else
            return "ads";
    }
    else if ( issubstr( var_0, "nomad" ) )
    {
        if ( level.ps3 || issubstr( var_0, "alt" ) )
            return "ads";
        else
            return "rt";
    }
    else if ( level.ps3 || issubstr( var_0, "alt" ) )
        return "rb";
    else
        return "rt";
}

get_lt_button_info()
{
    var_0 = getbuttonsconfig();

    if ( !level.player usinggamepad() )
        return "attack";

    if ( issubstr( var_0, "lefty" ) )
    {
        if ( level.ps3 || issubstr( var_0, "alt" ) )
            return "frag";
        else
            return "attack";
    }
    else if ( issubstr( var_0, "nomad" ) )
    {
        if ( level.ps3 || issubstr( var_0, "alt" ) )
            return "lb";
        else
            return "frag";
    }
    else if ( level.ps3 || issubstr( var_0, "alt" ) )
        return "lb";
    else
        return "lt";
}

wait_until_right_swing_pressed( var_0 )
{
    level.player.waiting_on_right_swing = 1;
    var_1 = maps\_shg_utility::hint_button_position( get_rt_button_info(), var_0, 0 );

    for (;;)
    {
        if ( right_swing_pressed() )
        {
            level.player.waiting_on_right_swing = 0;
            var_1 maps\_shg_utility::hint_button_clear();
            return;
        }

        wait 0.05;
    }
}

wait_until_left_swing_pressed( var_0 )
{
    level.player.waiting_on_left_swing = 1;
    var_1 = maps\_shg_utility::hint_button_position( get_lt_button_info(), var_0, 0 );

    for (;;)
    {
        if ( left_swing_pressed() )
        {
            level.player.waiting_on_left_swing = 0;
            var_1 maps\_shg_utility::hint_button_clear();
            return;
        }

        wait 0.05;
    }
}

wait_until_next_right_swing( var_0 )
{
    level.player.waiting_on_right_swing = 1;
    var_1 = maps\_shg_utility::hint_button_position( get_rt_button_info(), var_0, 0 );

    for (;;)
    {
        if ( isdefined( level.player.right_swing_released ) && level.player.right_swing_released == 1 && right_swing_pressed() )
        {
            level.player.waiting_on_right_swing = 0;
            var_1 maps\_shg_utility::hint_button_clear();
            return;
        }

        wait 0.05;
    }
}

wait_until_next_left_swing( var_0 )
{
    level.player.waiting_on_left_swing = 1;
    var_1 = maps\_shg_utility::hint_button_position( get_lt_button_info(), var_0, 0 );

    for (;;)
    {
        if ( isdefined( level.player.left_swing_released ) && level.player.left_swing_released == 1 && left_swing_pressed() )
        {
            level.player.waiting_on_left_swing = 0;
            var_1 maps\_shg_utility::hint_button_clear();
            return;
        }

        wait 0.05;
    }
}

monitor_right_swing_released()
{
    level.player.right_swing_released = 0;

    for (;;)
    {
        if ( !right_swing_pressed() )
        {
            level.player.right_swing_released = 1;
            return;
        }

        wait 0.05;
    }
}

monitor_left_swing_released()
{
    level.player.left_swing_released = 0;

    for (;;)
    {
        if ( !left_swing_pressed() )
        {
            level.player.left_swing_released = 1;
            return;
        }

        wait 0.05;
    }
}

wait_until_both_swings_pressed()
{
    level.player.waiting_on_left_swing = 1;
    level.player.waiting_on_right_swing = 1;
    maps\_utility::hintdisplayhandler( "both_climb_hint" );
    level.current_hint.font = "buttonprompt";

    for (;;)
    {
        if ( left_swing_pressed() && right_swing_pressed() )
        {
            level.player.waiting_on_left_swing = 0;
            level.player.waiting_on_right_swing = 0;
            return;
        }

        wait 0.05;
    }
}

#using_animtree("generic_human");

set_helmet_open( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.5;

    self setanimknobrestart( %sentinel_covert_helmet_open_idle, 1, var_0 );
}

set_helmet_closed( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.5;

    self setanimknobrestart( %sentinel_covert_helmet_closed_idle, 1, var_0 );
}

clear_additive_helmet_anim( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.5;

    self clearanim( %s1_helmet, 0 );
}

prep_cinematic( var_0 )
{
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingame( var_0, 1 );
    level.current_cinematic = var_0;
}

play_cinematic( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        soundscripts\_audio::deprecated_aud_send_msg( "begin_cinematic", var_0 );

    if ( isdefined( level.current_cinematic ) )
    {
        pausecinematicingame( 0 );
        setsaveddvar( "cg_cinematicFullScreen", "1" );
        level.current_cinematic = undefined;
    }
    else
        cinematicingame( var_0 );

    if ( !isdefined( var_2 ) || !var_2 )
        setsaveddvar( "cg_cinematicCanPause", "1" );

    wait 1;

    while ( iscinematicplaying() )
        wait 0.05;

    if ( !isdefined( var_2 ) || !var_2 )
        setsaveddvar( "cg_cinematicCanPause", "0" );

    if ( !isdefined( var_1 ) )
        soundscripts\_audio::deprecated_aud_send_msg( "end_cinematic", var_0 );
}

ending_fade_out( var_0 )
{
    var_1 = newhudelem();
    var_1.x = 0;
    var_1.y = 0;
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1.sort = -10;
    var_1 setshader( "black", 640, 480 );

    if ( isdefined( var_0 ) && var_0 > 0 )
    {
        var_1.alpha = 0;
        var_1 fadeovertime( var_0 );
        var_1.alpha = 1;
        wait(var_0);
    }

    waittillframeend;
}

destructible_boxtruck_think()
{
    self setcandamage( 1 );
    self.health = 500;

    while ( self.health > 0 )
    {
        self waittill( "damage", var_0, var_1 );

        if ( var_1 != level.player )
            self.health += var_0;
    }

    self setmodel( "vehicle_civ_boxtruck_destroyed" );
    soundscripts\_snd::snd_message( "boxtruck_explode" );
    playfx( common_scripts\utility::getfx( "boxcar_explosion" ), self.origin );
}

hovertank_weapon_hint( var_0 )
{
    var_1 = undefined;
    var_2 = "";

    switch ( var_0 )
    {
        case "missile":
            var_1 = ::hovertank_missile_hint_off;
            var_2 = "hovertank_missile_hint";
            break;
        case "cannon":
            var_1 = ::hovertank_cannon_hint_off;
            var_2 = "hovertank_cannon_hint";
            break;
        case "emp":
            var_1 = ::hovertank_emp_hint_off;
            var_2 = "hovertank_emp_hint";
            break;
        default:
            break;
    }

    if ( [[ var_1 ]]() )
        return;

    var_3 = gettime();
    maps\_utility::hintdisplayhandler( var_2, level.player.hovertank_weapon_hint_data.hint_duration_s );
    level.player.hovertank_weapon_hint_data.last_hint_times_ms[var_0] = var_3;
    level.player.hovertank_weapon_hint_data.last_hint_time_any_ms = var_3;
}

hovertank_hint_stop( var_0 )
{
    common_scripts\utility::flag_set( "flag_stop_hint_" + var_0 );
    thread hovertank_hint_reset_flag( var_0 );
}

hovertank_hint_reset_flag( var_0 )
{
    wait 0.5;
    common_scripts\utility::flag_clear( "flag_stop_hint_" + var_0 );
}

hovertank_missile_hint_off()
{
    var_0 = common_scripts\utility::flag( "flag_stop_hint_missile" );
    return issubstr( vehicle_scripts\_hovertank::get_current_weapon_name(), "missile" ) || common_scripts\utility::flag( "flag_se_hovertank_exit" ) || var_0;
}

hovertank_cannon_hint_off()
{
    var_0 = common_scripts\utility::flag( "flag_stop_hint_cannon" );
    return issubstr( vehicle_scripts\_hovertank::get_current_weapon_name(), "cannon" ) || common_scripts\utility::flag( "flag_se_hovertank_exit" ) || var_0;
}

hovertank_emp_hint_off()
{
    var_0 = common_scripts\utility::flag( "flag_stop_hint_emp" );
    return issubstr( vehicle_scripts\_hovertank::get_current_weapon_name(), "antiair" ) || common_scripts\utility::flag( "flag_se_hovertank_exit" ) || var_0;
}

ai_kill_when_out_of_sight( var_0, var_1 )
{
    var_0 endon( "death" );
    var_2 = 0.75;

    for (;;)
    {
        wait 1;

        if ( maps\_utility::players_within_distance( var_1, var_0.origin ) )
            continue;

        if ( maps\_utility::either_player_looking_at( var_0.origin + ( 0, 0, 48 ), var_2, 1 ) )
            continue;

        var_0 kill();
    }
}

detection_highlight_hud_effect( var_0, var_1, var_2 )
{
    var_3 = newhudelem();

    if ( isdefined( var_2 ) && var_2 )
        var_3.color = ( 0.1, 0, 0 );
    else
        var_3.color = ( 1, 0, 0 );

    var_3.alpha = 0.05;
    var_3 setradarhighlight( var_1 );
    wait(var_1);

    if ( isdefined( var_3 ) )
        var_3 destroy();
}

notify_on_flag( var_0, var_1 )
{
    common_scripts\utility::flag_wait( var_0 );
    self notify( var_1 );
}

disable_grenades()
{
    if ( isdefined( self.grenadeammo ) && !isdefined( self.oldgrenadeammo ) )
        self.oldgrenadeammo = self.grenadeammo;

    self.grenadeammo = 0;
}

enable_grenades()
{
    if ( isdefined( self.oldgrenadeammo ) )
    {
        self.grenadeammo = self.oldgrenadeammo;
        self.oldgrenadeammo = undefined;
    }
}

equip_microwave_grenade()
{
    self.grenadeweapon = "microwave_grenade";
    self.grenadeammo = 2;
}

random_move_rate_blend()
{
    self endon( "death" );
    var_0 = randomfloatrange( 0.5, 1 );
    var_1 = randomfloatrange( 0, 3 );
    var_2 = 0;

    while ( var_2 <= var_1 )
    {
        var_3 = maps\_utility::linear_interpolate( var_2 / var_1, var_0, 1 );
        self.moveplaybackrate = var_3;
        var_2 += 0.05;
        wait 0.05;
    }
}

monitor_out_of_bounds_areas( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    level.player_out_of_bounds_warning = 0;
    thread maps\lab_vo::player_out_of_bounds_warning_vo();
    var_1 = 0.1;
    var_2 = getentarray( "out_of_bounds_warning", "targetname" );
    var_3 = getentarray( "out_of_bounds_mission_fail", "targetname" );

    if ( var_0 )
        thread debug_out_of_bounds_areas();

    for (;;)
    {
        level.player_out_of_bounds_warning = 0;

        foreach ( var_5 in var_2 )
        {
            if ( level.player istouching( var_5 ) )
                level.player_out_of_bounds_warning = 1;

            if ( var_0 )
                common_scripts\utility::draw_trigger( var_5, var_1, ( 1, 0.5, 0 ) );
        }

        level.player_out_of_bounds_mission_fail = 0;

        foreach ( var_5 in var_3 )
        {
            if ( level.player istouching( var_5 ) )
            {
                level.player_out_of_bounds_mission_fail = 1;
                setdvar( "ui_deadquote", &"LAB_DEADQUOTE_ABANDONED_BURKE" );
                level.player freezecontrols( 1 );
                thread maps\_utility::missionfailedwrapper();
            }

            if ( var_0 )
                common_scripts\utility::draw_trigger( var_5, var_1, ( 1, 0, 0 ) );
        }

        wait(var_1);
    }
}

debug_out_of_bounds_areas()
{
    var_0 = newhudelem();
    var_0.x = 250;
    var_0.y = 200;
    var_0.alignx = "left";
    var_0.aligny = "top";
    var_0.horzalign = "fullscreen";
    var_0.vertalign = "fullscreen";
    var_0.fontscale = 2.0;
    var_0 settext( "" );
    var_1 = 0.1;

    for (;;)
    {
        if ( isdefined( level.player_out_of_bounds_mission_fail ) && level.player_out_of_bounds_mission_fail )
            var_0 settext( "Mission failed." );
        else if ( isdefined( level.player_out_of_bounds_warning ) && level.player_out_of_bounds_warning )
            var_0 settext( "Warning!  You are out of bounds!" );
        else
            var_0 settext( "" );

        wait(var_1);
    }
}

flag_wait_any_or_timeout( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = var_0 * 1000;
    var_7 = gettime();
    var_8 = [];

    if ( isdefined( var_1 ) )
        var_8[var_8.size] = var_1;

    if ( isdefined( var_2 ) )
        var_8[var_8.size] = var_2;

    if ( isdefined( var_3 ) )
        var_8[var_8.size] = var_3;

    if ( isdefined( var_4 ) )
        var_8[var_8.size] = var_4;

    if ( isdefined( var_5 ) )
        var_8[var_8.size] = var_5;

    for (;;)
    {
        foreach ( var_10 in var_8 )
        {
            if ( common_scripts\utility::flag_exist( var_10 ) && common_scripts\utility::flag( var_10 ) )
                break;
        }

        if ( gettime() >= var_7 + var_6 )
            break;

        waitframe();
    }
}

player_stance_monitor()
{
    var_0 = 0;
    var_1 = "";
    var_2 = "";
    var_3 = 0;

    for (;;)
    {
        var_2 = level.player getstance();

        if ( var_2 == "prone" && var_2 != var_1 )
        {
            var_1 = var_2;
            iprintln( "player prone" );
            var_0 += 15;
        }

        if ( var_2 == "crouch" && var_2 != var_1 )
        {
            var_1 = var_2;
            iprintln( "player crouch" );
            var_0 += 30;
        }

        if ( var_2 == "stand" && var_2 != var_1 )
        {
            var_1 = var_2;
            iprintln( "player stand" );
            var_0 += 40;
        }

        while ( level.player isjumping() )
        {
            if ( !var_3 )
            {
                iprintln( "player jumping" );
                var_0 += 75;
            }

            var_3 = 1;
            wait 0.05;
        }

        var_3 = 0;
        wait 0.05;
    }
}

player_exo_monitor()
{
    if ( isdefined( level.start_point ) )
    {
        switch ( level.start_point )
        {
            case "tank_ascent":
            case "tank_field_right_fork":
            case "tank_field_left_fork":
            case "tank_field":
            case "tank_road":
                return;
            default:
                break;
        }
    }

    common_scripts\utility::flag_wait( "flag_player_exo_enabled" );
    maps\_player_exo::player_exo_activate();
}

player_falling_to_death()
{
    level endon( "flag_rappel_start" );
    common_scripts\utility::flag_wait( "player_falling_to_death" );
    setdvar( "ui_deadquote", "" );
    level.player takeallweapons();
    var_0 = gettime() + 1000;

    while ( !level.player isonground() && gettime() < var_0 )
        wait 0.05;

    if ( level.player isonground() )
        level.player kill();
    else
        maps\_utility::missionfailedwrapper();
}

magic_bullet_strafe( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = 0;
    var_11 = var_2 - var_0;
    var_12 = var_3 - var_1;
    var_13 = 0;
    var_14 = 1 / var_5;
    var_15 = var_5 / var_4;
    var_16 = 0;

    for ( var_17 = var_7; var_13 < var_4; var_17 = min( var_24 + var_7, var_5 - var_10 ) )
    {
        if ( var_16 != var_17 )
            var_18 = randomfloatrange( var_16, var_17 );
        else
            var_18 = var_16;

        if ( var_18 > 0 )
        {
            wait(var_18);
            var_10 += var_18;
        }

        var_19 = var_1 + var_12 * var_14 * var_10;
        var_20 = var_0 + var_11 * var_13 / ( var_4 - 1 );

        if ( var_6 > 0 )
        {
            var_21 = randomfloat( var_6 );
            var_22 = ( 0, randomfloat( 360 ), 0 );
            var_20 += anglestoforward( var_22 ) * var_21;
        }

        if ( isdefined( var_9 ) )
            magicbullet( var_8, var_19, var_20, var_9 );
        else
        {
            var_23 = magicbullet( var_8, var_19, var_20 );
            var_23 soundscripts\_snd::snd_message( "lab_exfil_missile_strike" );
        }

        var_13++;
        var_24 = var_13 * var_15 - var_10;
        var_16 = max( 0, var_24 - var_7 );
    }
}

named_magic_bullet_strafe( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = maps\_utility::getent_or_struct( var_0 + "_source_start", "targetname" );
    var_8 = maps\_utility::getent_or_struct( var_0 + "_source_end", "targetname" );
    var_9 = maps\_utility::getent_or_struct( var_0 + "_target_start", "targetname" );
    var_10 = maps\_utility::getent_or_struct( var_0 + "_target_end", "targetname" );

    if ( !isdefined( var_7 ) || !isdefined( var_8 ) || !isdefined( var_9 ) || !isdefined( var_10 ) )
        return;

    magic_bullet_strafe( var_9.origin, var_7.origin, var_10.origin, var_8.origin, var_1, var_2, var_3, var_4, var_5, var_6 );
}

rumble_light()
{
    level.player playrumbleonentity( "damage_light" );
}

rumble_light_1()
{
    level.player playrumbleonentity( "light_1s" );
}

rumble_light_2()
{
    level.player playrumbleonentity( "light_2s" );
}

rumble_light_3()
{
    level.player playrumbleonentity( "light_3s" );
}

rumble_heavy()
{
    level.player playrumbleonentity( "damage_heavy" );
}

rumble_heavy_1()
{
    level.player playrumbleonentity( "heavy_1s" );
}

rumble_heavy_2()
{
    level.player playrumbleonentity( "heavy_2s" );
}

rumble_heavy_3()
{
    level.player playrumbleonentity( "heavy_3s" );
}

setup_level_rumble_ent()
{
    if ( !isdefined( level.rumble_ent ) )
        level.rumble_ent = maps\_utility::get_rumble_ent( "steady_rumble", 0.0 );

    level.rumble_ent.intensity = 0.0;
}

rumble_set_ent_rumble_intensity_for_time( var_0, var_1, var_2 )
{
    var_0.intensity = var_1;
    wait(var_2);
    var_0.intensity = 0.0;
}

play_rumble_on_entity( var_0, var_1 )
{
    var_0 playrumbleonentity( var_1 );
}
