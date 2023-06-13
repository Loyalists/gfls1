// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

refugee_camp_main()
{
    common_scripts\utility::flag_init( "bikes_enter_detroit" );
    level.refugee_camp_ai = [];
    level.downtown_ambient_guys = [];

    if ( level.nextgen )
    {
        precachemodel( "character_arab_civilian_lowres_a" );
        precachemodel( "character_arab_civilian_lowres_b" );
        precachemodel( "character_arab_civilian_lowres_c" );
        precachemodel( "character_arab_civilian_lowres_d" );
        precachemodel( "character_arab_civilian_lowres_e" );
        precachemodel( "character_arab_civilian_lowres_f" );
    }

    thread setup_civs();
    thread gate_decon_player_side();
    thread gate_decon_opposite_side();

    if ( level.nextgen )
    {
        thread spraypaint_gag();
        thread setup_refugee_stage_audience();
    }
    else
    {
        thread maps\detroit_transients_cg::cg_spraypaint_gag();
        thread maps\detroit_transients_cg::cg_setup_refugee_stage_audience();
    }

    thread buttress_function();
    thread ambient_dialogue_manager();
    thread refugee_camp_cleanup();
    thread left_mount_trigger_function();
    thread middle_civ_manager();
}

unload_intro_cinematic_assets()
{
    if ( istransientloaded( "detroit_introA_tr" ) )
    {
        wait 6;
        unloadtransient( "detroit_introA_tr" );

        for (;;)
        {
            if ( istransientloaded( "detroit_introa_tr" ) )
            {
                common_scripts\utility::flag_set( "flag_cg_intro_cin_has_run" );
                level notify( "tff_post_shed_intro_cin" );
                break;
            }

            wait 0.05;
        }
    }
}

delay_show_bones()
{
    level.bones hide();
    common_scripts\utility::flag_wait( "flag_camp_visibility_03" );
    level.bones show();
}

refugee_walk()
{
    soundscripts\_snd::snd_message( "begin_refugee_walk" );
    thread player_speed_control();
    level.squad_gestures_wait_count = [];
    level.squad_gestures_idle_count = [];
    level.burke thread squad_gestures_burke();
    level.joker thread squad_gestures_joker();

    if ( level.currentgen && !issubstr( level.transient_zone, "middle" ) )
    {
        common_scripts\utility::array_thread( getentarray( "joker_lookat_trigger", "targetname" ), ::det_camp_lookat_trigger_think, level.joker );
        common_scripts\utility::array_thread( getentarray( "burke_lookat_trigger", "targetname" ), ::det_camp_lookat_trigger_think, level.burke );
    }

    level.bones maps\_utility::set_moveplaybackrate( 1 );
    level.bones.ignoreall = 1;
}

squad_gestures_burke()
{
    level.burke set_refugee_camp_walk_anims();
    level.burke maps\_utility::set_moveplaybackrate( 1 );
    level.burke.ignoreall = 1;
    goto_squad_node( "post_gesture_01_burke", "flag_post_gesture_01" );
    goto_squad_node( "pre_gesture_02_burke", "flag_gesture_spray_paint" );
    play_squad_gesture( "org_gesture_02_burke", "det_casual_gestures_l_shakehead_burke" );
    goto_squad_node( "post_gesture_02_burke", "flag_post_gesture_02" );
    goto_squad_node( "pre_gesture_03_burke", "flag_gesture_food_truck" );
    goto_squad_node( "post_gesture_03_burke", "flag_gesture_stage_speaker" );
    goto_squad_node( "post_gesture_04_burke", "flag_post_gesture_04" );
    goto_squad_node( "pre_gesture_05_burke", "flag_gesture_last_guard" );
    goto_squad_node( "post_gesture_05_burke", "flag_enter_scanner" );
    self.turnrate = self.old_turnrate;
    self.old_turnrate = undefined;
    common_scripts\utility::flag_wait( "flag_enter_scanner" );
    common_scripts\utility::flag_set( "squad_gestures_done_burke" );
}

squad_gestures_joker()
{
    level.joker set_refugee_camp_walk_anims();
    level.joker maps\_utility::set_moveplaybackrate( 1 );
    level.joker.ignoreall = 1;
    goto_squad_node( "post_gesture_01_joker", "flag_post_gesture_01", 0.5 );
    goto_squad_node( "pre_gesture_02_joker", "flag_gesture_spray_paint", 0.5 );
    goto_squad_node( "post_gesture_02_joker", "flag_post_gesture_02", 0.75 );
    goto_squad_node( "pre_gesture_03_joker", "flag_gesture_food_truck", 0.5 );
    goto_squad_node( "post_gesture_03_joker", "flag_gesture_stage_speaker", 0.5 );
    goto_squad_node( "post_gesture_04_joker", "flag_post_gesture_04" );
    goto_squad_node( "pre_gesture_05_joker", "flag_gesture_last_guard", 0.5 );
    goto_squad_node( "post_gesture_05_joker", "flag_enter_scanner" );
    self.turnrate = self.old_turnrate;
    self.old_turnrate = undefined;
    common_scripts\utility::flag_wait( "flag_enter_scanner" );
    common_scripts\utility::flag_set( "squad_gestures_done_joker" );
}

play_doctor_pip()
{
    wait 7;
    wait 1;
    maps\_shg_utility::play_videolog( "detroit_videolog", "screen_add" );
}

play_squad_gesture( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_2 maps\_anim::anim_reach_solo( self, var_1 );
    var_2 maps\_anim::anim_single_solo_run( self, var_1 );
}

goto_squad_node( var_0, var_1, var_2 )
{
    var_3 = getnode( var_0, "targetname" );
    var_4 = level.scr_anim[self.animname]["refugee_camp_walk_to_idle"];
    var_5 = transformmove( var_3.origin, var_3.angles, getmovedelta( var_4 ), getangledelta3d( var_4 ), ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_6 = spawnstruct();
    var_6.origin = var_5["origin"];
    var_6.angles = var_5["angles"];
    self setgoalpos( var_6.origin );
    self.goalradius = 4;
    var_7 = 128;

    if ( var_0 == "pre_gesture_02_burke" )
        var_7 = 32;

    while ( distance( self.origin, var_6.origin ) > var_7 )
        waitframe();

    if ( isdefined( var_1 ) )
    {
        if ( !isdefined( level.squad_gestures_wait_count[var_1] ) )
            level.squad_gestures_wait_count[var_1] = 0;

        if ( !isdefined( level.squad_gestures_idle_count[var_1] ) )
            level.squad_gestures_idle_count[var_1] = 0;

        if ( !common_scripts\utility::flag( var_1 ) || level.squad_gestures_wait_count[var_1] > 0 )
        {
            level.squad_gestures_wait_count[var_1]++;
            var_6 maps\_anim::anim_reach_solo( self, "refugee_camp_walk_to_idle" );
            var_6 maps\_anim::anim_custom_animmode_solo( self, "gravity", "refugee_camp_walk_to_idle" );
            thread maps\_anim::anim_loop_solo( self, "refugee_camp_idle", "refugee_camp_idle_ender" );
            level.squad_gestures_idle_count[var_1]++;
            common_scripts\utility::flag_wait( var_1 );

            while ( level.squad_gestures_idle_count[var_1] < 2 )
                waitframe();

            if ( isdefined( var_2 ) )
                wait(var_2);

            self notify( "refugee_camp_idle_ender" );
            maps\_anim::anim_custom_animmode_solo( self, "gravity", "refugee_camp_idle_to_walk" );
        }
        else
        {

        }
    }
}

det_camp_lookat_trigger_think( var_0 )
{
    if ( level.currentgen )
        level endon( "flag_camp_visibility_04" );

    var_1 = getent( self.target, "targetname" );
    var_2 = self.radius;

    while ( distancesquared( self.origin, var_0.origin ) > var_2 * var_2 )
        wait 0.1;

    var_0 setlookatentity( var_1 );
    wait 1;

    while ( distancesquared( self.origin, var_0.origin ) < var_2 * var_2 )
        wait 0.1;

    var_0 setlookatentity();
}

signed_distance_to_plane( var_0, var_1, var_2 )
{
    return vectordot( var_2 - var_0, var_1 );
}

player_speed_control()
{
    var_0 = 0.05;
    var_1 = 1.0;
    var_2 = 0;
    var_3 = 220;
    var_4 = 500;
    var_5 = 200;
    level.player setmovespeedscale( 0.3 );
    level.player allowsprint( 0 );
    common_scripts\utility::flag_wait( "flag_player_off_helipad" );
    var_6 = 1;

    while ( !common_scripts\utility::flag( "flag_camp_visibility_04" ) )
    {
        var_7 = vectornormalize( anglestoforward( level.burke.angles ) + anglestoforward( level.joker.angles ) + vectornormalize( ( level.burke.origin + level.joker.origin ) * 0.5 - level.player.origin ) );
        var_8 = 0 - signed_distance_to_plane( level.burke.origin, var_7, level.player.origin );
        var_9 = 0 - signed_distance_to_plane( level.joker.origin, var_7, level.player.origin );
        var_10 = min( var_8, var_9 );
        var_6 = maps\_shg_utility::linear_map_clamp( var_10, var_2, var_3, var_0, var_1 );
        waittillframeend;
        level.player setmovespeedscale( var_6 );

        if ( var_10 > var_4 )
        {

        }

        if ( var_10 < var_5 )
            level.player allowsprint( 0 );

        waitframe();
    }

    var_11 = ( 1 - var_6 ) / 50;

    while ( var_6 < 1 )
    {
        var_6 += var_11;
        level.player setmovespeedscale( var_6 );
        wait 0.1;
    }

    level.player setmovespeedscale( 1 );
}

decon_guy_walk_to( var_0, var_1 )
{
    var_0 maps\_anim::anim_reach_solo( var_1, "gate_decon" );
    var_1 thread maps\_anim::anim_loop_solo( var_1, "gate_decon_idle" );
}

decon_guy_walk_away( var_0, var_1 )
{
    var_0 maps\_anim::anim_single_solo( self, "gate_decon" );

    if ( var_1 == 1 || var_1 == 6 )
        self delete();
    else
    {
        var_2 = getnode( "node_decon_delete_pass", "targetname" );

        if ( var_1 == 4 )
            var_2 = getnode( "node_decon_delete_pass_b", "targetname" );

        self setgoalnode( var_2 );
        self.goalradius = 8;
        self waittill( "goal" );
        self delete();
    }
}

gate_decon_opposite_side()
{
    var_0 = getent( "scanner_intro_anim_node", "targetname" );
    thread gate_decon_opposite_side_guard( var_0 );
    common_scripts\utility::flag_wait( "flag_camp_visibility_03" );
    var_1 = [];

    for ( var_2 = 0; var_2 < 2; var_2++ )
    {
        var_1[var_2] = getent( "scanner_guy_animated_spawner0" + ( var_2 + 1 ), "targetname" ) maps\_utility::spawn_ai( 1 );
        var_1[var_2].animname = "scanner_guy_animated_spawner0" + ( var_2 + 1 );
        var_1[var_2].ignoreall = 1;
        var_1[var_2].ignoreme = 1;
        var_1[var_2].team = level.player.team;
        var_1[var_2].disableexits = 1;
        var_1[var_2] maps\_utility::gun_remove();
        var_1[var_2] maps\_utility::set_run_anim( "gate_decon_walk" );
        var_1[var_2] character\gfl\randomizer_atlas::main();
    }

    var_0 maps\_anim::anim_first_frame_solo( var_1[0], "gate_decon" );
    var_1[0] thread maps\_anim::anim_loop_solo( var_1[0], "gate_decon_idle", "stop_idle_guy1" );
    var_0 maps\_anim::anim_first_frame_solo( var_1[1], "gate_decon" );
    var_1[1] thread maps\_anim::anim_loop_solo( var_1[1], "gate_decon_idle", "stop_idle_guy2" );
    maps\_utility::trigger_wait_targetname( "gate_decon_opposite_side" );

    for ( var_2 = 2; var_2 < 4; var_2++ )
    {
        var_1[var_2] = getent( "scanner_guy_animated_spawner0" + ( var_2 + 1 ), "targetname" ) maps\_utility::spawn_ai( 1 );
        var_1[var_2].animname = "scanner_guy_animated_spawner0" + ( var_2 + 1 );
        var_1[var_2] maps\_utility::gun_remove();
        var_1[var_2] maps\_utility::set_run_anim( "gate_decon_walk" );
        var_1[var_2].team = level.player.team;
        var_1[var_2].ignoreall = 1;
        var_1[var_2].ignoreme = 1;
        var_1[var_2].alwaysrunforward = undefined;
        var_1[var_2] character\gfl\randomizer_atlas::main();
    }

    thread decon_guy_walk_to( var_0, var_1[2] );
    maps\_utility::delaythread( 0.75, ::decon_guy_walk_to, var_0, var_1[3] );
    level waittill( "decon_a" );
    var_1[0] thread decon_guy_walk_away( var_0, 1 );
    var_1[1] thread decon_guy_walk_away( var_0, 2 );
    level waittill( "decon_b" );
    var_1[2] thread decon_guy_walk_away( var_0, 3 );
    level waittill( "decon_c" );
    var_1[3] thread decon_guy_walk_away( var_0, 4 );
    level waittill( "decon_d" );
    level waittill( "decon_e" );
}

gate_decon_opposite_side_guard( var_0 )
{
    var_1 = getent( "det_security_checkpoint_b", "targetname" );
    var_1 hide();
    thread decon_reverse_blocking();
    common_scripts\utility::flag_wait( "flag_camp_visibility_03" );
    var_2 = getent( "scanner_guard_animated_spawner01", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_2.animname = "scanner_guard_animated_spawner01";
    var_3 = getent( "scanner_guard_animated_spawner01", "targetname" );
    var_2.ignoreall = 1;
    var_2.ignoreme = 1;
    var_1 show();
    var_1.animname = "decon_gate";
    var_1 maps\_anim::setanimtree();
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "det_gate_decon_station" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_2, "gate_decon" );
    var_2 thread maps\_anim::anim_loop_solo( var_2, "gate_decon_idle", "decon_guard_opposite_side_idle_ender" );
    maps\_utility::trigger_wait_targetname( "gate_decon_opposite_side" );
    var_2 notify( "decon_guard_opposite_side_idle_ender" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "det_gate_decon_station" );
    var_0 maps\_anim::anim_single_solo( var_2, "gate_decon" );
    var_2 thread maps\_anim::anim_loop_solo( var_2, "gate_decon_idle", "decon_guard_opposite_side_idle_ender" );
}

decon_reverse_blocking()
{
    var_0 = getent( "player_camp_scan_reverse_blockage", "targetname" );
    var_0 notsolid();
    var_0 connectpaths();
    maps\_utility::trigger_wait_targetname( "gate_decon_opposite_side" );
    wait 38.76;
    var_0 solid();
    var_0 disconnectpaths();
}

gate_decon_player_side()
{
    var_0 = getent( "det_security_checkpoint_a", "targetname" );
    var_0 hide();
    thread gate_decon_player_side_cinematic_screens();
    common_scripts\utility::flag_wait( "flag_camp_visibility_03" );
    var_1 = getent( "scanner_intro_anim_node", "targetname" );
    var_2 = getent( "decon_gate_clip_01", "targetname" );
    var_2 notsolid();
    var_2 thread solidify_on_player_decon();
    var_0 show();
    var_0.animname = "decon_gate";
    var_0 maps\_anim::setanimtree();
    var_1 thread maps\_anim::anim_first_frame_solo( var_0, "decon_scanner_front" );
    var_3 = getent( "scanner_guard_animated_spawner", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_3.animname = "scanner_guard_animated_spawner";
    var_4 = getent( "scanner_guard_animated_spawner", "targetname" );
    var_3.ignoreall = 1;
    var_3.ignoreme = 1;
    level.camp_scanner_guy = var_3;
    var_1 thread maps\_anim::anim_first_frame_solo( var_3, "gate_decon" );
    var_3 thread maps\_anim::anim_loop_solo( var_3, "gate_decon_idle", "decon_guard_gate_decon_idle_ender" );
    thread gate_decon_player_side_burke( var_1 );
    thread gate_decon_player_side_joker( var_1 );
    thread gate_decon_player_side_bones( var_1 );
    level waittill( "start_decon_guard" );
    common_scripts\utility::flag_set( "vo_refugee_camp_security_checkpoint" );
    var_1 thread maps\_anim::anim_single_solo( var_3, "gate_decon" );
    var_1 thread maps\_anim::anim_single_solo( var_0, "decon_scanner_front" );
    common_scripts\utility::flag_wait_all( "flag_decon_ready_burke", "flag_decon_ready_joker", "flag_decon_ready_player" );
    common_scripts\utility::flag_set( "vo_refugee_camp_scanner" );
    common_scripts\utility::flag_set( "flag_camp_visibility_04" );
    var_1 notify( "decon_guard_gate_decon_idle_ender" );
    var_1 thread maps\_anim::anim_single_solo( var_0, "decon_scanner_back" );
    level maps\_utility::notify_delay( "enable_decon_cinematic_screens", 1 );
    thread scanner_rumble();
    var_2 solid();
    thread decon_finish();
    var_3 notify( "decon_guard_gate_decon_idle_ender" );
    var_1 maps\_anim::anim_single_solo( var_3, "gate_decon_b" );
    var_5 = getent( "decon_guard_casual_idle_org", "targetname" );
    var_5 maps\_anim::anim_loop_solo( var_3, "gate_decon_idle" );
}

decon_finish()
{
    level waittill( "scanner_doors_open" );
    common_scripts\utility::flag_set( "flag_scanner_doors_open" );

    if ( level.currentgen )
    {
        var_0 = getent( "decon_gate_clip_02", "targetname" );
        var_0 notsolid();
    }
}

scanner_rumble()
{
    wait 0.5;
    var_0 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0 maps\_utility::set_rumble_intensity( 0.01 );
    var_0 maps\_utility::rumble_ramp_to( 0.15, 1 );
    wait 5.2;
    var_0 stoprumble( "steady_rumble" );
    var_0 delete();
}

hoverbike_rumble()
{
    wait 3;
    var_0 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0 maps\_utility::set_rumble_intensity( 0.1 );
    var_0 maps\_utility::delaythread( 2, maps\_utility::set_rumble_intensity, 0.35 );
    var_0 maps\_utility::delaythread( 3.1, maps\_utility::set_rumble_intensity, 0.17 );
    var_0 maps\_utility::delaythread( 7.1, maps\_utility::set_rumble_intensity, 0.22 );
    var_0 maps\_utility::delaythread( 9.1, maps\_utility::set_rumble_intensity, 0.08 );
    var_0 maps\_utility::delaythread( 11.1, maps\_utility::set_rumble_intensity, 0.22 );
    var_0 maps\_utility::delaythread( 16, maps\_utility::set_rumble_intensity, 0.18 );
    var_0 maps\_utility::delaythread( 20, maps\_utility::set_rumble_intensity, 0.26 );
    var_0 maps\_utility::delaythread( 23, maps\_utility::set_rumble_intensity, 0.2 );
    var_0 maps\_utility::delaythread( 24.5, maps\_utility::set_rumble_intensity, 0.15 );
    var_0 maps\_utility::delaythread( 25, maps\_utility::set_rumble_intensity, 0.13 );
    var_0 maps\_utility::delaythread( 35, maps\_utility::set_rumble_intensity, 0.25 );
    var_0 maps\_utility::delaythread( 36, maps\_utility::set_rumble_intensity, 0.06 );
    var_0 maps\_utility::delaythread( 52, maps\_utility::set_rumble_intensity, 0.18 );
    var_0 maps\_utility::delaythread( 55, maps\_utility::set_rumble_intensity, 0.23 );
    var_0 maps\_utility::delaythread( 59, maps\_utility::set_rumble_intensity, 0.18 );
    thread hoverbike_ride_in_autorumble( undefined, "ride_over" );
    wait 65;
    var_0 stoprumble( "steady_rumble" );
    var_0 delete();
}

hoverbike_ride_in_autorumble( var_0, var_1 )
{
    var_2 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_2 maps\_utility::set_rumble_intensity( 0.01 );

    if ( !isdefined( var_0 ) )
        var_0 = 90;

    for (;;)
    {
        if ( !isdefined( self ) )
        {
            var_2 stoprumble( "steady_rumble" );
            var_2 delete();
            return;
        }

        var_3 = self.veh_speed / var_0;

        if ( var_3 > 0 )
            var_2 maps\_utility::set_rumble_intensity( var_3 );

        if ( var_3 == 0 )
            var_2 maps\_utility::set_rumble_intensity( 0.01 );

        if ( common_scripts\utility::flag( var_1 ) )
        {
            if ( isdefined( var_2 ) )
            {
                var_2 stoprumble( "steady_rumble" );
                var_2 delete();
            }

            return;
        }

        wait(randomfloatrange( 0.3, 0.6 ));
    }
}

speed_display()
{
    for (;;)
    {
        if ( !isdefined( self ) )
            return;

        if ( isdefined( self.veh_speed ) )
            iprintln( self.veh_speed );

        wait 0.05;

        if ( common_scripts\utility::flag( "ride_over" ) )
            return;
    }
}

solidify_on_player_decon()
{
    common_scripts\utility::flag_wait( "flag_decon_ready_player" );
    self solid();
}

gate_decon_player_side_cinematic_screens()
{
    var_0 = getentarray( "scanner_cinematic_panels", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2 hide();
        var_2 notsolid();
    }

    level waittill( "enable_decon_cinematic_screens" );

    foreach ( var_2 in var_0 )
        var_2 show();

    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingameloop( "detroit_body_scan" );
    common_scripts\utility::flag_wait( "flag_scanner_doors_open" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    stopcinematicingame();
}

gate_decon_player_side_burke( var_0 )
{
    level endon( "player_has_used_bike" );
    common_scripts\utility::flag_wait( "squad_gestures_done_burke" );
    common_scripts\utility::flag_set( "obj_acquire_bikes_pos_bike" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "gate_decon" );
    level notify( "start_decon_guard" );
    var_0 maps\_anim::anim_single_solo( level.burke, "gate_decon" );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "gate_decon_idle", "burke_gate_decon_idle_ender" );
    common_scripts\utility::flag_set( "flag_decon_ready_burke" );
    common_scripts\utility::flag_wait_all( "flag_decon_ready_burke", "flag_decon_ready_joker", "flag_decon_ready_player" );
    var_0 notify( "burke_gate_decon_idle_ender" );
    var_0 thread maps\_anim::anim_single_solo( level.burke, "gate_decon_b" );
    thread bike_reach_function( level.burke, var_0 );
}

gate_decon_player_side_joker( var_0 )
{
    level endon( "player_has_used_bike" );
    common_scripts\utility::flag_wait( "squad_gestures_done_joker" );
    var_0 maps\_anim::anim_reach_solo( level.joker, "gate_decon" );
    level notify( "start_decon_guard" );
    var_0 maps\_anim::anim_single_solo( level.joker, "gate_decon" );
    var_0 thread maps\_anim::anim_loop_solo( level.joker, "gate_decon_idle", "joker_gate_decon_idle_ender" );
    common_scripts\utility::flag_set( "flag_decon_ready_joker" );
    common_scripts\utility::flag_wait_all( "flag_decon_ready_burke", "flag_decon_ready_joker", "flag_decon_ready_player" );
    var_0 notify( "joker_gate_decon_idle_ender" );
    common_scripts\utility::flag_set( "joker_deliver_decon_line" );
    var_0 thread maps\_anim::anim_single_solo( level.joker, "gate_decon_b" );
    thread bike_reach_function( level.joker, var_0 );
}

gate_decon_player_side_bones( var_0 )
{
    level endon( "player_has_used_bike" );
    common_scripts\utility::flag_wait_all( "flag_decon_ready_burke", "flag_decon_ready_joker", "flag_decon_ready_player" );
    var_0 thread maps\_anim::anim_single_solo( level.bones, "gate_decon_b" );
    thread bike_reach_function( level.bones, var_0 );
}

refugee_debug()
{
    wait 1;

    if ( isdefined( level.bones ) )
        level.bones thread color_debug( "bones", "y" );

    if ( isdefined( level.joker ) )
        level.joker thread color_debug( "joker", "o" );
}

color_debug( var_0, var_1 )
{
    if ( !isdefined( self ) )
        return;

    maps\_utility::is_default_start();

    if ( !maps\_utility::is_default_start() )
        return;

    self endon( "color_force_off" );

    while ( maps\_utility::is_default_start() )
    {
        if ( isdefined( self.script_forcecolor ) )
            waitframe();
        else
        {
            maps\_utility::set_force_color( var_1 );

            if ( isdefined( self.patrol_anim_set ) )
                maps\detroit::set_patrol_anim_set( self.patrol_anim_set );
        }

        wait 1;
    }
}

refugee_camp_cleanup()
{
    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    common_scripts\utility::array_thread( level.refugee_camp_ai, maps\_shg_design_tools::delete_auto );
    common_scripts\utility::flag_wait( "refugee_camp_cleanup" );
    var_0 = getent( "det_security_checkpoint_a", "targetname" );
    var_1 = getent( "det_security_checkpoint_b", "targetname" );
    var_0 delete();
    var_1 delete();
}

player_ads_disable_manager()
{
    waitframe();
    level.player allowads( 0 );
    common_scripts\utility::flag_wait( "drivein_player_bike_used" );
    level.player allowads( 1 );
}

left_mount_trigger_function()
{
    level endon( "player_has_used_bike" );
    level.playerisonleft = 0;
    var_0 = getent( "player_left_mount_vol", "targetname" );

    for (;;)
    {
        if ( level.player istouching( var_0 ) )
            level.playerisonleft = 1;
        else
            level.playerisonleft = 0;

        wait 0.05;
    }
}

middle_civ_manager()
{
    waitframe();
    maps\_utility::stop_exploder( "1501" );
    thread disable_middle_civs();
    thread show_middle_civs_now();
    thread disable_middle_civs_now();
}

disable_middle_civs()
{
    level endon( "No more civs ever" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "hide_middle_civs_trigger" );
        maps\_utility::stop_exploder( "1501" );
        wait 0.1;
        common_scripts\utility::flag_clear( "hide_middle_civs_trigger" );
    }
}

disable_middle_civs_now()
{
    common_scripts\utility::flag_wait( "begin_player_mount_bike" );
    maps\_utility::stop_exploder( "1501" );
    level notify( "No more civs ever" );
}

show_middle_civs_now()
{
    level endon( "No more civs ever" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "show_middle_civs_trigger" );
        common_scripts\_exploder::exploder( "1501" );
        wait 0.1;
        common_scripts\utility::flag_clear( "show_middle_civs_trigger" );
    }
}

spraypaint_gag()
{
    var_0 = getent( "sparaypaint_animspot", "targetname" );
    var_1 = getent( "spraypaint_artist_spawner", "targetname" );
    var_2 = var_1 maps\_utility::spawn_ai( 1 );
    var_2.animname = "generic";
    var_2.goalradius = 15;
    var_0 thread maps\_anim::anim_loop_solo( var_2, "spraypaint_idle" );
    var_2 attach( "com_spray_can01", "tag_weapon_right" );
    common_scripts\utility::flag_wait( "flag_gesture_spray_paint" );
    var_3 = getent( "spraypaint_guard", "targetname" );
    var_4 = var_3 maps\_utility::spawn_ai( 1 );
    var_4.ignoreall = 1;
    var_4.ignoreme = 1;
    var_4.goalradius = 15;
    var_4.animname = "generic";
    var_0 thread maps\_anim::anim_first_frame_solo( var_4, "chase_away" );
    thread spraypaint_runner( var_2, var_0 );
    thread spraypaint_chaser( var_4, var_0 );
    wait 7.31;
    var_4 maps\_utility::dialogue_queue( "detroit_atd_heyhey" );
}

spraypaint_chaser( var_0, var_1 )
{
    var_1 maps\_anim::anim_single_solo( var_0, "chase_away" );
    var_2 = getnode( "chaser_goal", "targetname" );
    var_0 setgoalnode( var_2 );
    var_0 delete();
}

spraypaint_runner( var_0, var_1 )
{
    var_1 maps\_anim::anim_single_solo( var_0, "spraypaint" );
    var_2 = getnode( "artist_goal", "targetname" );
    var_0 setgoalnode( var_2 );
    var_0 delete();
}

make_smart_floor_effect( var_0 )
{
    while ( !maps\_utility::ent_flag( "security_passed" ) )
    {
        var_0.origin = self.origin + ( 0, 0, 2 );
        waitframe();
    }

    var_0.origin = var_0.oldorigin;
}

setup_civs()
{
    if ( level.nextgen )
    {
        thread setup_civs_foodtruck();
        thread setup_civs_infosign();
        thread setup_civs_fence();
        thread setup_civs_baseball();
        thread setup_social_groups();
    }
    else
    {
        thread maps\detroit_transients_cg::cg_setup_civs_foodtruck();
        thread maps\detroit_transients_cg::cg_setup_civs_infosign();
        thread maps\detroit_transients_cg::cg_setup_civs_fence();
        thread maps\detroit_transients_cg::cg_setup_civs_baseball();
        thread maps\detroit_transients_cg::cg_setup_social_groups();
    }

    thread setup_food_line_and_guards();
    thread setup_choppers();
}

setup_civs_foodtruck()
{
    common_scripts\utility::flag_wait( "show_middle_civs_trigger" );
    var_0 = getent( "civilian_foodtruck1_spawner", "targetname" ) spawndrone();
    var_1 = undefined;
    var_2 = getent( "civilian_foodtruck3_spawner", "targetname" ) spawndrone();
    var_3 = undefined;
    var_4 = getent( "civilian_foodtruck5_spawner", "targetname" ) spawndrone();
    var_5 = getent( "civilian_foodtruck6_spawner", "targetname" ) spawndrone();
    var_6 = undefined;
    var_7 = getent( "civilian_foodtruck8_spawner", "targetname" ) spawndrone();
    var_8 = getent( "civilian_foodtruck9_spawner", "targetname" ) spawndrone();
    var_9 = getent( "civilian_foodtruck10_spawner", "targetname" ) spawndrone();
    var_10 = getent( "civilian_foodtruck11_spawner", "targetname" ) spawndrone();
    var_11 = undefined;
    var_12 = getent( "civilian_foodtruck13_spawner", "targetname" ) spawndrone();
    var_13 = getent( "civilian_foodtruck14_spawner", "targetname" ) spawndrone();
    var_14 = undefined;
    var_15 = getent( "atlas_guard_foodtruck2_spawner", "targetname" ) spawndrone();
    var_16 = getent( "foodtruck", "targetname" );
    var_0.animname = "drone_civs";
    var_2.animname = "drone_civs";
    var_4.animname = "drone_civs";
    var_5.animname = "drone_civs";
    var_7.animname = "drone_civs";
    var_8.animname = "drone_civs";
    var_9.animname = "drone_civs";
    var_10.animname = "drone_civs";
    var_12.animname = "drone_civs";
    var_13.animname = "drone_civs";
    var_15.animname = "drone_civs";
    var_16.animname = "foodtruck";
    var_0 maps\_anim::setanimtree();
    var_2 maps\_anim::setanimtree();
    var_4 maps\_anim::setanimtree();
    var_5 maps\_anim::setanimtree();
    var_7 maps\_anim::setanimtree();
    var_8 maps\_anim::setanimtree();
    var_9 maps\_anim::setanimtree();
    var_10 maps\_anim::setanimtree();
    var_12 maps\_anim::setanimtree();
    var_13 maps\_anim::setanimtree();
    var_15 maps\_anim::setanimtree();
    var_16 maps\_anim::setanimtree();
    var_17 = getent( "org_foodtruck", "targetname" );
    var_18 = spawn( "script_model", var_17.origin );
    var_18 setmodel( "det_cargo_box_single_01" );
    var_18.animname = "foodtruck_mre";
    var_18 maps\_anim::setanimtree();
    var_19 = spawn( "script_model", var_17.origin );
    var_19 setmodel( "det_cargo_box_single_01" );
    var_19.animname = "foodtruck_mre";
    var_19 maps\_anim::setanimtree();
    var_17 thread maps\_anim::anim_loop_solo( var_0, "foodtruck1" );
    var_17 thread maps\_anim::anim_loop_solo( var_2, "foodtruck3" );
    var_17 thread maps\_anim::anim_loop_solo( var_4, "foodtruck5" );
    var_17 thread maps\_anim::anim_loop_solo( var_5, "foodtruck6" );
    var_17 thread maps\_anim::anim_loop_solo( var_7, "foodtruck8" );
    var_17 thread maps\_anim::anim_loop_solo( var_8, "foodtruck9" );
    var_17 thread maps\_anim::anim_loop_solo( var_9, "foodtruck10" );
    var_17 thread maps\_anim::anim_loop_solo( var_10, "foodtruck11" );
    var_17 thread maps\_anim::anim_loop_solo( var_12, "foodtruck13" );
    var_17 thread maps\_anim::anim_loop_solo( var_13, "foodtruck14" );
    var_17 thread maps\_anim::anim_loop_solo( var_15, "foodtruck18" );
    var_17 thread maps\_anim::anim_loop_solo( var_16, "foodtruck_door" );
    thread mre_loop( var_18 );
    thread mre_loop( var_19 );
    var_17 thread maps\_anim::anim_loop_solo( var_18, "foodtruck_mre1" );
    var_17 thread maps\_anim::anim_loop_solo( var_19, "foodtruck_mre2" );

    if ( level.nextgen )
    {
        var_1 = getent( "civilian_foodtruck2_spawner", "targetname" ) spawndrone();
        var_1.animname = "drone_civs";
        var_1 maps\_anim::setanimtree();
        var_17 thread maps\_anim::anim_loop_solo( var_1, "foodtruck2" );
        var_3 = getent( "civilian_foodtruck4_spawner", "targetname" ) spawndrone();
        var_3.animname = "drone_civs";
        var_3 maps\_anim::setanimtree();
        var_17 thread maps\_anim::anim_loop_solo( var_3, "foodtruck4" );
        var_6 = getent( "civilian_foodtruck7_spawner", "targetname" ) spawndrone();
        var_6.animname = "drone_civs";
        var_6 maps\_anim::setanimtree();
        var_17 thread maps\_anim::anim_loop_solo( var_6, "foodtruck7" );
        var_11 = getent( "civilian_foodtruck12_spawner", "targetname" ) spawndrone();
        var_11.animname = "drone_civs";
        var_11 maps\_anim::setanimtree();
        var_17 thread maps\_anim::anim_loop_solo( var_11, "foodtruck12" );
        var_14 = getent( "atlas_guard_foodtruck1_spawner", "targetname" ) spawndrone();
        var_14.animname = "drone_civs";
        var_14 maps\_anim::setanimtree();
        var_17 thread maps\_anim::anim_loop_solo( var_14, "foodtruck17" );
    }

    while ( !common_scripts\utility::flag( "flag_camp_visibility_04" ) )
    {
        if ( randomint( 100 ) > 50 )
        {
            var_20 = getent( "civilian_foodtruck_grab_spawner_right", "targetname" ) spawndrone();
            var_20 hide();
            var_20.animname = "drone_civs";
            var_20 maps\_anim::setanimtree();
            var_20.runanim = level.scr_anim[var_20.animname]["foodtruck_grab_walk"];
            level waittill( "food_walker_go" );
            var_20 show();
            var_20 thread foodtruck_drone_walk_away_right( var_17 );
            continue;
        }

        var_20 = getent( "civilian_foodtruck_grab_spawner_left", "targetname" ) spawndrone();
        var_20 hide();
        var_20.animname = "drone_civs";
        var_20 maps\_anim::setanimtree();
        var_20.runanim = level.scr_anim[var_20.animname]["foodtruck_grab_walk"];
        level waittill( "food_walker_go" );
        var_20 show();
        var_20 thread foodtruck_drone_walk_away_left( var_17 );
    }

    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    var_0 delete();
    var_2 delete();
    var_4 delete();
    var_5 delete();
    var_7 delete();
    var_8 delete();
    var_9 delete();
    var_10 delete();
    var_12 delete();
    var_13 delete();
    var_15 delete();
    var_16 delete();

    if ( level.nextgen )
    {
        var_1 delete();
        var_3 delete();
        var_6 delete();
        var_11 delete();
        var_14 delete();
    }
}

mre_loop( var_0 )
{
    level waittill( "No more civs ever" );

    if ( isdefined( var_0 ) )
    {
        var_0 stopanimscripted();
        var_0 delete();
    }
}

foodtruck_drone_walk_away_right( var_0 )
{
    var_0 maps\_anim::anim_single_solo( self, "foodtruck_grab" );
    self.moveplaybackrate = 1;
    thread maps\_drone::drone_move();
}

foodtruck_drone_walk_away_left( var_0 )
{
    var_0 maps\_anim::anim_single_solo( self, "foodtruck_grab_left" );
    self.moveplaybackrate = 1;
    thread maps\_drone::drone_move();
}

setup_civs_infosign()
{
    common_scripts\utility::flag_wait( "flag_camp_visibility_01" );
    var_0 = undefined;
    var_1 = getent( "civilian_sign2_spawner", "targetname" ) spawndrone();
    var_2 = getent( "civilian_sign3_spawner", "targetname" ) spawndrone();
    var_3 = undefined;
    var_1.animname = "drone_civs";
    var_2.animname = "drone_civs";
    var_1 maps\_anim::setanimtree();
    var_2 maps\_anim::setanimtree();
    var_1 thread maps\_anim::anim_loop_solo( var_1, "sign2_spawner" );
    var_2 thread maps\_anim::anim_loop_solo( var_2, "sign3_spawner" );

    if ( level.nextgen )
    {
        var_0 = getent( "civilian_sign1_spawner", "targetname" ) spawndrone();
        var_0.animname = "drone_civs";
        var_0 maps\_anim::setanimtree();
        var_0 thread maps\_anim::anim_loop_solo( var_0, "sign1_spawner" );
        var_3 = getent( "civilian_sign4_spawner", "targetname" ) spawndrone();
        var_3.animname = "drone_civs";
        var_3 maps\_anim::setanimtree();
        var_3 thread maps\_anim::anim_loop_solo( var_3, "sign4_spawner" );
    }

    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    var_1 delete();
    var_2 delete();

    if ( level.nextgen )
    {
        var_0 delete();
        var_3 delete();
    }
}

setup_civ_fence_special()
{
    var_0 = getent( "civilian_fence9_spawner", "targetname" ) spawndrone();
    var_0.animname = "drone_civs";
    var_0 maps\_anim::setanimtree();
    var_0 thread maps\_anim::anim_loop_solo( var_0, "fence_spawner9_idle_start" );
    common_scripts\utility::flag_wait( "flag_civ_fence_sit" );
    var_0 notify( "stop_loop" );
    var_0 maps\_anim::anim_single_solo( var_0, "fence_spawner9_transition" );
    var_0 thread maps\_anim::anim_loop_solo( var_0, "fence_spawner9_idle_end" );

    while ( !common_scripts\utility::flag( "flag_camp_visibility_04" ) )
    {
        common_scripts\utility::flag_wait( "flag_camp_visibility_03b" );
        var_0 delete();
        common_scripts\utility::flag_clear( "flag_camp_visibility_03a" );
        common_scripts\utility::flag_wait( "flag_camp_visibility_03a" );
        var_0 = getent( "civilian_fence9_spawner", "targetname" ) spawndrone();
        var_0.animname = "drone_civs";
        var_0 maps\_anim::setanimtree();
        var_0 thread maps\_anim::anim_loop_solo( var_0, "fence_spawner9_idle_end" );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03b" );
    }
}

setup_civs_fence()
{
    thread setup_civ_fence_special();

    while ( !common_scripts\utility::flag( "flag_camp_visibility_04" ) )
    {
        var_0 = getent( "civilian_fence1_spawner", "targetname" ) spawndrone();
        var_1 = undefined;
        var_2 = getent( "civilian_fence3_spawner", "targetname" ) spawndrone();
        var_3 = getent( "civilian_fence4_spawner", "targetname" ) spawndrone();
        var_4 = getent( "civilian_fence5_spawner", "targetname" ) spawndrone();
        var_5 = getent( "civilian_fence6_spawner", "targetname" ) spawndrone();
        var_6 = getent( "civilian_fence7_spawner", "targetname" ) spawndrone();
        var_7 = getent( "civilian_fence8_spawner", "targetname" ) spawndrone();
        var_8 = undefined;
        var_9 = undefined;
        var_0.animname = "drone_civs";
        var_2.animname = "drone_civs";
        var_3.animname = "drone_civs";
        var_4.animname = "drone_civs";
        var_5.animname = "drone_civs";
        var_6.animname = "drone_civs";
        var_7.animname = "drone_civs";
        var_0 maps\_anim::setanimtree();
        var_2 maps\_anim::setanimtree();
        var_3 maps\_anim::setanimtree();
        var_4 maps\_anim::setanimtree();
        var_5 maps\_anim::setanimtree();
        var_6 maps\_anim::setanimtree();
        var_7 maps\_anim::setanimtree();
        var_0 thread maps\_anim::anim_loop_solo( var_0, "fence_spawner1" );
        var_2 thread maps\_anim::anim_loop_solo( var_2, "fence_spawner3" );
        var_3 thread maps\_anim::anim_loop_solo( var_3, "fence_spawner4" );
        var_4 thread maps\_anim::anim_loop_solo( var_4, "fence_spawner5" );
        var_5 thread maps\_anim::anim_loop_solo( var_5, "fence_spawner6" );
        var_6 thread maps\_anim::anim_loop_solo( var_6, "fence_spawner7" );
        var_7 thread maps\_anim::anim_loop_solo( var_7, "fence_spawner8" );

        if ( level.nextgen )
        {
            var_1 = getent( "civilian_fence2_spawner", "targetname" ) spawndrone();
            var_1.animname = "drone_civs";
            var_1 maps\_anim::setanimtree();
            var_1 thread maps\_anim::anim_loop_solo( var_1, "fence_spawner2" );
            var_8 = getent( "civilian_fence10_spawner", "targetname" ) spawndrone();
            var_8.animname = "drone_civs";
            var_8 maps\_anim::setanimtree();
            var_9 = getent( "civilian_fence11_spawner", "targetname" ) spawndrone();
            var_9.animname = "drone_civs";
            var_9 maps\_anim::setanimtree();
        }

        wait 1.0;

        if ( level.nextgen )
        {
            var_8 thread maps\_anim::anim_loop_solo( var_8, "fence_spawner10" );
            var_9 thread maps\_anim::anim_loop_solo( var_9, "fence_spawner11" );
        }

        common_scripts\utility::flag_wait( "flag_camp_visibility_03b" );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03a" );
        var_0 delete();
        var_2 delete();
        var_3 delete();
        var_4 delete();
        var_5 delete();
        var_6 delete();
        var_7 delete();

        if ( level.nextgen )
        {
            var_1 delete();
            var_8 delete();
            var_9 delete();
        }

        common_scripts\utility::flag_wait( "flag_camp_visibility_03a" );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03b" );
    }
}

setup_civs_baseball()
{
    common_scripts\utility::flag_wait( "flag_camp_visibility_01" );
    var_0 = getent( "org_baseball", "targetname" );
    var_1 = getent( "civilian_baseball1_spawner", "targetname" ) spawndrone();
    var_1.animname = "drone_civs";
    var_1 maps\_anim::setanimtree();
    var_2 = getent( "civilian_baseball2_spawner", "targetname" ) spawndrone();
    var_2.animname = "drone_civs";
    var_2 maps\_anim::setanimtree();
    var_3 = getent( "baseball_glove1", "targetname" );
    var_3.animname = "baseball_glove";
    var_3 maps\_anim::setanimtree();
    var_4 = getent( "baseball_glove2", "targetname" );
    var_4.animname = "baseball_glove";
    var_4 maps\_anim::setanimtree();
    var_0 thread maps\_anim::anim_loop_solo( var_1, "baseball1" );
    var_0 thread maps\_anim::anim_loop_solo( var_2, "baseball2" );
    var_0 thread maps\_anim::anim_loop_solo( var_3, "baseball_glove1" );
    var_0 thread maps\_anim::anim_loop_solo( var_4, "baseball_glove2" );
    var_1 attach( "ehq_baseball", "tag_weapon_chest" );
    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    var_1 delete();
    var_2 delete();
    var_3 delete();
    var_4 delete();
}

setup_civs_talking()
{
    var_0 = getent( "civilian_talking1_spawner", "targetname" ) spawndrone();
    var_1 = getent( "civilian_talking2_spawner", "targetname" ) spawndrone();
    var_0.animname = "drone_civs";
    var_1.animname = "drone_civs";
    var_0 maps\_anim::setanimtree();
    var_1 maps\_anim::setanimtree();
    var_2 = getent( "org_civtalking", "targetname" );
    var_2 thread maps\_anim::anim_single_solo( var_0, "civtalking1" );
    var_2 thread maps\_anim::anim_single_solo( var_1, "civtalking2" );
    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    var_0 delete();
    var_1 delete();
}

setup_choppers()
{
    level endon( "flag_camp_visibility_04" );

    if ( level.currentgen )
        level endon( "flag_cg_kill_camp_chopper_loop" );

    if ( level.currentgen )
    {
        for (;;)
        {
            if ( istransientloaded( "detroit_intro_tr" ) )
                break;

            wait 0.5;
        }
    }

    var_0 = getentarray( "cargo_chopper_01", "targetname" );
    var_1 = "com_prague_rope_animated";
    var_2 = "mob_cargo_pallet_long";
    var_3 = 464;
    wait 1;

    while ( !common_scripts\utility::flag( "flag_camp_visibility_04" ) )
    {
        var_4 = var_0;

        for ( var_5 = 0; var_5 < 2; var_5++ )
        {
            var_6 = var_4[randomint( var_4.size )];
            var_4 = common_scripts\utility::array_remove( var_4, var_6 );
            var_7 = var_6 maps\_vehicle::spawn_vehicle_and_gopath();
            var_7.targetname = "refugee_camp_looping_choppers";
            playfxontag( common_scripts\utility::getfx( "aircraft_light_wingtip_red_med" ), var_7, "TAG_light_L_wing" );
            wait 0.05;
            playfxontag( common_scripts\utility::getfx( "aircraft_light_wingtip_red_med" ), var_7, "TAG_light_R_wing" );
            playfxontag( common_scripts\utility::getfx( "aircraft_light_wingtip_red_med" ), var_7, "TAG_light_tail" );
            var_8 = getent( "reflection_golden_bottom", "targetname" );
            var_7 overridereflectionprobe( var_8.origin );

            if ( level.currentgen )
            {
                if ( common_scripts\utility::flag( "flag_cg_kill_camp_chopper_loop" ) )
                    break;
            }

            wait(randomintrange( 2, 10 ));
        }

        wait 30;
    }
}

setup_social_groups()
{
    var_0 = [ "civilian_smoking_a", "civilian_smoking_b", "civilian_atm", "civilian_stand_idle", "london_civ_idle_checkwatch", "london_civ_idle_foldarms2", "london_civ_idle_lookbehind", "london_civ_idle_foldarms_scratchass", "london_civ_idle_scratchnose" ];
    var_1 = [ "civilian_sitting_business_lunch_a_1", "civilian_sitting_business_lunch_b_1", "civilian_sitting_talking_a_1", "civilian_sitting_talking_a_2", "civilian_sitting_talking_b_1", "civilian_sitting_talking_b_2", "civilian_texting_sitting", "civilian_reader_1", "sitting_guard_loadak_idle", "guarda_sit_sleeper_idle", "parabolic_leaning_guy_idle", "civilian_stand_idle", "det_camp_box_seated_civ_guy01", "det_camp_box_seated_civ_guy02", "det_camp_box_seated_civ_guy02", "sitting_guard_loadak_idle", "civilian_reader_2" ];
    var_2 = getentarray( "civ_life_scene_01", "targetname" );
    var_3 = getentarray( "civ_life_scene_02", "targetname" );
    var_4 = common_scripts\utility::getstructarray( "civ_life_scene_01", "targetname" );
    var_5 = common_scripts\utility::getstructarray( "civ_life_scene_02", "targetname" );
    var_6 = common_scripts\utility::array_combine( var_4, var_5 );
    var_7 = getentarray( "spawner_civs_food_herd_01", "targetname" );
    var_8 = getentarray( "civ_life_scene_01_orgs", "targetname" );
    var_6 = common_scripts\utility::array_combine( var_6, var_8 );
    level.section_1_civilians = [];
    level.tent_scene_civilians_01 = [];
    level.tent_scene_civilians_02 = [];

    foreach ( var_10 in var_6 )
    {
        var_11 = common_scripts\utility::random( var_7 ) spawndrone();
        var_11.animname = "drone_civs";
        var_11 maps\_anim::setanimtree();
        var_11.origin = var_10.origin;
        var_11.angles = var_10.angles;
        var_11 thread delete_me_on_notify();
        level.section_1_civilians[level.section_1_civilians.size] = var_11;

        if ( isdefined( var_10.script_noteworthy ) && var_10.script_noteworthy == "civ_sitting" )
        {
            var_10 thread maps\_shg_design_tools::anim_simple( var_11, common_scripts\utility::random( var_1 ) );
            continue;
        }

        var_10 thread maps\_shg_design_tools::anim_simple( var_11, common_scripts\utility::random( var_0 ) );
    }

    var_13 = common_scripts\utility::getstructarray( "civ_tent_scene_01", "targetname" );
    var_14 = common_scripts\utility::getstructarray( "civ_tent_scene_02", "targetname" );

    foreach ( var_10 in var_14 )
    {
        var_11 = common_scripts\utility::random( var_7 ) spawndrone();
        var_11.animname = "drone_civs";
        var_11 maps\_anim::setanimtree();
        var_11.origin = var_10.origin;
        var_11.angles = var_10.angles;
        var_11 thread delete_me_on_notify();
        level.tent_scene_civilians_02[level.tent_scene_civilians_02.size] = var_11;

        if ( var_10.animation == "civilian_smoking_b" || var_10.animation == "civilian_smoking_a" )
        {
            var_11 attach( "prop_cigarette", "tag_inhand", 1 );
            var_10 thread maps\_shg_design_tools::anim_simple( var_11, var_10.animation );
            continue;
        }

        var_10 thread maps\_shg_design_tools::anim_simple( var_11, var_10.animation );
    }

    while ( !common_scripts\utility::flag( "flag_camp_visibility_04" ) )
    {
        foreach ( var_10 in var_13 )
        {
            var_11 = common_scripts\utility::random( var_7 ) spawndrone();
            var_11.animname = "drone_civs";
            var_11 maps\_anim::setanimtree();
            var_11.origin = var_10.origin;
            var_11.angles = var_10.angles;
            var_11 thread delete_me_on_notify();
            level.tent_scene_civilians_01[level.tent_scene_civilians_01.size] = var_11;

            if ( var_10.animation == "civilian_smoking_b" || var_10.animation == "civilian_smoking_a" )
            {
                var_11 attach( "prop_cigarette", "tag_inhand", 1 );
                var_10 thread maps\_shg_design_tools::anim_simple( var_11, var_10.animation );
                continue;
            }

            var_10 thread maps\_shg_design_tools::anim_simple( var_11, var_10.animation );
        }

        common_scripts\utility::flag_wait( "flag_camp_visibility_03b" );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03a" );
        common_scripts\utility::array_thread( level.tent_scene_civilians_01, maps\_shg_design_tools::delete_auto );
        common_scripts\utility::flag_wait( "flag_camp_visibility_03a" );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03b" );
        wait 0.2;
    }

    common_scripts\utility::array_thread( level.section_1_civilians, maps\_shg_design_tools::delete_auto );
    common_scripts\utility::array_thread( level.tent_scene_civilians_01, maps\_shg_design_tools::delete_auto );
    common_scripts\utility::array_thread( level.tent_scene_civilians_02, maps\_shg_design_tools::delete_auto );
}

delete_me_on_notify()
{
    common_scripts\utility::flag_wait( "begin_player_mount_bike" );

    if ( isdefined( self ) )
    {
        self stopanimscripted();
        self delete();
    }
}

setup_food_line_and_guards()
{
    common_scripts\utility::flag_wait( "level_intro_cinematic_complete" );
    level endon( "flag_camp_visibility_04" );
    var_0 = getentarray( "spawner_civs_food_herd_01", "targetname" );
    common_scripts\utility::array_thread( var_0, ::looping_civilian_path_foodwalkers );
    wait(randomfloatrange( 10.0, 15.0 ));
    common_scripts\utility::array_thread( var_0, ::looping_civilian_path_foodwalkers );
    wait(randomfloatrange( 10.0, 15.0 ));
    common_scripts\utility::array_thread( var_0, ::looping_civilian_path_foodwalkers );
}

looping_civilian_path_foodwalkers()
{
    level endon( "flag_camp_visibility_04" );
    var_0 = [ "civ_team1", "civ_team2", "civ_team3", "civ_team4", "civ_team5", "civ_team6", "civ_team7", "civ_team8", "civ_team9" ];

    for (;;)
    {
        var_1 = common_scripts\utility::random( maps\_utility::getgenericanim( "depressed_walk" ) );
        wait(randomfloatrange( 5.0, 10.0 ));
        var_2 = maps\_utility::dronespawn( self );
        thread setup_civ_animations( var_2, var_1 );

        if ( !isdefined( var_2.target ) )
        {
            var_2 delete();
            continue;
        }

        var_2.team = common_scripts\utility::random( var_0 );
        var_2 waittill( "goal" );
        var_2 delete();
    }
}

setup_civ_animations( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
    {
        var_0.animname = "generic";
        var_0.runanim = var_1;
    }
}

set_refugee_camp_walk_anims()
{
    maps\_utility::set_run_anim( "refugee_camp_walk_fast" );
    maps\_utility::set_idle_anim( "refugee_camp_idle" );
    self.old_turnrate = self.turnrate;
    self.turnrate = 0.05;
    self orientmode( "face motion" );
    self.usepathsmoothingvalues = 1;
    self.maxturnspeed = 3;
    self.old_pathlookaheaddist = self.pathlookaheaddist;
    self.pathlookaheaddist = 160;
    self.sharpturn = 0.2;
    self.stand_to_run_overrideanim = maps\_utility::getanim( "refugee_camp_idle_to_walk" );
    self notify( "move_loop_restart" );
    self allowedstances( "stand" );
    self.disablearrivals = 1;
    self.disableexits = 1;
    thread clear_refugee_camp_walk_anims();
}

clear_refugee_camp_walk_anims()
{
    common_scripts\utility::flag_wait( "refugee_camp_cleanup" );
    self.usepathsmoothingvalues = 0;
    self.old_disablearrivals = undefined;
    self.pathlookaheaddist = self.old_pathlookaheaddist;
    self.old_pathlookaheaddist = undefined;
    self.disablearrivals = 0;
    self.disableexits = 0;
    self allowedstances( "stand", "crouch", "prone" );
}

setup_civs_walkers()
{
    maps\_utility::trigger_wait_targetname( "spawn_walking_civs" );
    var_0 = getent( "walker", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    wait 5;
}

security_triggers()
{
    thread sec_trig1();
    thread sec_trig2();
    thread sec_trig3();
    thread sec_trig4();
}

sec_trig1()
{
    maps\_utility::trigger_wait_targetname( "invalid_1" );
}

sec_trig2()
{
    maps\_utility::trigger_wait_targetname( "invalid_2" );
}

sec_trig3()
{
    maps\_utility::trigger_wait_targetname( "access_granted" );
}

sec_trig4()
{

}

tv_movie()
{
    common_scripts\utility::array_call( getentarray( "propaganda_screens_static", "targetname" ), ::hide );
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingameloop( "detroit_stage_display" );
    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    stopcinematicingame();
    common_scripts\utility::array_call( getentarray( "propaganda_screens", "targetname" ), ::delete );
    common_scripts\utility::array_call( getentarray( "propaganda_screens_static", "targetname" ), ::show );
}

debug_start_bike_ride_in()
{
    var_0 = getent( "player_bike_node", "targetname" );
    wait 0.05;
    level.player maps\_utility::teleport_player( var_0 );
}

opening_start()
{
    thread delay_show_bones();
    common_scripts\utility::flag_set( "level_intro_cinematic_complete_real" );
    thread opening_start_fov_changes();
    soundscripts\_snd::snd_message( "opening_start" );
    var_0 = getdvarint( "g_friendlyNameDist" );
    setsaveddvar( "compass", "0" );
    setsaveddvar( "ammoCounterHide", "1" );
    setsaveddvar( "hud_showstance", "0" );
    setsaveddvar( "actionSlotsHide", "1" );
    setsaveddvar( "g_friendlyNameDist", 0 );
    common_scripts\utility::flag_wait( "level_name_intro_done" );
    level.player allowjump( 0 );
    var_1 = maps\_utility::spawn_anim_model( "world_body" );
    level.player maps\_shg_utility::setup_player_for_scene();
    thread player_ads_disable_manager();
    level.player playerlinktodelta( var_1, "tag_player", 1.0, 0, 0, 0, 0, 1 );
    var_2 = getent( "burke_level_intro_animnode", "targetname" );
    var_3 = maps\_utility::spawn_anim_model( "warbird_int" );
    var_4 = maps\_utility::spawn_anim_model( "warbird_ext" );
    thread maps\detroit_fx::waribird_intro_vfx( var_4 );
    var_5 = getent( "reflection_golden_bottom", "targetname" );
    var_6 = getent( "reflection_dark_bottom", "targetname" );
    var_7 = getent( "reflection_dark_bottom2", "targetname" );
    var_8 = getent( "reflection_white_bottom", "targetname" );
    var_3 overridereflectionprobe( var_6.origin );
    var_4 overridereflectionprobe( var_5.origin );
    playfxontag( common_scripts\utility::getfx( "light_wingtip_red_med_point" ), var_4, "TAG_light_L_wing" );
    playfxontag( common_scripts\utility::getfx( "light_wingtip_red_med_point" ), var_4, "TAG_light_R_wing" );
    playfxontag( common_scripts\utility::getfx( "light_wingtip_red_med_point" ), var_4, "TAG_light_tail" );
    common_scripts\utility::flag_set( "vo_refugee_camp_intro" );
    var_9 = getent( "intro_guy1", "targetname" );
    var_10 = getent( "intro_guy2", "targetname" );
    var_11 = getent( "intro_guy3", "targetname" );
    var_12 = var_9 maps\_utility::spawn_ai( 1 );
    var_13 = var_10 maps\_utility::spawn_ai( 1 );
    var_14 = var_11 maps\_utility::spawn_ai( 1 );

    if ( level.nextgen )
    {
        var_12 overridereflectionprobe( var_7.origin );
        var_13 overridereflectionprobe( var_7.origin );
    }

    var_12.animname = "intro_guy1";
    var_13.animname = "intro_guy2";
    var_14.animname = "intro_guy3";
    soundscripts\_snd::snd_message( "level_intro_cinematic", var_4 );
    var_3 common_scripts\utility::delaycall( 9, ::delete );
    var_12 common_scripts\utility::delaycall( 9, ::delete );
    var_13 common_scripts\utility::delaycall( 9, ::delete );
    thread play_jump_out_of_heli_rumble();
    var_2 thread maps\_anim::anim_single_run( [ level.burke ], "level_intro_cinematic" );
    var_2 thread maps\_anim::anim_single_run( [ level.joker ], "level_intro_cinematic" );
    var_2 maps\_anim::anim_single_run( [ var_3, var_4, var_1, var_12, var_13, var_14 ], "level_intro_cinematic" );
    common_scripts\utility::flag_set( "level_intro_cinematic_complete" );
    var_14 thread guard_the_gate( var_2 );
    var_1 delete();
    level.player unlink();
    level notify( "end_burke_intro_talk" );
    common_scripts\utility::flag_set( "intro_animation_completed_now" );
    level.player maps\_shg_utility::setup_player_for_gameplay();
    maps\_utility::delaythread( 2, maps\_utility::center_screen_text, &"DETROIT_FOUR_YEARS_LATER" );
    maps\_utility::delaythread( 2, common_scripts\utility::flag_set, "begin_objectives" );
    level.player allowprone( 0 );
    level.player takeallweapons();
    level.player giveweapon( "iw5_bal27down_sp_silencer01_variablereddot" );
    level.player switchtoweapon( "iw5_bal27down_sp_silencer01_variablereddot" );
    level.player allowfire( 0 );
    level.player allowmelee( 0 );
    level.player allowsprint( 0 );
    level.player disableoffhandweapons();
    level.player maps\_player_exo::unsetboostdash();
    setsaveddvar( "r_hudOutlineEnable", 0 );
    setsaveddvar( "compass", "1" );
    setsaveddvar( "hud_showstance", "1" );
    setsaveddvar( "actionSlotsHide", "0" );
    setsaveddvar( "g_friendlyNameDist", var_0 );
    common_scripts\utility::flag_set( "obj_acquire_bikes_give" );
    thread refugee_walk();
    wait 0.05;
    var_4 delete();
    wait 9.25;
    common_scripts\utility::flag_set( "vo_refugee_camp_meet_joker" );
}

play_jump_out_of_heli_rumble()
{
    wait 3.92;
    level.player playrumbleonentity( "damage_light" );
}

guard_the_gate( var_0 )
{
    var_0 thread maps\_anim::anim_loop_solo( self, "post_level_intro_cinematic_idle" );
    level waittill( "player_has_used_bike" );
    var_0 notify( "stop_loop" );
    self delete();
}

opening_start_fov_changes()
{
    level waittill( "opening_fovchange" );
    level.player lerpfov( 65, 1 );
}

setup_refugee_camp_soldiers_group_1()
{
    var_0 = getent( "refugee_soldier_spawner", "targetname" );
    var_1 = getentarray( "refugee_vignette_soldier_loop_01", "targetname" );

    while ( !common_scripts\utility::flag( "flag_camp_visibility_04" ) )
    {
        var_2 = [];

        foreach ( var_4 in var_1 )
        {
            var_0.count = 1;
            var_5 = var_0 maps\_utility::spawn_ai( 1 );
            var_2[var_2.size] = var_5;
            var_5 maps\_utility::deletable_magic_bullet_shield();

            if ( var_4.animation != "casual_stand_idle" )
                var_4 thread maps\_shg_design_tools::anim_simple( var_5, var_4.animation );
            else
            {
                var_5.origin = var_4.origin;
                var_5.angles = var_4.angles;

                if ( maps\_utility::s1_motionset_avaliable() )
                    var_5 maps\_drone::drone_set_archetype_idle( "s1_soldier" );
                else
                    var_5 maps\_drone::drone_set_archetype_idle( "soldier" );
            }

            wait 0.05;
        }

        common_scripts\utility::flag_wait( "flag_camp_visibility_03b" );
        common_scripts\utility::array_call( var_2, ::delete );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03a" );
        common_scripts\utility::flag_wait( "flag_camp_visibility_03a" );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03b" );
    }
}

player_bike_shutoff( var_0 )
{
    common_scripts\utility::flag_wait( "shutoff_player_bike" );
    level.player takeallweapons();
    var_0 notify( "stop_jetbike_handle_viewmodel_anims" );
    var_0 vehicle_jetbikesethoverforcescale( 0 );
    level.player giveweapon( "iw5_bal27_sp_silencer01_variablereddot" );
    level.player switchtoweapon( "iw5_bal27_sp_silencer01_variablereddot" );
    level.player allowfire( 1 );
    level.player allowmelee( 1 );
    level.player allowdodge( 1 );
    setsaveddvar( "r_hudOutlineEnable", 1 );
}

player_bike_lower()
{
    level endon( "stop_lowering_bike" );
    level endon( "time to raise bike up" );
    maps\_utility::trigger_wait_targetname( "enter_garage" );

    for (;;)
    {
        level.player_hover_height = 0.6;
        wait 0.05;
    }
}

mechs_motorpool_animation()
{
    var_0 = getent( "scanner_intro_anim_node", "targetname" );
    maps\_shg_design_tools::waittill_trigger_with_name( "access_granted" );

    if ( level.currentgen )
    {
        thread transient_intro_to_middle_begin();

        for (;;)
        {
            if ( istransientloaded( "detroit_gatetrans_tr" ) )
                break;

            wait 0.5;
        }
    }

    common_scripts\utility::flag_wait( "everone_motorpool_animate" );
    var_1 = [ level.mech1, level.mech2 ];
    var_0 thread maps\_anim::anim_single( var_1, "hoverbike_meet_up" );
}

ai_motorpool_animation()
{
    var_0 = getent( "scanner_intro_anim_node", "targetname" );
    var_1 = getent( "detroit_entrance_gate", "targetname" );
    var_1.animname = "entrance_gate";
    var_1 maps\_anim::setanimtree();
    var_2 = [ level.bones, level.joker, level.burke, var_1 ];
    var_3 = [ level.burke_bike, level.joker_bike, level.bones_bike ];
    common_scripts\utility::flag_wait( "everone_motorpool_animate" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "hoverbike_meet_up" );
}

setup_refugee_camp_soldiers()
{
    maps\_drone_ai::init();

    if ( level.nextgen )
        thread setup_refugee_stage_speaker();
    else
        thread maps\detroit_transients_cg::cg_setup_refugee_stage_speaker();

    thread setup_refugee_camp_soldiers_group_1();
    var_0 = getent( "refugee_soldier_spawner", "targetname" );
    common_scripts\utility::flag_wait( "flag_camp_visibility_01" );
    var_1 = [];
    var_2 = getentarray( "refugee_vignette_soldier_loop_02", "targetname" );

    foreach ( var_4 in var_2 )
    {
        var_0.count = 1;
        var_5 = var_0 maps\_utility::spawn_ai( 1 );
        var_5.friendname = "soldier 2";
        var_1[var_1.size] = var_5;
        var_5 maps\_utility::deletable_magic_bullet_shield();
        var_4 thread maps\_shg_design_tools::anim_simple( var_5, var_4.animation );
        wait 0.05;
    }

    common_scripts\utility::flag_wait( "flag_camp_visibility_02" );
    var_7 = [];
    var_2 = getentarray( "refugee_vignette_soldier_loop_03", "targetname" );

    foreach ( var_4 in var_2 )
    {
        var_0.count = 1;
        var_5 = var_0 maps\_utility::spawn_ai( 1 );
        var_7[var_7.size] = var_5;
        var_5 maps\_utility::deletable_magic_bullet_shield();
        var_4 thread maps\_shg_design_tools::anim_simple( var_5, var_4.animation );
        wait 0.05;
    }

    if ( level.currentgen )
    {
        var_10 = [];
        var_2 = getentarray( "refugee_vignette_soldier_loop_03_pre_scanners", "targetname" );

        foreach ( var_4 in var_2 )
        {
            var_0.count = 1;
            var_5 = var_0 maps\_utility::spawn_ai( 1 );
            var_5 maps\_utility::deletable_magic_bullet_shield();
            var_4 thread maps\_shg_design_tools::anim_simple( var_5, var_4.animation );
            thread maps\detroit_transients_cg::cg_kill_entity_on_flag( var_5, "flag_camp_visibility_04" );
            wait 0.05;
        }
    }

    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    var_13 = [];
    var_2 = getentarray( "refugee_vignette_soldier_loop_04", "targetname" );

    foreach ( var_4 in var_2 )
    {
        var_0.count = 1;
        var_5 = var_0 maps\_utility::spawn_ai( 1 );
        var_13[var_13.size] = var_5;
        var_5 maps\_utility::deletable_magic_bullet_shield();
        var_4 thread maps\_shg_design_tools::anim_simple( var_5, var_4.animation );
        wait 0.05;
    }

    common_scripts\utility::array_call( var_1, ::delete );
    common_scripts\utility::flag_wait( "refugee_camp_cleanup" );
    common_scripts\utility::array_call( var_7, ::delete );
    common_scripts\utility::flag_wait( "open_massive_door" );
    common_scripts\utility::array_call( var_13, ::delete );
}

setup_refugee_stage_speaker()
{
    common_scripts\utility::flag_wait( "flag_stage_dialogue_start_audio" );
    var_0 = getent( "refugee_stage_speaker", "targetname" ) maps\_utility::dronespawn();
    var_0.animname = "Atlas_Commander";
    var_0.runanim = level.scr_anim[var_0.animname]["det_camp_stagespeech_walk"];
    var_1 = getent( "org_stage_speaker", "targetname" );
    var_1 maps\_anim::anim_single_solo( var_0, "det_camp_stagespeech_guy01" );
    var_0.target = "stage_talker_exit";
    var_0.moveplaybackrate = 1;
    var_0 thread maps\_drone::drone_move();
}

setup_refugee_stage_audience()
{
    common_scripts\utility::flag_wait( "flag_camp_visibility_01" );
    var_0 = [];
    var_1 = getentarray( "civilian_orgs_sitting", "targetname" );
    var_2 = getentarray( "civilian_spawner", "targetname" );

    foreach ( var_4 in var_1 )
    {
        if ( maps\_shg_design_tools::percentchance( 30 ) )
        {
            var_5 = common_scripts\utility::random( var_2 );
            var_5.count = 1;
            var_6 = maps\_utility::dronespawn( var_5 );
            var_4 thread maps\_shg_design_tools::anim_simple( var_6, var_4.animation );
            var_0[var_0.size] = var_6;
            level.refugee_camp_ai[level.refugee_camp_ai.size] = var_6;
        }

        wait(randomfloat( 0.25 ));
    }

    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    common_scripts\utility::array_call( var_0, ::delete );
}

sighting_think( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    target_set( var_1 );
    target_hidefromplayer( var_1, level.player );
    var_0.count = 1;
    var_2 = var_0 maps\_utility::spawn_ai( 1 );

    if ( !isdefined( var_2 ) )
        return;

    var_2.ignoreall = 1;
    var_2.animname = "generic";
    var_2 teleport( self.origin, self.angles );
    var_2 thread maps\_anim::anim_generic_first_frame( var_2, self.animation );
    var_1.origin = var_2 gettagorigin( "tag_eye" );

    while ( isdefined( var_2 ) )
    {
        if ( target_isincircle( var_1, level.player, 65, 100 ) && bullettracepassed( level.player geteye(), var_2 geteye(), 0, var_2 ) )
            break;

        waitframe();
    }

    if ( isdefined( var_2 ) )
    {
        var_2 maps\_anim::anim_generic( var_2, self.animation );
        var_2 delete();
    }

    var_1 delete();
}

debug_vehicle_node()
{
    for (;;)
    {
        self waittill( "trigger" );
        thread draw_vehicle_node_triggered();
    }
}

draw_vehicle_node_triggered()
{
    for ( var_0 = 0; var_0 < 20; var_0++ )
        waitframe();
}

debug_tag( var_0, var_1, var_2, var_3 )
{
    thread debug_tag_internal( var_0, var_1, var_2, var_3 );
}

debug_tag_internal( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = var_1;

    if ( !isdefined( var_3 ) )
        var_3 = 10;

    var_0 endon( "death" );

    for (;;)
    {
        var_4 = var_0 gettagorigin( var_1 );
        var_5 = var_0 gettagangles( var_1 );
        waitframe();
    }
}

handle_ambient_cleanup_vehicles()
{
    wait 1;
    var_0 = getent( "spawner_ambient_car_guys", "targetname" );
    var_1 = getent( "ambient_cleanup_vehicle_01", "targetname" );
    var_2 = 3;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = var_0 maps\_shg_design_tools::actual_spawn();
        var_4.ignoreall = 1;
        thread maps\_utility::guy_runtovehicle_load( var_4, var_1 );
        var_4 thread turn_self_into_level_notify( "enteredvehicle" );
        wait 1.5;
    }

    for ( var_3 = 0; var_3 < var_2; var_3++ )
        level waittill( "enteredvehicle" );

    wait 1;
    var_1 maps\_vehicle::gopath();
    level waittill( "stop_busses" );
}

turn_self_into_level_notify( var_0 )
{
    self waittill( var_0 );
    level notify( var_0 );
}

handle_name_identifiers_intro_drive()
{
    var_0 = getdvarint( "g_friendlyNameDist" );
    setsaveddvar( "g_friendlyNameDist", 0 );
    common_scripts\utility::flag_wait( "obj_check_school_give" );
    setsaveddvar( "g_friendlyNameDist", var_0 );
}

handle_guage_textures_intro_drive()
{
    level waittill( "intro_drive_on_button_pressed" );
    level.player_bike vehicle_scripts\_jetbike::jetbike_speedometer_on();
    level waittill( "intro_drive_off_button_pressed" );
    level.player_bike vehicle_scripts\_jetbike::jetbike_speedometer_off();
}

handle_guage_textures_intro_drive_newbike()
{
    level waittill( "intro_drive_on_button_pressed" );
    level.player_bikenew vehicle_scripts\_jetbike::jetbike_speedometer_on();
    level waittill( "intro_drive_off_button_pressed" );
    level.player_bikenew vehicle_scripts\_jetbike::jetbike_speedometer_off();
}

notify_bike_hover( var_0 )
{
    var_0 notify( "powerup" );
}

notify_guy_mounted( var_0 )
{
    var_0 notify( "bike_mounted" );
}

joker_bones_bike_start( var_0 )
{
    common_scripts\utility::flag_wait( "flag_decon_ready_joker" );
    var_1 = [ level.joker_bike, level.bones_bike ];
    var_0 thread maps\_anim::anim_single( var_1, "hoverbike_kickstand" );
    thread joker_bike_idle_wait( var_0 );
    thread bones_bike_idle_wait( var_0 );
}

joker_bike_idle_wait( var_0 )
{
    level.joker_bike waittill( "powerup" );
    var_0 thread maps\_anim::anim_loop( [ level.joker_bike ], "hoverbike_pre_mount", "hoverbike_pre_mount_ender" );
}

bones_bike_idle_wait( var_0 )
{
    level.bones_bike waittill( "powerup" );
    var_0 thread maps\_anim::anim_loop( [ level.bones_bike ], "hoverbike_pre_mount", "hoverbike_pre_mount_ender" );
}

setup_mechs()
{
    level.mech1 = getent( "big_door_mech_spawner_left", "targetname" ) maps\_shg_design_tools::actual_spawn();
    level.mech1.animname = "mech1";
    level.mech1.ignoreall = 1;
    level.mech1.ignoreme = 1;
    level.mech2 = getent( "big_door_mech_spawner_right", "targetname" ) maps\_shg_design_tools::actual_spawn();
    level.mech2.animname = "mech2";
    level.mech2.ignoreall = 1;
    level.mech2.ignoreme = 1;
    level.hoverbike_meet_up_mech1 = level.mech1;
    var_0 = getent( "detroit_entrance_gate", "targetname" );
    var_0.animname = "entrance_gate";
    var_0 maps\_anim::setanimtree();
}

setup_motorpool( var_0 )
{
    var_1 = getent( "scanner_intro_anim_node", "targetname" );
    var_2 = [];

    foreach ( var_4 in [ "burke_bike", "joker_bike", "bones_bike", "player_bike" ] )
    {
        var_5 = getstartorigin( var_1.origin, var_1.angles, level.scr_anim[var_4]["hoverbike_pre_mount"][0] );
        var_6 = getstartangles( var_1.origin, var_1.angles, level.scr_anim[var_4]["hoverbike_pre_mount"][0] );
        var_7 = spawn( "script_model", var_5 );
        var_7.angles = var_6;
        var_7 setmodel( "vehicle_mil_hoverbike_parked_static" );
        var_2[var_2.size] = var_7;
    }

    common_scripts\utility::flag_wait( "flag_camp_visibility_03" );
    maps\detroit::spawn_bikes();

    foreach ( var_10 in var_2 )
        var_10 delete();

    level.player_bike_obj = spawn( "script_model", ( 0, 0, 0 ) );
    level.player_bike_obj.animname = level.player_bike.animname;
    level.player_bike_obj maps\_utility::assign_animtree();
    level.player_bike_obj setmodel( "vehicle_mil_hoverbike_ai_obj" );
    var_12 = [ level.player_bike, level.burke_bike, level.joker_bike, level.bones_bike ];
    var_13 = [ level.player_bike_obj, level.player_bike, level.burke_bike ];
    var_1 thread maps\_anim::anim_loop( var_13, "hoverbike_pre_mount", "hoverbike_pre_mount_ender" );
    thread joker_bones_bike_start( var_1 );
    level.player_bike showallparts();
    level.player_bike_obj hideallparts();
    common_scripts\utility::flag_wait( "flag_scanner_doors_open" );

    if ( level.nextgen )
    {

    }

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( var_0 == 0 )
        maps\_shg_design_tools::waittill_trigger_with_name( "access_granted" );

    if ( level.currentgen )
    {
        thread transient_intro_to_middle_begin();

        for (;;)
        {
            if ( istransientloaded( "detroit_gatetrans_tr" ) )
                break;

            wait 0.5;
        }
    }

    level.mech1 = getent( "big_door_mech_spawner_left", "targetname" ) maps\_shg_design_tools::actual_spawn();
    level.mech1.animname = "mech1";
    level.mech1.ignoreall = 1;
    level.mech1.ignoreme = 1;
    level.mech2 = getent( "big_door_mech_spawner_right", "targetname" ) maps\_shg_design_tools::actual_spawn();
    level.mech2.animname = "mech2";
    level.mech2.ignoreall = 1;
    level.mech2.ignoreme = 1;
    level.hoverbike_meet_up_mech1 = level.mech1;
    var_14 = getent( "detroit_entrance_gate", "targetname" );
    var_14.animname = "entrance_gate";
    var_14 maps\_anim::setanimtree();
    var_15 = [ level.burke, level.bones, level.joker ];
    var_16 = getent( "use_hoverbike_opening_trigger", "targetname" );
    var_16 sethintstring( &"DETROIT_PROMPT_USE" );
    var_17 = getent( "use_hoverbike_opening_trigger", "targetname" ) maps\_shg_utility::hint_button_trigger( "use", 200 );

    if ( level.start_point != "mount_bikes" )
        var_16 waittill( "trigger" );

    thread play_doctor_pip();
    level notify( "player_has_used_bike" );
    common_scripts\utility::flag_set( "begin_player_mount_bike" );
    var_16 delete();
    var_17 maps\_shg_utility::hint_button_clear();
    objective_position( maps\_utility::obj( "Follow Gideon" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "Follow Gideon" ), &"DETROIT_FOLLOW" );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    common_scripts\utility::flag_set( "vo_autopilot_engaged" );
    common_scripts\utility::flag_set( "refugee_camp_cleanup" );
    common_scripts\utility::flag_set( "security_checkpoint_cleanup" );
    common_scripts\utility::flag_set( "drivein_player_bike_used" );
    common_scripts\utility::flag_set( "obj_acquire_bikes_complete" );

    if ( level.nextgen )
    {
        level.burke_bike overridematerial( "mtl_mil_hoverbike", "m/mtl_mil_hoverbike_emissive" );
        level.burke_bike overridematerial( "m/mtl_mil_hoverbike_glass", "m/mtl_mil_hoverbike_glass" );
        level.joker_bike overridematerial( "mtl_mil_hoverbike", "m/mtl_mil_hoverbike_emissive" );
        level.joker_bike overridematerial( "m/mtl_mil_hoverbike_glass", "m/mtl_mil_hoverbike_glass" );
        level.bones_bike overridematerial( "mtl_mil_hoverbike", "m/mtl_mil_hoverbike_emissive" );
        level.bones_bike overridematerial( "m/mtl_mil_hoverbike_glass", "m/mtl_mil_hoverbike_glass" );
    }
    else
    {
        level.burke_bike overridematerial( "mtl_mil_hoverbike", "mq/mtl_mil_hoverbike_emissive" );
        level.burke_bike overridematerial( "mq/mtl_mil_hoverbike_glass", "mq/mtl_mil_hoverbike_glass" );
        level.joker_bike overridematerial( "mtl_mil_hoverbike", "mq/mtl_mil_hoverbike_emissive" );
        level.joker_bike overridematerial( "mq/mtl_mil_hoverbike_glass", "mq/mtl_mil_hoverbike_glass" );
        level.bones_bike overridematerial( "mtl_mil_hoverbike", "mq/mtl_mil_hoverbike_emissive" );
        level.bones_bike overridematerial( "mq/mtl_mil_hoverbike_glass", "mq/mtl_mil_hoverbike_glass" );
    }

    level.player_bike_obj delete();

    if ( level.nextgen )
        level.player_bike showallparts();

    level.player takeallweapons();
    level.player giveweapon( "iw5_bal27_sp_silencer01_variablereddot" );
    level.player switchtoweapon( "iw5_bal27_sp_silencer01_variablereddot" );
    level.player allowfire( 1 );
    level.player allowmelee( 1 );
    level.player allowsprint( 1 );
    level.player maps\_player_exo::setboostdash();
    setsaveddvar( "r_hudOutlineEnable", 1 );
    thread handle_name_identifiers_intro_drive();
    thread handle_guage_textures_intro_drive();
    thread maps\detroit_lighting::bike_mount_dof();

    if ( level.nextgen )
    {
        setsaveddvar( "r_mbEnable", "2" );
        setsaveddvar( "r_mbVelocityScalar", "1" );
    }

    level.player lerpfov( level.detroit_drive_in_fov, 2 );
    thread maps\detroit_lighting::gate_lights_on();
    level.player setmovespeedscale( 1 );
    level.player allowjump( 1 );
    var_18 = maps\_utility::spawn_anim_model( "world_body", level.player.origin );

    if ( isdefined( level.playerisonleft ) && level.playerisonleft )
        var_19 = "hoverbike_mount_left";
    else
        var_19 = "hoverbike_mount";

    var_1 maps\_anim::anim_first_frame_solo( var_18, var_19 );
    var_18 hide();
    var_20 = 0.5;
    level.player playerlinktoblend( var_18, "tag_player", var_20, var_20 * 0.3, var_20 * 0.3 );
    wait(var_20);
    level.player playerlinktodelta( var_18, "tag_player", 1, 70, 70, 30, 30, 1 );
    level.player springcamenabled( 0, level.detroit_spring_cam_lerp_speed, level.detroit_spring_cam_release_speed );
    var_18 show();
    var_1 notify( "hoverbike_pre_mount_ender" );

    if ( level.playerisonleft )
    {
        var_21 = [ level.burke_bike, level.joker_bike, level.bones_bike, level.burke, level.joker, level.bones ];
        soundscripts\_snd::snd_message( "jetbike_intro", "left_anim" );
        level.player_bike thread hoverbike_rumble();
        var_1 thread maps\_anim::anim_single_solo( var_18, "hoverbike_mount_left" );
        var_1 thread maps\_anim::anim_single_solo( level.player_bike, "hoverbike_mount_left" );
        var_1 maps\_anim::anim_single( var_21, "hoverbike_mount", undefined, 0.05 );
    }
    else
    {
        var_21 = [ level.player_bike, level.burke_bike, level.joker_bike, level.bones_bike, var_18, level.burke, level.joker, level.bones ];
        soundscripts\_snd::snd_message( "jetbike_intro", "right_anim" );
        level.player_bike thread hoverbike_rumble();
        var_1 maps\_anim::anim_single( var_21, "hoverbike_mount", undefined, 0.05 );
    }

    level.hoverbike_meet_up_mech1 = level.mech1;
    var_22 = [ level.player_bike, level.burke_bike, level.joker_bike, level.bones_bike, var_18, level.burke, level.joker, level.bones, level.mech1, level.mech2, var_14 ];
    thread maps\detroit_lighting::mech_intro_gate_lighting( level.mech2 );
    level.ride_in_mech = level.mech1;

    foreach ( var_10 in var_12 )
        var_10 maps\_utility::delaythread( getanimlength( var_18 maps\_utility::getanim( "hoverbike_meet_up" ) ) - 0.35, maps\_vehicle::gopath );

    level.player_bike vehicle_jetbikesethoverforcescale( 0.8 );
    level.burke_bike vehicle_jetbikesethoverforcescale( 1.1 );
    level.bones_bike vehicle_jetbikesethoverforcescale( 0.8 );
    level.joker_bike vehicle_jetbikesethoverforcescale( 0.5 );
    common_scripts\utility::flag_set( "vo_drive_in_mech_scene" );
    var_1 maps\_anim::anim_single( var_22, "hoverbike_meet_up", undefined, 0.05 );
    level.player_bike setanim( level.player_bike maps\_utility::getanim( "jetbike_casual_drive_idle" ) );
    level.player_bike.world_body = var_18;
    var_18 linkto( level.player_bike, "tag_driver", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.player_bike thread maps\_anim::anim_single_solo( var_18, "jetbike_casual_drive_idle", "tag_driver" );
    level.player_bike stopanimscripted();
    level.player_bike vehicle_jetbikesethoverforcescale( 1, 2 );
    level.player_bike setanim( level.player_bike maps\_utility::getanim( "jetbike_casual_drive_idle" ) );
    level.burke_bike thread intro_drive_scripted_bike_burke();
    level.bones_bike thread intro_drive_scripted_bike_bones();
    level.joker_bike thread intro_drive_scripted_bike_joker();
    level.mech1 delete();
    level.mech2 delete();
    maps\_utility::delaythread( 2, ::camera_rotator_begin );
    thread maps\detroit_school::play_garage_bike_dismount( level.burke_bike, level.bones_bike, level.joker_bike, level.player_bike );
}

school_begin_onbike()
{
    maps\_utility::vision_set_fog_changes( "detroit_garage", 0 );
    level.player lightsetforplayer( "garage" );
    level.player setclutforplayer( "clut_detroit_exterior", 0 );
    level.player maps\_stealth_utility::stealth_default();
    maps\detroit::debug_start_common();
    maps\detroit_school::school_animated_fences();

    if ( level.nextgen )
    {
        setsaveddvar( "r_mbEnable", "2" );
        setsaveddvar( "r_mbVelocityScalar", "1" );
    }

    var_0 = getent( "player_jetbike", "targetname" );
    level.player_onbike = var_0 maps\_utility::spawn_vehicle();
    level.player_onbike.animname = "player_bike";
    var_1 = getent( "bones_jetbike", "targetname" );
    level.bones_onbike = var_1 maps\_utility::spawn_vehicle();
    level.bones_onbike.animname = "bones_bike";
    var_2 = getent( "joker_jetbike", "targetname" );
    level.joker_onbike = var_2 maps\_utility::spawn_vehicle();
    level.joker_onbike.animname = "joker_bike";
    var_3 = getent( "burke_jetbike", "targetname" );
    level.burke_onbike = var_3 maps\_utility::spawn_vehicle();
    level.burke_onbike.animname = "burke_bike";
    var_4 = getent( "actual_dismount_animation_origin", "targetname" );
    var_5 = [ level.burke_onbike, level.player_onbike, level.bones_onbike, level.joker_onbike ];
    var_4 maps\_anim::anim_first_frame( var_5, "bike_dismount" );
    level.player_hover_height = 0.8;
    level.player_onbike stopanimscripted();
    level.player_onbike setmodel( "vehicle_mil_hoverbike_vm" );
    level.player_onbike vehicle_jetbikesethoverforcescale( level.player_hover_height );
    level.player_onbike attach( level.scr_model["world_body"], "tag_driver" );
    level.player lerpfov( level.detroit_drive_in_fov, 2 );
    level.smooth_veh_play = 0;
    thread maps\detroit_school::play_garage_bike_dismount( level.burke_onbike, level.bones_onbike, level.joker_onbike, level.player_onbike );
    thread player_bike_shutoff( level.player_onbike );
    thread player_bike_lower();
    level.player_onbike detach( level.scr_model["world_body"], "tag_driver" );
    common_scripts\utility::flag_set( "begin_bike_dismount_burke" );
    common_scripts\utility::flag_set( "begin_bike_dismount_bones" );
    common_scripts\utility::flag_set( "begin_bike_dismount_joker" );
    common_scripts\utility::flag_set( "begin_playing_player_dismount_anim" );
    common_scripts\utility::flag_wait( "shutoff_player_bike" );
    level notify( "stop hovering player bike" );
    level.player_onbike vehicle_jetbikesethoverforcescale( 0 );
    level.player_onbike notify( "stop_jetbike_handle_viewmodel_anims" );
}

hint_hoverbike()
{
    maps\_utility::hint( &"DETROIT_JETBIKE_CONTROLS", 4, -80 );
}

debug_tag_camera()
{
    for (;;)
        waitframe();
}

transient_hide_intro_vista_buildings()
{
    var_0 = getentarray( "intro_vista_buildings", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1] hide();
}

transient_intro_to_middle_begin()
{
    common_scripts\utility::flag_set( "flag_cg_kill_camp_chopper_loop" );
    var_0 = getentarray( "cargo_chopper_01", "targetname" );
    var_1 = getentarray( "refugee_camp_looping_choppers", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_1 );

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
        var_0[var_2] delete();

    thread transient_add_gatetrans_entry();
    level notify( "tff_pre_intro_to_middle" );
    level waittill( "player_has_used_bike" );

    for ( var_2 = 0; var_2 < 35; var_2++ )
        wait 1.0;

    unloadtransient( "detroit_intro_tr" );
    loadtransient( "detroit_middle_tr" );

    for (;;)
    {
        if ( istransientloaded( "detroit_middle_tr" ) )
        {
            level notify( "tff_post_intro_to_middle" );
            break;
        }

        wait 0.05;
    }
}

transient_add_gatetrans_entry()
{
    if ( !istransientloaded( "detroit_gatetrans_tr" ) )
    {
        loadtransient( "detroit_gatetrans_tr" );

        for (;;)
        {
            if ( istransientloaded( "detroit_gatetrans_tr" ) )
            {
                level notify( "tff_post_gatetrans_entry" );
                break;
            }

            wait 0.05;
        }
    }
}

camera_rotator_begin()
{
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0 thread camera_rotator_think( level.player_bike.world_body, level.joker_bike );
    waitframe();
    level.player playerlinktodelta( var_0, "tag_origin", 1, 50, 50, 30, 30, 1 );
    level.player springcamenabled( 0, level.detroit_spring_cam_lerp_speed, level.detroit_spring_cam_release_speed );
}

smooth_limit( var_0, var_1 )
{
    return atan( var_0 / var_1 ) * 0.0174533 * var_1;
}

camera_rotator_think( var_0, var_1 )
{
    var_2 = 0.8;
    var_3 = 45;
    var_4 = 0;
    var_5 = 1;
    var_6 = 0;

    while ( isdefined( var_1 ) && isdefined( var_0 ) && isdefined( self ) )
    {
        var_7 = transformmove( ( 0, 0, 0 ), ( 0, 0, 0 ), var_0.origin, var_0.angles, var_1.origin, var_1.angles )["origin"];
        var_8 = angleclamp180( vectortoangles( var_7 )[1] );
        var_6 = maps\_utility::linear_interpolate( var_2, smooth_limit( var_8, var_3 ), var_6 );

        if ( common_scripts\utility::flag( "begin_bike_dismount_player" ) )
        {
            var_5 = 0;
            var_4 = 0;
        }

        if ( var_5 )
            var_9 = maps\_shg_utility::linear_map_clamp( var_4, 0, 5, 0, 1 );
        else
            var_9 = maps\_shg_utility::linear_map_clamp( var_4, 0, 1, 1, 0 );

        self linkto( var_0, "tag_player", ( 0, 0, 0 ), ( 0, var_6 * var_9, 0 ) );
        var_4 += 0.05;
        wait 0.05;
    }

    self delete();
}

draw_trail( var_0, var_1 )
{
    var_2 = 10;
    self endon( "death" );
    var_3 = self gettagorigin( var_0 );

    for (;;)
    {
        waittillframeend;
        waittillframeend;
        thread common_scripts\utility::draw_line_for_time( var_3, self gettagorigin( var_0 ), var_1[0], var_1[1], var_1[2], var_2 );
        var_3 = self gettagorigin( var_0 );
        waitframe();
    }
}

play_bike_gesture( var_0, var_1 )
{
    var_2 = maps\_vehicle::vehicle_ai_event( var_0 );

    if ( isdefined( var_1 ) )
        wait(var_1);
    else
        var_2[0] waittill( "anim_on_tag_done" );
}

intro_drive_scripted_bike_burke()
{
    intro_drive_start_scripted_bike( level.burke, level.burke_bike );
    level.burke_bike maps\detroit_jetbike::vehicle_rubberband( level.player_bike, 780, 0, 4, 6 );
    thread intro_drive_scripted_bike_burke_gestures();
    wait 23;
    level.burke_bike maps\detroit_jetbike::vehicle_rubberband_set_desired_range( 39 );
}

intro_drive_scripted_bike_burke_gestures()
{
    play_bike_gesture( "hoverbike_driving_gesture_lft_2" );
    wait 2;
    play_bike_gesture( "hoverbike_driving_lean_right_into_2" );
    play_bike_gesture( "hoverbike_driving_lean_right_out_2" );
    play_bike_gesture( "hoverbike_driving_gesture_lft_2" );
    wait 3.5;
    play_bike_gesture( "hoverbike_driving_lean_right_into_2" );
    play_bike_gesture( "hoverbike_driving_lean_right_out_2" );
    wait 3;
    level.burke maps\detroit_lighting::add_enemy_flashlight( "flashlight", "bright" );
    level.burke maps\_utility::delaythread( 8, ::notify_method, "flashlight_off" );
    play_bike_gesture( "hoverbike_driving_flashlight_left_1" );
    level.burke maps\_utility::gun_recall();
}

notify_method( var_0 )
{
    self notify( var_0 );
}

intro_drive_scripted_bike_bones()
{
    intro_drive_start_scripted_bike( level.bones, level.bones_bike );
    level.bones_bike maps\detroit_jetbike::vehicle_rubberband( level.player_bike, 390, 0, 4, 6 );
    thread intro_drive_scripted_bike_bones_gestures();
    wait 23;
    level.bones_bike maps\detroit_jetbike::vehicle_rubberband_set_desired_range( -273 );
}

intro_drive_scripted_bike_bones_gestures()
{
    wait 1;
    play_bike_gesture( "hoverbike_driving_look_over_lft_shoulder_1" );
    play_bike_gesture( "hoverbike_driving_look_over_rt_shoulder_1" );
    play_bike_gesture( "hoverbike_driving_lean_right_into_1" );
    play_bike_gesture( "hoverbike_driving_lean_right_out_1" );
    play_bike_gesture( "hoverbike_driving_gesture_rt_1" );
    play_bike_gesture( "hoverbike_driving_lean_right_into_1" );
    play_bike_gesture( "hoverbike_driving_lean_right_out_1" );
    play_bike_gesture( "hoverbike_driving_lean_left_into_1" );
    play_bike_gesture( "hoverbike_driving_lean_left_out_1" );
    level.bones maps\_utility::gun_recall();
}

intro_drive_scripted_bike_joker()
{
    intro_drive_start_scripted_bike( level.joker, level.joker_bike );
    level.joker_bike maps\detroit_jetbike::vehicle_rubberband( level.player_bike, 585, 0, 4, 6 );
    thread intro_drive_scripted_bike_joker_gestures();
    wait 23;
    level.joker_bike maps\detroit_jetbike::vehicle_rubberband_set_desired_range( 19.5 );
}

intro_drive_scripted_bike_joker_gestures()
{
    wait 5;
    level.joker maps\detroit_lighting::add_enemy_flashlight( "flashlight", "bright" );
    level.joker maps\_utility::delaythread( 8, ::notify_method, "flashlight_off" );
    play_bike_gesture( "hoverbike_driving_flashlight_right_1" );
    wait 4;
    play_bike_gesture( "hoverbike_driving_lean_right_into_1" );
    play_bike_gesture( "hoverbike_driving_lean_right_out_1" );
    wait 4;
    play_bike_gesture( "hoverbike_driving_lean_right_into_1" );
    play_bike_gesture( "hoverbike_driving_lean_right_out_1" );
    play_bike_gesture( "hoverbike_driving_lean_right_into_1" );
    play_bike_gesture( "hoverbike_driving_lean_right_out_1" );
    play_bike_gesture( "hoverbike_driving_lean_left_into_1" );
    play_bike_gesture( "hoverbike_driving_lean_left_idle_1" );
    play_bike_gesture( "hoverbike_driving_lean_left_out_1" );
    wait 10;
    level.joker maps\_utility::gun_recall();
}

bike_reach_function( var_0, var_1 )
{
    var_1 endon( "hoverbike_pre_mount_ender" );
    var_1 maps\_anim::anim_reach_solo( var_0, "hoverbike_pre_mount" );

    if ( var_0 == level.joker || var_0 == level.bones )
        var_0 waittill( "bike_mounted" );

    var_1 maps\_anim::anim_loop_solo( var_0, "hoverbike_pre_mount", "hoverbike_pre_mount_ender" );
}

intro_drive_start_scripted_bike( var_0, var_1 )
{
    var_1 stopanimscripted();
    var_1 vehicle_jetbikesethoverforcescale( 1, 3 );
    var_0 stopanimscripted();
    var_1 maps\_utility::guy_enter_vehicle( var_0 );
    var_1.dont_clear_vehicle_anim = 1;
    var_0 dontinterpolate();
}

open_big_door()
{
    var_0 = getent( "right_main_door", "targetname" );
    var_1 = getent( "right_inner_door", "targetname" );
    var_2 = getent( "left_main_door", "targetname" );
    var_3 = getent( "left_inner_door", "targetname" );
    var_4 = getent( "right_door_inner_org1", "targetname" );
    var_5 = getent( "left_door_inner_org1", "targetname" );
    var_6 = getent( "right_door_inner_org2", "targetname" );
    var_7 = getent( "left_door_inner_org2", "targetname" );
    var_8 = getent( "right_door_main_org1", "targetname" );
    var_9 = getent( "left_door_main_org1", "targetname" );
    var_1 moveto( var_4.origin, 2, 0.75, 1.25 );
    var_3 moveto( var_5.origin, 2, 0.75, 1.25 );
    wait 2.05;
    var_1 moveto( var_6.origin, 2, 0.75, 1.25 );
    var_3 moveto( var_7.origin, 2, 0.75, 1.25 );
    var_0 moveto( var_8.origin, 2, 0.75, 1.25 );
    var_2 moveto( var_9.origin, 2, 0.75, 1.25 );
}

setup_door_anim_leader( var_0, var_1, var_2, var_3 )
{
    var_4 = [ var_0, var_1, var_2, var_3 ];
    var_5 = getent( var_4[0], "targetname" );
    var_5 thread maps\_anim::anim_generic_loop( self, var_5.animation );
    self.ignoreall = 1;
    maps\detroit::set_patrol_anim_set( "gundown" );
    maps\_shg_design_tools::waittill_trigger_with_name( "open_radiation_doors_trigger" );
    maps\_shg_design_tools::anim_stop( var_5 );
    var_6 = getent( var_4[1], "targetname" );
    var_6 maps\_anim::anim_generic_reach( self, var_6.animation );
    maps\_utility::set_moveplaybackrate( 0.6 );
    var_6 maps\_anim::anim_generic( self, var_6.animation );
    maps\_utility::set_moveplaybackrate( 1 );
    common_scripts\utility::flag_set( "massive_door_guard_in_position" );
    var_6 = getent( var_4[2], "targetname" );
    var_6 maps\_anim::anim_generic_reach( self, var_6.animation );
    var_6 thread maps\_anim::anim_generic_loop( self, var_6.animation );
    level notify( "finished_door_scan" );
    maps\_shg_design_tools::anim_stop( var_6 );
    var_6 = getent( var_4[3], "targetname" );
    var_6 maps\_anim::anim_generic_reach( self, var_6.animation );
    var_6 maps\_anim::anim_generic( self, var_6.animation );
    thread maps\_anim::anim_generic_loop( self, "patrol_bored_idle_cellphone" );
    wait 30;
    common_scripts\utility::flag_set( "massive_door_cleanup" );
}

setup_door_anim( var_0, var_1, var_2, var_3 )
{
    var_4 = [ var_0, var_1, var_2, var_3 ];
    var_5 = getent( var_4[0], "targetname" );
    var_5 thread maps\_anim::anim_generic_loop( self, var_5.animation );
    self.ignoreall = 1;
    maps\detroit::set_patrol_anim_set( "gundown" );
    maps\_shg_design_tools::waittill_trigger_with_name( "open_radiation_doors_trigger" );
    wait(randomfloat( 3.0 ));
    maps\_shg_design_tools::anim_stop( var_5 );
    var_6 = getent( var_4[1], "targetname" );
    var_6 maps\_anim::anim_generic_reach( self, var_6.animation );
    var_6 thread maps\_anim::anim_generic_loop( self, var_6.animation );
    level waittill( "finished_door_scan" );
    wait(randomfloat( 1.0 ));
    maps\_shg_design_tools::anim_stop( var_6 );
    var_6 = getent( var_4[2], "targetname" );
    var_6 maps\_anim::anim_generic_reach( self, var_6.animation );
    var_6 thread maps\_anim::anim_generic_loop( self, var_6.animation );
}

ambient_dialogue_manager()
{
    thread atlas_guard_dialogue_line1();

    if ( level.nextgen )
        thread civ_conversation_gag1();
    else
        thread maps\detroit_transients_cg::cg_civ_conversation_gag1();

    thread security_check_1_dialogue();
}

security_check_1_dialogue()
{
    common_scripts\utility::flag_wait( "flag_camp_visibility_03" );
    var_0 = getent( "org_security_gate_guards_dialogue", "targetname" );
    var_1 = getent( "dialogue_guard_at_first_gate", "targetname" );
    var_2 = var_1 maps\_utility::spawn_ai( 1 );
    var_2.animname = "generic";
    var_0 thread maps\_shg_design_tools::anim_simple( var_2, var_0.animation );
    level.camp_security_greeter = var_2;
}

player_dist_to_speaker( var_0 )
{
    for (;;)
        wait 0.1;
}

civ_conversation_gag1()
{
    var_0 = getent( "civilian_1_spawner", "targetname" );
    var_1 = getent( "civilian_2_spawner", "targetname" );
    var_2 = getent( "civilian_3_spawner", "targetname" );
    var_3 = getent( "civilian_4_spawner", "targetname" );
    level.civ1 = var_0 spawndrone();
    level.civ1.animname = "drone_civs";
    level.civ1 maps\_anim::setanimtree();
    level.civ2 = var_1 spawndrone();
    level.civ2.animname = "drone_civs";
    level.civ2 maps\_anim::setanimtree();
    level.civ3 = var_2 spawndrone();
    level.civ3.animname = "drone_civs";
    level.civ3 maps\_anim::setanimtree();
    level.civ4 = var_3 spawndrone();
    level.civ4.animname = "drone_civs";
    level.civ4 maps\_anim::setanimtree();
    level.civ1 thread maps\_anim::anim_loop_solo( level.civ1, "sign1_spawner" );
    level.civ2 thread maps\_anim::anim_loop_solo( level.civ2, "sign2_spawner" );
    level.civ3 thread maps\_anim::anim_loop_solo( level.civ3, "sign3_spawner" );
    level.civ4 thread maps\_anim::anim_loop_solo( level.civ4, "sign4_spawner" );
    maps\detroit_school::continue_when_player_near_entity( level.civ1, 250 );
    common_scripts\utility::flag_set( "vo_civ_convo_01" );
    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    level.civ1 delete();
    level.civ2 delete();
    level.civ3 delete();
    level.civ4 delete();
}

atlas_guard_dialogue_line1()
{
    common_scripts\utility::flag_wait( "flag_camp_visibility_01" );
    var_0 = getent( "atlas_guard_dialogue_line_spawner", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.animname = "generic";
    var_2 = getent( "refugee_vignette_soldier_loop_dialogue", "targetname" );
    var_1 thread guy_cig_manager();
    var_2 thread maps\_anim::anim_loop_solo( var_1, "patrol_bored_idle_smoke" );
    maps\detroit_school::continue_when_player_near_entity( var_1, 300 );
    var_1 maps\_utility::dialogue_queue( "detroit_atd_rememberonepacketpersector" );
    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    var_1 delete();
}

guy_cig_manager()
{
    while ( isalive( self ) )
    {
        level waittill( "show special cig" );
        self attach( "prop_cigarette", "tag_inhand", 1 );
        level waittill( "hide special cig" );
        self detach( "prop_cigarette", "tag_inhand" );
    }
}

buttress_function()
{
    var_0 = getent( "butress1_origin", "targetname" );
    var_1 = getent( "butress2_origin", "targetname" );
    var_2 = getent( "butress3_origin", "targetname" );
    var_3 = getent( "butress1", "targetname" );
    var_4 = getent( "butress2", "targetname" );
    var_5 = getent( "butress3", "targetname" );
    var_6 = getent( "butress1_trigger", "targetname" );
    var_7 = getent( "butress3_trigger", "targetname" );
    thread butress_animate( var_3, var_0, var_6 );
    thread butress_animate( var_4, var_1, var_6 );
    thread butress_animate( var_5, var_2, var_7 );
}

butress_animate( var_0, var_1, var_2 )
{
    var_0.animname = "butress";
    var_0 maps\_anim::setanimtree();
    var_1 maps\_anim::anim_first_frame_solo( var_0, "close" );
    maps\_utility::trigger_wait_targetname( var_2.targetname );
    var_1 soundscripts\_snd::snd_message( "refugee_butress_down" );
    var_1 thread maps\_anim::anim_single_solo( var_0, "close" );
    maps\_anim::anim_set_rate_single( var_0, "close", 0.5 );
}

disable_same_side_blocking()
{
    var_0 = getent( "player_same_side_blocking", "targetname" );
    level waittill( "scanner_doors_open" );
    wait 3.0;
    var_0 notsolid();
}
