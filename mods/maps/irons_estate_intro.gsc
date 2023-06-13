// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

intro_start()
{
    level.start_point_scripted = "intro";
    maps\irons_estate::irons_estate_objectives();
    maps\irons_estate_code::spawn_player_checkpoint();
    level.player maps\_grapple::grapple_take();
    level.player maps\_tagging::tagging_set_enabled( 0 );
    level.start_point_intro = 1;
    soundscripts\_snd::snd_message( "start_intro" );
}

intro_main()
{
    level.start_point_scripted = "intro";
    maps\irons_estate_code::spawn_allies();
    common_scripts\utility::flag_set( "intro_begin" );
    level.intro_anim_struct = common_scripts\utility::getstruct( "intro_anim_struct", "targetname" );
    intro_begin();
    common_scripts\utility::flag_wait( "intro_end" );
    var_0 = getent( "waterfall_cave_trigger", "targetname" );
    var_0 thread maps\irons_estate_code::waterfall_save( "grapple_end" );
}

intro_begin()
{
    common_scripts\utility::flag_init( "introscreen2_complete" );
    common_scripts\utility::flag_init( "spawn_intro_drones" );
    thread maps\irons_estate_code::player_kill_trigger( "waterfall_bottom_kill_trigger" );
    thread handle_intro();
    level.allies[0] thread intro_allies();
    level.allies[1] thread intro_allies();
    level.allies[2] thread intro_allies();
    thread intro_vo();
    thread intro_bink();
    common_scripts\_exploder::exploder( 7900 );
    common_scripts\_exploder::exploder( 9900 );
}

handle_intro()
{
    thread introscreen2();
    thread intro_player();
    thread intro_cave_rumble();
    common_scripts\utility::flag_wait( "introscreen2_complete" );
    common_scripts\utility::flag_set( "spawn_intro_drones" );
    thread intro_drone();
    common_scripts\utility::flag_wait( "drone_passed" );
}

intro_cave_rumble()
{
    level endon( "player_in_estate" );
    var_0 = common_scripts\utility::getstruct( "intro_start", "targetname" );
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = var_0.origin;
    var_1 thread intro_cave_rumble_cleanup();

    for (;;)
    {
        common_scripts\utility::flag_wait( "intro_cave_waterfall_trigger" );
        var_1 playrumblelooponentity( "ie_cave_rumble" );
        common_scripts\utility::flag_waitopen( "intro_cave_waterfall_trigger" );
        var_1 stoprumble( "ie_cave_rumble" );
        wait 0.05;
    }
}

intro_cave_rumble_cleanup()
{
    common_scripts\utility::flag_wait( "player_in_estate" );

    if ( isdefined( self ) )
    {
        self stoprumble( "ie_cave_rumble" );
        self delete();
    }
}

introscreen2()
{
    if ( isdefined( level.start_point_intro ) )
        thread maps\_hud_util::fade_out( 0, "black" );

    var_0 = 8;
    maps\_utility::delaythread( var_0, maps\_utility::center_screen_text, &"IRONS_ESTATE_CENTER_SCREEN_TEXT2" );
    wait(var_0);

    if ( level.currentgen )
    {
        if ( !istransientloaded( "irons_estate_cliffs_tr" ) )
            level waittill( "tff_post_briefing_to_cliffs" );
    }

    thread maps\_hud_util::fade_in( 1 );
    common_scripts\utility::flag_set( "introscreen2_complete" );
}

intro_player()
{
    level.player freezecontrols( 1 );
    level.player allowsprint( 0 );
    level.player thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    level.player allowfire( 0 );
    level.player disableweapons();
    level.player setstance( "crouch" );
    wait 1.25;
    level.player allowprone( 0 );
    level.player allowstand( 0 );
    var_0 = common_scripts\utility::getstruct( "intro_start", "targetname" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1 setmodel( "tag_origin" );
    var_1.angles = var_0.angles;
    level.player playerlinkto( var_1, "tag_origin", 0, 0, 0, 0, 0, 0 );
    var_1 delete();
    waitframe();
    var_1 = spawn( "script_model", level.player getorigin() );
    var_1 setmodel( "tag_origin" );
    var_1.angles = var_0.angles;
    level.player playerlinktodelta( var_1, "tag_origin", 0, 0, 0, 0, 0, 0 );
    common_scripts\utility::flag_wait( "introscreen2_complete" );
    soundscripts\_snd::snd_message( "aud_patching_in_foley" );
    wait 0.5;
    level.player lerpviewangleclamp( 0.5, 0.25, 0.25, 60, 60, 40, 20 );
    common_scripts\utility::flag_wait( "drone_passed" );
    wait 0.5;
    level.player enableweaponswitch();
    var_2 = level.player getweaponslistall();
    level.player switchtoweaponimmediate( var_2[0] );
    wait 0.05;
    level.player takeweapon( "s1_unarmed" );
    level.player allowmelee( 1 );
    level.player allowsprint( 1 );
    level.player allowads( 1 );
    level.player setmovespeedscale( 1 );
    level.player enableweapons();
    wait 1;
    var_1 delete();
    level.player allowprone( 1 );
    level.player allowstand( 1 );
    level.player freezecontrols( 0 );
    level.player allowsprint( 1 );
    level.player thread maps\_shg_utility::enable_features_exiting_cinema( 1 );
    level.player allowfire( 1 );
    thread player_grapple_check();
}

player_grapple_check()
{
    level waittill( "ready_hooks" );
    wait 1.5;
    level.player disableweapons();
    wait 0.25;

    if ( level.player getstance() != "stand" )
        level.player setstance( "stand" );

    var_0 = level.player getcurrentweapon();
    level.player.grapple["dist_max"] = 0;
    level.player maps\_grapple::grapple_give();
    level.player maps\_grapple::grapple_switch( var_0 != level.player.grapple["weapon"], 1, 0 );
    level.player disableweaponswitch();
    wait 0.25;
    level.player enableweapons();
    level.player hideviewmodel();
    var_1 = spawn( "script_model", ( 0, 0, 0 ) );
    var_1 hide();
    var_1 setmodel( "s1_gfl_ump45_viewhands_player" );
    var_1 linktoplayerview( level.player, "J_Elbow_LE", ( 0, 0, 0 ), ( 0, 0, 0 ), 1 );
    level notify( "start_grapplinghook_hud_gearup" );
    wait 0.5;
    var_1 show();
    level.player setviewmodel( "s1_gfl_ump45_viewhands" );
    level.player showviewmodel();
    level.player setviewmodelanim( "ie_intro_grapple_inspect_player" );
    thread maps\_trigger::spawneffectonplayerview( "ie_light_intro_dev" );
    level waittill( "grapple_check_bink_done" );
    thread maps\_trigger::stopeffectonplayerview( "ie_light_intro_dev" );
    level.player maps\_grapple::grapple_take();
    level.player switchtoweaponimmediate( var_0 );
    wait 0.25;
    level.player enableweaponswitch();
    level.player setviewmodel( "s1_gfl_ump45_viewhands" );
    var_1 delete();
    level.player.grapple["ammoCounterHide"] = 0;
    level.player maps\_grapple::grapple_give();
}

intro_bink()
{
    setsaveddvar( "cg_cinematicCanPause", "1" );
    cinematicingame( "grapplinghook_hud_gearup", 1 );
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    level waittill( "start_grapplinghook_hud_gearup" );
    pausecinematicingame( 0 );
    wait 0.05;
    wait 6;
    level notify( "grapple_check_bink_done" );
    setsaveddvar( "cg_cinematicCanPause", "0" );
}

intro_drone()
{
    var_0 = vehicle_scripts\_pdrone_security::drone_spawn_and_drive( "intro_drone" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::ent_flag_init( "intro_drone_path_end" );

    wait 6;
    common_scripts\utility::flag_set( "drone_passed" );

    foreach ( var_2 in var_0 )
    {
        var_2 maps\_utility::ent_flag_wait( "intro_drone_path_end" );
        var_2 delete();
    }
}

intro_allies()
{
    self.ignoreall = 1;
    maps\_utility::enable_cqbwalk();
    self setgoalpos( self.origin );

    if ( self.animname == "knox" )
        level.intro_anim_struct maps\_anim::anim_first_frame_solo( self, "ie_intro_idle" );
    else
        level.intro_anim_struct maps\_anim::anim_first_frame_solo( self, "ie_intro_ally" );

    wait 2;

    if ( self.animname == "knox" )
    {
        level.knox_pda = spawn( "script_model", ( 0, 0, 0 ) );
        level.knox_pda setmodel( "greece_drone_control_pad" );
        playfxontag( level._effect["ie_light_teal"], level.knox_pda, "tag_origin" );
        level.knox_pda linkto( self, "tag_weapon_chest", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.intro_anim_struct maps\_anim::anim_single_solo( self, "ie_intro_idle" );
        level.intro_anim_struct thread maps\_anim::anim_single_solo( self, "ie_intro_ally" );
        wait 9;
        soundscripts\_snd::snd_message( "aud_intro_foley" );

        if ( isdefined( level.knox_pda ) )
        {
            stopfxontag( level._effect["ie_light_teal"], level.knox_pda, "tag_origin" );
            level.knox_pda delete();
        }

        self waittillmatch( "single anim", "end" );
    }
    else
        level.intro_anim_struct maps\_anim::anim_single_solo( self, "ie_intro_ally" );

    if ( !common_scripts\utility::flag( "intro_end" ) )
        common_scripts\utility::flag_set( "intro_end" );
}

intro_vo()
{
    wait 5;
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_knoxitgoing" );
    wait 0.5;
    level.allies[2] maps\_utility::smart_dialogue( "ie_nox_donepatching" );
}
