// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

pre_load()
{

}

post_load()
{
    common_scripts\utility::flag_init( "flag_allow_punishment" );
    common_scripts\utility::flag_init( "flag_s2walk_start" );
    common_scripts\utility::flag_init( "flag_stop_mover" );
    level._s2walk = spawnstruct();
    level._s2walk.ally_mover = [];
}

start()
{
    level.player disableweapons();
    level.player disableoffhandweapons();
    level.player disableweaponswitch();
    setsaveddvar( "g_friendlyNameDist", 0 );
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );

    if ( issubstr( level.start_point, "s2walk" ) )
    {
        level.player maps\captured_util::warp_to_start( "struct_playerstart_s2walk" );
        spawn_player_prisoner_hands();
        soundscripts\_snd::snd_message( "start_s2_walk" );
        var_0 = getent( "origin_scene_s1elevator", "targetname" );

        if ( isdefined( var_0 ) )
        {
            var_0 moveto( var_0.origin - ( 0, 0, 594 ), 0.1 );
            wait 0.2;
        }

        thread scene_intro_walk();
    }
    else
    {
        level.player maps\captured_util::warp_to_start( "struct_playerstart_s2elevator" );
        soundscripts\_snd::snd_message( "start_s2_elevator" );
    }
}

main_s2walk()
{
    wait 5.5;
    var_0 = getent( "brush_elevator_s1s2_bottomgate", "targetname" );
    var_0 moveto( var_0.origin + ( 0, 0, 192 ), 2 );
    thread s2walk_ambient_character_cleanup();
    level.cover_warnings_disabled = undefined;
    level notify( "s1_elevator_gate_open" );
    soundscripts\_snd::snd_message( "s2_elevator_door_open" );
    soundscripts\_snd::snd_message( "aud_s2walk_loudspeaker2_line1" );
    var_1 = maps\_utility::array_spawn_noteworthy( "actor_s2w_guards" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_1[var_2] maps\captured_util::ignore_everything();
        var_1[var_2] maps\_utility::gun_remove();
        var_1[var_2].animname = "guard_" + var_2;
    }

    var_3 = common_scripts\utility::getstruct( "struct_s2walk", "targetname" );
    var_3 thread maps\_anim::anim_loop( var_1, "s2walk_loop", "s2walk_loop_ender" );
    level waittill( "s2walk_intro_end" );
    soundscripts\_snd::snd_message( "aud_s2walk_emitters" );
    level.player thread maps\_utility::blend_movespeedscale( 1, 3 );
    level.player thread player_walk();
    thread scene_walk( var_1, var_3 );
    thread helicopter_flyby();
    thread maps\captured_util::captured_caravan_spawner( "vehicle_s2_truck", 13, 4, 10, "s2walk" );
    soundscripts\_snd::snd_message( "s2_prison_amb" );
    soundscripts\_snd::snd_message( "aud_s2walk_trigger_start" );
    soundscripts\_snd::snd_message( "s2_walk_vo_execution" );
    common_scripts\utility::flag_set( "flag_allow_punishment" );
    common_scripts\utility::flag_wait( "flag_s2walk_near_end" );
    soundscripts\_snd::snd_message( "aud_s2walk_loudspeaker2_line2" );
    common_scripts\utility::flag_wait( "flag_s2walk_end" );
}

s2walk_ambient_character_cleanup()
{
    var_0 = getent( "s2_cell_prisoner_trigger_on", "targetname" );
    var_0 waittill( "trigger" );
    level notify( "s2_killpoppingcharacters" );
    var_0 = getent( "s2_looping_cleanup_1", "targetname" );
    var_0 waittill( "trigger" );
    level notify( "s2_looping_group_1" );
    common_scripts\utility::flag_wait( "flag_s2elevator_end" );
    level notify( "s2_looping_group_2" );
}

main_s2elevator()
{
    thread elevator_ride_s2s3();
    common_scripts\utility::flag_wait( "flag_s2elevator_end" );
}

scene_intro_walk( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::getstruct( "struct_scene_s2walkstart", "targetname" );
    var_4 = common_scripts\utility::getstruct( "struct_s2walk", "targetname" );
    var_5 = getent( "origin_scene_s1elevator", "targetname" );
    var_6 = level.allies;
    common_scripts\utility::array_thread( var_6, maps\captured_util::ignore_everything );
    common_scripts\utility::array_thread( var_6, maps\_utility::gun_remove );

    if ( !isdefined( var_0 ) )
        var_0 = maps\_utility::array_spawn_noteworthy( "actor_s2wintro_guards" );

    for ( var_7 = 0; var_7 < var_0.size; var_7++ )
    {
        var_0[var_7] maps\captured_util::ignore_everything();
        var_8 = var_7 + 1;
        var_0[var_7].animname = "guard_" + var_8;

        if ( var_8 == 3 )
            var_0[var_7] maps\_utility::gun_remove();
    }

    var_9 = [ var_0[2] ];
    var_10 = [ var_0[0], var_0[1] ];
    var_11 = [ var_0[3], var_0[4] ];
    thread maps\captured::dialogue_s2_elevator_open( var_0 );
    var_3 thread maps\captured_anim::anim_single_to_loop( var_10, "s2walk_intro_start_front", "s2walk_wait_intro_loop_front", "s2walk_front_guard_wait_loop" );
    var_3 thread maps\captured_anim::anim_single_to_loop( var_11, "s2walk_intro_start_back", "s2walk_wait_intro_loop_back", "s2walk_all_wait_loop_ender" );
    var_3 maps\captured_anim::anim_single_to_loop( var_9, "s2walk_intro_start_third", "s2walk_wait_intro_loop_thrid", "s2walk_front_guard_wait_loop" );
    level waittill( "s1_elevator_gate_open" );
    wait 3.0;
    level.player disableslowaim();
    level.player allowcrouch( 0 );
    level.player allowjump( 0 );
    level.player allowprone( 0 );
    level.player allowsprint( 0 );
    player_hands_idle_start();
    level.player thread maps\_utility::blend_movespeedscale( 0.015 );
    level.player thread maps\_utility::blend_movespeedscale( 0.3, 20 );
    level.player unlink();

    if ( isdefined( var_1 ) )
        var_1 delete();

    if ( isdefined( var_2 ) )
        var_2 delete();

    var_12 = getent( "s2walk_elevator_exit_collision", "targetname" );
    var_12 delete();
    common_scripts\utility::flag_wait( "flag_s2walk_start" );
    level thread s2walk_player_push( var_3, var_9, var_0 );
    var_3 thread maps\_anim::anim_single( var_10, "s2walk_intro_grab" );
    level waittill( "s2walk_start_walking" );
    level notify( "s2walk_intro_end" );
    var_3 notify( "s2walk_all_wait_loop_ender" );
    var_5 notify( "s2walk_all_wait_loop_ender" );
}

s2walk_player_push( var_0, var_1, var_2 )
{
    var_0 notify( "s2walk_front_guard_wait_loop" );

    if ( isdefined( level.player.rig ) )
        player_hands_idle_stop( 1 );

    var_3 = maps\_utility::spawn_anim_model( "player_rig_noexo" );
    var_4 = var_3 thread maps\captured_util::captured_player_cuffs();
    var_4 hide();
    var_3 hide();
    var_5 = common_scripts\utility::array_add( var_1, var_3 );
    var_0 thread maps\_anim::anim_single( var_5, "s2walk_intro_grab" );
    level.player common_scripts\utility::delaycall( 3.85, ::playrumbleonentity, "heavy_1s" );
    level.player playerlinktoblend( var_3, "tag_player", 0.5 );
    wait 0.5;
    var_4 show();
    var_3 show();
    level.player playerlinktodelta( var_3, "tag_player", 1, 0, 0, 0, 0, 1 );
    wait(getanimlength( var_3 maps\_utility::getanim( "s2walk_intro_grab" ) ) - 0.5);
    var_3 delete();
    var_4 delete();
    player_hands_idle_start();
    level waittill( "s2_looping_group_1" );
    maps\_utility::array_delete( var_2 );
}

scene_walk( var_0, var_1 )
{
    var_2 = level.allies;
    var_3 = undefined;
    var_4 = undefined;
    level.player thread maps\_utility::blend_movespeedscale( 1, 1 );
    var_5 = getent( "s2elevator_trolley_intro_guard", "script_noteworthy" );

    if ( isdefined( var_5 ) )
    {
        var_3 = var_5 maps\_utility::spawn_ai( 1 );
        var_3 maps\captured_util::ignore_everything();
        var_3.animname = "guard_3";
        var_4 = common_scripts\utility::getstruct( "struct_scene_s2elevator", "targetname" );
        var_4 thread maps\_anim::anim_loop_solo( var_3, "s2walk_intro_trolley_loop", "s2walk_intro_trolley_loop_ender" );
        thread trolley_doors_function();
    }

    var_6 = getent( "s2elevator_trolley_intro_guard_end", "script_noteworthy" );
    var_7 = var_6 maps\_utility::spawn_ai( 1 );
    var_7 maps\captured_util::ignore_everything();
    var_7 maps\_utility::gun_remove();
    var_7.animname = "guard_end";
    thread maps\captured::dialogue_s2_walk( var_0, var_7, var_3 );
    var_1 notify( "s2walk_loop_ender" );
    var_8 = common_scripts\utility::array_combine( var_2, var_0 );
    var_8 = common_scripts\utility::array_add( var_8, var_7 );
    var_8 = common_scripts\utility::array_add( var_8, level.player._walk.walk_node );
    soundscripts\_snd::snd_message( "s2_elevator_door_close" );
    soundscripts\_snd::snd_message( "aud_s2walk_guard_radios" );
    soundscripts\_snd::snd_message( "aud_s2walk_temp_guard_VO", var_0[0] );
    var_9 = common_scripts\utility::spawn_tag_origin();
    var_10 = common_scripts\utility::spawn_tag_origin();
    var_9 thread set_origin_per_time( var_2[1], var_2[2], 0.05 );
    var_10 thread set_origin_per_time( var_2[0], var_0[1], 0.05 );
    var_1 thread maps\_anim::anim_single( var_8, "s2walk" );
    thread s2walk_cage_door_open();
    var_11 = getanimlength( var_7 maps\_utility::getanim( "s2walk" ) );
    thread s2walk_guard_end_cleanup( var_11, var_7 );
    var_0 = common_scripts\utility::array_remove( var_0, var_7 );
    s2elevator_trolley_intro_scene( var_0, var_3, var_4 );
    var_9 delete();
    var_10 delete();
}

s2walk_cage_door_open()
{
    var_0 = getent( "s2walk_cage_door", "targetname" );
    wait 14.5;
    var_0 soundscripts\_snd::snd_message( "aud_s2walk_door_open" );
    var_0 rotateto( ( 0, 285, 0 ), 2.0, 1.0, 0.25 );
    wait 16.5;
    var_0 rotateto( ( 0, -285, 0 ), 2.0, 1.0, 0.25 );
    level waittill( "trolley_player_start" );
    var_0 delete();
}

nt_s2walk_anims_start( var_0 )
{
    level notify( "s2walk_start_walking" );
}

s2walk_guard_end_cleanup( var_0, var_1 )
{
    wait(var_0);
    var_1 delete();
}

player_walk()
{
    self endon( "beaten_to_death" );
    level endon( "stop_walk" );
    self endon( "death" );
    var_0 = common_scripts\utility::getstruct( "struct_player_goal", "targetname" );
    self._walk = spawnstruct();
    self._walk.walk_node = maps\_utility::spawn_anim_model( "s2_walking_node" );
    self._walk.pushpoint = self._walk.walk_node common_scripts\utility::spawn_tag_origin();
    self._walk.pushpoint linkto( self._walk.walk_node );
    self._walk.walk_speed = 60;
    self._walk.sprint_speed = 80;
    self._walk.player_move_mod = 0;
    self._walk.punishment_level["forward"] = 0;
    self._walk.punishment_level["back"] = 0;
    self._walk.punishment_level["left_right"] = 0;
    self._walk.punishment_level["look"] = 0;
    self._walk.max_punishments = 2;
    self._walk.forward_punish_dist = 64;
    self._walk.behind_punish_dist = -64;
    self._walk.right_left_punish_dist = 64;
    var_1 = 5;
    var_2 = 0;
    var_3 = self._walk;

    for (;;)
    {
        var_4 = s2walk_dynamic_speed_adjuster();
        maps\_utility::player_speed_set( var_4[0] );

        if ( common_scripts\utility::flag( "flag_allow_punishment" ) )
        {
            punishment_check();

            if ( isdefined( self.punishment ) )
            {
                punishment();
                var_2 = 0;
                self.punishment = undefined;
            }
            else
            {
                var_2++;

                if ( var_2 >= var_1 * 20 )
                {
                    punishment_recovery();
                    var_2 = 0;
                }
            }
        }

        wait 0.05;
    }

    self._walk.pushpoint delete();
    self._walk delete();
}

player_walk_end()
{
    level notify( "stop_walk" );
    player_hands_idle_stop();
    level.player unlink();
    level.player.rig delete();
    level.player maps\_utility::player_speed_default();
}

spawn_player_prisoner_hands()
{
    level.player disableweapons();
    level.player disableoffhandweapons();
    level.player disableweaponswitch();
    level.player.rig = maps\_utility::spawn_anim_model( "player_arms", level.player.origin, level.player.angles );
    level.player.rig linktoplayerviewignoreparentrot( level.player, "tag_origin", ( -6, 0, -60 ), ( 0, -90, 0 ), 1, 0, 0, 1 );
    level.player.rig attach( "s1_vm_handcuffs", "tag_weapon_left" );
    player_hands_idle_start();
}

player_hands_idle_start()
{
    if ( isdefined( level.player.rig.hidden ) )
    {
        level.player.rig show();
        level.player.rig.hidden = undefined;
    }

    level.player.rig notify( "s2walk_idle_ender" );
    level.player.rig thread maps\_anim::anim_loop_solo( level.player.rig, "s2walk_idle", "s2walk_idle_ender" );
    level.player allowcrouch( 0 );
    level.player allowjump( 0 );
    level.player allowprone( 0 );
}

player_hands_idle_stop( var_0 )
{
    if ( isdefined( var_0 ) && var_0 )
    {
        level.player.rig hide();
        level.player.rig.hidden = 1;
    }

    level.player.rig maps\_utility::anim_stopanimscripted();
}

s2walk_dynamic_speed_adjuster()
{
    var_0 = -20;
    var_1 = 40;
    var_2 = 1.2;
    var_3 = level.player._walk.pushpoint;
    var_4 = vectornormalize( level.player.origin - var_3.origin );
    var_5 = anglestoforward( var_3.angles );
    var_6 = anglestoright( var_3.angles );
    var_7 = distance( level.player.origin, var_3.origin );
    var_8 = vectordot( var_4, var_5 );
    var_9 = level.player._walk.walk_speed;
    var_10 = level.player._walk.sprint_speed;

    if ( var_8 * var_7 > var_0 )
    {
        var_11 = abs( var_0 + var_8 * var_7 );
        var_12 = abs( ( var_1 - var_11 ) * var_2 );
        var_9 = level.player._walk.walk_speed - var_12;
        var_10 = level.player._walk.sprint_speed - var_12;
    }

    var_13 = [ var_9, var_10 ];
    return var_13;
}

punishment_check()
{
    var_0 = self._walk.forward_punish_dist;
    var_1 = self._walk.behind_punish_dist;
    var_2 = self._walk.right_left_punish_dist;
    var_3 = -0.4;
    var_4 = 0.6;
    var_5 = 5;
    var_6 = self._walk.pushpoint;
    var_7 = vectornormalize( self.origin - var_6.origin );
    var_8 = anglestoforward( var_6.angles );
    var_9 = anglestoright( var_6.angles );
    var_10 = distance( self.origin, var_6.origin );
    var_11 = vectordot( var_7, var_8 );
    var_12 = vectordot( var_7, var_9 );

    if ( var_12 * var_10 > var_2 )
        self.punishment = "right";
    else if ( var_12 * var_10 * -1 > var_2 )
        self.punishment = "left";
    else if ( var_11 * var_10 > var_0 )
        self.punishment = "forward";
    else if ( var_11 * var_10 < var_1 )
        self.punishment = "back";

    if ( isdefined( self.punishment ) )
    {
        self.punish_view_level = undefined;
        return;
    }

    var_13 = anglestoforward( self getangles() );
    var_14 = vectordot( var_13, var_8 );

    if ( vectordot( var_13, var_8 ) > var_4 )
    {
        if ( isdefined( self.punish_view_level ) && self.punish_view_level > 0 )
            self.punish_view_level -= 0.05;
        else
            self.punish_view_level = undefined;

        return;
    }

    if ( !isdefined( self.punish_view_level ) )
    {
        self.punish_view_level = 0;
        self.last_punish_time = gettime();
    }

    if ( var_14 < var_3 || self.punish_view_level > var_5 )
    {
        var_15 = ( var_8[0], var_8[1], 0 );
        self.last_punish_time = gettime();

        if ( vectorcross( var_13, var_15 )[2] > 0 )
            self.punishment = "look_right";
        else
            self.punishment = "look_left";

        self.punish_view_level = undefined;
        return;
    }

    var_16 = var_5 * 0.05;
    self.punish_view_level += randomfloatrange( 0, var_16 );
}

punishment()
{
    if ( self.punishment != "forward" )
    {
        common_scripts\utility::flag_set( "flag_stop_mover" );
        var_0 = 0;
        var_1 = [ "cap_gr4_inline", "cap_gr4_getinline" ];
        var_2 = [ "cap_gr4_staycentered", "cap_gr4_stayinline" ];
        var_3 = [ "cap_gr4_eyesforward", "cap_gr4_stoplookin", "cap_gr4_eyesforward2" ];

        switch ( self.punishment )
        {
            case "forward":
                self._walk.punishment_level["forward"]++;
                var_0 = self._walk.punishment_level["forward"];
                thread maps\_utility::smart_radio_dialogue( common_scripts\utility::random( var_1 ) );
                break;
            case "back":
                self._walk.punishment_level["back"]++;
                var_0 = self._walk.punishment_level["back"];
                thread maps\_utility::smart_radio_dialogue( common_scripts\utility::random( var_1 ) );
                break;
            case "left":
                self._walk.punishment_level["left_right"]++;
                var_0 = self._walk.punishment_level["left_right"];
                thread maps\_utility::smart_radio_dialogue( common_scripts\utility::random( var_2 ) );
                thread punishment_anim( "s2walk_punish_left" );
                break;
            case "right":
                self._walk.punishment_level["left_right"]++;
                var_0 = self._walk.punishment_level["left_right"];
                thread maps\_utility::smart_radio_dialogue( common_scripts\utility::random( var_2 ) );
                thread punishment_anim( "s2walk_punish_right" );
                break;
            case "look_left":
                self._walk.punishment_level["look"]++;
                var_0 = self._walk.punishment_level["look"];
                thread maps\_utility::smart_radio_dialogue( common_scripts\utility::random( var_3 ) );
                thread punishment_anim( "s2walk_punish_left" );
                break;
            case "look_right":
                self._walk.punishment_level["look"]++;
                var_0 = self._walk.punishment_level["look"];
                thread maps\_utility::smart_radio_dialogue( common_scripts\utility::random( var_3 ) );
                thread punishment_anim( "s2walk_punish_right" );
        }

        self freezecontrols( 1 );
        var_4 = var_0 * 20;
        self dodamage( var_4, self.origin );
        screenshake( self.origin, var_0, var_0, var_0, 1, 0, 1, 256, 8, 15, 12, 5.0 );
        soundscripts\_snd::snd_message( "aud_plr_hit" );
        self playerlinktoblend( self._walk.pushpoint, "tag_origin", 0.5, 0, 0.5 );
        wait 0.5;
        self unlink();
        self freezecontrols( 0 );
        self.punishment = undefined;
        common_scripts\utility::flag_clear( "flag_stop_mover" );
    }
}

punishment_anim( var_0 )
{
    level endon( "stop_walk" );
    player_hands_idle_stop();
    level.player.rig maps\_anim::anim_single_solo( level.player.rig, var_0 );
    player_hands_idle_start();
}

punishment_recovery()
{
    foreach ( var_2, var_1 in self._walk.punishment_level )
    {
        if ( self._walk.punishment_level[var_2] > 0 )
            self._walk.punishment_level[var_2]--;
    }
}

punishment_push( var_0 )
{

}

set_origin_per_time( var_0, var_1, var_2 )
{
    self endon( "death" );

    for (;;)
    {
        self.origin = averagepoint( [ var_0.origin, var_1.origin ] );
        wait(var_2);
    }
}

goal_mover( var_0, var_1 )
{
    self notify( "stop_goalmover" );
    self endon( "stop_goalmover" );
    level.player endon( "beaten_to_death" );
    level endon( "stop_walk" );
    var_2 = 80;
    var_3 = self;
    self.at_goal = 0;
    var_0.at_goal = 0;

    for (;;)
    {
        if ( isdefined( var_3.target ) )
        {
            var_3 = common_scripts\utility::getstruct( var_3.target, "targetname" );

            if ( !isdefined( var_3 ) )
                var_3 = getent( var_3.target, "targetname" );
        }
        else
        {
            self.at_goal = 1;
            break;
        }

        var_4 = distance( self.origin, var_3.origin );
        var_5 = vectornormalize( var_3.origin - self.origin );
        var_6 = var_4 / ( level.player._walk.walk_speed + level.player._walk.player_move_mod );
        var_7 = var_4 / var_6 * 0.05;

        for ( var_8 = 0; var_8 <= var_6; var_8 += 0.05 )
        {
            common_scripts\utility::flag_waitopen( "flag_stop_mover" );

            if ( isdefined( var_0 ) && !var_0.at_goal )
            {
                var_9 = distance( self.origin, var_0.origin );

                while ( var_9 < var_2 )
                {
                    var_9 = distance( self.origin, var_0.origin );
                    wait 0.5;
                }
            }
            else
                var_0 = undefined;

            if ( isdefined( var_1 ) )
                self rotateto( vectortoangles( var_1.origin - self.origin ), 1 );

            self moveto( self.origin + var_5 * var_7, 0.05 );
            wait 0.05;
        }
    }
}

elevator_ride_s2s3()
{
    common_scripts\utility::flag_wait( "flag_player_in_s2s3_room" );
    level waittill( "elevator_black" );
    common_scripts\utility::flag_set( "flag_s2elevator_end" );
}

s2elevator_trolley_intro_scene( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::getstruct( "struct_scene_s2elevator", "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    level waittill( "trolley_guard_3_start" );
    var_2 notify( "s2walk_intro_trolley_loop_ender" );
    var_3 thread maps\_anim::anim_single_solo( var_1, "s2walk_intro_trolley" );
    level waittill( "trolley_player_start" );
    player_walk_end();
    var_4 = maps\_utility::spawn_anim_model( "player_rig_noexo" );
    var_5 = var_4 thread maps\captured_util::captured_player_cuffs();
    var_5 hide();
    var_4 hide();
    level.player common_scripts\utility::delaycall( 17.3, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 18.35, ::playrumbleonentity, "light_3s" );
    var_3 thread maps\_anim::anim_single_solo( var_4, "s2walk_intro_trolley" );
    level.player playerlinktoblend( var_4, "tag_player", 0.5 );
    wait 0.5;
    level.player playerlinktodelta( var_4, "tag_player", 0.5, 30, 30, 20, 20, 1 );
    var_5 show();
    var_4 show();
    wait(getanimlength( var_4 maps\_utility::getanim( "s2walk_intro_trolley" ) ));
    maps\_utility::array_delete( var_0 );
    var_4 delete();
    var_5 delete();
}

trolley_doors_function()
{
    var_0 = common_scripts\utility::getstruct( "struct_scene_s2elevator", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "trolley_guard_door_1" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "s2walk_intro_trolley" );
    var_2 = maps\_utility::spawn_anim_model( "trolley_guard_door_2" );
    var_0 maps\_anim::anim_first_frame_solo( var_2, "s2walk_intro_trolley" );
    var_3 = maps\_utility::spawn_anim_model( "trolley_gate" );
    var_0 maps\_anim::anim_first_frame_solo( var_3, "s2walk_intro_trolley" );
    var_4 = spawn( "script_model", ( 5372, -8116, -592 ) );
    var_4 setmodel( "tag_origin" );
    var_3 retargetscriptmodellighting( var_4 );
    var_5 = [];

    for ( var_6 = 0; var_6 < 4; var_6++ )
    {
        var_7 = var_6 + 1;
        var_8 = "trolley_zip_" + var_7;
        var_9 = maps\_utility::spawn_anim_model( var_8 );
        var_0 maps\_anim::anim_first_frame_solo( var_9, "s2walk_intro_trolley" );
        var_5 = common_scripts\utility::array_add( var_5, var_9 );
    }

    level waittill( "trolley_guard_3_door_1" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "s2walk_intro_trolley" );
    level waittill( "trolley_guard_3_door_2" );
    var_0 thread maps\_anim::anim_single_solo( var_2, "s2walk_intro_trolley" );
    level waittill( "trolley_zip_start" );
    var_0 thread maps\_anim::anim_single( var_5, "s2walk_intro_trolley" );
    level waittill( "trolley_gate" );
    var_0 thread maps\_anim::anim_single_solo( var_3, "s2walk_intro_trolley" );
    level waittill( "trolley_doctor_start" );
    soundscripts\_snd::snd_message( "aud_s2walk_clear_foley_mix" );
    var_10 = getent( "trolley_doctor", "targetname" );
    var_11 = var_10 maps\_utility::spawn_ai( 1 );
    var_11 character\gfl\character_gfl_dima::main();
    var_11.animname = "drug_doctor";
    var_12 = maps\_utility::spawn_anim_model( "trolley_syringe" );
    var_13 = [ var_11, var_12 ];
    var_0 thread maps\_anim::anim_single( var_13, "s2walk_intro_trolley" );
    thread maps\captured::dialogue_doctor_trolley( var_11 );
    wait(getanimlength( var_11 maps\_utility::getanim( "s2walk_intro_trolley" ) ) - 3.05);
    thread s2elevator_fade_transition();
    common_scripts\utility::flag_wait( "flag_s2elevator_end" );
    var_1 delete();
    var_2 delete();
    var_3 delete();
    var_11 delete();
    maps\_utility::array_delete( var_5 );
}

nt_trolley_guard_start( var_0 )
{
    level notify( "trolley_guard_3_start" );
}

nt_trolley_player_start( var_0 )
{
    level notify( "trolley_player_start" );
}

nt_trolley_zip_start( var_0 )
{
    level notify( "trolley_zip_start" );
}

nt_trolley_doctor_start( var_0 )
{
    level notify( "trolley_doctor_start" );
}

nt_trolley_door_01( var_0 )
{
    level notify( "trolley_guard_3_door_1" );
}

nt_trolley_door_02( var_0 )
{
    level notify( "trolley_guard_3_door_2" );
}

nt_trolley_gate( var_0 )
{
    level notify( "trolley_gate" );
}

s2elevator_fade_transition()
{
    var_0 = maps\_hud_util::create_client_overlay( "black", 0, level.player );
    var_0 fadeovertime( 3.0 );
    var_0.alpha = 1;
    wait 4.0;
    level notify( "elevator_black" );
    wait 3.0;

    if ( level.currentgen )
    {
        if ( !istransientloaded( "captured_interrogate_tr" ) )
            level waittill( "tff_post_s2walk_to_interrogate" );
    }

    var_0 fadeovertime( 5.0 );
    var_0.alpha = 0;
    wait 5.0;
    var_0 destroy();
}

helicopter_flyby()
{
    level waittill( "start_helicopter_fly" );
    level notify( "s1_looping_prisoner" );
    var_0 = getent( "first_walk_helo", "script_noteworthy" );
    var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
    var_1 vehicle_turnengineoff();
    var_1 waittill( "reached_dynamic_path_end" );
    var_1 delete();
    level waittill( "start_helicopter_fly" );
    level thread maps\captured_fx::fx_walk_heli_flyby();
    var_0 = getent( "second_walk_helo", "script_noteworthy" );
    var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
    var_1 vehicle_turnengineoff();
    var_1 waittill( "reached_dynamic_path_end" );
    var_1 delete();
}
