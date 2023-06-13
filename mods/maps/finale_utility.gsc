// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

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

waittill_notify_func( var_0, var_1, var_2, var_3 )
{
    self waittill( var_0 );

    if ( isdefined( var_3 ) )
        self [[ var_1 ]]( var_2, var_3 );
    else if ( isdefined( var_2 ) )
        self [[ var_1 ]]( var_2 );
    else
        self [[ var_1 ]]();
}

player_animated_sequence_restrictions( var_0 )
{
    if ( isdefined( var_0 ) && var_0 )
        level.player waittill( "notify_player_animated_sequence_restrictions" );

    level.player.disablereload = 1;
    level.player disableweapons();
    level.player disableoffhandweapons();
    level.player disableweaponswitch();
    level.player allowcrouch( 0 );
    level.player allowjump( 0 );
    level.player allowmelee( 0 );
    level.player allowprone( 0 );
    level.player allowsprint( 0 );
}

load_mech()
{
    mech_player_anims();
    mech_generic_human();
    mech_script_models();
    mech_fx();
}

#using_animtree("player");

mech_player_anims()
{
    level.scr_animtree["mech_viewmodel"] = #animtree;
    level.scr_model["mech_viewmodel"] = "s1_gfl_ump45_viewhands_player";
    level.scr_anim["mech_viewmodel"]["mech_enable"] = %cap_playermech_getinto_mech_vm;
    maps\_anim::addnotetrack_notify( "mech_viewmodel", "enable_mech", "notify_mech_enable", "mech_enable" );
}

#using_animtree("generic_human");

mech_generic_human()
{
    level.scr_animtree["mech_player_rig"] = #animtree;
    level.scr_anim["mech_player_rig"]["mech_run_through"] = %cap_playermech_run_through_mech_short;
    level.scr_model["mech_player_rig"] = "worldhands_playermech";
    level.scr_animtree["mech_suit_top"] = #animtree;
    level.scr_model["mech_suit_top"] = "playermech_animated_model_top";
    level.scr_anim["mech_suit_top"]["mech_enable"] = %cap_playermech_getinto_mech_mech;
    level.scr_animtree["mech_suit_bottom"] = #animtree;
    level.scr_model["mech_suit_bottom"] = "playermech_animated_model_btm";
    level.scr_anim["mech_suit_bottom"]["mech_enable"] = %cap_playermech_getinto_mech_mech;
    level.scr_anim["generic"]["explode_death"] = %death_explosion_run_f_v2;
}

#using_animtree("script_model");

mech_script_models()
{
    level.scr_animtree["mb_wall_1"] = #animtree;
    level.scr_anim["mb_wall_1"]["mech_run_through"] = %cap_playermech_run_through_prop_short;
    level.scr_model["mb_wall_1"] = "cap_playermech_breakable_wall";
}

mech_fx()
{

}

mech_setup()
{
    setsaveddvar( "mechSpeed", 350 );
    setsaveddvar( "mechAcceleration", 3.25 );
    setsaveddvar( "mechAirAcceleration", 0.23 );
    setsaveddvar( "player_sprintSpeedScale", 1.6 );

    if ( level.player adsbuttonpressed() || getdvar( "quickmech" ) == "1" )
        thread mech_enable();
}

mech_enable( var_0, var_1 )
{
    level.damage_multiplier_mod = 0.13;
    level.mech_swarm_rocket_max_targets = 6;
    level.mech_swarm_rocket_dud_min_count = 2;
    level.mech_swarm_rocket_dud_max_count = 3;
    level.mech_swarm_skip_line_of_sight_obstruction_test = 0;
    level.player maps\_playermech_code::playermech_start( "base", var_1, var_0, "vm_view_arms_mech", "vm_view_arms_mech" );
    setsaveddvar( "mechStandHeight", 71 );
    setsaveddvar( "mechBarrelSpinAnim", "s1_playermech_barrel_spin" );
}

mech_enable_switch_exhaust_version( var_0, var_1 )
{
    level.player notify( "kill_think_player_blast_walk_anims" );
    level.player.blast_anim_set = undefined;
    level.player takeweapon( "playermech_auto_cannon_finale" );
    level.player giveweapon( "playermech_auto_cannon_finale" );
    level.player switchtoweaponimmediate( "playermech_auto_cannon_finale" );
    setsaveddvar( "mechBarrelSpinAnim", "s1_blast_gun_up_playermech_barrel_spin" );
    level.player.mechdata.weapon_names["mech_base_weapon"] = "playermech_auto_cannon_finale";
    level.player maps\_playermech_code::playermech_start( "base", var_0, var_1, "vm_view_arms_mech", "vm_view_arms_mech" );
}

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

screen_fade_out( var_0 )
{
    level notify( "new_screen_fade" );
    level endon( "new_screen_fade" );

    if ( !isdefined( var_0 ) )
        var_0 = 1.0;

    if ( !isdefined( level.black_screen ) )
        create_black_screen();

    setblur( 10, var_0 );

    if ( var_0 > 0 )
    {
        level.black_screen.alpha = 0;
        level.black_screen fadeovertime( var_0 );
    }

    level.black_screen.alpha = 1;
    wait(var_0);
}

screen_fade_in( var_0 )
{
    level notify( "new_screen_fade" );
    level endon( "new_screen_fade" );

    if ( !isdefined( var_0 ) )
        var_0 = 1.0;

    if ( !isdefined( level.black_screen ) )
        create_black_screen();

    setblur( 0, var_0 );

    if ( var_0 > 0 )
    {
        level.black_screen.alpha = 1;
        level.black_screen fadeovertime( var_0 );
    }

    level.black_screen.alpha = 0;
    wait(var_0);
}

create_black_screen()
{
    level.black_screen = newhudelem();
    level.black_screen.x = 0;
    level.black_screen.y = 0;
    level.black_screen.alpha = 0;
    level.black_screen.horzalign = "fullscreen";
    level.black_screen.vertalign = "fullscreen";
    level.black_screen.foreground = 1;
    level.black_screen setshader( "black", 640, 480 );
}

screen_fade( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1.0;

    if ( !isdefined( var_1 ) )
        var_1 = 1.0;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    thread screen_fade_out( var_0 );
    wait(var_2 + var_0);
    thread screen_fade_in( var_1 );
}

set_custom_patrol_anim_set( var_0 )
{
    set_custom_run_anim( var_0 );
    self allowedstances( "stand" );
    self.oldcombatmode = self.combatmode;
    self.combatmode = "no_cover";
    maps\_utility::disable_cqbwalk();
}

set_custom_run_anim( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;

    if ( isdefined( level.scr_anim["generic"]["patrol_walk_" + var_0] ) )
        var_1 = "patrol_walk_" + var_0;

    if ( isdefined( level.scr_anim["generic"]["patrol_walk_weights_" + var_0] ) )
        var_2 = "patrol_walk_weights_" + var_0;

    maps\_utility::set_generic_run_anim_array( var_1, var_2, 1 );

    if ( isdefined( level.scr_anim["generic"]["patrol_idle_" + var_0] ) )
    {
        var_3 = "patrol_idle_" + var_0;
        maps\_utility::set_generic_idle_anim( var_3 );
    }

    if ( isdefined( level.scr_anim["generic"]["patrol_transin_" + var_0] ) )
    {
        self.customarrivalfunc = ::custom_idle_trans_function;
        self.startidletransitionanim = level.scr_anim["generic"]["patrol_transin_" + var_0];
    }

    if ( isdefined( level.scr_anim["generic"]["patrol_transout_" + var_0] ) )
    {
        self.permanentcustommovetransition = 1;
        self.custommovetransition = animscripts\cover_arrival::custommovetransitionfunc;
        self.startmovetransitionanim = level.scr_anim["generic"]["patrol_transout_" + var_0];
    }
}

#using_animtree("generic_human");

custom_idle_trans_function()
{
    if ( !isdefined( self.startidletransitionanim ) )
        return;

    var_0 = self.approachnumber;
    var_1 = self.startidletransitionanim;

    if ( !isdefined( self.heat ) )
        thread animscripts\cover_arrival::abortapproachifthreatened();

    self clearanim( %body, 0.2 );
    self setflaggedanimrestart( "coverArrival", var_1, 1, 0.2, self.movetransitionrate );
    animscripts\face::playfacialanim( var_1, "run" );
    animscripts\shared::donotetracks( "coverArrival", animscripts\cover_arrival::handlestartaim );
    var_2 = anim.arrivalendstance[self.approachtype];

    if ( isdefined( var_2 ) )
        self.a.pose = var_2;

    self.a.movement = "stop";
    self.a.arrivaltype = self.approachtype;
    self clearanim( %root, 0.3 );
    self.lastapproachaborttime = undefined;
    var_3 = self.origin - self.goalpos;
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

angles_and_origin( var_0 )
{
    if ( isdefined( var_0.origin ) )
        self.origin = var_0.origin;

    if ( isdefined( var_0.angles ) )
        self.angles = var_0.angles;
}

spawn_tag_origin_monitor( var_0 )
{
    if ( !isdefined( level.monitored_tag_origins ) )
        level.monitored_tag_origins = [];

    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 angles_and_origin( self );

    if ( isdefined( var_0 ) )
        var_1.tag_idx = var_0;

    level.monitored_tag_origins[level.monitored_tag_origins.size] = var_1;
    level.monitored_tag_origins = common_scripts\utility::array_removeundefined( level.monitored_tag_origins );
    iprintln( level.monitored_tag_origins.size );
    return var_1;
}

mech_glass_damage_think( var_0 )
{
    level endon( var_0 );

    for (;;)
    {
        if ( isdefined( self ) )
            glassradiusdamage( self.origin, 72, 1000, 100 );

        wait 0.05;
    }
}

setstencilstate( var_0 )
{
    self hudoutlineenable( 6, 1 );
}

clearstencilstate()
{
    if ( isdefined( self ) )
    {
        self hudoutlinedisable();
        self hudoutlineenable( 0, 0 );
        self hudoutlinedisable();
        setsaveddvar( "r_hudoutlinewidth", 1 );
    }
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

enable_takedown_hint( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "enable_takedown_hint_called" );
    self endon( "enable_takedown_hint_called" );
    var_5 = undefined;
    var_6 = undefined;

    if ( isdefined( var_4 ) )
        var_6 = gettime() + var_4 * 1000;

    if ( isdefined( var_1 ) )
        var_5 = var_1 * var_1;

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
        if ( common_scripts\utility::flag( "flag_disable_takedown_hint" ) || isdefined( var_6 ) && gettime() > var_6 )
        {
            if ( level.melee_hint_displayed )
                level.should_display_melee_hint = 0;

            common_scripts\utility::flag_clear( "flag_disable_takedown_hint" );
            return;
        }

        var_7 = distance2dsquared( var_0.origin, level.player.origin );

        if ( level.melee_hint_displayed )
        {
            if ( isdefined( var_5 ) && var_7 > var_5 + 10 )
                level.should_display_melee_hint = 0;

            if ( isdefined( level._cloaked_stealth_settings ) && isdefined( level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim ) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1 )
                level.should_display_melee_hint = 0;

            if ( isdefined( var_2 ) && var_2 )
            {
                var_8 = var_0 geteye();
                var_9 = 0.9;

                if ( !level.player player_looking_in_direction_2d( var_8, var_9, 1 ) )
                    level.should_display_melee_hint = 0;
            }
        }
        else if ( !isdefined( var_5 ) || var_7 <= var_5 )
        {
            var_10 = 1;

            if ( isdefined( level._cloaked_stealth_settings ) && isdefined( level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim ) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1 )
                var_10 = 0;

            if ( isdefined( var_2 ) && var_2 )
            {
                var_8 = var_0 geteye();
                var_9 = 0.9;

                if ( !level.player player_looking_in_direction_2d( var_8, var_9, 1 ) )
                    var_10 = 0;
            }

            if ( var_10 )
            {
                level.should_display_melee_hint = 1;
                level.melee_hint_displayed = 1;
                level.player allowmelee( 0 );
                level.takedown_button = var_0 maps\_shg_utility::hint_button_tag( "melee", "J_SpineUpper" );
                maps\_utility::hintdisplaymintimehandler( "takedown_hint", undefined );
            }
        }

        wait 0.05;
    }

    self notify( "player_completed_takedown" );
    common_scripts\utility::flag_set( var_3 );
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

        if ( isdefined( level.takedown_button ) )
            level.takedown_button maps\_shg_utility::hint_button_clear();

        return 1;
    }

    return 0;
}

tackle_handle_hint_display()
{
    if ( common_scripts\utility::flag( "flag_balcony_tackle_too_late" ) || common_scripts\utility::flag( "flag_balcony_tackle_started" ) )
        return 1;

    return 0;
}

process_stab_finale_scene( var_0, var_1, var_2, var_3, var_4 )
{
    common_scripts\utility::flag_clear( "flag_stop_display_melee_hint" );
    level.player endon( "flag_stop_display_melee_hint" );
    common_scripts\utility::flag_clear( "flag_button_melee_success" );

    if ( !common_scripts\utility::flag_exist( "flag_final_melee_pressed" ) )
        common_scripts\utility::flag_init( "flag_final_melee_pressed" );

    common_scripts\utility::flag_clear( "flag_final_melee_pressed" );
    var_5 = 0;

    if ( isdefined( var_3 ) )
        wait(var_3);

    var_6 = var_0 maps\_shg_utility::hint_button_tag( "melee", var_1 );
    var_6.fontscale = 2;
    var_6 thread final_scene_handle_melee_hint();
    common_scripts\utility::flag_wait_or_timeout( "flag_final_melee_pressed", var_2 );

    if ( common_scripts\utility::flag( "flag_final_melee_pressed" ) )
    {
        if ( var_1 == "J_Wrist_RI" )
            soundscripts\_snd::snd_message( "finale_ending_qte1_success" );
        else
            soundscripts\_snd::snd_message( "finale_ending_qte2_success" );

        common_scripts\utility::flag_set( "flag_button_melee_success" );

        if ( isdefined( var_4 ) )
        {
            var_0 maps\_utility::anim_stopanimscripted();
            level.irons maps\_utility::anim_stopanimscripted();
        }
    }
    else if ( var_1 == "J_Wrist_RI" )
        soundscripts\_snd::snd_message( "finale_ending_qte1_timeout" );
    else
        soundscripts\_snd::snd_message( "finale_ending_qte2_timeout" );
}

final_scene_handle_melee_hint()
{
    var_0 = 0;
    common_scripts\utility::flag_clear( "flag_final_melee_pressed" );

    while ( !common_scripts\utility::flag( "flag_stop_display_melee_hint" ) )
    {
        if ( level.player meleebuttonpressed() )
        {
            if ( !common_scripts\utility::flag( "flag_stop_display_melee_hint" ) )
                common_scripts\utility::flag_set( "flag_final_melee_pressed" );

            break;
        }

        waitframe();
    }

    var_0 = 1;
    level.melee_hint_displayed = 0;

    if ( isdefined( self ) )
        maps\_shg_utility::hint_button_clear();
}

process_buttonmash_finale_scene( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "end_process_buttonmash" );
    common_scripts\utility::flag_clear( "flag_xbutton_mash_end" );
    level.player.buttonmash_decay_per_frame = 0.1;
    level.player.buttonmash_value = 0.0;
    level.player.buttonmash_add_per_press = 0.2;
    level.player notifyonplayercommand( "x_pressed", "+usereload" );
    level.player notifyonplayercommand( "x_pressed", "+activate" );
    var_0 thread maps\_shg_utility::hint_button_create_flashing( var_1, "x", "end_process_buttonmash", ( 0, 0, 0 ), 35, 300, 2 );
    var_4 = 0;
    var_5 = 30;

    while ( var_4 < var_5 )
    {
        if ( level.player usebuttonpressed() )
        {
            soundscripts\_snd::snd_message( "finale_ending_buttonmash_start" );
            break;
        }

        var_4 += 1;
        waitframe();
    }

    if ( var_4 >= var_5 )
        var_0 thread process_buttonmash_handle_fail( var_3 );

    childthread buttonmash_monitor( var_3, var_0 );
    common_scripts\utility::flag_wait( "flag_xbutton_mash_end" );
    level.player notifyonplayercommandremove( "x_pressed", "+usereload" );
    level.player notifyonplayercommandremove( "x_pressed", "+activate" );
    var_0 notify( "end_process_buttonmash" );
}

buttonmash_monitor( var_0, var_1 )
{
    level notify( "notify_buttonmash_monitor_reset" );
    level endon( "notify_buttonmash_monitor_reset" );
    level.player.buttonmash_value = 0;

    while ( !common_scripts\utility::flag( "flag_xbutton_mash_end" ) )
    {
        childthread buttonmash_decay( var_0, var_1 );
        level.player common_scripts\utility::waittill_any( "x_pressed", "b_pressed", "a_pressed" );
        level.player.buttonmash_value += level.player.buttonmash_add_per_press;
        waitframe();
    }

    level notify( "notify_buttonmash_decay_stop" );
}

buttonmash_decay( var_0, var_1 )
{
    level notify( "notify_buttonmash_decay_stop" );
    level endon( "notify_buttonmash_decay_stop" );
    var_2 = 0;
    var_3 = 30;

    while ( var_2 < var_3 )
    {
        if ( level.player.buttonmash_value > 0 )
            level.player.buttonmash_value -= level.player.buttonmash_decay_per_frame;

        var_2 += 1;
        waitframe();
    }

    var_1 thread process_buttonmash_handle_fail( var_0 );
}

process_buttonmash_handle_hint()
{
    if ( common_scripts\utility::flag( "flag_xbutton_mash_end" ) || common_scripts\utility::flag( "missionfailed" ) || level.player usebuttonpressed() )
        return 1;

    return 0;
}

process_buttonmash_handle_fail( var_0 )
{
    soundscripts\_snd::snd_message( "finale_ending_buttonmash_fail" );
    common_scripts\utility::flag_set( "flag_xbutton_mash_end" );
    level.player lightsetforplayer( "finale_hang_fail" );
    self notify( "end_process_buttonmash" );
    level notify( "audio_finale_qte_fail" );
    thread maps\finale_fx::vfx_irons_fail_fall();
    var_1 = [ self, level.irons ];
    var_0 maps\_anim::anim_single( var_1, "balcony_finale_pt3_fail" );
    setdvar( "ui_deadquote", "" );
    maps\_utility::missionfailedwrapper();
}

chase_timer_countdown( var_0, var_1 )
{
    level notify( "chase_timer_countdown_stop" );
    level endon( "chase_timer_countdown_stop" );
    common_scripts\utility::flag_wait_or_timeout( "flag_irons_escaped", var_0 );

    if ( var_1 == &"FINALE_FAILED_MISSILE_LAUNCH" )
    {
        level.player showhud();
        level.player setclientomnvar( "ui_playermech_hud", 0 );
        setsaveddvar( "cg_drawCrosshair", 0 );
    }

    setdvar( "ui_deadquote", var_1 );
    maps\_utility::missionfailedwrapper();
}

chase_timer_cancel()
{
    level notify( "chase_timer_countdown_stop" );
}

sprint_hint_reminder()
{
    while ( !common_scripts\utility::flag( "flag_player_passed_door" ) )
    {
        if ( !level.player issprinting() )
            thread maps\_utility::hintdisplayhandler( "player_input_sprint_hint" );

        waitframe();
    }
}

player_input_sprint()
{
    if ( level.player issprinting() || level.player issprintsliding() || common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    return 0;
}

player_chase_speed_control()
{
    level endon( "missionfailed" );
    var_0 = 1;
    var_1 = 0.8;
    var_2 = 0.5;
    level.too_close_distance = 180;
    var_3 = level.too_close_distance + 80;
    common_scripts\utility::flag_set( "flag_player_speed_control_on" );
    level.player setmovespeedscale( var_0 );

    while ( common_scripts\utility::flag( "flag_player_speed_control_on" ) )
    {
        if ( distance( level.player.origin, level.irons.origin ) < level.too_close_distance )
        {
            while ( var_0 >= var_1 && distance( level.player.origin, level.irons.origin ) < level.too_close_distance && common_scripts\utility::flag( "flag_player_speed_control_on" ) )
            {
                var_0 -= 0.05;
                level.player setmovespeedscale( var_0 );
                wait(var_2);
            }

            while ( distance( level.player.origin, level.irons.origin ) < var_3 && common_scripts\utility::flag( "flag_player_speed_control_on" ) )
                waitframe();

            while ( var_0 < 1 && distance( level.player.origin, level.irons.origin ) < level.too_close_distance & common_scripts\utility::flag( "flag_player_speed_control_on" ) )
            {
                var_0 += 0.05;
                level.player setmovespeedscale( var_0 );
                wait(var_2);
            }

            if ( var_0 > 1 )
            {
                var_0 = 1;
                level.player setmovespeedscale( var_0 );
            }
        }

        waitframe();
    }

    level.player setmovespeedscale( 1 );
}

lowering_door_think( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = getent( var_1, "targetname" );
    var_7 = getent( var_2, "targetname" );
    var_3 = getent( var_3, "targetname" );
    thread lowering_door_slide_hint();

    if ( isdefined( var_4 ) )
        common_scripts\utility::flag_wait( var_4 );

    var_7 linkto( var_6 );
    soundscripts\_snd::snd_message( "irons_chase_door_close", var_6 );
    var_6 move_door_to_position( var_3.origin, var_0, undefined, undefined, var_5 );

    if ( !common_scripts\utility::flag( "flag_player_passed_door" ) )
    {
        chase_timer_cancel();
        setdvar( "ui_deadquote", &"FINALE_FAILED_IRONS_CHASE" );
        maps\_utility::missionfailedwrapper();
    }
}

move_door_to_position( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );

    if ( isdefined( var_4 ) )
        var_4 = getent( var_4, "targetname" );

    var_5 = distance( var_0, self.origin );
    var_6 = 0;
    var_7 = self.origin;

    while ( var_6 < var_5 )
    {
        var_8 = getlerpfraction( self.origin, var_0, var_1, var_2 );

        if ( var_8 == 0 )
            break;

        self.origin = vectorlerp( self.origin, var_0, var_8 );

        if ( isdefined( var_3 ) )
            self.angles += var_3;

        var_6 = distance( self.origin, var_7 );

        if ( isdefined( var_4 ) )
        {
            var_9 = 0;

            while ( level.player istouching( var_4 ) )
            {
                var_9 += 1;

                if ( var_9 == 30 )
                {
                    level.player kill();
                    break;
                }

                waitframe();
            }
        }

        wait 0.05;
    }

    level notify( "lerp_complete" );
}

getlerpfraction( var_0, var_1, var_2, var_3 )
{
    var_4 = distance( var_0, var_1 );

    if ( var_2 == 0 || var_4 == 0 )
        return 0;

    var_5 = var_2 / var_4 * 0.05;

    if ( var_5 > 0 )
        return var_5;
    else
        return 0;
}

lowering_door_slide_hint()
{
    self notify( "slide_hint" );
    self endon( "slide_hint" );
    var_0 = getent( "vol_door_slide_reminder", "targetname" );

    while ( !common_scripts\utility::flag( "flag_player_passed_door" ) )
    {
        if ( level.player istouching( var_0 ) )
            thread maps\_utility::hintdisplayhandler( "player_input_slide_button" );

        waitframe();
    }
}

player_input_slide_under_door()
{
    if ( common_scripts\utility::flag( "flag_player_passed_door" ) || common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    return 0;
}

build_new_view_matrix( var_0 )
{
    var_1 = anglestoright( self.angles );
    var_2 = vectorcross( var_0, var_1 );
    var_3 = axistoangles( var_0, var_1, var_2 );
    return var_3;
}

get_goal_angles_ramped_given_viewdir( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = anglestoforward( var_0 );
    var_6 = 1.0;

    if ( gettime() < var_3 )
        var_6 = ( gettime() - var_2 ) / ( var_3 - var_2 );

    if ( isdefined( var_4 ) && var_6 > var_4 )
        var_6 = var_4;

    var_7 = 1.0 - var_6;
    var_1 = var_6 * var_1 + var_7 * var_5;
    var_8 = build_new_view_matrix( var_1 );
    return var_8;
}

rotate_camera_to_see_ent( var_0, var_1, var_2, var_3 )
{
    self.target_entity = var_0;
    var_4 = self.target_entity.origin - self.origin;
    var_5 = vectornormalize( var_4 );
    rotate_camera_to_internal( var_5, var_1, var_2, 1, var_3 );
}

rotate_camera_to_offset_angles( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = ( var_0, var_1, var_2 );
    var_6 = combineangles( self.angles, var_5 );
    var_7 = anglestoforward( var_6 );
    var_7 = vectornormalize( var_7 );
    rotate_camera_to_internal( var_7, var_3, var_4 );
}

rotate_camera_to_match_ent( var_0, var_1, var_2 )
{
    var_3 = anglestoforward( var_0.angles );
    var_4 = vectornormalize( var_3 );
    rotate_camera_to_internal( var_4, var_1, var_2, 1 );
}

rotate_camera_to_internal( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = self.angles;
    var_6 = gettime();
    var_7 = gettime() + var_2 * 1000;
    var_8 = gettime() + var_1 * 1000;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    while ( gettime() <= var_8 )
    {
        var_9 = get_goal_angles_ramped_given_viewdir( var_5, var_0, var_6, var_7, var_4 );
        iprintln( var_9 );
        self unlink();
        self.angles = var_9;
        self linkto( level.player.drivingvehicle );
        thread maps\_shg_debug::draw_axis( self.origin, var_9, 10 );
        waitframe();

        if ( var_3 )
        {
            var_10 = self.target_entity.origin - self.origin;
            var_0 = vectornormalize( var_10 );
        }
    }
}

camera_sway_tuning()
{
    level.values[0] = 0.2;
    level.values[1] = 4.1;
    level.values[2] = 0.56;
    level.values[3] = 2;
    level.values[4] = 0.95;
    level.values[5] = 0;
    level.values[6] = 0;
    level.values[7] = 0.4;
    level.values[8] = 0.1;
    level.values[9] = 0.1;
    var_0[0] = "scalePitch";
    var_0[1] = "scaleyaw";
    var_0[2] = "scaleroll";
    var_0[3] = "duration";
    var_0[4] = "durationfadeup";
    var_0[5] = "durationfadedown";
    var_0[6] = "radius";
    var_0[7] = "frequencypitch";
    var_0[8] = "frequencyyaw";
    var_0[9] = "frequencyroll";
    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        if ( level.player buttonpressed( "DPAD_LEFT" ) )
        {
            var_1++;

            if ( var_1 >= var_0.size )
                var_1 = 0;

            var_2 = 1;
            wait 0.5;
        }
        else if ( level.player buttonpressed( "DPAD_RIGHT" ) )
        {
            var_1--;

            if ( var_1 < 0 )
                var_1 = var_0.size - 1;

            var_2 = 1;
            wait 0.5;
        }
        else if ( level.player buttonpressed( "DPAD_UP" ) )
        {
            level.values[var_1] += 0.05;
            var_2 = 1;
        }
        else if ( level.player buttonpressed( "DPAD_DOWN" ) )
        {
            level.values[var_1] -= 0.05;
            var_2 = 1;
        }

        if ( var_2 )
        {
            var_3 = var_0[var_1] + "(" + level.values[var_1] + ") ";
            iprintln( var_3 );
            var_2 = 0;
        }

        waitframe();
    }
}

boat_bobbing_think( var_0 )
{
    level endon( "boat_scene_cleanup" );
    self endon( "death" );

    if ( !isdefined( var_0 ) )
    {
        var_0 = common_scripts\utility::get_target_ent();
        var_0 linkto( self );
    }

    maps\_utility::ent_flag_init( "flag_big_bobbing" );

    for (;;)
    {
        var_1 = boat_scene_small_bob_settings();
        maps\_bobbing_boats::prep_bobbing( [ self ], maps\_bobbing_boats::bobbingobject, var_1, 0 );
        thread maps\_bobbing_boats::start_bobbing_single( randomfloatrange( 0.0, 1.0 ) );
        maps\_utility::ent_flag_wait( "flag_big_bobbing" );
        var_1 = boat_scene_big_bob_settings();
        maps\_bobbing_boats::prep_bobbing( [ self ], maps\_bobbing_boats::bobbingobject, var_1, 0 );
        thread maps\_bobbing_boats::start_bobbing_single( randomfloatrange( 0.0, 1.0 ) );
        maps\_utility::ent_flag_waitopen( "flag_big_bobbing" );
    }
}

boat_scene_small_bob_settings()
{
    var_0 = spawnstruct();
    var_0.max_pitch = 3;
    var_0.min_pitch_period = 3;
    var_0.max_pitch_period = 6;
    var_0.max_yaw = 6;
    var_0.min_yaw_period = 3;
    var_0.max_yaw_period = 6;
    var_0.max_roll = 6;
    var_0.min_roll_period = 3;
    var_0.max_roll_period = 6;
    var_0.max_sink = 4;
    var_0.max_float = 6;
    var_0.min_bob_period = 2;
    var_0.max_bob_period = 4;
    return var_0;
}

boat_scene_big_bob_settings()
{
    var_0 = spawnstruct();
    var_0.max_pitch = 3;
    var_0.min_pitch_period = 3;
    var_0.max_pitch_period = 6;
    var_0.max_yaw = 0;
    var_0.min_yaw_period = 3;
    var_0.max_yaw_period = 6;
    var_0.max_roll = 6;
    var_0.min_roll_period = 3;
    var_0.max_roll_period = 6;
    var_0.max_sink = 36;
    var_0.max_float = 24;
    var_0.min_bob_period = 3;
    var_0.max_bob_period = 6;
    return var_0;
}

postspawn_rpg_vehicle()
{
    self setmodel( "projectile_rpg7" );
    var_0 = common_scripts\utility::getfx( "rpg_trail" );
    playfxontag( var_0, self, "tag_origin" );
    var_0 = common_scripts\utility::getfx( "rpg_muzzle" );
    playfxontag( var_0, self, "tag_origin" );
    self playsound( "weap_rpg_fire_npc" );

    if ( isdefined( self.script_sound ) )
    {
        if ( isdefined( self.script_wait ) )
            common_scripts\utility::delaycall( self.script_wait, ::playsound, self.script_sound );
        else
            self playsound( self.script_sound );
    }
    else
        self playloopsound( "weap_rpg_loop" );

    self waittill( "reached_end_node" );
    self notify( "explode", self.origin );
    var_1 = 0;

    if ( isdefined( self.currentnode ) )
    {
        var_2 = undefined;

        for ( var_3 = self.currentnode; isdefined( var_3 ); var_3 = getvehiclenode( var_3.target, "targetname" ) )
        {
            var_2 = var_3;

            if ( !isdefined( var_3.target ) )
                break;
        }

        if ( isdefined( var_2.target ) )
        {
            var_4 = common_scripts\utility::getstruct( var_2.target, "targetname" );

            if ( isdefined( var_4 ) )
            {
                level thread rpg_explosion( var_4.origin, var_4.angles );
                var_1 = 1;
            }
        }
    }

    if ( !var_1 )
    {
        var_4 = spawnstruct();
        var_4.origin = self.origin;
        var_4.angles = ( -90, 0, 0 );
        level thread rpg_explosion( var_4.origin, var_4.angles );
    }

    self delete();
}

rpg_explosion( var_0, var_1 )
{
    var_2 = common_scripts\utility::getfx( "rpg_explode" );
    playfx( var_2, var_0, anglestoforward( var_1 ), anglestoup( var_1 ) );
    radiusdamage( var_0, 200, 150, 50 );
    thread common_scripts\utility::play_sound_in_space( "null", var_0 );
}

combat_silo_seeker_ai()
{
    var_0 = 2;
    var_1 = [];

    for (;;)
    {
        var_2 = getaiarray( "axis" );
        var_3 = [];

        foreach ( var_5 in var_2 )
        {
            if ( issubstr( var_5.classname, "mech" ) )
                var_3[var_3.size] = var_5;
        }

        waitframe();
        var_1 = [];

        for ( var_7 = 0; var_7 < var_0; var_7++ )
        {
            if ( var_3.size > var_7 )
            {
                var_5 = maps\_utility::get_closest_living( level.player.origin, var_3 );

                if ( isalive( var_5 ) )
                {
                    if ( isdefined( var_5.magic_bullet_shield ) )
                        var_5 maps\_utility::stop_magic_bullet_shield();

                    var_5.playerseeker = 1;
                    var_5 cleargoalvolume();
                    var_5 thread maps\_utility::player_seek();
                    var_5.favoriteenemy = level.player;
                    var_1[var_1.size] = var_5;
                }
            }
        }

        if ( var_1.size > 0 )
            maps\_utility::array_wait( var_1, "death" );

        wait 2;
    }

    foreach ( var_9 in var_1 )
    {
        if ( isalive( var_9 ) )
            var_9 notify( "goal" );
    }
}

murder_player_seek()
{
    self cleargoalvolume();
    self.favoriteenemy = level.player;
    maps\_utility::set_baseaccuracy( 999 );
    self setgoalentity( level.player );
    self.goalradius = 20;
    self.combatmode = "no_cover";
    self notify( "end_patrol" );
    level.player enablehealthshield( 0 );
}

get_follow_volume_array()
{
    var_0 = getent( "info_v_silo_top", "targetname" );
    var_1 = getent( "info_v_silo_bottom", "targetname" );
    var_2 = [ var_0, var_1 ];
    level.player.follow_volume_designated_head_top = var_0;
    level.player.follow_volume_designated_head_bottom = var_1;
    var_3 = var_2;

    foreach ( var_5 in var_2 )
    {
        for ( var_6 = var_5; isdefined( var_6.target ) && isdefined( getent( var_6.target, "targetname" ) ); var_6 = var_7 )
        {
            var_7 = getent( var_6.target, "targetname" );
            var_3[var_3.size] = var_7;
        }
    }

    return var_3;
}

get_opposite_volume( var_0 )
{
    var_1 = undefined;

    if ( isdefined( var_0.script_linkto ) )
        var_1 = getent( var_0.script_linkto, "script_linkname" );
    else if ( isdefined( var_0.script_linkname ) )
    {
        foreach ( var_3 in level.player.follow_volume_array )
        {
            if ( isdefined( var_3.script_linkto ) && var_3.script_linkto == var_0.script_linkname )
            {
                var_1 = var_3;
                break;
            }
        }
    }

    if ( !isdefined( var_1 ) )
        var_1 = "opposite not found";

    return var_1;
}

player_follow_volume_think()
{
    self endon( "kill_player_follow_volume_think" );
    self endon( "death" );
    self.match_player_floor_percent = 0.75;
    self.follow_volume_array = get_follow_volume_array();
    level.player.follow_volume_maintain_count = 0;
    var_0 = 0;

    for (;;)
    {
        var_1 = get_non_mech_enemies();
        var_2 = 0;
        var_3 = 0;

        if ( var_0 != var_1.size )
        {
            if ( var_1.size <= 3 )
                var_2 = 1;

            if ( var_0 <= 3 && var_1.size > 3 )
                var_3 = 1;
        }

        foreach ( var_5 in self.follow_volume_array )
        {
            if ( ( !isdefined( self.follow_volume ) || var_2 || var_3 || self.follow_volume != var_5 ) && self istouching( var_5 ) )
            {
                if ( var_2 )
                    self.match_player_floor_percent = 1.0;
                else if ( !isdefined( self.follow_volume ) )
                    self.match_player_floor_percent = 0.75;
                else
                    self.match_player_floor_percent = 0.75;

                self.follow_volume = var_5;

                if ( !isdefined( var_5.target ) )
                    self.follow_volume_target = self.follow_volume;
                else
                    self.follow_volume_target = getent( var_5.target, "targetname" );

                self.follow_volume_target_opposite = get_opposite_volume( self.follow_volume_target );

                foreach ( var_7 in var_1 )
                    var_7.follow_volume = undefined;

                level.player.follow_volume_maintain_count = 0;

                if ( !isdefined( self.follow_volume_target ) )
                    self.follow_volume_target = self.follow_volume;

                break;
            }
        }

        var_0 = var_1.size;
        waitframe();
    }
}

get_non_mech_enemies()
{
    var_0 = getaiarray( "axis" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( var_3.classname != "actor_enemy_mech" )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

is_goal_blocked( var_0 )
{
    if ( isdefined( var_0.script_flag_true ) && !common_scripts\utility::flag( var_0.script_flag_true ) )
        return 1;
    else
        return 0;
}

move_guy( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
    {
        var_2 = undefined;
        var_0 = level.player.follow_volume_designated_head_top;
        var_1 = level.player.follow_volume_designated_head_bottom;
    }

    [var_4, var_5] = get_floor_count_array();
    var_6 = 0;

    if ( var_4 + var_5 > 0 )
        var_6 = var_4 / ( var_4 + var_5 );

    var_7 = undefined;
    var_8 = undefined;

    if ( var_6 <= level.player.match_player_floor_percent )
    {
        var_7 = var_0;
        var_8 = 1;
    }
    else
    {
        var_7 = var_1;
        var_8 = 2;
    }

    if ( is_goal_blocked( var_7 ) )
    {
        if ( isstring( var_7 ) || !isdefined( var_7 ) )
        {
            self.follow_volume = "opposite not found";
            return 0;
        }

        if ( var_7 == var_0 )
        {
            var_7 = var_2;
            var_8 = 3;
        }
        else
        {
            var_7 = get_opposite_volume( var_2 );
            var_8 = 4;
        }
    }

    self cleargoalvolume();
    self.goalradius = 256;
    self setgoalvolumeauto( var_7 );
    self.follow_volume = var_7;
    return var_8;
}

follow_volume_think()
{
    self endon( "death" );

    if ( self.classname == "actor_enemy_mech" )
        return;

    thread death_watcher();
    self.follow_volume_status = 0;

    if ( 1 )
        self.follow_volume_status = move_guy( level.player.follow_volume_target, level.player.follow_volume_target_opposite, level.player.follow_volume );

    for (;;)
    {
        if ( !has_target_volume() )
            self.follow_volume_status = move_guy( level.player.follow_volume_target, level.player.follow_volume_target_opposite, level.player.follow_volume );
        else if ( 1 && level.player.follow_volume_maintain_count > 0 && check_move_me_to_maintain_ratio() )
        {
            level.player.follow_volume_maintain_count--;
            self.follow_volume_status = move_guy( level.player.follow_volume_target, level.player.follow_volume_target_opposite, level.player.follow_volume );
        }
        else if ( is_guy_follow_status_blocked() )
        {
            if ( !is_goal_blocked( self.follow_volume ) )
            {
                var_0 = getent( self.follow_volume.target, "targetname" );
                var_1 = get_opposite_volume( var_0 );
                self.follow_volume_status = move_guy( var_0, var_1, self.follow_volume );
            }
        }

        wait(randomfloatrange( 1.0, 5.0 ));
    }
}

death_watcher()
{
    self waittill( "death" );

    if ( isdefined( self.follow_volume ) && !isstring( self.follow_volume ) )
        level.player.follow_volume_maintain_count++;
}

check_move_me_to_maintain_ratio()
{
    if ( !1 )
        return 0;

    [var_1, var_2] = get_floor_count_array();
    var_3 = 0;

    if ( var_1 + var_2 > 0 )
        var_3 = var_1 / ( var_1 + var_2 );

    if ( var_3 <= level.player.match_player_floor_percent )
    {
        if ( self.follow_volume_status != 1 && self.follow_volume_status != 3 )
            return 1;
    }
    else if ( self.follow_volume_status != 2 && self.follow_volume_status != 4 )
        return 1;

    return 0;
}

has_target_volume()
{
    if ( isdefined( self.follow_volume ) )
        return 1;
    else
        return 0;
}

is_guy_follow_status_blocked()
{
    return self.follow_volume_status == 3 || self.follow_volume_status == 4;
}

get_floor_count_array()
{
    var_0 = 0;
    var_1 = 0;
    var_2 = getaiarray( "axis" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4.follow_volume ) && isdefined( var_4.follow_volume_status ) && ( var_4.follow_volume_status == 1 || var_4.follow_volume_status == 3 ) )
            var_0++;

        if ( isdefined( var_4.follow_volume ) && isdefined( var_4.follow_volume_status ) && ( var_4.follow_volume_status == 2 || var_4.follow_volume_status == 4 ) )
            var_1++;
    }

    return [ var_0, var_1 ];
}

set_level_player_rumble_ent_intensity( var_0 )
{
    if ( !isdefined( level.rumble_ent ) )
        level.rumble_ent = maps\_utility::get_rumble_ent( "steady_rumble", 0.0 );

    if ( isdefined( var_0 ) )
        level.rumble_ent.intensity = var_0;
    else
        level.rumble_ent.intensity = 0.0;

    level.rumble_ent.base_intensity = level.rumble_ent.intensity;
}

set_level_player_rumble_ent_intensity_for_time( var_0, var_1 )
{
    if ( !isdefined( level.rumble_ent ) )
        level.rumble_ent = maps\_utility::get_rumble_ent( "steady_rumble", 0.0 );

    if ( !isdefined( level.rumble_ent.base_intensity ) )
        level.rumble_ent.base_intensity = 0.0;

    if ( isdefined( var_0 ) )
        level.rumble_ent.intensity = var_0;
    else
        level.rumble_ent.intensity = 0.0;

    if ( isdefined( var_1 ) )
        wait(var_1);
    else
        wait 0.25;

    level.rumble_ent.intensity = level.rumble_ent.base_intensity;
}

get_closest_point_on_segment( var_0, var_1, var_2 )
{
    return get_closest_point_from_segment_to_segment( var_0, var_0, var_1, var_2 );
}

get_closest_point_from_segment_to_segment( var_0, var_1, var_2, var_3 )
{
    var_4 = 0.001;
    var_5 = undefined;
    var_6 = var_1 - var_0;
    var_7 = var_3 - var_2;
    var_8 = var_0 - var_2;
    var_9 = vectordot( var_6, var_6 );
    var_10 = vectordot( var_7, var_7 );
    var_11 = vectordot( var_7, var_8 );
    var_12 = 0;

    if ( var_9 <= var_4 && var_10 <= var_4 )
    {
        var_5 = 0;
        var_13 = 0;
        var_14 = var_0;
        var_15 = var_2;
        return [ var_5, vectordot( var_14 - var_15, var_14 - var_15 ), var_14, var_15 ];
    }

    if ( var_9 <= var_4 )
    {
        var_5 = 0;
        var_13 = var_11 / var_10;
        var_13 = clamp( var_13, 0, 1 );
    }
    else
    {
        var_16 = vectordot( var_6, var_8 );

        if ( var_10 <= var_4 )
        {
            var_13 = 0;
            var_5 = clamp( -1 * var_16 / var_9, 0, 1 );
        }
        else
        {
            var_17 = vectordot( var_6, var_7 );
            var_18 = var_9 * var_10 - var_17 * var_17;

            if ( var_18 != 0 )
                var_5 = clamp( ( var_17 * var_11 - var_16 * var_10 ) / var_18, 0, 1 );
            else
                var_5 = 0;

            var_13 = ( var_17 * var_5 + var_11 ) / var_10;

            if ( var_13 < 0 )
            {
                var_13 = 0;
                var_5 = clamp( -1 * var_16 / var_9, 0, 1 );
            }
            else if ( var_13 > 1 )
            {
                var_13 = 1;
                var_5 = clamp( ( var_17 - var_16 ) / var_9, 0, 1 );
            }
        }
    }

    var_14 = var_0 + var_6 * var_5;
    var_15 = var_2 + var_7 * var_13;
    return [ var_13, vectordot( var_14 - var_15, var_14 - var_15 ), var_14, var_15 ];
}
