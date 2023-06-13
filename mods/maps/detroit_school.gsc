// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

school_main()
{
    common_scripts\utility::flag_init( "hazmat_creeps_reload_ok" );
    common_scripts\utility::flag_init( "ok_to_wall_pull" );
    common_scripts\utility::flag_init( "_stealth_enabled" );
    common_scripts\utility::flag_init( "special_kva_alerted" );
    school_animated_fences();
    thread setup_school();
    thread audio_stingers_school_bodies_room();
    thread enable_school_trains();

    if ( level.currentgen )
    {
        cg_school_entrance_doors_init();
        thread transient_middle_remove_school_interior_begin();
        thread cg_setup_school_entrance_doors_startpoints();
    }
}

cg_school_entrance_doors_init()
{
    var_0 = getent( "det_school_entrance_door_r", "targetname" );
    var_0.coll = getent( "det_school_entrance_door_r_coll", "targetname" );
    var_0.coll linkto( var_0 );
    var_0.closed_angles = var_0.angles;
    var_0.open_angles = var_0.closed_angles + ( 0, 90, 0 );
    var_1 = getent( "det_school_entrance_door_l", "targetname" );
    var_1.coll = getent( "det_school_entrance_door_l_coll", "targetname" );
    var_1.coll linkto( var_1 );
    var_1.closed_angles = var_1.angles;
    var_1.open_angles = var_1.closed_angles - ( 0, 90, 0 );
}

cg_open_close_school_entrance_doors( var_0 )
{
    if ( level.currentgen )
    {
        var_1 = getent( "det_school_entrance_door_r", "targetname" );
        var_2 = getent( "det_school_entrance_door_l", "targetname" );

        if ( var_0 )
        {
            var_1.coll connectpaths();
            var_1 rotateto( var_1.open_angles, 1.0, 0.5, 0.25 );
            var_2.coll connectpaths();
            var_2 rotateto( var_2.open_angles, 1.0, 0.5, 0.25 );
        }
        else
        {
            var_1 rotateto( var_1.closed_angles, 1.0, 0.5, 0.25 );
            var_1.coll disconnectpaths();
            var_2 rotateto( var_2.closed_angles, 1.0, 0.5, 0.25 );
            var_2.coll disconnectpaths();
        }
    }
}

cg_setup_school_entrance_doors_startpoints()
{
    if ( level.currentgen && issubstr( level.transient_zone, "school" ) )
        cg_open_close_school_entrance_doors( 1 );
    else if ( level.currentgen && issubstr( level.transient_zone, "hospital" ) )
        cg_open_close_school_entrance_doors( 0 );
}

transient_middle_add_school_interior_begin()
{
    level notify( "tff_pre_middle_remove_gatetrans" );

    if ( !istransientloaded( "detroit_school_interior_tr" ) )
    {
        unloadtransient( "detroit_gatetrans_tr" );
        loadtransient( "detroit_school_interior_tr" );
    }

    for (;;)
    {
        if ( istransientloaded( "detroit_school_interior_tr" ) )
        {
            level notify( "tff_post_middle_add_school" );
            break;
        }

        wait 0.05;
    }

    cg_open_close_school_entrance_doors( 1 );
}

transient_middle_remove_school_interior_begin()
{
    maps\_utility::trigger_wait_targetname( "CG_UnloadSchoolInteriorTrigger" );
    level notify( "tff_pre_middle_remove_school" );
    unloadtransient( "detroit_school_interior_tr" );

    for (;;)
    {
        if ( !istransientloaded( "detroit_school_interior_tr" ) )
        {
            level notify( "tff_post_middle_remove_school" );
            break;
        }

        wait 0.05;
    }

    thread transient_middle_add_nighclub_interior_begin();
}

transient_middle_add_nighclub_interior_begin()
{
    loadtransient( "detroit_nightclub_interior_tr" );

    for (;;)
    {
        if ( istransientloaded( "detroit_nightclub_interior_tr" ) )
        {
            var_0 = getent( "office_interior_model", "targetname" );
            var_0 setcontents( 0 );
            var_0 hide();
            level notify( "tff_post_middle_add_nightclub" );
            break;
        }

        wait 0.05;
    }
}

school_animated_fences()
{
    if ( !isdefined( level.bones_fence ) )
    {
        var_0 = getent( "actual_dismount_animation_origin", "targetname" );
        level.bones_fence = maps\_utility::spawn_anim_model( "bones_fence" );
        level.joker_fence = maps\_utility::spawn_anim_model( "joker_fence" );
        level.bones_fence.animname = "bones_fence";
        level.joker_fence.animname = "joker_fence";
        var_0 thread maps\_anim::anim_first_frame_solo( level.bones_fence, "bike_dismount" );
        var_0 thread maps\_anim::anim_first_frame_solo( level.joker_fence, "bike_dismount" );
        var_1 = common_scripts\utility::getstruct( "school_origin_02", "targetname" );
        level.bones_fence overridelightingorigin( var_1.origin );
        level.joker_fence overridelightingorigin( var_1.origin );
    }
}

player_exiting()
{
    level endon( "player_linked" );
    maps\_utility::trigger_wait_targetname( "player_trying_to_exit_garage" );
    maps\_player_death::set_deadquote( &"DETROIT_OBJECTIVE_FAIL_JETBIKE" );
    maps\_utility::missionfailedwrapper();
}

debug_stealth_type()
{
    for (;;)
        level waittill( "event_awareness", var_0 );
}

setup_school_stealth()
{
    while ( !isdefined( level.burke ) )
        waitframe();

    level.burke.ignoreme = 1;
    stealth_reset_awareness();
}

stealth_reset_awareness()
{
    var_0 = level._stealth.group.groups;

    foreach ( var_7, var_2 in var_0 )
    {
        var_3 = maps\_stealth_shared_utilities::group_get_ai_in_group( var_7 );

        foreach ( var_5 in var_3 )
        {
            if ( var_5 maps\_utility::ent_flag_exist( "_stealth_normal" ) && !var_5 maps\_utility::ent_flag( "_stealth_normal" ) )
                var_5 maps\_utility::ent_flag_set( "_stealth_normal" );
        }
    }
}

school_funtions_to_load()
{
    thread burke_path_to_school();
    thread setup_school_bodies();
    thread burke_deadroom_door();
    thread teleport_burke_to_alley();
}

busted_light_gag()
{
    var_0 = getent( "busted_light_gag_animorg", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "working_light", var_0.origin );
    var_2 = maps\_utility::spawn_anim_model( "busted_light", var_0.origin );
    var_2 hide();
    var_0 maps\_anim::anim_first_frame_solo( var_1, "busted_light_gag" );
    var_0 maps\_anim::anim_first_frame_solo( var_2, "busted_light_gag" );
    thread maps\detroit_lighting::hallway_light_scare();
    maps\_utility::trigger_wait_targetname( "tile_fall" );
    var_1 delete();
    var_2 show();
    var_0 thread maps\_anim::anim_single_solo( var_2, "busted_light_gag" );
    playfxontag( common_scripts\utility::getfx( "fluorecent_bulb_pop" ), var_2, "tag_fx" );
    var_2 soundscripts\_snd::snd_message( "horror_fluorescent_break" );
    wait 0.5;
    common_scripts\utility::flag_set( "vo_school_light_burst_dialogue" );
}

play_garage_bike_dismount( var_0, var_1, var_2, var_3 )
{
    var_4 = [ var_0, var_1, var_2 ];

    foreach ( var_6 in var_4 )
        var_6 vehphys_disablecrashing();

    thread burke_dismount( var_0, var_1, var_2 );
    thread bones_dismount( var_1 );
    thread joker_dismount( var_2 );
    thread player_dismount_newbike( var_3 );
}

flag_wait_bones()
{
    common_scripts\utility::flag_wait( "begin_bike_dismount_bones" );
    iprintlnbold( "bones dismount flag called" );
}

flag_wait_joker()
{
    common_scripts\utility::flag_wait( "begin_bike_dismount_joker" );
    iprintlnbold( "joker dismount flag called" );
}

flag_wait_burke()
{
    common_scripts\utility::flag_wait( "begin_bike_dismount_burke" );
    iprintlnbold( "burke dismount flag called" );
}

swap_bike_to_static()
{
    common_scripts\utility::flag_wait( "school_player_falling" );
    level notify( "stop_tracking_backtrack" );
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0 setmodel( "vehicle_mil_hoverbike_parked_static" );
    self delete();
    common_scripts\utility::flag_wait( "exit_drive_cinematic_start" );
    var_0 delete();
}

burke_dismount( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_wait( "begin_bike_dismount_burke" );
    var_0 maps\detroit_jetbike::vehicle_rubberband_stop();
    var_3 = getent( "actual_dismount_animation_origin", "targetname" );
    thread intro_dialogue();
    thread maps\detroit_lighting::jetbike_dismount_red_light();
    thread burke_move_ahead_wait_function();
    var_0.animname = "burke_bike";
    var_0 maps\detroit_jetbike::vehicle_rubberband_stop();
    vehicle_scripts\_jetbike::smooth_vehicle_animation_wait( var_0, var_3, "bike_dismount", 13.1695 );
    level.burke unlink();
    level.burke maps\_vehicle_aianim::disassociate_guy_from_vehicle();
    var_0 maps\_utility::delaythread( 5, vehicle_scripts\_jetbike::jetbike_stop_hovering_now );
    maps\_utility::delaythread( 7.5, common_scripts\utility::flag_set, "school_trains" );
    var_0 overridematerialreset();
    var_1 overridematerialreset();
    var_2 overridematerialreset();
    thread vehicle_scripts\_jetbike::smooth_vehicle_animation_play( var_0, var_3, "bike_dismount", [ level.burke ], 1, 2 );
    thread burke_dismount_timing_fix();
    wait(getanimlength( level.scr_anim["burke"]["bike_dismount"] ));
    var_3 thread maps\_anim::anim_loop_solo( level.burke, "dismount_idle", "burke_stop_idle" );
    var_0 thread swap_bike_to_static();
    var_3 notify( "burke_stop_idle" );

    if ( level.nextgen )
    {

    }

    var_3 maps\_anim::anim_single_solo( level.burke, "dismount_rollout" );
    level.burke maps\_utility::set_generic_run_anim( "stealth_walk", 0 );
    school_funtions_to_load();
}

burke_dismount_timing_fix()
{
    wait 7.9;
    common_scripts\utility::flag_set( "vo_school_exterior" );
}

burke_move_ahead_wait_function()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "ride_finished" );
    common_scripts\utility::flag_set( "player_has_dismounted_and_moved_ahead" );
}

bones_dismount( var_0 )
{
    common_scripts\utility::flag_wait_any( "begin_bike_dismount_bones", "begin_playing_player_dismount_anim" );
    var_0 maps\detroit_jetbike::vehicle_rubberband_stop();
    var_1 = getent( "actual_dismount_animation_origin", "targetname" );
    var_0.animname = "bones_bike";
    var_0 maps\detroit_jetbike::vehicle_rubberband_stop();
    vehicle_scripts\_jetbike::smooth_vehicle_animation_wait( var_0, var_1, "bike_dismount", 7.51324 );
    level.bones unlink();
    level.bones maps\_vehicle_aianim::disassociate_guy_from_vehicle();
    var_0 maps\_utility::delaythread( 5, vehicle_scripts\_jetbike::jetbike_stop_hovering_now );
    vehicle_scripts\_jetbike::smooth_vehicle_animation_play( var_0, var_1, "bike_dismount", [ level.bones, level.bones_fence ], 1, 2 );
    var_0 thread swap_bike_to_static();
    var_2 = getnode( "bones_hide_spot", "targetname" );
    level.bones setgoalnode( var_2 );
    level.bones.goalradius = 15;
    level.bones waittill( "goal" );
    level.bones delete();
}

joker_dismount( var_0 )
{
    common_scripts\utility::flag_wait( "begin_bike_dismount_joker" );
    var_0 maps\detroit_jetbike::vehicle_rubberband_stop();
    var_1 = getent( "actual_dismount_animation_origin", "targetname" );
    var_0.animname = "joker_bike";
    var_0 maps\detroit_jetbike::vehicle_rubberband_stop();
    vehicle_scripts\_jetbike::smooth_vehicle_animation_wait( var_0, var_1, "bike_dismount", 12.7558 );
    level.joker unlink();
    level.joker maps\_vehicle_aianim::disassociate_guy_from_vehicle();
    var_0 maps\_utility::delaythread( 5, vehicle_scripts\_jetbike::jetbike_stop_hovering_now );
    vehicle_scripts\_jetbike::smooth_vehicle_animation_play( var_0, var_1, "bike_dismount", [ level.joker, level.joker_fence ], 1, 2 );
    var_0 thread swap_bike_to_static();
    var_2 = getnode( "joker_hide_spot", "targetname" );
    level.joker setgoalnode( var_2 );
    level.joker.goalradius = 15;
    level.joker waittill( "goal" );
    level.joker delete();
}

player_dismount()
{
    common_scripts\utility::flag_wait( "begin_bike_dismount_player" );
    var_0 = getent( "actual_dismount_animation_origin", "targetname" );
    level.player_bike.animname = "player_bike";
    vehicle_scripts\_jetbike::smooth_vehicle_animation_wait( level.player_bike, var_0, "bike_dismount", 11.1633 );

    if ( isdefined( level.player_bike.world_body ) )
    {
        var_1 = level.player_bike.world_body;
        var_1 unlink();
    }
    else
        var_1 = maps\_utility::spawn_anim_model( "world_body", level.player.origin );

    level.player_bike maps\_utility::delaythread( 5, vehicle_scripts\_jetbike::jetbike_stop_hovering_now );
    thread player_dismount_link_player_end_of_frame( var_1 );
    vehicle_scripts\_jetbike::smooth_vehicle_animation_play( level.player_bike, var_0, "bike_dismount", [ var_1 ], 1, 2 );
    maps\detroit_anim::player_bike_to_ai_model();
    common_scripts\utility::flag_set( "obj_check_school_give" );
    common_scripts\utility::flag_set( "ride_over" );
    var_1 delete();
    level.player unlink();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player enablehybridsight( "iw5_bal27_sp_silencer01_variablereddot", 1 );
    setsaveddvar( "ammoCounterHide", "0" );
    thread maps\_utility::autosave_by_name( "seeker" );

    if ( level.currentgen )
        thread transient_middle_add_school_interior_begin();

    level.player_bike thread swap_bike_to_static();
}

checking_for_flag()
{
    iprintlnbold( "checking for flag is called" );
    common_scripts\utility::flag_wait( "begin_playing_player_dismount_anim" );
    iprintlnbold( "the flag has been set" );
}

player_dismount_newbike( var_0 )
{
    level endon( "dont_do_old_dismount" );
    common_scripts\utility::flag_wait( "begin_playing_player_dismount_anim" );
    thread player_school_disable_values();
    var_1 = getent( "actual_dismount_animation_origin", "targetname" );
    var_0.animname = "player_bike";
    vehicle_scripts\_jetbike::smooth_vehicle_animation_wait( var_0, var_1, "bike_dismount", 11.1633 );

    if ( isdefined( var_0.world_body ) )
    {
        var_2 = var_0.world_body;
        var_2 unlink();
    }
    else
        var_2 = maps\_utility::spawn_anim_model( "world_body", level.player.origin );

    var_0 maps\_utility::delaythread( 5, vehicle_scripts\_jetbike::jetbike_stop_hovering_now );
    thread rumble_killer( 7.6 );
    thread player_dismount_link_player_end_of_frame( var_2 );
    vehicle_scripts\_jetbike::smooth_vehicle_animation_play( var_0, var_1, "bike_dismount", [ var_2 ], 1, 2 );
    var_0 setmodel( "vehicle_mil_hoverbike_ai" );
    level notify( "switch_bikes_to_ai" );
    common_scripts\utility::flag_set( "obj_check_school_give" );
    common_scripts\utility::flag_set( "vo_school_exterior" );
    common_scripts\utility::flag_set( "ride_over" );
    var_2 delete();
    level.player unlink();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player thread maps\detroit::give_regular_grenades();
    thread block_from_going_back();
    level.player enablehybridsight( "iw5_bal27_sp_silencer01_variablereddot", 1 );
    setsaveddvar( "ammoCounterHide", "0" );
    level.player thread maps\_player_exo::player_exo_activate();
    level.player enableoffhandweapons();
    thread maps\_utility::autosave_by_name( "seeker" );

    if ( level.currentgen )
        thread transient_middle_add_school_interior_begin();

    var_0 thread swap_bike_to_static();
    var_3 = getent( "player_trying_to_exit_garage_warning", "targetname" );
    thread player_exiting();
    thread maps\detroit_hospital::mission_fail_warning( var_3 );
}

rumble_killer( var_0 )
{
    wait(var_0);
    stopallrumbles();
}

block_from_going_back()
{
    level endon( "stop_tracking_backtrack" );
    maps\_utility::trigger_wait_targetname( "play_garage_animation_sequence" );
    maps\_player_death::set_deadquote( &"DETROIT_OBJECTIVE_FAIL_JETBIKE" );
    maps\_utility::missionfailedwrapper();
}

player_school_disable_values()
{
    maps\_utility::trigger_wait_targetname( "move_burke_ahead" );
    level.player allowdodge( 0 );
    level.player allowsprint( 0 );
}

player_dismount_link_player_end_of_frame( var_0 )
{
    waittillframeend;
    level.player maps\_shg_utility::setup_player_for_scene( 0 );
    level.player playerlinktodelta( var_0, "tag_player", 1, 70, 70, 60, 20, 1 );
    level.player lerpviewangleclamp( 2, 0, 0, 0, 0, 0, 0 );
}

intro_dialogue()
{
    level endon( "player_has_started_outside_combat" );
    wait 7.5;
    wait 2.5;
    maps\_utility::stop_exploder( "4011" );
    maps\_utility::delaythread( 5, common_scripts\utility::flag_set, "bike_lights_off" );
    level notify( "huddle_dof_off" );
}

enable_school_trains()
{
    common_scripts\utility::flag_wait( "school_trains" );
    var_0 = 15;
    var_1 = 25;
    var_2 = 1400;
    var_3 = 2200;
    wait 5;
    thread spawn_reverse_school_train( var_2 + ( var_3 - var_3 ) / 2 );
    thread spawn_trains_track1( var_0, var_1, var_2, var_3 );
    thread spawn_trains_track2( var_0, var_1, var_2, var_3 );
}

spawn_trains_track1( var_0, var_1, var_2, var_3 )
{
    while ( !common_scripts\utility::flag( "school_player_falling" ) )
    {
        wait(randomintrange( var_0, var_1 ));
        thread spawn_a_school_train( randomintrange( var_2, var_3 ) );
    }

    common_scripts\utility::flag_wait( "flag_reenable_school_trains" );

    while ( !common_scripts\utility::flag( "hospital_escape_trains_only" ) )
    {
        wait(randomintrange( var_0, var_1 ));
        thread spawn_a_school_train( randomintrange( var_2, var_3 ) );
    }
}

spawn_trains_track2( var_0, var_1, var_2, var_3 )
{
    while ( !common_scripts\utility::flag( "school_player_falling" ) )
    {
        wait(randomintrange( var_0, var_1 ));
        thread spawn_reverse_school_train( randomintrange( var_2, var_3 ) );
    }

    common_scripts\utility::flag_wait( "flag_reenable_school_trains" );

    while ( !common_scripts\utility::flag( "hospital_escape_trains_only" ) )
    {
        wait(randomintrange( var_0, var_1 ));
        thread spawn_reverse_school_train( randomintrange( var_2, var_3 ) );
    }
}

spawn_a_school_train( var_0 )
{
    if ( !common_scripts\utility::flag( "hospital_escape_trains_only" ) )
    {
        var_1 = getent( "school_train_path_start", "targetname" );
        var_2 = getentarray( "school_train_path", "targetname" );
        var_3 = maps\detroit_exit_drive::run_train( var_1, var_2, var_0 );
        var_3 thread maps\detroit_exit_drive::player_proximity_rumble( 1500 );
        var_3 waittill( "death" );
    }
}

spawn_right_hospital_train( var_0 )
{
    var_1 = getent( "train_path_special_right_start", "targetname" );
    var_2 = getentarray( "train_path_special_right", "targetname" );
    var_3 = maps\detroit_hospital::run_train_with_shaking( var_1, var_2, var_0 );
    var_3 thread maps\detroit_exit_drive::player_proximity_rumble( 850 );
    var_3 waittill( "death" );
}

spawn_left_hospital_train( var_0 )
{
    var_1 = getent( "train_path_special_left_start", "targetname" );
    var_2 = getentarray( "train_path_special_left", "targetname" );
    var_3 = maps\detroit_hospital::run_train_with_shaking( var_1, var_2, var_0 );
    var_3 thread maps\detroit_exit_drive::player_proximity_rumble( 850 );
    var_3 waittill( "death" );
}

spawn_reverse_school_train( var_0 )
{
    if ( !common_scripts\utility::flag( "hospital_escape_trains_only" ) )
    {
        var_1 = getent( "school_train2_path_start", "targetname" );
        var_2 = getentarray( "school_train2_path", "targetname" );
        var_3 = maps\detroit_exit_drive::run_train( var_1, var_2, var_0 );
        var_3 thread maps\detroit_exit_drive::player_proximity_rumble( 1500 );
        var_3 waittill( "death" );
    }
}

monitor_flashlight_burke()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "move_burke_ahead" );
    level.burke maps\detroit_lighting::add_burke_flashlight( "flashlight", 1 );
}

burke_path_to_school()
{
    thread monitor_flashlight_burke();
    var_0 = getent( "burke_outside_hide", "targetname" );
    thread school_objective();
    var_0 maps\_anim::anim_single_solo( level.burke, "burke_school_approach" );
    thread maps\detroit::battle_chatter_off_both();

    if ( maps\_utility::players_within_distance( 300, level.burke.origin ) )
        level.burke burke_school_approach_idle_skip( var_0 );
    else
        level.burke burke_school_approach_idle( var_0 );

    common_scripts\utility::flag_set( "vo_school_cleaning_crew_ahead" );
    thread maps\_utility::autosave_by_name();

    if ( maps\_utility::players_within_distance( 300, level.burke.origin ) )
        level.burke burke_wall_idle_skip( var_0 );
    else
        level.burke burke_wall_idle( var_0 );

    common_scripts\utility::flag_set( "vo_school_checkpoint_blue" );
    thread maps\_utility::autosave_by_name();
    burke_at_school_door();
    burke_busted_light();
    level notify( "ok_to_start_school" );
    level.burke maps\_utility::set_moveplaybackrate( 1 );
}

burke_school_approach_idle_skip( var_0 )
{
    var_0 maps\_anim::anim_single_solo( self, "burke_goto_trash" );
}

burke_school_approach_idle( var_0 )
{
    var_0 maps\_anim::anim_single_solo( self, "burke_school_approach_into" );
    var_0 thread maps\_anim::anim_loop_solo( self, "burke_school_approach_idle", "ender" );
    is_player_near_burke_or_flag( 450, "to_school_player_02" );
    var_0 notify( "ender" );
    var_0 maps\_anim::anim_single_solo( self, "burke_school_approach_out" );
}

burke_wall_idle_skip( var_0 )
{
    var_0 maps\_anim::anim_single_solo( self, "burke_goto_school" );
    var_0 thread maps\_anim::anim_loop_solo( self, "burke_stairs_idle", "ender" );
    is_player_near_burke_or_flag( undefined, "to_school_player_02" );
    var_0 notify( "ender" );
}

burke_wall_idle( var_0 )
{
    var_0 maps\_anim::anim_single_solo( self, "burke_wall_wait_into" );
    var_0 thread maps\_anim::anim_loop_solo( self, "burke_wall_wait_idle", "ender" );
    is_player_near_burke_or_flag( 300, "to_school_player_02" );
    var_0 notify( "ender" );
    var_0 maps\_anim::anim_single_solo( self, "burke_wall_wait_out" );
    var_0 thread maps\_anim::anim_loop_solo( self, "burke_stairs_idle", "ender_stairs_idle" );
    is_player_near_burke_or_flag( undefined, "flag_player_entering_school" );
    var_0 notify( "ender_stairs_idle" );
}

burke_at_school_door()
{
    thread busted_light_gag();
    var_0 = getent( "burke_bodies_anim_origin", "targetname" );
    var_0 maps\_anim::anim_single_solo( level.burke, "burke_goto_corner" );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "burke_corner_idle", "ender_school_door_idle" );
    common_scripts\utility::flag_wait( "player_near_burke_school_corner" );
    thread maps\_utility::autosave_by_name();
    var_0 notify( "ender_school_door_idle" );
}

burke_busted_light()
{
    var_0 = getent( "burke_bodies_anim_origin", "targetname" );
    var_0 maps\_anim::anim_single_solo( level.burke, "burke_goto_bodies" );
}

school_objective()
{
    wait 19.03;
    common_scripts\utility::flag_set( "check_school" );
}

is_player_near_burke( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 150;

    var_1 = 0;

    for (;;)
    {
        if ( isdefined( level.burke ) )
        {
            var_1 = distance2d( level.burke.origin, level.player.origin );

            if ( var_1 < var_0 )
                return;
        }

        wait 0.05;
    }

    wait 1.5;
}

is_1_near_2( var_0, var_1, var_2 )
{
    for (;;)
    {
        if ( distance2d( var_0.origin, var_1.origin ) < var_2 )
            return;

        wait 0.05;
    }
}

is_player_near_burke_or_flag( var_0, var_1 )
{
    level endon( var_1 );

    if ( !isdefined( var_0 ) )
        var_0 = 150;

    if ( common_scripts\utility::flag( var_1 ) )
        return;

    var_2 = 0;

    for (;;)
    {
        if ( isdefined( level.burke ) )
        {
            var_2 = distance2d( level.burke.origin, level.player.origin );

            if ( var_2 < var_0 )
                return;
        }

        wait 0.05;
    }
}

continue_when_player_near_entity( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 150;

    var_3 = 0;

    for (;;)
    {
        if ( isdefined( var_0 ) )
        {
            var_4 = distance2d( var_0.origin, level.player.origin );

            if ( var_4 < var_1 )
                return;
        }

        if ( isdefined( var_2 ) )
        {
            var_4 = distance2d( var_0.origin, var_2.origin );

            if ( var_4 < var_1 )
                return;
        }

        wait 0.05;
    }

    wait 1.5;
}

teleport_burke_to_alley()
{
    var_0 = getnode( "ally_burke_start_onfoot", "targetname" );
    common_scripts\utility::flag_wait( "flag_reenable_school_trains" );
    level.burke delete();
    common_scripts\utility::flag_wait( "vo_school_burke_external" );
    var_1 = getent( "burke_spawner", "targetname" );
    var_1.count = 1;
    level.burke = maps\detroit::setup_burke();
    level.burke maps\_utility::teleport_ai( var_0 );
}

player_basement_objective_mover()
{
    var_0 = getent( "basement_objective_org1", "targetname" );
    var_1 = getent( "basement_objective_org2", "targetname" );
    var_2 = getent( "basement_objective_org3", "targetname" );
    var_3 = getent( "basement_objective_org4", "targetname" );
    maps\_utility::trigger_wait_targetname( "player_fall_basement_trigger" );
    common_scripts\utility::flag_wait( "basement_string_objectives" );
    objective_position( maps\_utility::obj( "Reunite with Burke" ), var_0.origin );
    is_1_near_2( level.player, var_0, 90 );
    objective_position( maps\_utility::obj( "Reunite with Burke" ), var_1.origin );
    is_1_near_2( level.player, var_1, 225 );
    objective_position( maps\_utility::obj( "Reunite with Burke" ), var_2.origin );
    is_1_near_2( level.player, var_2, 225 );
    objective_position( maps\_utility::obj( "Reunite with Burke" ), var_3.origin );
}

distance_check_loop( var_0, var_1 )
{
    level endon( "stop_loop_check" );
    wait 2;

    for (;;)
    {
        var_2 = distance2d( var_0.origin, var_1.origin );
        iprintln( var_2 );
        wait 0.05;
    }
}

return_boost_dash()
{
    common_scripts\utility::flag_wait( "rendezvous_obj_reached" );
    maps\_player_exo::player_exo_activate();
}

gideon_keep_up_fail_trigger( var_0 )
{
    maps\_utility::trigger_wait_targetname( var_0 );
    wait(randomfloatrange( 1.1, 2.4 ));
    maps\_player_death::set_deadquote( &"DETROIT_OBJECTIVE_FAIL_JETBIKE" );
    maps\_utility::missionfailedwrapper();
}

brick_smash_setup()
{
    thread wall_pull_animation();
}

basement_jump_awareness()
{
    self endon( "death" );

    for (;;)
    {
        if ( level.player isjumping() )
        {
            if ( distance2d( self.origin, level.player.origin ) < 400 )
            {
                wait 0.4;
                self notify( "make_me_alert_now" );
                return;
            }
        }

        wait 0.05;
    }
}

audio_stingers_school_bodies_room()
{
    maps\_utility::trigger_wait_targetname( "tile_fall" );
    wait 7.73;
    soundscripts\_snd::snd_message( "horror_burke_gets_up_after_tile" );
    common_scripts\utility::flag_wait( "open_school_door" );
    soundscripts\_snd::snd_message( "horror_burk_opens_bodies_room_door" );
    common_scripts\utility::flag_wait( "burke_leaving_bodies_room" );
    soundscripts\_snd::snd_message( "horror_ghost_runs_by_door" );
    maps\_utility::trigger_wait_targetname( "end_lightning_buildup_trigger" );
    soundscripts\_snd::snd_message( "end_lightning_buildup" );
}

animate_dead_body( var_0, var_1 )
{
    wait 38.5;
    var_1 maps\_anim::anim_single_solo( var_0, "touch_dead_npc" );
    var_1 maps\_anim::anim_last_frame_solo( var_0, "touch_dead_npc" );
}

bodies_gag_door_trigger()
{
    common_scripts\utility::flag_wait( "burke_needs_to_idle" );
    var_0 = getent( "bodies_room_gag_used", "targetname" );
    var_0 usetriggerrequirelookat();
    maps\_utility::enable_trigger_with_targetname( "bodies_room_gag_used" );
    objective_setpointertextoverride( maps\_utility::obj( "Follow Gideon" ), &"DETROIT_OPEN" );
    var_1 = getent( "bodies_room_gag_used", "targetname" ) maps\_shg_utility::hint_button_trigger( "use", 200 );
    common_scripts\utility::flag_set( "obj_check_school_pos_door" );
    level notify( "show_glowing_door" );
    var_0 sethintstring( &"DETROIT_PROMPT_OPEN" );
    maps\_utility::trigger_wait_targetname( "bodies_room_gag_used" );
    objective_setpointertextoverride( maps\_utility::obj( "Follow Gideon" ), &"DETROIT_FOLLOW" );
    objective_position( maps\_utility::obj( "Follow Gideon" ), ( 0, 0, 0 ) );
    var_1 maps\_shg_utility::hint_button_clear();
    var_0 delete();
}

burke_path_through_school()
{
    level waittill( "ok_to_start_school" );
    common_scripts\utility::flag_wait( "flag_player_entering_school" );
    level.burke get_burke_to_deadroom();
    maps\_utility::trigger_wait_targetname( "start_kva_gag" );
    level.player setmovespeedscale( 0.6 );
    level.burke.ignoreme = 1;
    level.player.ignoreme = 1;
    maps\_utility::trigger_wait_targetname( "player_fall_basement_trigger" );
    level.player.ignoreme = 0;
    maps\_utility::trigger_wait_targetname( "disable_burke_ignoreme" );
    level.burke.ignoreme = 0;
}

school_fall_rumble()
{
    wait 1.41;
    var_0 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0 maps\_utility::set_rumble_intensity( 0.29 );
    var_0 maps\_utility::delaythread( 0.14, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 1.75, maps\_utility::set_rumble_intensity, 0.81 );
    var_0 maps\_utility::delaythread( 2.2, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 12.36, maps\_utility::set_rumble_intensity, 0.09 );
    var_0 maps\_utility::delaythread( 12.82, maps\_utility::set_rumble_intensity, 0.41 );
    var_0 maps\_utility::delaythread( 13.3, maps\_utility::set_rumble_intensity, 0.09 );
    var_0 maps\_utility::delaythread( 14.49, maps\_utility::set_rumble_intensity, 0.03 );
    var_0 maps\_utility::delaythread( 14.64, maps\_utility::set_rumble_intensity, 0.54 );
    var_0 maps\_utility::delaythread( 15.24, maps\_utility::set_rumble_intensity, 0.01 );
    wait 17;
    var_0 stoprumble( "steady_rumble" );
    var_0 delete();
}

stop_all_rumble_on_time( var_0, var_1 )
{
    wait(var_0);
    self stoprumble( var_1 );
}

lightning_gag()
{
    maps\_utility::trigger_wait_targetname( "lightning_gag" );
    maps\detroit_lighting::lightning_call_single( "detroit_lightning_max", 0.3, 0.7 );
}

spawn_kva_downstairs()
{
    var_0 = getent( "soldiers_downstairs_team1", "targetname" );
    var_1 = getent( "soldiers_downstairs_team2", "targetname" );
    var_2 = getent( "soldiers_downstairs_team3", "targetname" );
    var_3 = getent( "soldiers_downstairs_team4", "targetname" );
    var_4 = [];
    var_4[var_4.size] = var_0 maps\_utility::spawn_ai( 1 );
    var_4[var_4.size] = var_2 maps\_utility::spawn_ai( 1 );

    foreach ( var_9, var_6 in var_4 )
    {
        var_6.ignoreall = 1;

        if ( var_6 == var_4[0] )
            var_6 thread maps\detroit_lighting::add_enemy_flashlight( "flashlight", "med" );

        if ( var_6 == var_4[1] )
            var_6 thread maps\detroit_lighting::add_enemy_flashlight( "flashlight", "med" );
        else
            var_6 thread maps\detroit_lighting::add_enemy_flashlight( "flashlight" );

        var_6.old_fovcosine = var_6.fovcosine;
        var_6.fovcosine = 0.95;
        var_6.combatmode = "no_cover";
        var_6.goalradius = 15;
        var_6 maps\detroit::set_patrol_anim_set( "active", 1 );
        var_7 = var_9 + 1;
        var_8 = getnode( "guy" + var_7 + "_goal", "targetname" );
        var_6 setgoalnode( var_8 );
        var_6 thread stealth_delete_at_goal();
        var_6 thread alert_check_function();
        var_6 thread kill_me_on_notify();
        var_6 thread maps\_utility::set_moveplaybackrate( 1.05 );
    }

    level.school_kva_fall_notice_guy = var_4[1];
    common_scripts\utility::flag_set( "vo_school_shimmy" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_shimmey_ok" );
    return_stealth_distances();
}

alert_check_function()
{
    self endon( "death" );
    maps\_stealth_utility::stealth_enemy_waittill_alert();
}

youre_dead_functon()
{
    wait 3;
    maps\_player_death::set_deadquote( "You've blown your cover!" );
    maps\_utility::missionfailedwrapper();
}

youre_spoted_functon()
{
    wait 3;
    maps\_player_death::set_deadquote( "You've been spotted!" );
    maps\_utility::missionfailedwrapper();
}

enable_check_health()
{
    self endon( "death" );
    self endon( "alert" );
    var_0 = self.health;

    for (;;)
    {
        if ( self.health < var_0 )
        {
            level.player.ignoreme = 0;
            level.burke.ignoreme = 0;
            self.ignoreall = 0;
            thread youre_dead_functon();
            return;
        }

        wait 0.05;
    }
}

enable_doorway_blocking()
{
    maps\_utility::trigger_wait_targetname( "player_fall_basement_trigger" );
    var_0 = getent( "door_blocker_1", "targetname" );
    var_1 = getent( "door_blocker_2", "targetname" );
    var_2 = getent( "door_blocker_3", "targetname" );
    var_3 = getent( "door_blocker_4", "targetname" );
    var_0 connectpaths();
    var_1 connectpaths();
    var_2 connectpaths();
    var_3 connectpaths();
    var_0 delete();
    var_1 delete();
    var_2 delete();
    var_3 delete();
}

override_stealth_distances()
{
    level.old_stealth_numbers = [];
    level.old_stealth_numbers["prone"] = level._stealth.logic.detect_range["hidden"]["prone"];
    level.old_stealth_numbers["crouch"] = level._stealth.logic.detect_range["hidden"]["crouch"];
    level.old_stealth_numbers["stand"] = level._stealth.logic.detect_range["hidden"]["stand"];
    level._stealth.logic.detect_range["hidden"]["prone"] = level.old_stealth_numbers["prone"] / 5;
    level._stealth.logic.detect_range["hidden"]["crouch"] = level.old_stealth_numbers["crouch"] / 5;
    level._stealth.logic.detect_range["hidden"]["stand"] = level.old_stealth_numbers["stand"] / 5;
}

return_stealth_distances()
{
    level._stealth.logic.detect_range["hidden"]["prone"] = level.old_stealth_numbers["prone"];
    level._stealth.logic.detect_range["hidden"]["crouch"] = level.old_stealth_numbers["crouch"];
    level._stealth.logic.detect_range["hidden"]["stand"] = level.old_stealth_numbers["stand"];
}

stealth_delete_at_goal()
{
    self endon( "alert" );
    self waittill( "goal" );
    waitframe();
    self delete();
}

basement_hide_setup()
{
    thread basement_door_school_anim();
    common_scripts\utility::flag_wait( "flag_start_kva_basement" );
    level thread exo_dodge_stealth_watcher();
    common_scripts\utility::flag_clear( "school_trains" );
    level.firstguy = maps\_utility::spawn_targetname( "kva_basement_troop", 1 );
    level.firstguy maps\detroit::force_patrol_anim_set( "active_right" );
    level.firstguy thread make_me_alert( "player_basement_spotted" );
    level.firstguy thread bump_into_awareness();
    level.firstguy thread seek_player_on_detection();
    level.firstguy thread new_kva_basement_1();
    level.firstguy thread call_in_assistance();
    level.firstguy thread i_have_seen_the_player();
    level.firstguy.fovcosine = cos( 45 );
    level.firstguy waittill( "enemy" );
    common_scripts\utility::flag_set( "vo_school_basement_sawsomething", level.firstguy );
}

exo_dodge_stealth_watcher()
{
    level.player endon( "death" );

    while ( level.player maps\_utility::ent_flag( "_stealth_enabled" ) )
    {
        level.player waittill( "exo_dodge" );
        var_0 = maps\_utility::get_within_range( level.player.origin, getaiarray( "axis" ), 500 );

        foreach ( var_2 in var_0 )
        {
            if ( isdefined( var_2._stealth ) )
            {
                var_2 notify( "ai_event", "gunshot" );
                var_2 maps\_utility::set_favoriteenemy( level.player );
            }
        }
    }
}

call_in_assistance()
{
    self endon( "death" );
    common_scripts\utility::waittill_any_ents( level, "_stealth_spotted", self, "shooting" );
    hide1_shelf_delete();

    if ( !common_scripts\utility::flag( "flag_start_kva_2_basement" ) )
    {
        var_0 = getent( "kva_basement_troop_2", "targetname" );
        var_1 = var_0 maps\_utility::spawn_ai( 1 );
        self.goalradius = 10;
        var_1.goalradius = 10;
        var_1 setgoalentity( level.player );
        var_1 notify( "alert" );
        var_1 notify( "player_spotted" );
        var_1 thread maps\_utility::player_seek();
        common_scripts\utility::flag_set( "dont_spawn_basement_troop_2" );
        level.player allowsprint( 1 );
    }
}

hide1_shelf_delete()
{
    var_0 = getentarray( "hide_1_shelf", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();
}

hide2_shelf_delete()
{
    var_0 = getentarray( "hide_2_shelf", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();
}

spawn_third_floor_guy_for_assistance()
{
    var_0 = getent( "spawner_school_f2_patroller_1", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1 thread maps\_utility::player_seek();
    common_scripts\utility::flag_set( "dont_spawn_art_room_flashlight_guy" );
    var_0.count = 1;
}

walking_awareness()
{
    self endon( "death" );
    self endon( "damage" );

    for (;;)
    {
        var_0 = distance( self.origin, level.player.origin );

        if ( var_0 < 300 )
        {
            var_1 = length( level.player getvelocity() );

            if ( var_1 > 80 )
            {
                if ( level.player getstance() == "stand" )
                {
                    wait 0.4;
                    self notify( "make_me_alert_now" );
                    return;
                }
            }
        }

        wait 0.05;
    }
}

bump_into_awareness()
{
    self endon( "death" );
    self endon( "damage" );

    for (;;)
    {
        var_0 = distance( self.origin, level.player.origin );

        if ( var_0 < 45 )
        {
            self notify( "ai_event", "gunshot" );
            maps\_utility::set_favoriteenemy( level.player );
            return;
        }

        wait 0.05;
    }
}

player_velocity_display( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        var_1 = length( var_0 getvelocity() );
        iprintln( var_1 );
        wait 0.05;
    }
}

notify_spotted_player()
{
    self endon( "death" );
    self waittill( "spotted_player" );
    self stopanimscripted();
    maps\_utility::clear_run_anim();
    return;
}

monitor_my_health()
{
    while ( isalive( self ) )
    {
        iprintln( self.health );
        wait 1;
    }
}

new_kva_basement_1()
{
    self.animname = "kva";
    self endon( "death" );
    self endon( "_stealth_spotted" );
    self endon( "alert" );
    level endon( "player_has_been_spotted" );
    self endon( "enemy" );
    maps\detroit_lighting::add_enemy_flashlight( "flashlight", "med" );
    maps\detroit_lighting::enemy_flashlight_toggle_think( "trig_flashlight_basement_on", "trig_flashlight_basement_off" );
    thread delete_guy_on_trigger_stealth( "new_hall_troops_trigger" );
    var_0 = getent( "basement_door_open_anim_org", "targetname" );
    thread dont_animate_basement_door_on_death( var_0 );
    var_1 = getnode( "test_goal_node", "targetname" );
    var_2 = getent( "kva_check_3_org", "targetname" );
    var_2 thread break_me_out_if_player_found();
    self setgoalnode( var_1 );
    self waittill( "goal" );

    if ( !common_scripts\utility::flag( "player_basement_spotted" ) )
        var_0 maps\_anim::anim_reach_solo( self, "door_open_basement", undefined, 1 );

    if ( !common_scripts\utility::flag( "player_basement_spotted" ) )
    {
        common_scripts\utility::flag_set( "open_school_basement_door" );
        var_0 maps\_anim::anim_single_solo( self, "door_open_basement", undefined, 1 );
        common_scripts\utility::flag_set( "connect_basement_door_clip" );
    }

    if ( !common_scripts\utility::flag( "player_basement_spotted" ) )
        var_2 maps\_anim::anim_reach_solo( self, "search_flashlight_low_basement_loop", undefined, 1 );

    if ( !common_scripts\utility::flag( "player_basement_spotted" ) )
    {
        var_2 thread maps\_anim::anim_loop_solo( self, "search_flashlight_low_basement_loop" );
        thread maps\_shg_design_tools::notify_relay( self, "enemy", var_2, "stop_loop" );
    }
}

break_me_out_if_player_found()
{
    level.firstguy endon( "death" );
    level.firstguy waittill( "enemy" );
    level.firstguy notify( "end_patrol" );
    level.firstguy notify( "flashlight_off" );
    level.firstguy.alwaysrunforward = undefined;
}

dont_animate_basement_door_on_death( var_0 )
{
    self waittill( "death" );
    level notify( "stop_animating_the_basement_door" );
}

basement_door_school_anim()
{
    level endon( "stop_animating_the_basement_door" );
    var_0 = maps\_utility::spawn_anim_model( "basement_door" );
    var_0 thread dont_animate_on_kva_death();
    var_1 = getent( "basement_door_open_anim_org", "targetname" );
    var_1 thread maps\_anim::anim_first_frame_solo( var_0, "door_open_basement" );
    var_0 thread basement_door_clip_function();
    common_scripts\utility::flag_wait( "open_school_basement_door" );
    var_1 thread maps\_anim::anim_single_solo( var_0, "door_open_basement" );
    wait 2.84;
    level notify( "too_late_to_close_door" );
}

dont_animate_on_kva_death()
{
    level endon( "too_late_to_close_door" );
    level waittill( "stop_animating_the_basement_door" );
    self stopanimscripted();
}

basement_troop_2()
{
    common_scripts\utility::flag_wait( "flag_start_kva_2_basement" );

    if ( !common_scripts\utility::flag( "dont_spawn_basement_troop_2" ) )
    {
        soundscripts\_snd::snd_message( "kva_basement_idle_start" );
        var_0 = getent( "basement_investigate_origin", "targetname" );
        level.flashlight_guy = maps\_utility::spawn_targetname( "kva_basement_troop_2", 1 );
        level.flashlight_guy endon( "death" );
        level.flashlight_guy thread bump_into_awareness();
        level.flashlight_guy maps\detroit::force_patrol_anim_set( "active" );
        level.flashlight_guy thread delete_guy_on_trigger_stealth( "new_hall_troops_trigger" );
        level.flashlight_guy maps\detroit_lighting::add_enemy_flashlight( "flashlight", "med" );
        level.flashlight_guy maps\detroit_lighting::enemy_flashlight_toggle_think( "trig_flashlight_basement_on", "trig_flashlight_basement_off" );
        level.flashlight_guy.animname = "kva";
        level.flashlight_guy thread se_kva_basement_2( var_0 );
        level.flashlight_guy thread seek_player_on_detection();
        level.flashlight_guy thread i_have_seen_the_player();
        level.flashlight_guy waittill( "enemy" );
        common_scripts\utility::flag_set( "vo_school_basement_sawsomething", level.flashlight_guy );
        level.flashlight_guy notify( "end_patrol" );
        level.flashlight_guy notify( "flashlight_off" );
        level.flashlight_guy maps\_utility::anim_stopanimscripted();
        getent( "kva_2_flashlight_loop_org", "targetname" ) maps\_utility::anim_stopanimscripted();
        var_0 notify( "stop_searching_now" );
    }
}

delete_notify()
{
    self waittill( "death" );
}

se_kva_basement_2( var_0 )
{
    self endon( "death" );
    self endon( "_spotted_player" );
    self endon( "enemy" );
    self.fovcosine = cos( 30 );
    thread notify_valve_on_death();
    var_1 = maps\_utility::spawn_anim_model( "valve" );
    var_2 = maps\_utility::spawn_anim_model( "generic_prop" );
    thread steam_burst_function();
    self.animname = "kva";
    thread alert_stop_animating( var_0 );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "school_investigate" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_2, "school_investigate" );
    var_3 = getent( "kva_basement_gate_open", "targetname" );
    var_3 linkto( var_2, "tag_origin_animated" );
    var_0 thread maps\_anim::anim_loop_solo( self, "basement_flashlight_idle", "stop_searching_now" );
    common_scripts\utility::flag_wait( "steam_startle_flag" );
    self.fovcosine = cos( 60 );

    if ( !isalive( self ) )
        return;

    if ( maps\_utility::ent_flag( "_stealth_attack" ) )
        return;

    var_0 notify( "stop_searching_now" );
    soundscripts\_snd::snd_message( "steam_burst_valve_started" );
    soundscripts\_snd::snd_message( "basement_investigate" );
    level thread maps\detroit_fx::steam_spray_custom_function();
    level.kva_basement_guy = self;
    common_scripts\utility::flag_set( "vo_school_basement_rats" );
    var_4 = [ var_1, var_2 ];
    var_0 thread basement_valve_and_door_stop_early( self, var_4, var_3, "school_investigate" );
    var_0 maps\_anim::anim_single_solo( self, "school_investigate" );
    var_5 = getent( "kva_2_flashlight_loop_org", "targetname" );
    thread se_kva_basement_2_idle( var_5 );
}

basement_valve_and_door_stop_early( var_0, var_1, var_2, var_3 )
{
    thread maps\_anim::anim_single( var_1, var_3 );
    var_4 = 23.5;
    var_5 = var_0 common_scripts\utility::waittill_any_timeout( var_4, "enemy", "death" );

    if ( var_5 == "timeout" )
    {
        var_2 connectpaths();
        return;
    }

    foreach ( var_7 in var_1 )
        var_7 setanimrate( var_7 maps\_utility::getanim( var_3 ), 0 );

    maps\_utility::anim_stopanimscripted();
}

seek_player_on_detection()
{
    self endon( "death" );
    self waittill( "enemy" );
    self notify( "end_patrol" );
    self.combatmode = "no_cover";

    for (;;)
    {
        self setgoalentity( level.player );
        self.goalradius = 4;
        wait 0.5;
    }
}

stop_animating_when_kva2_dead()
{
    level waittill( "stop_valve_animation" );
    self stopanimscripted();
}

notify_valve_on_death()
{
    self waittill( "death" );
    level notify( "stop_valve_animation" );
}

valve_stop_animating()
{
    level waittill( "stop_valve_animation" );
    self stopanimscripted();
}

steam_burst_function()
{
    common_scripts\utility::flag_wait( "steam_startle_flag" );
    common_scripts\_exploder::exploder( 1759 );
}

alert_stop_animating( var_0 )
{
    self endon( "death" );
    maps\_utility::ent_flag_wait( "_stealth_attack" );
    self stopanimscripted();
    var_0 stopanimscripted();
    common_scripts\utility::flag_set( "kill_the_valve_anim" );
    self notify( "stop_searching_now" );
    var_0 notify( "stop_searching_now" );
    level notify( "stop_valve_animation" );
}

se_kva_basement_2_idle( var_0 )
{
    self endon( "death" );
    self endon( "enemy" );

    if ( !maps\_utility::ent_flag( "_stealth_attack" ) )
    {
        var_0 maps\_anim::anim_reach_solo( self, "search_flashlight_low_basement_loop", undefined, 1 );
        var_0 thread maps\_anim::anim_loop_solo( self, "so_hijack_search_flashlight_high_loop" );
    }
}

stealth_guy_think()
{
    self endon( "death" );

    if ( isai( self ) )
    {
        thread maps\detroit::disable_grenades();
        maps\_utility::ent_flag_init( "spotted_player" );
        self.fovcosine = 0.9;
        self.combatmode = "no_cover";
        common_scripts\utility::waittill_any_ents( self, "damage", self, "_stealth_spotted", self, "stealth_event", self, "enemy" );
    }

    maps\_utility::ent_flag_set( "spotted_player" );

    if ( isdefined( level.firstguy ) && self == level.firstguy )
        level notify( "stop_animating_the_basement_door" );

    self notify( "end_patrol" );
    self stopanimscripted();
    self notify( "flashlight_off" );
    var_0 = level.player getweaponslist( "primary" );
    var_1 = 0;

    if ( !isdefined( var_0 ) )
        var_1 = 1;

    if ( isarray( var_0 ) )
    {
        foreach ( var_3 in var_0 )
        {
            if ( issubstr( var_3, "unarmed" ) )
                var_1 = 1;
        }
    }

    if ( var_1 )
        common_scripts\utility::flag_set( "vo_school_basement_sawsomething", self );
}

i_have_seen_the_player()
{
    level endon( "group_spotted_already" );
    var_0 = common_scripts\utility::flag_wait( "vo_school_basement_sawsomething" );

    if ( !isdefined( var_0 ) )
        return;

    if ( var_0.targetname == "kva_basement_troop_AI" )
    {
        if ( common_scripts\utility::flag( "no_more_basement_alerts" ) )
            return;

        var_0 thread maps\_utility::dialogue_queue( "det_kva_contact" );
        common_scripts\utility::flag_set( "no_more_basement_alerts" );
        return;
    }
    else if ( var_0.targetname == "kva_basement_troop_2_AI" )
    {
        if ( common_scripts\utility::flag( "no_more_basement_alerts" ) )
            return;

        var_0 thread maps\_utility::dialogue_queue( "det_kva_huh" );
        common_scripts\utility::flag_set( "no_more_basement_alerts" );
        return;
    }
    else if ( var_0.targetname == "spawner_school_f2_patroller_1_AI" )
    {
        if ( common_scripts\utility::flag( "third_guy_alerted" ) )
            return;

        var_0 thread maps\_utility::dialogue_queue( "det_kva_ivegotcontact" );
        common_scripts\utility::flag_set( "no_more_basement_alerts" );
        common_scripts\utility::flag_set( "third_guy_alerted" );
        return;
    }
}

delete_guy_on_trigger_stealth( var_0 )
{
    self endon( "alert" );
    self endon( "death" );
    maps\_shg_design_tools::waittill_trigger_with_name( var_0 );
    maps\_shg_design_tools::delete_auto();
}

hall_troop_scare_moment()
{
    maps\_utility::trigger_wait_targetname( "new_hall_troops_trigger" );
    var_0 = getent( "new_hall_troop_1", "targetname" );
    var_1 = getent( "new_hall_troop_2", "targetname" );
    var_2 = getent( "new_hall_troop_3", "targetname" );
    var_3 = var_0 maps\_utility::spawn_ai( 1 );
    var_4 = var_1 maps\_utility::spawn_ai( 1 );
    var_5 = var_2 maps\_utility::spawn_ai( 1 );
    var_6 = getnode( "new_hall_troop_die_spot1", "targetname" );
    var_7 = getnode( "new_hall_troop_die_spot2", "targetname" );
    var_8 = getnode( "new_hall_troop_die_spot3", "targetname" );
    var_9 = [ var_3, var_4, var_5 ];

    foreach ( var_11 in var_9 )
    {
        var_11.ignoreall = 1;
        var_11 maps\detroit_lighting::add_enemy_flashlight( "flashlight", 1 );
        var_11 thread nearby_shot_alert();
        var_11 thread maps\detroit_lighting::enemy_flashlight_toggle_think( "trig_flashlight_patroller_on", "trig_flashlight_patroller_off" );
        var_11.goalradius = 15;
        var_11 maps\_utility::enable_cqbwalk();
        var_11 thread break_ignore_all_on_damage();
        var_11 thread alert_when_another_is_hurt();
        var_11 thread kill_me_if_player_escapes();
    }

    var_3 setgoalnode( var_6 );
    var_4 setgoalnode( var_7 );
    var_5 setgoalnode( var_8 );
    wait 1;
}

kill_me_if_player_escapes()
{
    maps\_utility::trigger_wait_targetname( "train_scare" );

    if ( isalive( self ) )
        self delete();
}

nearby_shot_alert()
{
    self endon( "death" );

    for (;;)
    {
        if ( level.player attackbuttonpressed() )
        {
            if ( distance( level.player.origin, self.origin ) < 1000 )
            {
                level notify( "alert_stairs_team" );
                return;
            }
        }

        wait 0.05;
    }
}

delete_me_on_flag( var_0 )
{
    common_scripts\utility::flag_wait( var_0 );

    if ( isalive( self ) )
        self delete();
}

delete_me_on_goal()
{
    self waittill( "goal" );
    self delete();
}

break_ignore_all_on_damage()
{
    self endon( "death" );
    self waittill( "damage" );
    level notify( "alert_stairs_team" );
    self.ignoreall = 0;
}

alert_when_another_is_hurt()
{
    self endon( "death" );
    var_0 = getent( "new_hall_troop_combat_vol", "targetname" );
    level waittill( "alert_stairs_team" );
    maps\_utility::battlechatter_on( "axis" );
    wait(randomfloatrange( 0.1, 0.3 ));

    if ( isalive( self ) )
    {
        self.ignoreall = 0;
        self setgoalvolumeauto( var_0 );
    }

    maps\_utility::trigger_wait_targetname( "lightning_gag" );
    maps\_utility::battlechatter_off( "axis" );

    if ( isalive( self ) )
        self delete();
}

debug_stealth()
{
    thread maps\_stealth_debug::last_known_position_monitor();
}

monitor_stealth_flags()
{
    maps\_utility::ent_flag_wait( "_stealth_enemy_alert_level_action" );
    maps\_utility::ent_flag_clear( "_stealth_enemy_alert_level_action" );
    maps\_utility::ent_flag_wait( "_stealth_enemy_alert_level_action" );
    self endon( "death" );

    for (;;)
    {
        level waittill( "event_awareness", var_0 );

        if ( var_0 == "warning" )
        {
            self notify( "new_anim_reach" );
            continue;
        }

        if ( var_0 == "attack" )
            break;
    }

    if ( isdefined( self.old_fovcosine ) )
        self.fovcosine = self.old_fovcosine;

    remove_patrol_anim_set();
}

remove_patrol_anim_set()
{
    self.patrol_walk_twitch = undefined;
    self.patrol_walk_anim = undefined;
    self.script_animation = undefined;
    maps\_utility::clear_generic_run_anim();
    self.goalradius = 512;
    self allowedstances( "stand", "crouch", "prone" );
    self.disablearrivals = 0;
    self.disableexits = 0;
    self.allowdeath = 1;
    self.alwaysrunforward = undefined;

    if ( isdefined( self.oldcombatmode ) )
        self.combatmode = self.oldcombatmode;

    if ( isdefined( level.patroller ) && self == level.patroller )
        return;

    maps\_utility::enable_cqbwalk();
    return;
}

kill_me_on_notify()
{
    level waittill( "delete_walkthrough_guys" );

    if ( isdefined( self ) )
        self delete();
}

setup_school()
{
    thread maps\detroit_lighting::player_school_flashlight();
    thread enable_doorway_blocking();
    thread burke_path_through_school();
    thread burke_shimmey_setup();
    thread take_every_grenade_now();
    thread setup_player_fall();
    thread basement_hide_setup();
    thread basement_troop_2();
    thread setup_hazmant_suit_room();
    thread hall_troop_scare_moment();
    thread brick_smash_setup();
    thread player_basement_objective_mover();
    thread return_boost_dash();
    common_scripts\utility::flag_wait( "flag_player_shimmy_start" );
    level notify( "flickering_light_02_off" );
    common_scripts\utility::flag_set( "rendezvous" );
}

lerp_time_function_wallpull()
{
    thread wait_for_success_press();
    thread maps\detroit_hospital::use_hint_blinks();

    for ( var_0 = 0; var_0 < 1.6; var_0 += 0.05 )
    {
        if ( level.player usebuttonpressed() )
        {
            thread maps\detroit_hospital::fade_out_use_hint( 0.1 );
            common_scripts\utility::flag_clear( "wall_grab_success" );
            level notify( "player_grabbed_brick" );
            maps\_utility::slowmo_lerp_out();
            soundscripts\_snd::snd_message( "wall_pull_slowmo", "end" );
            return;
        }

        wait 0.05;
    }

    soundscripts\_snd::snd_message( "wall_pull_slowmo", "fail" );
    thread maps\detroit_hospital::fade_out_use_hint( 0.1 );
}

wait_for_success_press()
{
    level endon( "player_grabbed_brick" );
    wait 1.0;
    level.player stopanimscripted();
    common_scripts\utility::flag_set( "player_failed_wall_grab_stop" );
    maps\_player_death::set_deadquote( &"DETROIT_QTE_FAIL" );
}

helmet_swap_wait_function()
{
    level waittill( "helmet_swap_time" );
    // self detach( "kva_hazmat_head_a" );
    // self attach( "kva_hazmat_head_a_damaged" );
    wait 2;
    maps\_utility::pretend_to_be_dead();
}

wall_pull_animation()
{
    var_0 = getent( "choke_gag_spawner", "targetname" );
    var_1 = getent( "test_anim_origin", "targetname" );
    var_2 = maps\_utility::spawn_anim_model( "brick" );
    var_3 = maps\_utility::spawn_anim_model( "world_body" );
    var_3 hide();
    var_4 = [ var_3, var_2 ];
    var_1 maps\_anim::anim_first_frame( var_4, "wall_pull" );
    level.brick = var_2;
    maps\_utility::trigger_wait_targetname( "wall_pull_animation" );
    common_scripts\utility::flag_set( "kill_scare_team" );
    level notify( "weapon_take_no_longer_needed" );
    thread maps\detroit::battle_chatter_off_both();
    level.player maps\_shg_utility::setup_player_for_scene();
    var_0.count = 1;
    var_5 = var_0 maps\_utility::spawn_ai( 1 );
    var_5.ignoresonicaoe = 1;
    var_5.dropweapon = 0;
    var_5.ignoreall = 1;
    var_5.ignoreme = 1;
    var_5.allowdeath = 1;
    var_5.a.nodeath = 1;
    maps\_utility::spawn_failed( var_5 );
    var_5.animname = "generic";
    var_5 character\gfl\character_gfl_destroyer::main();
    var_6 = 0.05;
    var_7 = 0.2;
    level.player setstance( "stand" );
    level.player allowcrouch( 0 );
    var_3 common_scripts\utility::delaycall( var_7, ::show );
    level.player playerlinktoblend( var_3, "tag_player", var_6 );
    level.player common_scripts\utility::delaycall( var_6, ::playerlinktodelta, var_3, "tag_player", 0, 0, 0, 0, 0, 1 );
    var_4 = [ var_5, var_3, var_2 ];
    var_5 maps\_utility::gun_remove();
    var_5 showallparts();
    var_5 thread helmet_swap_wait_function();
    thread wall_pull_animation_dialogue();
    thread maps\detroit_lighting::grab_lighting();
    soundscripts\_snd::snd_message( "wall_pull_animation_begin" );
    thread slowmo_in_wait_function();
    var_3 thread stop_animating_player_rig_on_flag();
    thread school_wall_grab_rumble();
    var_1 maps\_anim::anim_single( var_4, "wall_pull" );
    level notify( "takedown_over" );
    var_8 = var_5 maps\_utility::getanim( "wall_pull" );
    var_5 setanimrate( var_8, 0 );
    var_5 setanimtime( var_8, 0.99 );
    level.player allowcrouch( 1 );
    var_3 delete();
    common_scripts\utility::flag_set( "wall_grab_guy_dead" );
    level.player unlink();
    level.player givemaxammo( "frag_grenade_var" );
    level.player givemaxammo( "contact_grenade_var" );
    level.player givemaxammo( "tracking_grenade_var" );
    level.player givemaxammo( "flash_grenade_var" );
    level.player givemaxammo( "emp_grenade_var" );
    level.player givemaxammo( "paint_grenade_var" );
    level.player maps\_shg_utility::setup_player_for_gameplay();
    thread kva_knife_takedown();
    thread window_hint();
}

window_hint()
{
    var_0 = getent( "window_origin", "targetname" );
    objective_position( maps\_utility::obj( "Reunite with Burke" ), var_0.origin );
}

xprompt_on_brick()
{
    var_0 = getent( "brick_xprompt_org", "targetname" );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    var_2 = var_1 maps\_shg_utility::hint_button_tag( "x", "tag_origin", 128 );
    level waittill( "player_grabbed_brick" );
    var_2 maps\_shg_utility::hint_button_clear();
}

stop_animating_player_rig_on_flag()
{
    level endon( "takedown_over" );
    var_0 = getent( "test_anim_death_origin", "targetname" );
    common_scripts\utility::flag_wait( "player_failed_wall_grab_stop" );
    level.player playerlinktodelta( self, "tag_player", 0, 0, 0, 0, 0, 1 );
    var_0 thread maps\_anim::anim_single_solo( self, "det_hos_breach_fail_vm" );
    maps\_utility::missionfailedwrapper();
    thread maps\detroit_hospital::fade_out_use_hint( 0.1 );
}

kva_knife_takedown()
{
    soundscripts\_snd::snd_message( "kva_knife_takedown_scene_begin" );
    var_0 = getent( "test_anim_origin", "targetname" );
    var_1 = getent( "last_kva_guy_inside_school_spawner", "targetname" );
    var_2 = var_1 maps\_shg_design_tools::actual_spawn();
    var_2 thread maps\detroit_lighting::add_enemy_flashlight( "flashlight", "med" );
    var_2 thread maps\detroit::force_patrol_anim_set( "active_right" );
    var_2 thread stealth_guy_think();
    var_2 setgoalpos( var_0.origin );
    var_2 thread last_burke_external_dialogue();
    var_2 thread remove_flashlight_on_goal();
    var_2 thread set_this_flag_when_im_dead( "last_school_guy_dead" );
    var_2 endon( "death" );
    var_2 maps\_utility::ent_flag_wait( "spotted_player" );
    var_2 maps\_utility::enable_cqbwalk();
    var_2 notify( "goal" );
}

set_this_flag_when_im_dead( var_0 )
{
    self waittill( "death" );
    common_scripts\utility::flag_set( var_0 );
}

school_wall_grab_rumble()
{
    wait 0.1;
    var_0 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0 maps\_utility::set_rumble_intensity( 0.3 );
    var_0 maps\_utility::delaythread( 0.35, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 0.65, maps\_utility::set_rumble_intensity, 0.19 );
    var_0 maps\_utility::delaythread( 0.95, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 1.4, maps\_utility::set_rumble_intensity, 0.12 );
    var_0 maps\_utility::delaythread( 1.55, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 2.7, maps\_utility::set_rumble_intensity, 0.12 );
    var_0 maps\_utility::delaythread( 2.9, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 4.7, maps\_utility::set_rumble_intensity, 0.6 );
    var_0 maps\_utility::delaythread( 4.9, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 6.8, maps\_utility::set_rumble_intensity, 0.25 );
    var_0 maps\_utility::delaythread( 7, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 7.8, maps\_utility::set_rumble_intensity, 0.7 );
    var_0 maps\_utility::delaythread( 8.0, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 9.8, maps\_utility::set_rumble_intensity, 0.2 );
    var_0 maps\_utility::delaythread( 10.06, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 11.28, maps\_utility::set_rumble_intensity, 0.55 );
    var_0 maps\_utility::delaythread( 11.46, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 12.58, maps\_utility::set_rumble_intensity, 0.55 );
    var_0 maps\_utility::delaythread( 12.76, maps\_utility::set_rumble_intensity, 0.13 );
    var_0 maps\_utility::delaythread( 12.96, maps\_utility::set_rumble_intensity, 0.29 );
    var_0 maps\_utility::delaythread( 13.7, maps\_utility::set_rumble_intensity, 0.11 );
    var_0 maps\_utility::delaythread( 16.7, maps\_utility::set_rumble_intensity, 0.01 );
    var_0 maps\_utility::delaythread( 18.2, maps\_utility::set_rumble_intensity, 0.11 );
    var_0 maps\_utility::delaythread( 18.65, maps\_utility::set_rumble_intensity, 0.01 );
    wait 20;
    var_0 stoprumble( "steady_rumble" );
    var_0 delete();
}

remove_flashlight_on_goal()
{
    self waittill( "goal" );
    self notify( "flashlight_off" );
    self setgoalpos( level.player.origin );
    thread maps\_utility::player_seek();
}

last_burke_external_dialogue()
{
    common_scripts\utility::waittill_any_ents( self, "death", level, "spawn_ally_burke_backup" );
    common_scripts\utility::flag_set( "vo_school_burke_external" );
    var_0 = getglass( "burke_street_glass" );
    destroyglass( var_0 );
}

take_knife_when_done()
{
    self endon( "death" );
    self waittill( "weapon_switch_started" );
    level.player giveweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player switchtoweapon( "iw5_hbra3_sp_opticstargetenhancer" );
}

save_game_when_dead( var_0 )
{
    for (;;)
    {
        if ( !isalive( var_0 ) )
        {
            wait 4;
            thread maps\_utility::autosave_by_name( "seeker" );
            return;
        }

        wait 0.05;
    }
}

check_to_activate( var_0, var_1 )
{
    for (;;)
    {
        if ( distance2d( level.window_guy.origin, level.player.origin ) < 250 )
        {
            var_0.ignoreall = 0;
            level.window_guy notify( "flashlight_off" );
            level.player.ignoreme = 0;
            return;
        }

        wait 0.05;
    }
}

wall_pull_animation_dialogue()
{
    wait 6;
    wait 3;
    wait 4.5;
    common_scripts\utility::flag_set( "begin_final_slice_moment" );
    wait 3;
    soundscripts\_snd::snd_message( "detroit_kva_bauerdoyoureadme" );
    wait 7;
}

burke_shimmey_setup()
{
    if ( level.currentgen )
    {
        for (;;)
        {
            if ( istransientloaded( "detroit_school_interior_tr" ) )
                break;

            wait 0.2;
        }
    }

    var_0 = maps\_utility::spawn_anim_model( "school_blockage" );
    thread maps\detroit_lighting::blockage_lighting( var_0 );
    var_1 = getent( "school_player_fall_first_floor", "targetname" );
    var_1 thread maps\_anim::anim_first_frame_solo( var_0, "burke_wall_walk" );
    var_2 = getent( "placed_beam_clip", "targetname" );
    var_3 = getent( "placed_beam_clip_final", "targetname" );
    maps\_utility::disable_trigger_with_targetname( "trigger_shimmey_ok" );
    maps\_utility::trigger_wait_targetname( "start_burke_shimmey" );
    thread maps\detroit::battle_chatter_off_both();
    maps\_utility::enable_trigger_with_targetname( "trigger_shimmey_ok" );
    common_scripts\utility::flag_set( "resume_100_speed" );
    thread det_debris_falling();
    var_4 = [ var_0, level.burke ];
    thread beam_clip_disable_function();
    var_1 maps\_anim::anim_single( var_4, "burke_wall_walk" );
    common_scripts\utility::flag_set( "burke_is_shimmey_halfway_can_continue" );

    if ( !common_scripts\utility::flag( "flag_burke_stop_idle_at_shimmy" ) )
        var_1 thread maps\_anim::anim_loop_solo( level.burke, "burke_shimmey_wait_idle", "ender" );

    common_scripts\utility::flag_wait( "flag_burke_stop_idle_at_shimmy" );
    var_1 notify( "ender" );
    level.burke maps\_utility::anim_stopanimscripted();
    var_1 maps\_anim::anim_single_solo( level.burke, "burke_shimmey_wait_idle_out" );
    var_1 thread maps\_anim::anim_loop_solo( level.burke, "burke_wall_walk_idle", "ender" );
    common_scripts\utility::flag_wait( "school_player_falling" );
    thread maps\detroit_lighting::player_fall_lighting();
    var_1 notify( "ender" );
    var_1 thread maps\_anim::anim_single_solo( level.burke, "school_fall" );
    maps\_utility::activate_trigger_with_targetname( "burke_finished_walk" );
}

take_every_grenade_now()
{
    common_scripts\utility::flag_wait( "flag_player_shimmy_start" );
}

beam_clip_disable_function()
{
    var_0 = getent( "placed_beam_clip", "targetname" );
    var_1 = getent( "placed_beam_clip_final", "targetname" );
    wait 2.45;
    var_0 delete();
    var_1 solid();
}

det_debris_falling()
{
    common_scripts\utility::flag_wait( "burke_is_shimmey_halfway_can_continue" );
    common_scripts\utility::flag_wait( "flag_burke_stop_idle_at_shimmy" );
    var_0 = getent( "burke_fx_footdrop", "targetname" );
    var_1 = anglestoforward( var_0.origin );
    playfx( common_scripts\utility::getfx( "det_debris_falling" ), var_0.origin, var_1 );
    wait 0.6;
    wait 1;
    thread spawn_kva_downstairs();
}

setup_player_fall()
{
    if ( level.currentgen )
    {
        for (;;)
        {
            if ( istransientloaded( "detroit_school_interior_tr" ) )
                break;

            wait 0.2;
        }
    }

    var_0 = getent( "school_player_fall_first_floor", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "floorboards" );
    var_2 = maps\_utility::spawn_anim_model( "school_floor" );
    waitframe();
    var_0 thread maps\_anim::anim_loop_solo( var_1, "det_school_fall_shuffle_pt0_idle_beams", "stop_player_shuffle_loop" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_2, "school_fall" );
    var_3 = getent( "basement_clip_block", "targetname" );
    var_3 notsolid();
    var_3 connectpaths();
    common_scripts\utility::flag_wait( "flag_player_shimmy_start" );
    var_0 notify( "stop_player_shuffle_loop" );
    var_4 = maps\_utility::spawn_anim_model( "world_body" );
    var_4 hide();
    var_0 maps\_anim::anim_first_frame_solo( var_4, "school_fall_stand_2_shuffle" );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    var_5 = 0.5;
    level.player stopanimscripted();
    level.player allowmelee( 0 );
    level.player playerlinktoblend( var_4, "tag_player", var_5, var_5 / 3, var_5 / 3 );
    var_4 common_scripts\utility::delaycall( var_5, ::show );
    wait(var_5);
    level.player playerlinktodelta( var_4, "tag_player", 1, 80, 20, 20, 20, 1 );
    var_6 = distance2d( level.burke.origin, level.player.origin );

    if ( var_6 > 70 )
    {
        soundscripts\_snd::snd_message( "player_shimmy_intro", "short_version" );
        var_0 thread maps\_anim::anim_single_solo( var_1, "det_school_fall_stand_2_shuffle_beams" );
        var_0 maps\_anim::anim_single_solo( var_4, "school_fall_stand_2_shuffle" );
    }
    else
    {
        soundscripts\_snd::snd_message( "player_shimmy_intro", "long_version" );
        var_0 thread maps\_anim::anim_single_solo( var_1, "det_school_fall_stand_2_shuffle_beams" );
        var_0 maps\_anim::anim_single_solo( var_4, "det_school_fall_stand_2_shuffle_slow_vm" );
    }

    var_0 thread maps\_anim::anim_loop_solo( var_4, "school_fall_shuffle_pt0_idle", "stop_player_shuffle_loop" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "det_school_fall_shuffle_pt0_idle_beams", "stop_player_shuffle_loop" );
    waittill_player_tries_to_advance();
    var_0 notify( "stop_player_shuffle_loop" );
    level notify( "player_linked" );
    thread maps\detroit_lighting::burke_walk_lighting();
    var_0 thread maps\_anim::anim_single_solo( var_1, "det_school_fall_shuffle_pt1_beams" );
    var_0 maps\_anim::anim_single_solo( var_4, "school_fall_shuffle_pt1" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "det_school_fall_shuffle_pt1_idle_beams", "stop_player_shuffle_loop" );
    var_0 thread maps\_anim::anim_loop_solo( var_4, "school_fall_shuffle_pt1_idle", "stop_player_shuffle_loop" );
    waittill_player_tries_to_advance();
    var_0 notify( "stop_player_shuffle_loop" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "det_school_fall_shuffle_pt2_beams" );
    var_0 maps\_anim::anim_single_solo( var_4, "school_fall_shuffle_pt2" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "det_school_fall_shuffle_pt2_idle_beams", "stop_player_shuffle_loop" );
    var_0 thread maps\_anim::anim_loop_solo( var_4, "school_fall_shuffle_pt2_idle", "stop_player_shuffle_loop" );
    waittill_player_tries_to_advance();
    var_0 notify( "stop_player_shuffle_loop" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "det_school_fall_shuffle_pt3_beams" );
    var_0 maps\_anim::anim_single_solo( var_4, "school_fall_shuffle_pt3" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "det_school_fall_shuffle_pt3_idle_beams", "stop_player_shuffle_loop" );
    var_0 thread maps\_anim::anim_loop_solo( var_4, "school_fall_shuffle_pt3_idle", "stop_player_shuffle_loop" );
    waittill_player_tries_to_advance();
    var_0 notify( "stop_player_shuffle_loop" );
    level.player springcamenabled( 0, level.detroit_spring_cam_lerp_speed, level.detroit_spring_cam_release_speed );
    var_0 thread maps\_anim::anim_single_solo( var_1, "det_school_fall_shuffle_pt4_beams" );
    var_0 maps\_anim::anim_single_solo( var_4, "school_fall_shuffle_pt4" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "det_school_fall_shuffle_pt4_idle_beams", "stop_player_shuffle_loop" );
    var_0 thread maps\_anim::anim_loop_solo( var_4, "school_fall_shuffle_pt4_idle", "stop_player_shuffle_loop" );
    waittill_player_tries_to_advance();
    var_0 notify( "stop_player_shuffle_loop" );
    common_scripts\utility::flag_set( "school_player_falling" );
    common_scripts\utility::flag_set( "school_jeep_delete" );
    soundscripts\_snd::snd_message( "school_fall" );
    common_scripts\utility::flag_set( "obj_check_school_complete" );
    common_scripts\utility::flag_set( "vo_school_holdtight" );
    level.player lerpviewangleclamp( 1, 0.25, 0.25, 0, 0, 0, 0 );
    var_7 = maps\_utility::spawn_anim_model( "gun" );
    var_0 thread maps\_anim::anim_single_solo( var_7, "school_fall" );
    thread cracked_floor_function();
    thread kva_spot_player_durring_fall();
    var_0 thread maps\_anim::anim_single_solo( var_1, "det_school_fall_beams" );
    thread school_fall_frame_hide();
    var_0 thread maps\_anim::anim_single_solo( var_2, "school_fall" );
    level.player playerlinktodelta( var_4, "tag_player", 1, 80, 20, 20, 20, 1 );
    thread school_fall_rumble();
    var_0 maps\_anim::anim_single_solo( var_4, "school_fall" );
    level.player maps\_shg_utility::setup_player_for_gameplay();
    var_1 hide();
    level.player unlink();
    var_4 delete();
    var_7 delete();
    common_scripts\utility::flag_set( "obj_reunite_with_burke_give" );
    level.player setmovespeedscale( 0.7 );
    level.player enableweapons();
    setsaveddvar( "ammoCounterHide", 0 );

    foreach ( var_9 in level.player getweaponslistprimaries() )
        level.player takeweapon( var_9 );

    foreach ( var_12 in level.player getweaponslistoffhands() )
        level.player setweaponammostock( var_12, 0 );

    level.player allowsprint( 0 );
    level.player allowcrouch( 1 );
    level.player allowmelee( 1 );
    level.player allowprone( 1 );
    level.player thread maps\detroit::handle_unarmed_viewbob();
    level.player giveweapon( "iw5_titan45_sp" );
    level.player switchtoweapon( "iw5_titan45_sp" );
    level.player setweaponammostock( "iw5_titan45_sp", 0 );
    level.player setweaponammoclip( "iw5_titan45_sp", 1 );
    level.player thread remove_unarmed_when_pickup_new_wep();
    thread maps\_utility::autosave_by_name( "seeker" );
    common_scripts\utility::flag_wait( "basement_clear" );
    var_2 delete();
}

remove_unarmed_when_pickup_new_wep()
{
    level endon( "weapon_take_no_longer_needed" );

    for (;;)
    {
        var_0 = level.player maps\_utility::get_storable_weapons_list_primaries();

        if ( var_0.size == 2 )
        {
            level.player takeweapon( "iw5_titan45_sp" );
            level.player allowsprint( 1 );
            maps\_player_exo::player_exo_activate();
            level notify( "player_no_longer_unarmed" );
            return;
        }

        wait 0.05;
    }
}

school_fall_slowmo_lerp()
{
    wait 2.05;
    maps\_utility::slowmo_lerp_in();
    wait 0.5;
    maps\_utility::slowmo_lerp_out();
}

school_fall_frame_hide()
{
    var_0 = getentarray( "school_fall_frame", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();
}

slowmo_in_wait_function()
{
    level waittill( "begin_slowmo_lerp_in" );
    wait 1.5;
    soundscripts\_snd::snd_message( "wall_pull_slowmo", "begin" );
    setslowmotion( level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in );
    wait(level.slowmo.lerp_time_in);
    thread lerp_time_function_wallpull();
}

kva_spot_player_durring_fall()
{
    var_0 = getnode( "player_fall_kva_animated_moment_org", "targetname" );
    var_1 = getent( "player_fall_kva_animated_moment_spawner", "targetname" );
    var_2 = getent( "kva_animated_moment_org_new", "targetname" );
    var_3 = getent( "kva_animated_moment_org", "targetname" );
    wait 2.66;
    level notify( "delete_walkthrough_guys" );
    wait 8.95;
    var_4 = var_1 maps\_utility::spawn_ai( 1 );
    var_4 maps\detroit_lighting::add_enemy_flashlight( "flashlight", "med" );
    var_4 maps\detroit::set_patrol_anim_set( "active", 1 );
    var_4.ignoreall = 1;
    var_4.ignoreme = 1;
    var_4.goalradius = 15;
    var_4.animname = "kva";
    var_3 maps\_anim::anim_reach_solo( var_4, "so_hijack_search_flashlight_high_loop" );
    level.school_kva_spot_guy = var_4;
    maps\_utility::delaythread( 2, common_scripts\utility::flag_set, "vo_school_kva_checkcomms" );
    var_2 thread maps\_anim::anim_loop_solo( var_4, "so_hijack_search_flashlight_high_loop" );
    common_scripts\utility::flag_set( "vo_school_burke_post_fall" );
    common_scripts\utility::flag_wait( "flag_start_kva_basement" );
    var_4 delete();
}

cracked_floor_function()
{
    wait 2.2;
    common_scripts\utility::flag_set( "show_cracked_floor" );
    wait 11.6;
    common_scripts\utility::flag_set( "delete_cracked_floor" );
    soundscripts\_snd::snd_message( "school_fall_into_basement" );
}

basement_door_clip_function()
{
    var_0 = getent( "basement_door_ai_clip_extra", "targetname" );
    var_1 = getent( "basement_door_clip", "targetname" );
    var_0 linkto( self, "jo_door_l" );
    var_1 linkto( self, "jo_door_l" );
    common_scripts\utility::flag_wait( "connect_basement_door_clip" );
    var_1 connectpaths();
    var_0 connectpaths();
}

waittill_player_tries_to_advance()
{
    while ( level.player getnormalizedmovement()[1] > -0.25 || distance2d( level.player.origin, level.burke.origin ) < 64 )
        waitframe();
}

spawn_patroller_guide_floor2()
{
    var_0 = getent( "spawner_school_f2_patroller_1", "targetname" );
    var_1 = getent( "guy2_hide_spot_origin", "targetname" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_floor2_patroller_1" );
    common_scripts\utility::flag_set( "basement_clear" );
    var_2 = getent( "basement_clip_block", "targetname" );
    var_2 solid();
    var_2 disconnectpaths();
    level.patroller = var_0 maps\_shg_design_tools::actual_spawn();
    level.patroller maps\_utility::disable_surprise();
    level.patroller maps\_utility::disable_pain();
    level.patroller.goalradius = 15;
    level.patroller setgoalentity( var_1 );
    level.patroller.animname = "kva";
    level.patroller thread make_me_alert();
    level.patroller thread bump_into_awareness();
    level.patroller thread change_to_run_after_time( 18 );
    level.patroller thread maps\detroit::set_patrol_anim_set( "active_forward", 1 );
    level.patroller thread maps\detroit_lighting::add_enemy_flashlight( "flashlight", "med" );
    level.patroller thread maps\detroit_lighting::enemy_flashlight_toggle_think( "trig_flashlight_patroller_on", "trig_flashlight_patroller_off" );
    level.patroller thread delete_me_on_goal_special( var_1 );
    level.patroller thread stealth_guy_think();
    level.patroller thread ambush_wait();
    level.patroller thread call_for_backup();
    level.patroller thread i_have_seen_the_player();
    level.patroller endon( "death" );
    level.patroller waittill( "_stealth_spotted" );
    level.patroller maps\_utility::player_seek();
}

call_for_backup()
{
    self endon( "death" );
    self waittill( "damage" );
    var_0 = common_scripts\_destructible::getdamagetype( self.damagemod );

    if ( isdefined( self.attacker ) && self.attacker == level.player && var_0 == "bullet" )
    {

    }

    common_scripts\utility::flag_set( "kill_scare_team" );
    maps\_utility::activate_trigger_with_targetname( "new_hall_troops_trigger" );
}

pursue_player()
{
    self endon( "death" );
    common_scripts\utility::waittill_any( "make_me_alert_now" );

    for (;;)
    {
        wait(randomfloatrange( 1.1, 3.3 ));
        var_0 = distance( self.origin, level.player.origin );

        if ( var_0 > 70 )
            self setgoalpos( level.player.origin );
    }
}

make_me_alert( var_0 )
{
    self endon( "death" );
    common_scripts\utility::waittill_any( "make_me_alert_now", "damage", "alert" );

    if ( isdefined( var_0 ) )
        common_scripts\utility::flag_set( var_0 );

    self setgoalpos( level.player.origin );
    level notify( "stop_animating_the_basement_door" );
    self notify( "_stealth_spotted" );
    self notify( "end_patrol" );
    remove_patrol_anim_set();
    self notify( "flashlight_off" );
    maps\_utility::enable_pain();
    maps\_utility::disable_careful();
    thread maps\_utility::player_seek();
    maps\_utility::anim_stopanimscripted();
}

delete_me_on_goal_special( var_0 )
{
    self endon( "death" );
    self endon( "alert" );
    self endon( "damage" );
    self endon( "_stealth_spotted" );
    is_1_near_2( self, var_0, 40 );
    self delete();
}

damage_change_goal()
{
    self endon( "death" );
    self waittill( "damage" );
    self setgoalpos( level.player.origin );
    thread maps\_utility::player_seek();
    maps\_utility::enable_pain();
}

ambush_wait()
{
    self endon( "death" );
    level waittill( "alert_stairs_team" );
    self notify( "make_me_alert_now" );
}

goal_and_interupt()
{
    self endon( "death" );
    self endon( "alert" );
    self endon( "damage" );
    self endon( "_stealth_spotted" );
    var_0 = getnode( "node_searcher_goto1", "targetname" );
    level.patroller setgoalnode( var_0 );
    level.patroller waittill( "goal" );
    wait 1;
    level.patroller delete();
}

break_out_and_fight()
{
    common_scripts\utility::waittill_any( "alert", "damage", "_stealth_spotted" );
    remove_patrol_anim_set();
    self notify( "end_patrol" );
    self notify( "flashlight_off" );
    maps\_utility::player_seek();
}

change_to_run_after_time( var_0 )
{
    self endon( "death" );
    self endon( "alert" );
    self endon( "damage" );
    self endon( "_stealth_spotted" );
    self endon( "make_me_alert_now" );
    wait(var_0);
    remove_patrol_anim_set();
    self notify( "end_patrol" );
    self notify( "flashlight_off" );
}

change_to_run_now()
{
    common_scripts\utility::waittill_any( "alert", "damage", "_stealth_spotted" );
    remove_patrol_anim_set();
    self notify( "end_patrol" );
    self notify( "flashlight_off" );
}

player_kill_function()
{
    self endon( "death" );
    level.player endon( "death" );
    var_0 = level.player.health;

    for (;;)
    {
        if ( level.player.health < var_0 )
        {
            var_1 = level.player.health;

            for (;;)
            {
                if ( level.player.health < var_1 )
                    level.player kill();

                wait 0.05;
            }
        }

        wait 0.1;
    }
}

setup_hazmant_suit_room()
{
    thread spawn_patroller_guide_floor2();
}

school_bodies_room_no_crouching()
{
    level endon( "stop_tracking_backtrack" );
    var_0 = getent( "no_player_crouch_here", "targetname" );
    var_1 = getent( "no_player_crouch_here_2", "targetname" );
    var_2 = getent( "no_player_crouch_here_3", "targetname" );

    for (;;)
    {
        if ( level.player istouching( var_0 ) )
            level.player allowprone( 0 );
        else if ( level.player istouching( var_1 ) )
            level.player allowprone( 0 );
        else if ( level.player istouching( var_2 ) )
            level.player allowprone( 0 );
        else
            level.player allowprone( 1 );

        wait 0.05;
    }
}

player_leaving_bodyroom_gag()
{
    var_0 = getent( "bodies_room_gag_used", "targetname" );
    var_0 makeusable();
    var_1 = getent( "player_viewmodel_door_animorg", "targetname" );
    var_2 = maps\_utility::spawn_anim_model( "body_room_exit_door" );
    var_3 = spawn( "script_model", ( 0, 0, 0 ) );
    var_3.animname = var_2.animname;
    var_3 maps\_utility::assign_animtree();
    var_3 setmodel( "det_school_door_01_anim_obj" );

    if ( level.currentgen )
    {
        if ( !istransientloaded( "detroit_school_interior_tr" ) )
        {
            for (;;)
            {
                wait 0.25;

                if ( istransientloaded( "detroit_school_interior_tr" ) )
                    break;
            }
        }
    }

    var_1 maps\_anim::anim_first_frame_solo( var_2, "body_room_exit" );
    var_1 maps\_anim::anim_first_frame_solo( var_3, "body_room_exit" );
    var_4 = getent( "bodies_room_door2_clip", "targetname" );
    var_4 linkto( var_2, "jo_door_l" );
    var_2 showallparts();
    var_3 hideallparts();
    var_5 = maps\_utility::spawn_anim_model( "world_hands" );
    var_5 hide();
    level waittill( "show_glowing_door" );
    thread nag_player_get_door();
    var_0 waittill( "trigger", var_6 );
    common_scripts\_exploder::exploder( 5622 );
    common_scripts\utility::flag_set( "player_used_bodies_room_door" );
    var_0 makeunusable();
    var_2 setmodel( "det_school_door_01_anim" );
    var_2 showallparts();
    var_3 delete();
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    var_7 = 0.5;
    soundscripts\_snd::snd_message( "body_room_exit" );
    var_1 maps\_anim::anim_first_frame_solo( var_5, "body_room_exit" );
    level.player playerlinktoblend( var_5, "tag_player", var_7 );
    level.player common_scripts\utility::delaycall( var_7, ::playerlinktodelta, var_5, "tag_player", 0, 0, 0, 0, 0, 1 );
    wait(var_7);
    level notify( "player_door_open" );
    level.burke notify( "stop_idling_in_deadroom" );
    thread bodyroom_gag_ghost_function();
    common_scripts\_exploder::exploder( 5612 );
    var_5 show();
    var_8 = [ var_5, var_2 ];
    thread finish_bodies_room_burke();
    thread bodyroom_gag_support_function();
    var_1 maps\_anim::anim_single( var_8, "body_room_exit" );
    var_9 = level.player common_scripts\utility::spawn_tag_origin();
    var_9.origin += ( 0, 0, 0.167 );
    level.player maps\_utility::teleport_player( var_9 );
    level.player unlink();
    var_5 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player allowsprint( 0 );
    maps\_player_exo::player_exo_deactivate();
}

nag_player_get_door()
{
    for (;;)
    {
        wait(randomintrange( 4, 7 ));

        if ( common_scripts\utility::flag( "player_used_bodies_room_door" ) )
            return;

        var_0 = randomint( 2 );

        if ( var_0 == 0 )
        {
            level.burke maps\_utility::dialogue_queue( "det_gdn_thedoormitchell" );
            continue;
        }

        level.burke maps\_utility::dialogue_queue( "det_gdn_getthedoor" );
    }
}

bodyroom_gag_support_function()
{
    common_scripts\utility::flag_set( "burke_leaving_bodies_room" );
    level notify( "disable_burke_bodiesroom_idle" );
}

bodyroom_gag_ghost_function()
{
    var_0 = getent( "bodies_room_gag_spawner", "targetname" );
    var_1 = getent( "bodies_room_gag_anim_org_new", "targetname" );
    wait 2.7;
    soundscripts\_snd::snd_message( "new_ghost_gag_stinger" );
}

burke_deadroom_door()
{
    var_0 = getent( "burke_bodies_anim_origin", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "school_door", var_0.origin );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "burke_school_door" );
    var_2 = getent( "bodies_room_door1_clip", "targetname" );
    var_2 linkto( var_1, "jo_door_l" );
    common_scripts\utility::flag_wait( "open_school_door" );
    wait 2.95;
    var_0 maps\_anim::anim_single_solo( var_1, "burke_school_door" );
    thread player_leaving_bodyroom_gag();
}

#using_animtree("generic_human");

get_burke_to_deadroom()
{
    level endon( "disable_burke_bodiesroom_idle" );
    level.burke.animname = "burke";
    var_0 = getent( "burke_bodies_anim_origin", "targetname" );

    if ( distance( level.player.origin, level.burke.origin ) > 200 )
        var_0 thread maps\_anim::anim_loop_solo( level.burke, "wait_by_door" );

    while ( distance( level.player.origin, level.burke.origin ) > 200 )
        waitframe();

    level.burke maps\_shg_design_tools::anim_stop( var_0 );
    level.burke maps\_shg_design_tools::anim_stop( level.burke );
    common_scripts\_exploder::exploder( 5568 );
    var_1 = undefined;

    if ( level.nextgen )
    {
        var_2 = getent( "school_deadbody_burke_look", "targetname" );
        var_3 = var_2 spawndrone();
        var_3 setcontents( 0 );
    }
    else
    {
        var_3 = spawn( "script_model", var_0.origin );
        var_3 setmodel( "civ_urban_male_dead_body_a" );
        var_1 = "head_male_sp_siejak";
        var_3 attach( var_1, "", 1 );
    }

    var_3 useanimtree( #animtree );
    var_3.animname = "generic";
    var_0 thread maps\_anim::anim_first_frame_solo( var_3, "touch_dead_npc" );
    thread animate_dead_body( var_3, var_0 );
    maps\_utility::disable_trigger_with_targetname( "bodies_room_gag_used" );
    thread bodies_gag_door_trigger();
    maps\_utility::delaythread( 20, common_scripts\utility::flag_set, "vo_school_deadroom" );
    common_scripts\utility::flag_set( "open_school_door" );
    thread school_bodies_room_no_crouching();
    var_0 maps\_anim::anim_single_solo( level.burke, "go_into_deadroom" );

    if ( common_scripts\utility::flag_exist( "burke_needs_to_idle" ) )
        var_0 thread maps\_anim::anim_loop_solo( level.burke, "deadroom_idle", "stop_idling_in_deadroom" );

    common_scripts\utility::flag_wait( "player_used_bodies_room_door" );
    var_0 notify( "stop_idling_in_deadroom" );
}

finish_bodies_room_burke()
{
    common_scripts\utility::flag_clear( "burke_needs_to_idle" );
    level.burke maps\_utility::set_generic_run_anim( "stealth_walk", 0 );
    soundscripts\_snd::snd_message( "finish_bodies_room_burke" );
    common_scripts\utility::flag_wait( "burke_leaving_bodies_room" );
    thread maps\_utility::autosave_by_name();
    var_0 = getent( "burke_bodies_anim_origin_updated", "targetname" );
    var_0 notify( "stop_idling_in_deadroom" );
    level.burke notify( "stop_idling_in_deadroom" );
    common_scripts\utility::flag_set( "obj_check_school_on_burke" );
    var_0 maps\_anim::anim_single_solo( level.burke, "exit_burke" );
    level.burke notify( "facelight_off" );
    level.burke.animname = "burke";
    var_1 = getent( "new_burke_stairs_check_animorg", "targetname" );
    var_1 thread maps\_anim::anim_loop_solo( level.burke, "burke_stairs_idle_inside", "stop_stairs_inside_idle" );
    common_scripts\utility::flag_set( "vo_school_stairs" );
    common_scripts\utility::flag_wait( "player_near_burke_school_bottom_stairs" );
    waitframe();
    thread gideon_keep_up_fail_trigger( "player_escaping_the_school" );
    thread maps\_utility::autosave_by_name();
    var_1 notify( "stop_stairs_inside_idle" );
    level.burke notify( "stop_stairs_inside_idle" );
    thread shit_blocked_upstairs();
    level.burke stopanimscripted();
    var_1 stopanimscripted();
    var_1 maps\_anim::anim_single_solo( level.burke, "school_stair_walk" );
    begin_the_shimmey_for_burke();
}

begin_the_shimmey_for_burke()
{
    var_0 = getent( "burke_third_floor_corner_check_wait", "targetname" );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "burke_corner_left_idle", "burke_stop_left_idle" );
    is_player_near_burke( 400 );
    thread maps\_utility::autosave_by_name();
    var_0 notify( "burke_stop_left_idle" );
    level.burke notify( "flashlight_off" );
    maps\_utility::activate_trigger_with_targetname( "start_burke_shimmey" );
    common_scripts\utility::flag_wait( "flag_player_shimmy_start" );
    level.player maps\_utility::notify_delay( "flashlight_off", 2 );
}

shit_blocked_upstairs()
{
    wait 12.88;
    wait 6.4;
    soundscripts\_snd::snd_message( "burke_startle_stairs" );
    wait 1.6;
    common_scripts\utility::flag_set( "vo_school_thisway" );
}

setup_school_bodies()
{

}

school_drone_spawn( var_0 )
{
    var_1 = maps\_spawner::spawner_dronespawn( var_0 );
    var_1.animname = "generic";
    return var_1;
}
