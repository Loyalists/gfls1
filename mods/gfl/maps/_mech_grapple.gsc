// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

mech_grapple_init()
{
    level.mech_grapple_setup_function = ::mech_setup_grapple_tappy;
    precachemodel( "playermech_animated_model_top" );
    precachemodel( "playermech_animated_model_btm" );
    precachemodel( "viewhands_sentinel" );
    precachemodel( "atlas_body" );
    precachemodel( "base_grapple_rope" );
    precacherumble( "mech_grapple_kill" );
    precacherumble( "minigun_rumble" );
    precache_fx();
    init_animset_mech_grapple_tappy();
}

precache_fx()
{
    level._effect["mech_grapple_burst"] = loadfx( "vfx/explosion/mech_grapple_burst" );
    level._effect["mech_blood_burst"] = loadfx( "vfx/blood/mech_blood_burst" );
    level._effect["mech_strain_burst"] = loadfx( "vfx/explosion/sparks_burst_electric_box" );
}

#using_animtree("player");

mech_spawn_player_rig()
{
    var_0 = undefined;

    if ( isdefined( level.player_rig_spawn_function ) )
    {
        var_0 = [[ level.player_rig_spawn_function ]]();
        var_0.animname = "mech_grapple_player";
    }
    else
    {
        var_0 = spawn( "script_model", ( 0, 0, 0 ) );
        var_0.animname = "mech_grapple_player";
        var_0 useanimtree( #animtree );
        var_0 setmodel( self.grapple["model_body"].model );
    }

    return var_0;
}

mech_setup_grapple_tappy( var_0 )
{
    if ( isdefined( level.grapple_magnets ) )
    {
        var_1 = spawnstruct();
        var_1.type = "callback_fired";
        var_1.callback = ::mech_start_grapple_tappy;
        var_1.distmin = 256;
        var_1.distmax = 750;
        var_1.dotlimittagfwd = ( 0, 1, 0 );
        var_1.dotlimitmin = 0.42;
        var_1.ignorecollision = 0;
        var_1.requireonground = 1;
        var_1.hint = "grapple_kill";
        maps\_grapple::grapple_magnet_register( var_0, "J_SpineUpper", ( 0, 0, 0 ), undefined, undefined, var_1, undefined );
    }
}

mech_start_grapple_tappy( var_0, var_1, var_2 )
{
    level.aud_mech_grapple_pitch_up = 1;
    thread mech_handle_grapple_tappy_sound( var_0 );
    var_1 notify( "stop_mHunt_bhavior" );
    var_1 notify( "stop_rocket_launcher" );
    var_1 hudoutlinedisable();
    var_1 maps\_utility::ai_ignore_everything();
    var_1 maps\_anim::anim_first_frame_solo( var_1, "enter", undefined, "mech_grapple" );
    var_1 notify( "stop_mech_turn_loop" );
    var_0.ignoreme = 1;
    var_0.grapple_mech_no_save = 1;
    var_0 enableinvulnerability();
    badplace_cylinder( "mech_grapple", 0, var_1.origin, 120, 60, "axis", "allies", "neutral", "team3" );
    badplace_cylinder( "mech_grapple_player", 0, var_0.origin, 120, 60, "axis", "allies", "neutral", "team3" );
    badplace_cylinder( "mech_grapple_inbetween", 0, var_1.origin + ( var_0.origin - var_1.origin ) / 2, 120, 60, "axis", "allies", "neutral", "team3" );
    var_0.grapple["enabled"] = 0;
    var_0 thread maps\_shg_utility::setup_player_for_scene( 1 );
    wait 0.2;
    var_0 hideviewmodel();
    var_3 = var_0 mech_spawn_player_rig();
    var_3 unlink();
    var_3 hide();
    var_3.origin = var_0.origin;
    var_3.angles = var_0.angles;
    var_3 dontinterpolate();
    var_3.player = var_0;
    var_3.mech = var_1;
    var_3.scene_origin = var_0.origin;
    var_4 = maps\_utility::spawn_anim_model( "mech_grapple_rope", var_0.origin, var_0.angles );
    var_3.rope = var_4;
    var_5 = common_scripts\utility::spawn_tag_origin();
    var_5.origin = var_0.origin;
    var_5.angles = var_0.angles;
    var_5 dontinterpolate();
    var_3 linkto( var_5 );
    var_4 linkto( var_5 );
    var_3.link = var_5;
    var_5 rotateto( ( vectortoangles( var_1.origin - var_0.origin )[0], var_0.angles[1], var_0.angles[2] ), 0.2 );
    var_0 maps\_grapple::grapple_disconnect();
    var_0 playerlinktoabsolute( var_3, "tag_player" );
    var_3 show();
    var_6 = common_scripts\utility::spawn_tag_origin();
    var_6.origin = var_1.origin;
    var_6.angles = var_1.angles;
    var_6 dontinterpolate();
    var_1 linkto( var_6 );
    var_6 rotateto( ( var_6.angles[0], var_0.angles[1], var_6.angles[2] ), 0.2 );
    var_3 thread maps\_anim::anim_single_solo( var_3, "enter" );
    var_3 thread maps\_anim::anim_single_solo( var_4, "enter" );
    var_1 thread maps\_anim::anim_single_solo( var_1, "enter", undefined, undefined, "mech_grapple" );
    wait 1;
    var_0 playrumblelooponentity( "minigun_rumble" );
    var_1 waittillmatch( "single anim", "end" );
    var_1 unlink();
    var_6 delete();
    level.old_dof_physical_enable = getdvar( "r_dof_physical_enable" );
    setsaveddvar( "r_dof_physical_enable", 1 );
    setsaveddvar( "r_dof_physical_accurateFov", 1 );
    var_0 enablephysicaldepthoffieldscripting();
    thread mech_handle_grapple_tappy( var_0, var_3, var_1, var_4 );
}

mech_handle_grapple_tappy( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "mech_grapple_tappy_end" );
    var_4 = 0.1;
    var_5 = 1.0;
    var_6 = "tappy";
    var_7 = var_6;
    var_8 = 5.0;
    var_9 = distance( var_2.origin, var_0.origin );
    var_1 thread maps\_anim::anim_single_solo( var_1, var_6 );
    var_1 thread maps\_anim::anim_single_solo( var_3, var_6 );
    var_2 thread maps\_anim::anim_loop_solo( var_2, var_6, undefined, undefined, "mech_grapple" );
    var_2 thread vfx_mech_grapple_strain_fx();
    var_1 setanimtime( var_1 maps\_utility::getanim( var_6 ), 0.5 );
    var_3 setanimtime( var_3 maps\_utility::getanim( var_6 ), 0.5 );
    var_0 thread mech_grapple_tappy_monitor_button_presses();
    var_0 setphysicaldepthoffield( 1.0, var_9, 0.25, 0.25 );

    while ( var_8 > 0.0 )
    {
        var_0 enableinvulnerability();
        var_0.mech_grapple_tappy_pressed = 1;

        if ( var_0.mech_grapple_tappy_pressed )
        {
            var_5 = 1.0;
            level.aud_mech_grapple_pitch_up = 1;

            if ( var_5 > 0.0 )
                var_7 = "tappy";

            var_0.mech_grapple_tappy_pressed = 0;
        }
        else
        {
            var_5 -= 0.05 / var_4;
            var_5 = max( var_5, -1.0 );
            level.aud_mech_grapple_pitch_up = 0;

            if ( var_5 < 0.0 )
                var_7 = "tappy_rev";
        }

        if ( var_7 != var_6 )
        {
            if ( var_5 < 0.0 )
                var_0 setphysicaldepthoffield( 2.5, 6.0, 0.25, 0.25 );
            else
                var_0 setphysicaldepthoffield( 2.0, var_9, 0.25, 0.25 );

            var_10 = 1.0 - var_1 getanimtime( var_1 maps\_utility::getanim( var_6 ) );
            var_6 = var_7;
            var_1 thread maps\_anim::anim_single_solo( var_1, var_6 );
            var_1 thread maps\_anim::anim_single_solo( var_3, var_6 );
            var_1 setanimtime( var_1 maps\_utility::getanim( var_6 ), var_10 );
            var_3 setanimtime( var_1.rope maps\_utility::getanim( var_6 ), var_10 );
        }

        var_1 setanimrate( var_1 maps\_utility::getanim( var_6 ), abs( var_5 ) );
        var_3 setanimrate( var_3 maps\_utility::getanim( var_6 ), abs( var_5 ) );
        wait 0.05;
        var_8 -= 0.05;
    }

    if ( var_6 == "tappy" )
    {
        var_10 = 1.0 - var_1 getanimtime( var_1 maps\_utility::getanim( var_6 ) );
        var_6 = "tappy_rev";
        var_1 thread maps\_anim::anim_single_solo( var_1, var_6 );
        var_1 thread maps\_anim::anim_single_solo( var_3, var_6 );
        var_1 setanimtime( var_1 maps\_utility::getanim( var_6 ), var_10 );
        var_3 setanimtime( var_3 maps\_utility::getanim( var_6 ), var_10 );
    }

    var_1 setanimrate( var_1 maps\_utility::getanim( var_6 ), 1.0 );
    var_3 setanimrate( var_3 maps\_utility::getanim( var_6 ), 1.0 );
}

mech_handle_grapple_tappy_sound( var_0 )
{
    wait 0.3;
    var_0 endon( "mech_grapple_tappy_end" );
    soundscripts\_snd_timescale::snd_set_timescale( "all_off" );
    thread soundscripts\_snd_playsound::snd_play_2d( "bagh_mechkill_stress" );
}

mech_grapple_tappy_monitor_button_presses()
{
    self endon( "mech_grapple_tappy_end" );
    self notifyonplayercommand( "mech_tappy_button_pressed", "+usereload" );
    self.mech_grapple_tappy_pressed = 0;

    for (;;)
    {
        self waittill( "mech_tappy_button_pressed" );
        self.mech_grapple_tappy_pressed = 1;
    }
}

mech_grapple_player_success_loop( var_0 )
{
    self endon( "success_end" );
    thread maps\_anim::anim_single_solo( self, "success_start" );
    wait 0.3;
    level.player stoprumble( "minigun_rumble" );
    wait 1.0;
    level.player playrumbleonentity( "mech_grapple_kill" );
    wait 0.1;
    level.player stoprumble( "mech_grapple_kill" );
    self waittillmatch( "single anim", "end" );
    thread maps\_anim::anim_single_solo( self, "success_loop" );
    var_1 = getstartorigin( self.origin, self.angles, level.scr_anim["mech_grapple_guy"]["success_end"] );
    var_2 = distance( var_1, var_0.start_origin + getcycleoriginoffset( var_0.angles, level.scr_anim["mech_grapple_guy"]["success_start"] ) );
    var_3 = var_2 / 360.0;
    var_3 += ( 1.0 - var_0 getanimtime( level.scr_anim["mech_grapple_guy"]["success_start"] ) ) * getanimlength( level.scr_anim["mech_grapple_guy"]["success_start"] );
    var_3 = floor( var_3 * 10.0 ) / 10.0;
    var_4 = getanimlength( level.scr_anim["mech_grapple_player"]["success_loop"] ) / var_3;
    self setanimrate( level.scr_anim["mech_grapple_player"]["success_loop"], var_4 );
}

mech_grapple_tappy_success( var_0 )
{
    var_0.player notify( "mech_grapple_tappy_end" );
    var_0.player maps\_grapple::grapple_kills_increment();

    if ( isdefined( level.hintelement ) )
    {
        level notify( "clearing_hints" );
        level.hintelement destroy();
    }

    var_1 = var_0.mech;
    var_2 = var_0.player;
    var_3 = var_0.rope;
    var_4 = var_1.origin;
    var_0 setanimrate( var_0 maps\_utility::getanim( "tappy" ), 1.0 );
    var_3 setanimrate( var_3 maps\_utility::getanim( "tappy" ), 1.0 );
    var_5 = distance( var_1.origin, var_2.origin );
    var_2 setphysicaldepthoffield( 2.0, var_5, 0.05, 0.05 );
    var_0 waittillmatch( "single anim", "end" );
    var_6 = mech_grapple_spawn_mech_guy( var_1 );
    var_7 = mech_grapple_spawn_mech_parts( var_1 );
    var_8 = common_scripts\utility::spawn_tag_origin();
    var_8.origin = var_6.origin;
    var_8.angles = var_6.angles;
    var_8 dontinterpolate();
    var_6 linkto( var_8 );
    var_8 rotateto( ( vectortoangles( var_4 - var_2.origin )[0], var_8.angles[1], var_8.angles[2] ), 0.1 );

    foreach ( var_10 in var_7 )
    {
        var_10 thread maps\_anim::anim_single_solo( var_10, "success_start" );
        var_10 thread vfx_mech_grapple_strain_fx( 15 );
    }

    var_0 thread mech_grapple_player_success_loop( var_6 );
    var_0 thread maps\_anim::anim_single_solo( var_3, "success_start" );
    var_0 mech_grapple_pull_guy_to_player( var_6 );
    var_0 notify( "success_end" );
    var_12 = common_scripts\utility::spawn_tag_origin();
    var_12.origin = var_0.scene_origin;
    var_12.angles = var_0.angles;
    var_12 dontinterpolate();
    var_13 = common_scripts\utility::spawn_tag_origin();
    var_13.origin = var_12.origin;
    var_13.angles = var_6.angles;
    var_13 dontinterpolate();
    var_8.origin = var_6.origin;
    var_8.angles = var_6.angles;
    var_8 dontinterpolate();
    var_12 thread maps\_anim::anim_single_solo( var_0, "success_end" );
    var_12 thread maps\_anim::anim_single_solo( var_6, "success_end" );
    var_6 linkto( var_0.link );
    wait 0.2;
    var_2 playrumbleonentity( "mech_grapple_kill" );
    wait 0.05;
    var_8 rotateto( ( 0, var_8.angles[1], var_8.angles[2] ), 0.25 );
    var_0.link rotateto( ( 0, var_0.link.angles[1], var_0.link.angles[2] ), 0.25 );
    wait 0.9;
    var_2 playrumbleonentity( "mech_grapple_kill" );
    var_6 waittillmatch( "single anim", "end" );
    level notify( "aud_stop_grapple_mech_cable_stress" );
    level notify( "aud_stop_grapple_mech_servo" );
    var_12 delete();
    var_13 delete();
    var_2 maps\_upgrade_challenge::give_player_challenge_kill( 1 );
    var_6 startragdoll();
    var_2 unlink();
    var_2 maps\_shg_utility::setup_player_for_gameplay();
    level.player.grapple["enabled"] = 1;
    var_2 showviewmodel();
    var_3 delete();
    var_0.link delete();
    var_0 delete();
    var_8 delete();
    var_2 disableinvulnerability();
    var_2.ignoreme = 0;
    var_2.grapple_mech_no_save = 0;
    badplace_delete( "mech_grapple" );
    badplace_delete( "mech_grapple_player" );
    badplace_delete( "mech_grapple_inbetween" );
}

#using_animtree("generic_human");

mech_grapple_spawn_mech_guy( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    var_1.angles = var_0.angles;
    var_1.animname = "mech_grapple_guy";
    var_1 useanimtree( #animtree );
    // var_1 setmodel( "atlas_body" );
    // var_1 codescripts\character::setheadmodel( var_0.headmodel );
    var_1 character\gfl\randomizer_atlas::main();
    var_1 thread vfx_mech_grapple_fx();
    return var_1;
}

mech_grapple_pull_guy_to_player( var_0 )
{
    thread mech_splode_sound();
    var_0.start_origin = var_0.origin;
    var_0 maps\_anim::anim_single_solo( var_0, "success_start" );
    var_0 unlink();
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
    var_1 dontinterpolate();
    var_2 = getstartorigin( self.origin, self.angles, level.scr_anim["mech_grapple_guy"]["success_end"] );
    var_3 = getstartangles( self.origin, self.angles, level.scr_anim["mech_grapple_guy"]["success_end"] );
    var_4 = distance( var_2, var_0.origin );
    var_5 = var_4 / 360.0;

    if ( var_5 >= 0.1 )
    {
        var_0 linkto( var_1 );
        var_5 = max( 0.05, floor( var_5 * 10.0 ) / 10.0 );
        var_1 moveto( var_2, var_5, var_5 / 2, 0.0 );
        var_1 rotateto( var_3, var_5 * 0.25, min( 0.1, var_5 * 0.1 ), min( 0.1, var_5 * 0.1 ) );
        self.player setphysicaldepthoffield( 1.5, var_4, var_5, var_5 );
        var_0 thread maps\_anim::anim_single_solo( var_0, "success_loop" );
        var_0 setanimrate( level.scr_anim["mech_grapple_guy"]["success_loop"], getanimlength( level.scr_anim["mech_grapple_guy"]["success_loop"] ) / var_5 );
        wait( var_5 );
    }

    level notify( "aud_stop_grapple_mech_pull" );
    thread mech_slate_quick();
    self.player setphysicaldepthoffield( 2.0, 6.0, 0.1, 0.1 );
    var_0 unlink();
    var_1 delete();
}

mech_splode_sound()
{
    wait 0.6666;
    soundscripts\_snd_playsound::snd_play_2d( "bagh_mechkill_splodey" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "bagh_mechkill_dudefly", 1.25 );
    wait 0.7;
    soundscripts\_audio_mix_manager::mm_add_submix( "mech_kill", 1 );
    wait 1.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mech_kill", 0.2 );
    soundscripts\_audio_mix_manager::mm_add_submix( "mech_kill_2", 0.2 );
    wait 0.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mech_kill_2", 0.2 );
    soundscripts\_audio_mix_manager::mm_add_submix( "mech_kill", 0.2 );
    wait 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mech_kill", 0.4 );
}

mech_slate_quick()
{

}

mech_grapple_spawn_mech_parts( var_0 )
{
    var_1 = [];
    var_1[0] = spawn( "script_model", var_0.origin );
    var_1[0].angles = var_0.angles;
    var_1[0].animname = "mech_grapple";
    var_1[0] useanimtree( #animtree );
    var_1[0] setmodel( "playermech_animated_model_btm" );
    var_1[1] = spawn( "script_model", var_0.origin );
    var_1[1].angles = var_0.angles;
    var_1[1].animname = "mech_grapple";
    var_1[1] useanimtree( #animtree );
    var_1[1] setmodel( "playermech_animated_model_top" );
    maps\_grapple::grapple_magnet_unregister( var_0, "J_SpineUpper" );
    var_0 hide();
    var_0 delete();
    return var_1;
}

mech_grapple_tappy_fail( var_0 )
{
    var_0.player notify( "mech_grapple_tappy_end" );

    if ( isdefined( level.hintelement ) )
    {
        level notify( "clearing_hints" );
        level.hintelement destroy();
    }

    var_1 = var_0.mech;
    var_2 = var_0.player;
    var_3 = var_0.rope;
    var_0 setanimrate( var_0 maps\_utility::getanim( "tappy_rev" ), 1.0 );
    var_1 setanimrate( maps\_utility::getanim_from_animname( "tappy_rev", "mech_grapple" ), 1.0 );
    var_0 waittillmatch( "single anim", "end" );
    level notify( "aud_stop_grapple_mech_cable_stress" );
    level notify( "aud_stop_grapple_mech_servo" );
    var_2 disablephysicaldepthoffieldscripting();
    setsaveddvar( "r_dof_physical_enable", level.old_dof_physical_enable );
    var_2 disableinvulnerability();
    var_1 thread maps\_anim::anim_single_solo( var_1, "fail_start", undefined, undefined, "mech_grapple" );
    var_0 maps\_anim::anim_single_solo( var_0, "fail_start" );
    var_2 unlink();
    var_2 maps\_shg_utility::setup_player_for_gameplay();
    var_2 showviewmodel();
    var_3 delete();
    var_0 delete();
    var_1.ignoreall = 0;
}

mech_grapple_start_slowmo( var_0 )
{
    if ( !isdefined( level.slowmo_speed ) )
        level.slowmo_speed = 1.0;

    var_1 = 0.25;
    setslowmotion( level.slowmo_speed, var_1, 0.2 );
    level.slowmo_speed = var_1;
}

mech_grapple_start_speedup( var_0 )
{
    if ( !isdefined( level.slowmo_speed ) )
        level.slowmo_speed = 1.0;

    var_1 = 1.5;
    setslowmotion( level.slowmo_speed, var_1, 0.2 );
    level.slowmo_speed = var_1;
}

mech_grapple_stop_slowmo( var_0 )
{
    if ( !isdefined( level.slowmo_speed ) )
        level.slowmo_speed = 1.0;

    var_1 = 1.0;
    setslowmotion( level.slowmo_speed, var_1, 0.2 );
    level.slowmo_speed = var_1;
}

mech_grapple_reset_dof( var_0 )
{
    var_0.player setphysicaldepthoffield( 5.6, 100, 0.25, 0.25 );
    wait 0.25;
    var_0.player disablephysicaldepthoffieldscripting();
    setsaveddvar( "r_dof_physical_enable", level.old_dof_physical_enable );
    soundscripts\_snd_timescale::snd_set_timescale( "all_on" );
}

vfx_mech_grapple_strain_fx( var_0 )
{
    var_1 = common_scripts\utility::getfx( "mech_strain_burst" );
    var_2 = [ "J_SpineLower", "j_SpineUpper", "J_Hip_LE", "J_Hip_RI", "J_Knee_LE", "J_Knee_RI", "J_Ankle_LE", "J_Ankle_RI", "J_Shoulder_LE", "J_Shoulder_RI", "J_Elbow_LE", "J_Elbow_RI" ];
    var_3 = gettime();

    while ( isdefined( self ) )
    {
        playfxontag( var_1, self, var_2[randomintrange( 0, 11 )] );
        var_4 = 0.05;
        var_5 = 0.25;

        if ( isdefined( var_0 ) )
        {
            var_4 = 0.05 + ( gettime() - var_3 ) / 1000 * 0.1;
            var_5 = var_4 * 2;
        }

        wait( randomfloatrange( var_4, var_5 ) );

        if ( isdefined( var_0 ) && gettime() > var_3 + var_0 * 1000 )
            break;
    }
}

vfx_mech_grapple_fx()
{
    var_0 = common_scripts\utility::getfx( "mech_grapple_burst" );
    var_1 = common_scripts\utility::getfx( "mech_blood_burst" );
    self waittillmatch( "single anim", "grapple_strain" );
    self waittillmatch( "single anim", "grapple_burst" );
    playfxontag( var_0, self, "J_SpineUpper" );
    self waittillmatch( "single anim", "face_slam" );
    var_2 = self gettagorigin( "jnt_brow_il" );
    var_3 = self gettagangles( "jnt_brow_il" );
    playfx( var_1, var_2, anglestoforward( var_3 ) * -1, anglestoup( var_3 ) );
}

init_animset_mech_grapple_tappy()
{
    level.scr_animtree["mech_grapple"] = #animtree;
    level.scr_anim["mech_grapple"]["enter"] = %grapple_mech_enter;
    level.scr_anim["mech_grapple"]["tappy"][0] = %grapple_mech_tappy;
    level.scr_anim["mech_grapple"]["tappy_rev"] = %grapple_mech_tappy_rev;
    level.scr_anim["mech_grapple"]["success_start"] = %grapple_mech_success_start;
    level.scr_anim["mech_grapple"]["fail_start"] = %grapple_mech_fail_start;
    level.scr_animtree["mech_grapple_guy"] = #animtree;
    level.scr_anim["mech_grapple_guy"]["success_start"] = %grapple_mech_guy_success_start;
    level.scr_anim["mech_grapple_guy"]["success_loop"] = %grapple_mech_guy_success_loop;
    level.scr_anim["mech_grapple_guy"]["success_end"] = %grapple_mech_guy_success_end;
    init_animset_mech_player_grapple_tappy();
    init_animset_mech_rope_grapple_tappy();
}

#using_animtree("player");

init_animset_mech_player_grapple_tappy()
{
    level.scr_animtree["mech_grapple_player"] = #animtree;
    level.scr_anim["mech_grapple_player"]["enter"] = %vm_grapple_mech_enter;
    level.scr_anim["mech_grapple_player"]["tappy"] = %vm_grapple_mech_tappy;
    level.scr_anim["mech_grapple_player"]["tappy_rev"] = %vm_grapple_mech_tappy_rev;
    level.scr_anim["mech_grapple_player"]["success_start"] = %vm_grapple_mech_success_start;
    level.scr_anim["mech_grapple_player"]["success_loop"] = %vm_grapple_mech_success_loop;
    level.scr_anim["mech_grapple_player"]["success_end"] = %vm_grapple_mech_success_end;
    level.scr_anim["mech_grapple_player"]["fail_start"] = %vm_grapple_mech_fail_start;
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "tappy_success", ::mech_grapple_tappy_success, "tappy" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "tappy_fail", ::mech_grapple_tappy_fail, "tappy_rev" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "start_slowmo", ::mech_grapple_start_slowmo, "success_start" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "stop_slowmo", ::mech_grapple_stop_slowmo, "success_start" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "start_speedup", ::mech_grapple_start_speedup, "success_start" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "start_slowmo", ::mech_grapple_start_slowmo, "success_loop" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "stop_slowmo", ::mech_grapple_stop_slowmo, "success_loop" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "start_speedup", ::mech_grapple_start_speedup, "success_loop" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "start_slowmo", ::mech_grapple_start_slowmo, "success_end" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "stop_slowmo", ::mech_grapple_stop_slowmo, "success_end" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "start_speedup", ::mech_grapple_start_speedup, "success_end" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "aud_mechkill_catchdude", ::aud_mechkill_catchdude, "success_end" );
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "reset_dof", ::mech_grapple_reset_dof, "success_end" );
}

aud_mechkill_catchdude( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "bagh_mechkill_catchdude" );
}

#using_animtree("animated_props");

init_animset_mech_rope_grapple_tappy()
{
    level.scr_animtree["mech_grapple_rope"] = #animtree;
    level.scr_model["mech_grapple_rope"] = "base_grapple_rope";
    level.scr_anim["mech_grapple_rope"]["enter"] = %vm_grapple_mech_enter_rope;
    level.scr_anim["mech_grapple_rope"]["tappy"] = %vm_grapple_mech_tappy_rope;
    level.scr_anim["mech_grapple_rope"]["tappy_rev"] = %vm_grapple_mech_tappy_rev_rope;
    level.scr_anim["mech_grapple_rope"]["success_start"] = %vm_grapple_mech_success_start_rope;
}
