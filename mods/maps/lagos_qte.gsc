// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

takedown_qte( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    level.player.no_breath_hud = 1;

    if ( !common_scripts\utility::flag( "takedown_underwater" ) )
    {
        maps\lagos_utility::start_end_takedown_highway_path_player_side();
        level.player allowads( 1 );
        var_8 hide();
        level.player maps\_shg_utility::setup_player_for_scene();
        level.player takeallweapons();
        var_11 = 1;
        level.player playerlinktoblend( var_8, "tag_player", var_11 );
        level.player common_scripts\utility::delaycall( var_11, ::playerlinktodelta, var_8, "tag_player", 1, 7, 7, 5, 5, 1 );
        var_8 common_scripts\utility::delaycall( var_11, ::show );
        level.player enableinvulnerability();
        level.player notifyonplayercommand( "gunFired", "+attack" );
        var_12 = [ var_2, var_3, var_8 ];
        var_13 = [ var_1, var_2, var_3, var_8 ];
        var_14 = [ var_2, var_3, var_8 ];
        var_15 = [ var_2, var_3 ];
        var_16 = [ var_2, var_3, var_9 ];
        var_17 = [ var_2, var_3 ];
        var_2 maps\_utility::deletable_magic_bullet_shield();
        var_3 maps\_utility::deletable_magic_bullet_shield();
        thread truck_takedown_player_hold_check( "flag_player_hold_on", var_9 );

        foreach ( var_19 in var_13 )
            var_19 linkto( var_9, "tag_body" );

        var_9 maps\_anim::anim_single( var_12, "hostage_truck_takedown_pt1", "tag_body" );
        level thread maps\lagos_fx::fake_tread_fx_hostage_truck( var_9 );

        if ( !common_scripts\utility::flag( "flag_player_hold_on" ) )
        {
            soundscripts\_snd::snd_printlnbold( "Van Grab failure" );
            hostage_truck_failure();
            var_0 maps\_anim::anim_first_frame_solo( var_9, "hostage_truck_takedown_pt2" );
            var_9 maps\_anim::anim_first_frame( var_12, "hostage_truck_takedown_pt2", "tag_body" );
            var_0 thread maps\_anim::anim_single_solo( var_9, "hostage_truck_takedown_pt2" );
            var_9 thread maps\_anim::anim_single( var_12, "hostage_truck_takedown_pt2", "tag_body" );
            wait 0.4;
            level.player unlink();
            level.player thread truck_takedown_player_hold_fail( var_8 gettagorigin( "tag_player" ), var_8 gettagangles( "tag_player" ), ( -400, 500, -200 ), ( -320, 128, 0 ) );
            var_8 stopanimscripted();
            var_8 delete();
            hostage_truck_gameover();
            return;
        }

        soundscripts\_snd::snd_message( "final_takedown_xbutton_hit" );
        var_0 notify( "stop_loop" );
        thread maps\lagos_vo::highway_traffic_final_takedown_hold_on();
        var_8 attach( "npc_titan45_base_loot", "TAG_WEAPON_RIGHT", 0 );
        soundscripts\_snd::snd_printlnbold( "Van Grab Success" );
        thread truck_takedown_player_shot_enemy_check( "flag_player_shot_enemy", 4.55, var_2, var_3, var_9 );
        thread player_free_aim( var_8, var_9, var_0 );
        hostage_truck_anim_single_break_when_timeout_or_fail( var_0, var_13, var_9 );
        level.player notify( "part2_done" );
        soundscripts\_snd::snd_message( "hostage_truck_slomo_end_pt2" );

        if ( !common_scripts\utility::flag( "flag_player_shot_enemy" ) )
        {
            soundscripts\_snd::snd_printlnbold( "Shoot Driver Fail" );
            hostage_truck_failure();

            if ( isdefined( var_2 ) && isalive( var_2 ) )
                var_2 thread shootblankthread( 1 );

            if ( isdefined( var_3 ) && isalive( var_3 ) )
                var_3 thread shootblankthread( 0 );

            var_0 thread maps\_anim::anim_single_solo( var_9, "hostage_truck_takedown_pt3" );
            waitframe();
            waitframe();
            var_9 thread maps\_anim::anim_single_solo( var_8, "hostage_truck_takedown_fail_pt2", "tag_body" );
            wait 0.3;
            level.player forcemovingplatformentity( undefined );
            level.player unlink();
            level.burke hide();
            level.player thread truck_takedown_player_hold_fail( var_8 gettagorigin( "tag_player" ), var_8 gettagangles( "tag_player" ), ( 0, 500, -200 ), ( -96, 360, 0 ) );
            var_8 stopanimscripted();
            var_8 delete();
            hostage_truck_gameover();
            return;
        }

        soundscripts\_snd::snd_printlnbold( "Shoot Driver Success" );
        level.player common_scripts\utility::delaycall( 6, ::lerpviewangleclamp, 1, 1, 0, 0, 0, 0, 0 );
        var_9 thread maps\_anim::anim_single_solo( level.burke, "hostage_truck_takedown_pt3", "tag_body" );
        var_0 thread maps\_anim::anim_single_solo( var_10, "hostage_truck_takedown_pt3" );
        var_0 thread maps\_anim::anim_single_solo( var_9, "hostage_truck_takedown_pt3" );
        var_9 thread maps\_anim::anim_single_solo( var_8, "hostage_truck_takedown_pt3", "tag_body" );
        var_8 waittillmatch( "single anim", "kva_part3_start" );
        var_9 thread maps\_anim::anim_single( var_15, "hostage_truck_takedown_pt3", "tag_body" );
        var_8 waittillmatch( "single anim", "unlink_from_truck" );
        thread maps\_utility::autosave_now_silent();
        var_9 delete();
        var_2 delete();
        var_3 delete();
    }

    thread takedown_underwater_portion( var_0, var_8, var_1, var_9, var_4, var_5, var_6 );
}

shootblankthread( var_0 )
{
    if ( var_0 )
    {
        self shootblank();
        waitframe();
        self shootblank();
        waitframe();
        self shoot();
        waitframe();
        self shoot();
        waitframe();
        self shoot();
        waitframe();
        waitframe();
        waitframe();
        self shoot();
        waitframe();
        waitframe();
        self shoot();
        waitframe();
        waitframe();
        self shoot();
        waitframe();
        waitframe();
        self shoot();
        waitframe();
        waitframe();
        self shoot();
    }
    else
    {
        self shootblank();
        waitframe();
        self shoot();
        waitframe();
        self shoot();
        waitframe();
        waitframe();
        waitframe();
        self shoot();
        waitframe();
        waitframe();
        waitframe();
        self shoot();
        waitframe();
        waitframe();
        self shoot();
        waitframe();
        waitframe();
        self shoot();
        waitframe();
        waitframe();
        self shoot();
    }
}

viewmodel_swim_handle_notetracks()
{
    for (;;)
    {
        self waittill( "swim_notes", var_0 );

        switch ( var_0 )
        {
            case "lagos_swimming_into_stroke":
            case "lagos_swimming_drowning_start":
            case "lagos_swimming_stroke":
                soundscripts\_snd::snd_message( var_0 );
                break;
        }
    }
}

#using_animtree("script_model");

viewmodel_swim_animations_loop( var_0, var_1, var_2, var_3 )
{
    level endon( "missionfailed" );
    level endon( var_2 );
    level.player enablemousesteer( 1 );
    var_0 childthread viewmodel_swim_handle_notetracks();
    var_4 = %wm_unarmed_underwater_swim_idle_loop;
    var_5 = %wm_unarmed_underwater_swim_loop_into;
    var_6 = %wm_unarmed_underwater_swim_loop;
    var_7 = %wm_unarmed_underwater_swim_drown;
    var_8 = %wm_unarmed_underwater_swim_arms_off_screen;
    var_9 = getnotetracktimes( var_6, "anim_interupt" );
    var_10 = getanimlength( var_4 );
    var_11 = getanimlength( var_5 );
    var_12 = getanimlength( var_6 );
    var_13 = 1;
    var_14 = 2;
    var_15 = 3;
    var_16 = 4;
    var_17 = var_13;
    var_0 setflaggedanimknob( "swim_notes", var_8, 1, 0.0 );
    var_0 setflaggedanimknob( "swim_notes", var_4, 1, 0.5 );
    var_18 = 0.0;

    for (;;)
    {
        level.player hideviewmodel();
        var_19 = level.player getnormalizedmovement();
        var_20 = level.player getnormalizedcameramovements();
        var_21 = 0;

        if ( var_19[0] > 0.2 )
            var_21 = 1;

        var_22 = var_17;
        var_23 = var_1.origin - level.player.origin;

        if ( !common_scripts\utility::flag( "van_door_open_lighting" ) && length( var_23 ) < 150 )
            var_21 = 0;
        else if ( common_scripts\utility::flag( "van_door_open_lighting" ) && length( var_23 ) < 110 )
            var_21 = 0;

        if ( var_1.origin[2] > level.player.origin[2] && !common_scripts\utility::flag( "flag_van_door_open" ) )
        {
            setdvar( "ui_deadquote", &"LAGOS_SWIM_FAIL" );
            maps\_utility::missionfailedwrapper();
            level.player enablemousesteer( 0 );
            return;
        }

        var_24 = 12;
        var_25 = ( 0, 0, 0 );

        if ( !var_21 && var_3 )
            var_25 = ( 0, 0, -10 );

        var_0 moveto( var_0.origin + anglestoforward( var_0.angles ) * var_19[0] * var_24 * var_21 + var_25, 0.1, 0.05, 0.05 );
        var_26 = 5;
        var_0 rotateto( var_0.angles - ( 0, 1, 0 ) * var_20[1] * var_26 - ( 1, 0, 0 ) * var_20[0] * var_26, 0.1, 0.05, 0.05 );

        if ( common_scripts\utility::flag( "player_swimming_drown" ) )
        {
            if ( var_17 == var_15 )
            {
                var_27 = var_0 getanimtime( var_6 );

                foreach ( var_29 in var_9 )
                {
                    if ( var_27 > var_29 - 0.1 && var_27 < var_29 + 0.1 )
                        var_17 = var_16;
                }
            }
            else
                var_17 = var_16;
        }

        if ( var_17 == var_13 )
        {
            if ( var_21 )
                var_17 = var_14;
            else if ( var_18 >= var_10 )
                var_22 = 0;
        }
        else if ( var_17 == var_14 )
        {
            if ( var_18 >= var_11 )
            {
                if ( var_21 )
                    var_17 = var_15;
                else
                    var_17 = var_13;
            }
        }
        else if ( var_17 == var_15 )
        {
            if ( var_21 )
            {
                if ( var_18 >= var_12 )
                    var_22 = 0;
            }
            else
            {
                var_27 = var_0 getanimtime( var_6 );

                foreach ( var_29 in var_9 )
                {
                    if ( var_27 > var_29 - 0.1 && var_27 < var_29 + 0.1 )
                        var_17 = var_13;
                }
            }
        }

        if ( var_22 != var_17 )
        {
            if ( var_17 == var_13 )
            {
                if ( var_22 == var_15 || var_22 == var_14 )
                    var_0 setflaggedanimknobrestart( "swim_notes", var_4, 1, 1.0 );
                else
                    var_0 setflaggedanimknobrestart( "swim_notes", var_4 );
            }
            else if ( var_17 == var_14 )
            {
                soundscripts\_snd::snd_message( "lagos_swimming_into_stroke" );
                var_0 setflaggedanimknobrestart( "swim_notes", var_5 );
            }
            else if ( var_17 == var_15 )
                var_0 setflaggedanimknobrestart( "swim_notes", var_6 );
            else if ( var_17 == var_16 )
                var_0 setflaggedanimknobrestart( "swim_notes", var_7, 1, 0.75 );

            var_18 = 0.05;
        }

        wait 0.05;
        var_18 += 0.05;
    }

    level.player enablemousesteer( 0 );
}

viewmodel_swim_animations( var_0, var_1, var_2, var_3 )
{
    var_4 = spawn( "script_model", level.player.origin );
    var_4 setmodel( "s1_gfl_ump45_viewhands_player" );
    var_4 dontcastshadows();

    if ( isdefined( var_3 ) )
        var_4.angles = var_3.angles;
    else
        var_4.angles = level.player.angles;

    var_4 useanimtree( #animtree );
    level.player playerlinktodelta( var_4, "tag_player", 1, 0, 0, 0, 0 );
    viewmodel_swim_animations_loop( var_4, var_0, var_1, var_2 );

    if ( !common_scripts\utility::flag( "missionfailed" ) )
    {
        var_4 setflaggedanimknobrestart( "swim_notes", %wm_unarmed_underwater_swim_arms_off_screen );
        var_5 = getanimlength( %wm_unarmed_underwater_swim_arms_off_screen );
        wait(var_5);
    }

    var_4 unlink();
    var_4 delete();
}

swim_bounds_fail()
{
    level endon( "swimming_fade" );
    common_scripts\utility::flag_clear( "flag_swim_bounds" );

    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_swim_bounds" ) )
        {
            setdvar( "ui_deadquote", &"LAGOS_SWIM_FAIL" );
            maps\_utility::missionfailedwrapper();
            return;
        }

        waitframe();
    }
}

swim_time_fail()
{
    wait 10;

    if ( !common_scripts\utility::flag( "flag_van_door_open" ) )
    {
        setdvar( "ui_deadquote", &"LAGOS_SWIM_FAIL" );
        maps\_utility::missionfailedwrapper();
        return;
    }
}

takedown_underwater_portion( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = 30;
    var_8 = [ var_2, var_1, var_4, var_5, var_6 ];
    var_9 = maps\_utility::spawn_anim_model( "hostage_truck", var_3.origin, var_3.angles );
    var_9 thread hostage_truck_scripted_descent( var_7 );
    var_10 = common_scripts\utility::getstruct( "van_takedown_underwater_player", "targetname" );
    var_2 hide();
    var_1 hide();
    level.player forcemovingplatformentity( undefined );
    level.player unlink();
    level.player maps\_utility::teleport_player( var_10 );
    var_11 = ( 13, 0, 0 );
    level.player.origin = ( -34194, 76524, 130 );
    level.player.angles = var_11;
    waitframe();
    level notify( "swimming_start" );
    var_9 thread maps\lagos_fx::water_bubbles_truck_door();
    soundscripts\_snd::snd_message( "underwater_sequence", var_9 );
    thread swim_bounds_fail();
    thread swim_time_fail();
    thread viewmodel_swim_animations( var_9, "latch_opened", 1, undefined );
    level.player waittill_player_uses_truck_latch( var_9, var_7 );
    level notify( "swimming_end" );
    level.player disableweapons();
    var_4 hide();
    var_5 hide();
    var_6 hide();
    var_4 linkto( var_9, "tag_body" );
    var_5 linkto( var_9, "tag_body" );
    var_6 linkto( var_9, "tag_body" );
    var_12 = 0.75;
    level.player playerlinktoblend( var_1, "tag_player", var_12, 0.5 );
    level.player common_scripts\utility::delaycall( var_12, ::playerlinktodelta, var_1, "tag_player", 1, 7, 7, 5, 5, 1 );
    var_1 common_scripts\utility::delaycall( var_12, ::show );
    var_2 common_scripts\utility::delaycall( var_12, ::show );
    var_4 common_scripts\utility::delaycall( var_12, ::show );
    var_5 common_scripts\utility::delaycall( var_12, ::show );
    var_6 common_scripts\utility::delaycall( var_12, ::show );
    var_9 thread maps\_anim::anim_single_solo( var_9, "hostage_truck_takedown_pt4_into", "tag_origin" );
    var_9 thread maps\_anim::anim_single( var_8, "hostage_truck_takedown_pt4_into", "tag_body" );
    soundscripts\_snd::snd_message( "underwater_rescue" );

    foreach ( var_14 in var_8 )
        var_14 linkto( var_9, "tag_body" );

    var_7 = getanimlength( var_1 maps\_utility::getanim( "hostage_truck_takedown_pt4_into" ) );
    wait(var_7);
    level thread maps\lagos_fx::ambient_underwater_effects_rescue( var_9 );
    var_0 thread maps\_anim::anim_single_solo( var_9, "hostage_truck_takedown_pt4" );
    var_9 thread maps\_anim::anim_single( var_8, "hostage_truck_takedown_pt4", "tag_body" );
    maps\_vehicle_traffic::delete_traffic_path( "highway_path_player_side" );
    maps\_vehicle_traffic::delete_traffic_path( "highway_path_other_side" );
    var_1 waittillmatch( "single anim", "unlink_from_truck" );
    level thread maps\lagos_fx::player_gasping_breath();
    common_scripts\utility::flag_set( "obj_progress_pursue_hostage_truck_highway_rescue" );
    level.player unlink();
    var_1 hide();
    thread viewmodel_swim_animations( var_9, "swimming_end", 0, var_1 );
    level thread maps\lagos_fx::player_drown_end_vm_transition();
    maps\_utility::delaythread( 7, common_scripts\utility::flag_set, "player_swimming_drown" );
    maps\_utility::delaythread( 11, common_scripts\utility::flag_set, "player_swimming_end" );
    common_scripts\utility::flag_wait( "player_swimming_end" );
    level notify( "swimming_fade" );
    wait 4;

    foreach ( var_14 in var_8 )
    {
        if ( isdefined( var_14 ) )
            var_14 stopanimscripted();
    }

    level.player allowads( 1 );
}

hostage_truck_anim_single_break_when_timeout_or_fail( var_0, var_1, var_2 )
{
    level.player endon( "part2_done" );
    level endon( "flag_player_shot_enemy" );
    var_0 maps\_anim::anim_first_frame_solo( var_2, "hostage_truck_takedown_pt2" );
    var_2 maps\_anim::anim_first_frame( var_1, "hostage_truck_takedown_pt2", "tag_body" );
    var_0 thread maps\_anim::anim_single_solo( var_2, "hostage_truck_takedown_pt2" );
    var_2 maps\_anim::anim_single( var_1, "hostage_truck_takedown_pt2", "tag_body" );
}

hostage_truck_scripted_descent( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "hostage_truck_sinking_control", "targetname" );
    var_2 = common_scripts\utility::getstruct( var_1.target, "targetname" );
    self.origin = var_1.origin;
    self.angles = var_1.angles;
    self moveto( var_2.origin, var_0, 0, var_0 );
    self rotateto( var_2.angles, var_0 );
}

printorigin3duntilnotify( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( var_4 );

    for (;;)
        wait 0.05;
}

truck_takedown_player_hold_check( var_0, var_1 )
{
    level.player waittill( "slowmo_start" );
    soundscripts\_snd::snd_printlnbold( "Slowmo Start" );
    var_2 = var_1 maps\_shg_utility::hint_button_tag( "x", "tag_mirror_right", 900, 900 );
    common_scripts\utility::flag_set( "van_takedown_hold_lighting" );

    if ( level.player common_scripts\utility::is_player_gamepad_enabled() )
        wait_for_flag_or_player_command( "flag_hostage_truck_is_failure", "+usereload" );
    else
        wait_for_flag_or_player_command( "flag_hostage_truck_is_failure", "+activate" );

    if ( common_scripts\utility::flag( "flag_hostage_truck_is_failure" ) )
    {
        maps\lagos_utility::clear_hint_button( var_2 );
        return;
    }

    soundscripts\_snd::snd_message( "van_takedown_1stjump_button_press" );
    hostage_truck_slomo_end( 1 );
    var_2 maps\_shg_utility::hint_button_clear();
    common_scripts\utility::flag_set( var_0 );
}

truck_takedown_player_hold_fail( var_0, var_1, var_2, var_3 )
{
    level.player disableinvulnerability();
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4.origin = var_0;
    var_4.angles = var_1;
    self playerlinktoabsolute( var_4, "tag_origin" );
    var_5 = bullettrace( level.player geteye(), level.player geteye() + var_2, 0 );
    var_6 = 0.25;
    var_7 = 25;
    var_8 = 360;
    var_9 = 45;
    var_10 = var_5["position"] + ( 0, 0, 64 );
    var_4 truck_takedown_player_fall( var_6, var_7, var_8, var_9, var_10, "heavy" );
    var_6 = 0.4;
    var_7 = 105;
    var_8 = 360;
    var_9 = 255;
    var_10 += var_3;
    var_4 truck_takedown_player_fall( var_6, var_7, var_8, var_9, var_10, "light" );
    level.player kill();
    var_6 = 0.6;
    var_7 = 95;
    var_8 = 200;
    var_9 = 155;
    var_10 += var_3;
    var_4 truck_takedown_player_fall( var_6, var_7, var_8, var_9, var_10, "heavy" );
}

truck_takedown_player_fall( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self moveto( var_4, var_0, 0, 0 );
    self rotateby( ( var_1, var_2, var_3 ), var_0, 0, 0 );
    earthquake( 1, var_0 * 2, self.origin, 500 );
    level.player dodamage( 34, self.origin + ( 0, 0, -32 ) );

    if ( isdefined( var_5 ) )
    {
        if ( var_5 == "heavy" )
            level.player playrumbleonentity( "damage_heavy" );
        else if ( var_5 == "light" )
            level.player playrumbleonentity( "damage_light" );
    }

    wait(var_0);
}

truck_takedown_player_shot_enemy_check( var_0, var_1, var_2, var_3, var_4 )
{
    var_2 thread kva_fake_death_checker( var_4, "hostage_truck_takedown_death" );
    var_3 thread kva_fake_death_checker( var_4, "hostage_truck_takedown_death" );

    for (;;)
    {
        level.kva_dead_count = 0;

        if ( !isalive( var_2 ) || var_2.fake_death )
            level.kva_dead_count++;

        if ( !isalive( var_3 ) || var_3.fake_death )
            level.kva_dead_count++;

        level.kva_1_dead = !isalive( var_2 ) || var_2.fake_death;
        level.kva_2_dead = !isalive( var_3 ) || var_3.fake_death;

        if ( level.kva_dead_count >= 2 )
        {
            hostage_truck_slomo_end( 1 );
            common_scripts\utility::flag_set( var_0 );
            break;
        }

        waitframe();
    }

    level.player.weapon_out = undefined;
    level.player notify( "set_normal_time_if_gun_fired_kill" );
}

set_normal_time_if_gun_fired()
{
    level.player endon( "part2_done" );

    for (;;)
    {
        level.player waittill( "gunFired" );
        hostage_truck_slomo_end( 1 );
        waitframe();
    }
}

kva_fake_death_checker( var_0, var_1 )
{
    level.player endon( "part1_done" );
    level.player endon( "part2_done" );
    self.fake_death = 0;
    thread kva_fake_death_checker_bloodfx();
    self waittill( "damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
    self.fake_death = 1;

    if ( !isdefined( self getlinkedparent() ) )
        self linkto( var_0.tag_driver );

    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        self stopanimscripted();
        var_0 thread maps\_anim::anim_single_solo( self, var_1, "tag_body" );
    }
}

kva_fake_death_checker_bloodfx()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
        var_10 = common_scripts\utility::spawn_tag_origin();
        var_10 linkto( self, var_7, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        playfxontag( common_scripts\utility::getfx( "lag_tkdown_truck_blood_impact" ), var_10, "TAG_ORIGIN" );
    }
}

doclamping()
{
    wait 3;
    level.player lerpviewangleclamp( 1, 0.25, 0.25, 0, 0, 0, 0 );
}

doclampingrelease()
{
    wait 0.6;
    level.player lerpviewangleclamp( 0.05, 0.25, 0.25, 35, 35, 22.5, 22.5 );
}

player_free_aim( var_0, var_1, var_2 )
{
    thread doclamping();
    level.player waittill( "do_viewmodel_swap" );
    thread doclampingrelease();
    var_3 = "iw5_titan45lagostrucktakedown_sp";
    level.player enableweapons();
    level.player hideviewmodel();
    level.player giveweapon( var_3 );
    level.player switchtoweapon( var_3 );
    wait 0.3;
    level.player showviewmodel();
    soundscripts\_snd::snd_message( "final_takedown_gun_up" );
    common_scripts\utility::flag_set( "van_takedown_shoot_lighting" );
    level.player forcemovingplatformentity( var_0 );
    level.player forcemovingplatformentity( var_1 );
    level.player playerrecoilscaleon( 0 );
    level.player waittill( "part2_done" );
    level.player disableweapons();
    wait 1;
    level.player playerrecoilscaleon( 1 );
    common_scripts\utility::flag_set( "van_takedown_impact_lighting" );
    level.player takeweapon( var_3 );

    if ( isdefined( var_0 ) )
        var_0 showallparts();
}

waittill_player_uses_truck_latch( var_0, var_1 )
{
    var_2 = var_0 maps\_shg_utility::hint_button_tag( "x", "latch_jnt", 150, 900 );
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = var_0 gettagorigin( "latch_jnt" ) - 32 * anglestoforward( var_0.angles );
    var_3 linkto( var_0, "latch_jnt" );
    var_3 makeusable();
    level.obj_tag = common_scripts\utility::spawn_tag_origin();
    level.obj_tag.origin = var_0 gettagorigin( "latch_jnt" );
    level.obj_tag linkto( var_0, "latch_jnt" );
    var_4 = getent( "trigger_player_ready_for_van_open", "targetname" );
    var_5 = getent( "swim_latch_open_trigger", "targetname" );
    var_4 maps\lagos_utility::fake_linkto( var_0 );
    var_5 maps\lagos_utility::fake_linkto( var_0 );
    common_scripts\utility::run_thread_on_targetname( "trigger_player_ready_for_van_open", ::truck_swim_latch_open_player_validation );
    var_6 = var_4 common_scripts\utility::waittill_notify_or_timeout_return( "latch_opening", var_1 - 5 );
    var_2 maps\_shg_utility::hint_button_clear();

    if ( isdefined( var_6 ) )
    {
        setdvar( "ui_deadquote", &"LAGOS_SWIM_FAIL" );
        maps\_utility::missionfailedwrapper();
        hostage_truck_gameover();
    }

    level notify( "latch_opened" );
    common_scripts\utility::flag_set( "van_door_open_lighting" );
    common_scripts\utility::flag_set( "flag_van_door_open" );
    var_3 delete();
    thread truck_latch_rumble();
}

truck_latch_rumble()
{
    wait 5;
    level.player playrumbleonentity( "damage_heavy" );
}

truck_swim_latch_open_player_validation()
{
    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( isplayer( var_0 ) )
        {
            while ( common_scripts\utility::flag( "flag_swim_latch_open_trigger" ) )
            {
                if ( level.player usebuttonpressed() )
                {
                    self notify( "latch_opening" );
                    return;
                }

                waitframe();
            }
        }
    }
}

truck_takedown_player_pry_open( var_0, var_1 )
{
    level.player waittill( "slowmo_start" );
    display_hint_timeout_override_old( "qte_pry_open", 20 );
    wait_for_flag_or_player_command( "flag_hostage_truck_is_failure", "+usereload" );

    if ( common_scripts\utility::flag( "flag_hostage_truck_is_failure" ) )
        return;

    hostage_truck_slomo_end( 1 );

    if ( var_0 == "flag_player_pry_open" )
        level notify( "pry_chk_complete" );

    common_scripts\utility::flag_set( var_0 );
}

hostage_truck_failure()
{
    common_scripts\utility::flag_set( "flag_hostage_truck_is_failure" );
    hostage_truck_slomo_end( 1 );
}

hostage_truck_gameover()
{
    level waittill( "forever" );
}

#using_animtree("vehicles");

setup_vehicles_for_takedown()
{
    level.hostage_truck = maps\_vehicle::spawn_vehicle_from_targetname( "KVA_hostage_truck_takedown" );
    level.hostage_truck.vehicle_stays_alive = 1;
    level.hostage_truck setmodel( "vehicle_civ_boxtruck_highres_ai" );
    level.hostage_truck.animname = "hostage_truck";
    level.hostage_truck useanimtree( #animtree );
    thread maps\_vehicle_traffic::add_script_car( level.hostage_truck );
    level.hostage_truck.tag_driver = spawn( "script_origin", ( 0, 0, 0 ) );
    level.hostage_truck.tag_driver.origin = level.hostage_truck gettagorigin( "tag_driver" );
    level.hostage_truck.tag_driver.angles = level.hostage_truck gettagangles( "tag_driver" );
    level.hostage_truck.tag_driver linkto( level.hostage_truck );
    level.hostage_truck_oncoming = maps\_vehicle::spawn_vehicle_from_targetname( "oncoming_hostage_truck_takedown" );
    level.hostage_truck_oncoming.animname = "oncoming_truck";
    level.hostage_truck_oncoming useanimtree( #animtree );
}

hostage_truck_slomo_start( var_0, var_1, var_2 )
{
    if ( common_scripts\utility::flag( "flag_truck_middle_takedown_is_failure" ) )
        return;

    level.player notify( "slowmo_start" );
    var_3 = level.player;
    var_3 thread maps\_utility::play_sound_on_entity( "slomo_whoosh" );
    var_3 thread player_heartbeat();
    maps\_utility::slowmo_start();
    var_3 allowmelee( 0 );
    maps\_utility::slowmo_setspeed_norm( var_0 );
    maps\_utility::slowmo_setspeed_slow( var_1 );
    maps\_utility::slowmo_setlerptime_in( var_2 );
    maps\_utility::slowmo_lerp_in();
}

hostage_truck_slomo_end( var_0 )
{
    var_1 = 0.75;

    if ( isdefined( var_0 ) && var_0 )
        var_1 = 0.05;

    level notify( "stop_player_heartbeat" );
    level.player thread maps\_utility::play_sound_on_entity( "slomo_whoosh" );
    maps\_utility::slowmo_setspeed_norm( 1.0 );
    maps\_utility::slowmo_setlerptime_out( var_1 );
    maps\_utility::slowmo_lerp_out();
    maps\_utility::slowmo_end();
}

player_heartbeat()
{
    level endon( "stop_player_heartbeat" );

    for (;;)
    {
        self playlocalsound( "breathing_heartbeat" );
        wait 0.5;
    }
}

hostage_truck_slomo_end_notetrack( var_0 )
{
    level.player notify( "slowmo_end" );
    hostage_truck_slomo_end( 0 );
}

hostage_truck_slomo_start_pt1( var_0 )
{
    soundscripts\_snd::snd_message( "hostage_truck_slomo_start_pt1" );
    var_1 = 0.095;
    var_2 = 0.095;
    var_3 = 0.2;
    hostage_truck_slomo_start( var_1, var_2, var_3 );
}

hostage_truck_slomo_start_pt2( var_0 )
{
    var_1 = 0.1;
    var_2 = 0.1;
    var_3 = 0.2;
    common_scripts\utility::flag_set( "flag_hostage_truck_fire_input_window_started" );

    if ( !isdefined( level.kva_1_dead ) || !isdefined( level.kva_1_dead ) || !level.kva_1_dead || !level.kva_1_dead )
    {
        soundscripts\_snd::snd_message( "hostage_truck_slomo_start_pt2" );
        hostage_truck_slomo_start( var_1, var_2, var_3 );
    }
}

hostage_truck_slomo_end_pt2( var_0 )
{
    if ( common_scripts\utility::flag( "flag_hostage_truck_fire_input_window_started" ) )
        level.player notify( "check_and_wait_for_shooting_result" );

    hostage_truck_slomo_end_notetrack( var_0 );
}

hostage_truck_slomo_start_pt3( var_0 )
{
    soundscripts\_snd::snd_message( "hostage_truck_slomo_start_pt3" );
    var_1 = 0.095;
    var_2 = 0.095;
    var_3 = 0.2;
    hostage_truck_slomo_start( var_1, var_2, var_3 );
}

hostage_truck_slomo_start_pt4( var_0 )
{
    soundscripts\_snd::snd_message( "hostage_truck_slomo_start_pt4" );
    var_1 = 0.095;
    var_2 = 0.095;
    var_3 = 0.2;
    hostage_truck_slomo_start( var_1, var_2, var_3 );
}

hostage_truck_viewmodel_swap( var_0 )
{
    level.player allowmelee( 0 );
    level.player notify( "do_viewmodel_swap" );
}

traverse_start_jump_start_slowmo( var_0 )
{
    soundscripts\_snd::snd_message( "traverse_start_jump_start_slowmo" );
    var_1 = 0.095;
    var_2 = 0.095;
    var_3 = 0.2;

    if ( level.currentgen )
    {
        var_1 = 0.2;
        var_2 = 0.2;
        var_3 = 0.1;
    }

    hostage_truck_slomo_start( var_1, var_2, var_3 );
}

traverse_start_jump_start_prompt( var_0 )
{
    thread maps\lagos_code::traffic_traverse_start_player_input();
    common_scripts\utility::flag_wait( "flag_highway_ledge_jump_started" );
    maps\lagos_utility::disable_exo_for_highway();
    traverse_start_jump_end_slowmo();

    if ( isdefined( level.traffic_ledge_jump_trigger_use ) )
        level.traffic_ledge_jump_trigger_use delete();
}

traverse_start_jump_end_prompt( var_0 )
{
    if ( isdefined( level.traffic_ledge_jump_trigger_use ) )
        level.traffic_ledge_jump_trigger_use delete();
}

traverse_start_jump_end_slowmo( var_0 )
{
    soundscripts\_snd::snd_message( "traverse_start_jump_end_slowmo" );
    hostage_truck_slomo_end_notetrack();

    if ( common_scripts\utility::flag( "flag_highway_ledge_jump_started" ) )
        return;
    else
    {
        common_scripts\utility::flag_set( "flag_highway_ledge_jump_fail" );
        level.org_player_highway_ledge maps\_utility::anim_stopanimscripted();
        level.org_player_highway_ledge maps\_anim::anim_single_solo( level.player_rig_highway_ledge, "traffic_start_VM_fail" );
        setdvar( "ui_deadquote", &"LAGOS_BUS_JUMP_FAILED" );
        maps\_utility::missionfailedwrapper();
    }
}

traverse_start_jump_player_looking( var_0 )
{
    common_scripts\utility::flag_set( "flag_highway_VM_looking_forward" );
}

wait_for_flag_or_player_command_aux( var_0, var_1 )
{
    level.player endon( "qte_success_message" );
    common_scripts\utility::flag_wait( var_0 );
    return 1;
}

wait_for_flag_or_player_command( var_0, var_1 )
{
    level.player notifyonplayercommand( "qte_success_message", var_1 );
    var_2 = wait_for_flag_or_player_command_aux( var_0, var_1 );
    level.player notifyonplayercommandremove( "qte_success_message", var_1 );
}

display_hint_timeout_override_old( var_0, var_1 )
{
    level.player.remove_hint = level.player.current_global_hint;
    level.player maps\_utility::display_hint_timeout( var_0, var_1 );
}

qte_grab_hold_off()
{
    if ( level.player usebuttonpressed() || isdefined( level.player.remove_hint ) && level.player.remove_hint == &"LAGOS_QTE_GRAB_HOLD" )
        return 1;

    return 0;
}

qte_shoot_kva_off()
{
    var_0 = "BUTTON_RTRIG";

    if ( !level.console && !level.player common_scripts\utility::is_player_gamepad_enabled() )
        var_0 = "mouse2";

    if ( level.player buttonpressed( var_0 ) || isdefined( level.player.remove_hint ) && level.player.remove_hint == &"LAGOS_QTE_SHOOT_KVA" )
        return 1;

    return 0;
}

qte_pry_open_off()
{
    if ( level.player usebuttonpressed() || isdefined( level.player.remove_hint ) && level.player.remove_hint == &"LAGOS_QTE_PRY_OPEN" )
        return 1;

    return 0;
}

qte_swim_off()
{
    if ( level.player getnormalizedmovement() > 0.01 || isdefined( level.player.remove_hint ) && level.player.remove_hint == &"LAGOS_QTE_SWIM" )
        return 1;

    return 0;
}

qte_success_off()
{
    if ( isdefined( level.player.remove_hint ) && level.player.remove_hint == &"LAGOS_QTE_SUCCESS" )
        return 1;

    return 0;
}

qte_fail_off()
{
    if ( isdefined( level.player.remove_hint ) && level.player.remove_hint == &"LAGOS_QTE_FAIL" )
        return 1;

    return 0;
}
