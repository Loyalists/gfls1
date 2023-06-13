// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

hospital_main()
{
    thread final_approach();
    thread doctor_capture_inner_fight();
    thread hidden_kva();
    thread grenade_ambush();
    thread magic_grenades_thrown();
    thread hospital_desk_door_open();
    thread kva_last_heavy();

    if ( level.nextgen )
        thread setup_hospital_bodies();
    else
        thread maps\detroit_transients_cg::cg_setup_hospital_bodies();

    thread hospital_escape_door_function();
    thread doctor_capture_dialogue();
    thread kva_sentinel_atlas_reveal_moment();
    thread maps\detroit_streets::shoot_at_sentinel_agents();
    thread disable_enable_exit_flags();
    thread doctor_capture_door_breach_anim();
    thread doctor_capture_breach_door_prompt();

    if ( level.currentgen )
    {
        thread transient_middle_remove_nightclub_interior_begin();
        thread cg_visibility_proxy_office_interior();
    }
}

cg_visibility_proxy_office_interior()
{
    if ( level.currentgen && issubstr( level.transient_zone, "middle" ) )
    {
        var_0 = getent( "office_interior_model", "targetname" );
        var_0 hide();
        var_0 setcontents( 0 );
    }

    if ( level.currentgen && issubstr( level.transient_zone, "hospital" ) )
    {
        var_0 = getent( "office_interior_model", "targetname" );
        var_0 show();
    }
}

transient_middle_remove_nightclub_interior_begin()
{
    maps\_utility::trigger_wait_targetname( "CG_LoadHospitalTrigger" );
    level notify( "tff_pre_middle_remove_nightclub" );
    unloadtransient( "detroit_nightclub_interior_tr" );
    var_0 = getent( "office_interior_model", "targetname" );
    var_0 show();
    thread transient_middle_add_hospital_interior_begin();
}

transient_middle_add_hospital_interior_begin()
{
    loadtransient( "detroit_hospital_interior_tr" );

    for (;;)
    {
        if ( istransientloaded( "detroit_hospital_interior_tr" ) )
        {
            var_0 = getent( "office_interior_model", "targetname" );
            var_0 show();
            level notify( "tff_post_middle_add_hospital" );
            break;
        }

        wait 0.05;
    }
}

grenade_ambush()
{
    maps\_utility::trigger_wait_targetname( "grenade_trigger" );
    wait 0.9;
    var_0 = getentarray( "kva_grenade", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );
        var_3.goalradius = 15;
        var_3.ignoreall = 1;
        var_3 maps\_utility::magic_bullet_shield();
        thread guy_toss_grenade( var_3 );
    }
}

guy_toss_grenade( var_0 )
{
    maps\_utility::trigger_wait_targetname( "kva_grenade_throw_trigger" );
    var_0 maps\_utility::stop_magic_bullet_shield();
    var_0 maps\_utility::throwgrenadeatplayerasap();
    var_0.ignoreall = 0;
}

magic_grenades_thrown()
{
    maps\_utility::trigger_wait_targetname( "kva_grenade_throw_trigger" );
    thread grenade_1();
    thread grenade_2();
    thread grenade_3();
    common_scripts\utility::flag_set( "flashbang" );
    wait 2.25;
    level.player shellshock( "paris_scripted_flashbang", 4 );
    common_scripts\utility::flag_set( "player_is_shocked" );
    thread maps\_shg_design_tools::white_out( 0.12, 0.4 );
    thread flash_mob1();
    thread flash_mob2();
    thread flash_mob3();
}

hospital_desk_door_open()
{
    var_0 = getent( "kva_door_buster", "targetname" );
    var_1 = getent( "hospital_door_clip_open", "targetname" );
    var_2 = getent( "first_hospital_door_open", "targetname" );
    var_1 notsolid();
    var_3 = getent( "hospital_door_clip_closed", "targetname" );
    var_4 = getent( "first_hospital_door_closed", "targetname" );
    var_2 hide();
    common_scripts\utility::flag_wait( "player_is_shocked" );
    var_4 delete();
    var_3 connectpaths();
    var_3 delete();
    var_2 show();
    var_1 solid();
    wait 0.05;
    var_5 = var_0 maps\_utility::spawn_ai( 1 );
    var_5.goalradius = 15;
    var_5 maps\_utility::disable_surprise();
    var_5 maps\_utility::disable_careful();
    var_6 = getnode( "kva_door_buster_goal", "targetname" );
    var_5 setgoalnode( var_6 );
}

grenade_1()
{
    var_0 = getent( "magic_grenade_start", "targetname" );
    var_1 = getent( "magic_grenade_target", "targetname" );
    var_2 = magicgrenade( "flash_grenade_var", var_0.origin, var_1.origin, 2.25, 1 );
    soundscripts\_snd::snd_message( "hospital_flashbang1", 2.25, var_1.origin );
}

grenade_2()
{
    var_0 = getent( "magic_grenade_start2", "targetname" );
    var_1 = getent( "magic_grenade_target2", "targetname" );
    var_2 = magicgrenade( "flash_grenade_var", var_0.origin, var_1.origin, 2.25, 1 );
    soundscripts\_snd::snd_message( "hospital_flashbang2", 2.25, var_1.origin );
}

grenade_3()
{
    var_0 = getent( "magic_grenade_start3", "targetname" );
    var_1 = getent( "magic_grenade_target3", "targetname" );
    var_2 = magicgrenade( "flash_grenade_var", var_0.origin, var_1.origin, 2.25, 1 );
    soundscripts\_snd::snd_message( "hospital_flashbang3", 2.25, var_1.origin );
}

flash_mob1()
{
    var_0 = getent( "flash_mob_1", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.animname = "generic";
    var_1.ignoreall = 1;
    var_1.allowdeath = 1;
    var_2 = getent( "hospital_mantle_1", "targetname" );
    var_2 maps\_anim::anim_single_solo( var_1, "hospital_mantle" );
    var_1.ignoreall = 0;
    var_3 = getnode( "kva_jumper_1_goal", "targetname" );
    var_1 setgoalnode( var_3 );
}

flash_mob2()
{
    var_0 = getent( "flash_mob_2", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.animname = "generic";
    var_1.ignoreall = 1;
    var_1.allowdeath = 1;
    var_2 = getent( "hospital_mantle_2", "targetname" );
    var_2 maps\_anim::anim_single_solo( var_1, "hospital_mantle_2" );
    var_1.ignoreall = 0;
    var_3 = getnode( "kva_jumper_2_goal", "targetname" );
    var_1 setgoalnode( var_3 );
}

flash_mob3()
{
    var_0 = getent( "flash_mob_3", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai();

    if ( isdefined( var_1 ) )
    {
        var_2 = getent( "hospital_fight_goal1", "targetname" );
        var_1 setgoalvolumeauto( var_2 );
    }
}

setup_hospital()
{
    thread team_move_hospital();
    thread hospital_kva_cleanup();
    thread make_gate_close_down();
    level.burke maps\_utility::enable_careful();
    level.joker maps\_utility::enable_careful();
    level.bones maps\_utility::enable_careful();
    var_0 = getent( "dr_first_anim_org", "targetname" );
    maps\_utility::trigger_wait_targetname( "kva_grenade_throw_trigger" );
    var_0 notify( "finish" );
    thread kva_ar();
    var_1 = getent( "kva_hospital_heavy_special", "targetname" );
    var_2 = var_1 maps\_utility::spawn_ai( 1 );
    var_2.combatmode = "no_cover";
    var_3 = getent( "hospital_fight_goal1", "targetname" );
    var_2 setgoalvolumeauto( var_3 );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_doctor" );
    common_scripts\utility::flag_set( "doctor_inside_office_now" );
}

make_gate_close_down()
{
    var_0 = getent( "gate_close_clip", "targetname" );
    var_0 notsolid();
    var_0 connectpaths();
    maps\_utility::trigger_wait_targetname( "doctor_chase_gate_close_trig" );
    var_0 solid();
    var_0 disconnectpaths();
    var_1 = getent( "hospital_gate_animated", "targetname" );
    var_2 = getent( "gate_close_origin", "targetname" );
    var_1 soundscripts\_snd::snd_message( "det_hospital_gate_close" );
    var_1 moveto( var_2.origin, 1, 0.9, 0.1 );
    var_3 = getent( "gate_lock_kva", "targetname" );
    var_4 = var_3 maps\_utility::spawn_ai( 0, 0 );
    var_4 waittill( "goal" );
    var_4 maps\_utility::player_seek_enable();
}

hospital_kva_cleanup()
{
    var_0 = getent( "kickdown", "targetname" );
    var_0 waittill( "trigger" );
    var_1 = 0;
    var_2 = getentarray( "killable", "script_noteworthy" );

    foreach ( var_4 in var_2 )
    {
        if ( isalive( var_4 ) )
        {
            var_4 thread maps\detroit_streets::random_bloody_death( 1.25 );
            var_1++;
        }
    }
}

hidden_kva()
{
    maps\_utility::trigger_wait_targetname( "kva_grenade_throw_trigger" );
    var_0 = getent( "special_KVA_cover_spawner", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai();
    var_1.ignoreall = 1;
    var_1.goalradius = 15;
    var_1 endon( "death" );
    maps\_utility::trigger_wait_targetname( "trigger_hidden_kva" );

    if ( isalive( var_1 ) )
        var_1.ignoreall = 0;
}

check_if_hurt( var_0 )
{
    while ( var_0.ignoreall == 1 )
    {
        if ( var_0.health < 100 )
        {
            var_0.ignoreall = 0;
            return;
        }

        wait 0.05;
    }
}

retreating_kva()
{
    self endon( "death" );
    maps\_utility::trigger_wait_targetname( "team_move_hospital" );
    var_0 = getentarray( "hospital_retreat_troops", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );
        var_3 maps\_utility::enable_careful();
        var_3 maps\_utility::set_moveplaybackrate( 0.8 );
        thread retreat_function( var_3 );
    }

    var_5 = getent( "hospital_retreat_shooter", "targetname" );
    var_6 = var_5 maps\_utility::spawn_ai( 1 );
    var_6.ignoreall = 1;
    var_6.animname = "generic";
    var_6 disable_awareness();
    var_7 = getent( "test_anim_spot", "targetname" );
    common_scripts\utility::flag_wait( "send_hospital_runner" );

    if ( isalive( var_6 ) )
    {
        var_6 maps\_utility::set_allowdeath( 1 );
        var_7 maps\_anim::anim_reach_solo( var_6, "run_and_shoot_behind" );

        if ( isalive( var_6 ) )
            var_7 thread maps\_anim::anim_single_solo( var_6, "run_and_shoot_behind" );

        var_6 enable_awareness();
        var_8 = getent( "hospital_fight_goal1", "targetname" );
        var_6 setgoalvolumeauto( var_8 );
    }

    if ( isalive( var_6 ) )
    {
        var_6 waittill( "goal" );
        var_6 maps\detroit::bloody_death( 0.25 );
    }
}

retreat_function( var_0 )
{
    common_scripts\utility::flag_wait( "go_go_go" );
    wait(randomintrange( 4, 8 ));

    if ( isdefined( var_0 ) )
    {
        var_1 = getent( "hospital_fight_goal1", "targetname" );
        var_0 setgoalvolumeauto( var_1 );
    }
}

team_move_hospital()
{
    common_scripts\utility::flag_wait( "exo_push_arrived" );
    level.burke stopanimscripted();
    level.burke unlink();
    wait 0.25;
    thread burke_advance_hospital();
    wait 0.25;
    thread joker_advance_hospital();
    wait 0.5;
    thread bones_advance_hospital();
    level.bones maps\_utility::set_force_color( "y" );
    level.joker maps\_utility::set_force_color( "o" );
}

hospital_escape_door_function()
{
    var_0 = getent( "hospital_escape_door_open", "targetname" );
    var_1 = getent( "hospital_escape_door_open_clip", "targetname" );
    var_2 = getent( "hospital_escape_door_closed", "targetname" );
    var_3 = getent( "hospital_escape_door_closed_clip", "targetname" );
    var_1 notsolid();
    var_0 hide();
    common_scripts\utility::flag_wait( "player_captured_doctor" );
    var_0 show();
    var_1 solid();
    var_3 connectpaths();
    var_2 delete();
    var_3 delete();
}

burke_advance_hospital()
{
    var_0 = getnode( "burke_holdup_before_going_upstairs_node", "targetname" );
    var_1 = getnode( "burke_hospital_hide", "targetname" );
    level.burke.ignoreall = 0;
    level.burke.goalradius = 15;
    wait 0.9;
    thread doctor_capture_new_breach_doctor_takedown();
    common_scripts\utility::flag_set( "go_go_go" );
    level.burke setgoalnode( var_0 );
    common_scripts\utility::flag_wait( "send_all_teammates_upstairs" );
    wait 0.5;
    level.burke setgoalnode( var_1 );
}

kva_sentinel_atlas_reveal_moment()
{
    var_0 = getent( "kva_sentinel_squad_reveal_animnode", "targetname" );
    thread player_sentinel_kva_reveal();
    thread bouncing_betty_animated();
    thread maps\detroit_lighting::sentinel_reveal_lighting();
    thread pay_machine();
    maps\_utility::trigger_wait_targetname( "sentinel_reveal_moment_trigger" );
    maps\_utility::delaythread( 6.69, common_scripts\utility::flag_set, "show_sentinel_guys_now" );
    level notify( "stop_180_burke_now" );
    thread player_jumped_out_vol();
    thread maps\detroit_streets::sneaky_reload();
    common_scripts\utility::flag_set( "reveal_the_sentinels" );
    common_scripts\utility::flag_set( "joker_wait_before_reveal" );
    thread sentinel_kva_fov_function();
    var_0 thread burke_sentinel_kva_reveal();
    var_0 thread guy1_sentinel_kva_reveal();
    var_0 thread guy2_sentinel_kva_reveal();

    if ( level.nextgen )
    {
        var_0 thread guy3_sentinel_kva_reveal();
        var_0 thread kva2_sentinel_kva_reveal();
    }

    var_0 thread kva1_sentinel_kva_reveal();
    var_0 thread kva3_sentinel_kva_reveal();
    var_0 thread joker_sentinel_kva_reveal();
    thread doctor_kva_reveal();
    thread kva_ambush_last_group_reveal();
    wait 28;
    common_scripts\utility::flag_set( "begin_kva_assault_on_sentinel" );
    wait 10.65;
}

player_jumped_out_vol()
{
    level.player endon( "death" );
    var_0 = getent( "player_jumped_out_sentinel", "targetname" );

    for (;;)
    {
        if ( level.player istouching( var_0 ) )
        {
            common_scripts\utility::flag_set( "exit_drive_cinematic_start" );
            return;
        }

        wait 0.05;
    }
}

pay_machine()
{
    if ( level.currentgen )
    {
        if ( !istransientloaded( "detroit_hospital_interior_tr" ) )
        {
            for (;;)
            {
                wait 0.25;

                if ( istransientloaded( "detroit_hospital_interior_tr" ) )
                    break;
            }
        }
    }

    var_0 = maps\_utility::spawn_anim_model( "pay_machine" );
    var_1 = getent( "kva_sentinel_squad_reveal_animnode", "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( var_0, "sentinel_kva_reveal" );
    common_scripts\utility::flag_wait( "knock_over_paymachine" );
    var_1 maps\_anim::anim_single_solo( var_0, "sentinel_kva_reveal" );
}

bouncing_betty_animated()
{
    var_0 = getent( "animated_destroy_box", "targetname" );
    var_1 = getent( "animated_bouncing_betty", "targetname" );
    var_2 = getent( "new_grenade_org", "targetname" );
    maps\_utility::trigger_wait_targetname( "sentinel_reveal_moment_trigger" );
    level notify( "no_more_random_trains" );
    setdemigodmode( level.player, 1 );
    soundscripts\_snd::snd_message( "reveal_scene_start" );
    var_1 moveto( var_1.origin + ( 0, 0, 50 ), 0.6, 0.3, 0.2 );
    wait 0.6;
    level.player shellshock( "paris_scripted_flashbang", 4 );
    var_3 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_3 maps\_utility::set_rumble_intensity( 0.5 );
    var_3 maps\_utility::delaythread( 0.8, maps\_utility::set_rumble_intensity, 0.01 );
    thread maps\detroit_fx::cg_sentinel_fx_light();
    soundscripts\_snd::snd_message( "reveal_explosion" );
    wait 0.3;
    common_scripts\utility::flag_set( "knock_over_paymachine" );
    var_1 delete();
    var_0 delete();
    wait 2;
    setdemigodmode( level.player, 0 );
}

sentinel_kva_fov_function()
{
    level.player lerpfov( 55, 2 );
    common_scripts\utility::flag_wait( "sentinel_kva_fov_lerp_out" );
    level.player lerpfov( 65, 1 );
}

joker_sentinel_kva_reveal()
{
    level.doctor.ignoreme = 1;
    level.joker hide();
    var_0 = getnode( "joker_with_doctor_waitnode", "targetname" );
    var_1 = getnode( "joker_with_doctor_goal_node", "targetname" );
    level.joker maps\_utility::teleport_ai( var_0 );
    level.joker setgoalnode( var_0 );
    level.joker maps\_utility::delaythread( 0.25, ::show_me_now );
    var_2 = getent( "joker_pickup_doctor_reveal_org", "targetname" );
    level.joker maps\_utility::gun_recall();
    thread maps\_anim::anim_single_solo( level.joker, "sentinel_kva_reveal" );
    common_scripts\utility::flag_wait( "send_joker_and_doctor_to_bikes" );
    var_2 thread maps\_anim::anim_first_frame_solo( level.doctor, "carry_doc_lift" );
    var_3 = getnode( "joker_with_doctor_waitnode_beforehall", "targetname" );
    thread doctor_capture_doctor_carry( var_2, "player_on_exitdrive_jetbike", var_3 );
    wait 5;
    common_scripts\utility::flag_set( "sentinel_reveal_animation_complete" );
    common_scripts\utility::flag_wait( "exit_drive_cinematic_start" );
    var_4 = getnode( "joker_wait_withdoc_after_reveal", "targetname" );
    level.joker setgoalnode( var_4 );
}

doctor_kva_reveal()
{
    var_0 = getent( "joker_pickup_doctor_reveal_org", "targetname" );
    var_0 maps\_anim::anim_first_frame_solo( level.doctor, "carry_doc_lift" );
}

show_me_now()
{
    self show();
}

burke_pre_sentinel_kva_reveal()
{
    level.burke thread final_flag_wait();
    var_0 = getnode( "burke_first_wait_after_capture_node", "targetname" );
    level.burke setgoalnode( var_0 );
    common_scripts\utility::flag_wait( "send_burke_to_stairs_waitpoint" );
    var_1 = getnode( "burke_wait_by_railwaydoor_node", "targetname" );
    level.burke setgoalnode( var_1 );
    common_scripts\utility::flag_wait( "send_burke_to_railway_half" );
    var_2 = getnode( "burke_half_railway_wait", "targetname" );
    level.burke setgoalnode( var_2 );
    common_scripts\utility::flag_wait( "send_burke_fully_across" );
    var_3 = getnode( "burke_post_before_sentinel_room", "targetname" );
    level.burke setgoalnode( var_3 );
    level.burke.radius = 15;
    maps\detroit_school::is_1_near_2( level.burke, var_3, 60 );
    common_scripts\utility::flag_wait( "make_burke_anim_reach_sentinel" );
    common_scripts\utility::flag_wait( "let_burke_reach_sentinel_reveal" );
    var_4 = getent( "burke_180_animorg", "targetname" );
    thread burke_180_function();
    common_scripts\utility::flag_wait( "joker_wait_before_doorway" );
    var_4 notify( "ender" );
    level.burke stopanimscripted();
    var_5 = getent( "kva_sentinel_squad_reveal_animnode", "targetname" );
    var_6 = getnode( "burke_wait_after_sentinel_moment", "targetname" );
    level.burke setgoalnode( var_6 );
}

burke_180_function()
{
    level.burke.animname = "burke";
    var_0 = getent( "burke_180_animorg", "targetname" );
    var_1 = getnode( "burke_wait_before_180", "targetname" );
    level.burke setgoalnode( var_1 );
    maps\detroit_school::is_1_near_2( level.burke, var_1, 100 );
    var_2 = getnode( "burke_wait_before_bomb", "targetname" );
    level.burke setgoalnode( var_2 );
}

final_flag_wait()
{
    var_0 = getnode( "burke_post_before_sentinel_room", "targetname" );

    for (;;)
    {
        if ( distance2d( level.burke.origin, var_0.origin ) < 50 )
        {
            common_scripts\utility::flag_set( "let_burke_reach_sentinel_reveal" );
            return;
        }

        wait 0.05;
    }
}

burke_sentinel_kva_reveal()
{
    level.burke stopanimscripted();
    var_0 = getent( "kva_sentinel_squad_reveal_animnode", "targetname" );
    var_0 thread maps\_anim::anim_single_solo( level.burke, "sentinel_kva_reveal" );
    level.burke.ignoreall = 1;
    level.burke.goalradius = 15;
    var_1 = getnode( "burke_wait_after_sentinel_moment", "targetname" );
    level.burke setgoalnode( var_1 );
}

kva_show_timer()
{
    self hide();
    wait 3.27;
    self show();
}

kill_me( var_0 )
{
    self endon( "death" );
    var_1 = self geteye();
    wait(var_0);

    if ( isalive( self ) )
    {
        magicbullet( "iw5_bal27_sp", level.sentinel_guy1 gettagorigin( "tag_flash" ), var_1 );
        magicbullet( "iw5_bal27_sp", level.sentinel_guy1 gettagorigin( "tag_flash" ), var_1 );
    }

    wait 0.1;

    if ( isalive( self ) )
    {
        magicbullet( "iw5_bal27_sp", level.sentinel_guy1 gettagorigin( "tag_flash" ), var_1 );
        magicbullet( "iw5_bal27_sp", level.sentinel_guy1 gettagorigin( "tag_flash" ), var_1 );
    }

    wait 0.1;

    if ( isalive( self ) )
    {
        magicbullet( "iw5_bal27_sp", level.sentinel_guy1 gettagorigin( "tag_flash" ), var_1 );
        magicbullet( "iw5_bal27_sp", level.sentinel_guy1 gettagorigin( "tag_flash" ), var_1 );
    }

    wait 0.1;

    if ( isalive( self ) )
    {
        magicbullet( "iw5_bal27_sp", level.sentinel_guy1 gettagorigin( "tag_flash" ), var_1 );
        magicbullet( "iw5_bal27_sp", level.sentinel_guy1 gettagorigin( "tag_flash" ), var_1 );
    }

    wait 0.1;

    if ( isalive( self ) )
    {
        magicbullet( "iw5_bal27_sp", level.sentinel_guy1 gettagorigin( "tag_flash" ), var_1 );
        magicbullet( "iw5_bal27_sp", level.sentinel_guy1 gettagorigin( "tag_flash" ), var_1 );
    }
}

kva1_sentinel_kva_reveal()
{
    var_0 = getent( "kva_reveal_spawner1", "targetname" );
    var_0.count = 1;
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.animname = "kva1";
    var_1 thread kva_show_timer();
    thread maps\_anim::anim_single_solo( var_1, "sentinel_kva_reveal" );
    var_1 setcontents( 0 );
    thread maps\detroit_lighting::sentinel_reveal_lighting_origins( var_1 );
    wait 10;
    var_2 = [ var_1 ];
    maps\_anim::anim_set_rate( var_2, "sentinel_kva_reveal", 0 );
    var_1.ignoreme = 1;
    var_1.ignoresonicaoe = 1;
    var_1 maps\_utility::pretend_to_be_dead();
}

kva2_sentinel_kva_reveal()
{
    var_0 = getent( "kva_reveal_spawner2", "targetname" );
    var_0.count = 1;
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.animname = "kva2";
    var_1 thread kva_show_timer();
    thread maps\_anim::anim_single_solo( var_1, "sentinel_kva_reveal" );
    var_1 setcontents( 0 );
    thread maps\detroit_lighting::sentinel_reveal_lighting_origins( var_1 );
    wait 10;
    var_2 = [ var_1 ];
    maps\_anim::anim_set_rate( var_2, "sentinel_kva_reveal", 0 );
    var_1.ignoreme = 1;
    var_1.ignoresonicaoe = 1;
    var_1 maps\_utility::pretend_to_be_dead();
}

kva3_sentinel_kva_reveal()
{
    var_0 = getent( "kva_reveal_spawner3", "targetname" );
    var_0.count = 1;
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.animname = "kva3";
    var_1 thread kva_show_timer();
    thread maps\_anim::anim_single_solo( var_1, "sentinel_kva_reveal" );
    var_1 setcontents( 0 );
    thread maps\detroit_lighting::sentinel_reveal_lighting_origins( var_1 );
    wait 10;
    var_2 = [ var_1 ];
    maps\_anim::anim_set_rate( var_2, "sentinel_kva_reveal", 0 );
    var_1.ignoreme = 1;
    var_1.ignoresonicaoe = 1;
    var_1 maps\_utility::pretend_to_be_dead();
}

player_sentinel_kva_reveal()
{
    var_0 = getent( "kva_sentinel_squad_reveal_animnode", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "world_body" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "sentinel_kva_reveal" );
    var_1 hide();
    maps\_utility::trigger_wait_targetname( "sentinel_reveal_moment_trigger" );
    thread maps\detroit_school::gideon_keep_up_fail_trigger( "player_escaping_animation_sentreveal_beforestairs" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    common_scripts\utility::flag_set( "burke_180_loop_end" );
    thread maps\detroit::battle_chatter_off_both();
    thread maps\detroit::hud_off();
    common_scripts\utility::flag_set( "obj_escape_detroit_pos_sentinel_reveal" );
    level.player maps\_shg_utility::setup_player_for_scene();
    level.player thread maps\_player_exo::player_exo_deactivate();
    var_2 = 0.01;
    level.player playerlinktoblend( var_1, "tag_player", var_2 );
    level.player common_scripts\utility::delaycall( var_2, ::playerlinktodelta, var_1, "tag_player", 1, 0, 0, 0, 0, 1 );
    var_1 common_scripts\utility::delaycall( var_2, ::show );
    var_1 thread view_clamping_unlock();

    if ( level.currentgen )
        var_0.origin += ( 0, 0, 1.5 );

    var_0 thread maps\_anim::anim_single_solo( var_1, "sentinel_kva_reveal" );
    wait 37;
    var_3 = level.player common_scripts\utility::spawn_tag_origin();
    var_3.origin += ( 0, 0, 0.268 );
    level.player maps\_utility::teleport_player( var_3 );
    level.player unlink();
    var_1 delete();
    common_scripts\utility::flag_set( "obj_escape_detroit_pos_exit_stairs" );
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player thread maps\_player_exo::player_exo_activate();
    thread maps\detroit::hud_on();
    common_scripts\utility::flag_set( "send_joker_and_doctor_to_bikes" );
}

wait_for_trigger_set_flag()
{
    maps\_utility::trigger_wait_targetname( "joker_pick_up_doctor" );
    common_scripts\utility::flag_set( "joker_pickup_doctor_is_ok_now" );
}

view_clamping_unlock()
{
    wait 8;
    level.player playerlinktodelta( self, "tag_player", 1, 20, 20, 20, 20, 1 );
}

decloak_wait_1()
{
    common_scripts\utility::flag_wait( "sentinel_reveal_guy1_decloak" );
    wait 1.9;
    thread cloak_off();
    thread set_helmet_open( 3, 2.45 );
    soundscripts\_snd::snd_message( "sent_guy_1_decloak" );
    maps\_utility::gun_remove();
    maps\_utility::forceuseweapon( "iw5_bal27_sp", "primary" );
    wait 5.2;
    common_scripts\utility::flag_wait( "sentinel_recloak" );
    wait 2.9;
    thread set_helmet_closed( 1.25, 1.1 );
    wait 1.5;
    wait 1.5;
    cloak_on();
}

decloak_wait_2()
{
    common_scripts\utility::flag_wait( "sentinel_reveal_guy2_decloak" );
    thread cloak_off();
    soundscripts\_snd::snd_message( "sent_guy_2_decloak" );
    common_scripts\utility::flag_wait( "sentinel_recloak" );
    wait 1.2;
    cloak_on();
}

decloak_wait_3()
{
    common_scripts\utility::flag_wait( "sentinel_reveal_guy3_decloak" );
    thread cloak_off();
    soundscripts\_snd::snd_message( "sent_guy_3_decloak" );
    common_scripts\utility::flag_wait( "sentinel_recloak" );
    wait 1.7;
    cloak_on();
}

unhide_me_on_flag( var_0 )
{
    common_scripts\utility::flag_wait( var_0 );
    wait(randomfloatrange( 0.2, 0.6 ));
    self show();
}

guy1_sentinel_kva_reveal()
{
    var_0 = getnode( "sentinel_cover_4", "targetname" );
    var_1 = getent( "sentinel_revealed_spawner3", "targetname" );
    var_1.count = 1;
    level.sentinel_guy1 = var_1 maps\_utility::spawn_ai( 1 );
    // level.sentinel_guy1 character\gfl\randomizer_sentinel::main();
    level.sentinel_guy1 thread unhide_me_on_flag( "show_sentinel_guys_now" );
    level.sentinel_guy1 maps\_utility::forceuseweapon( "iw5_bal27_sp", "primary" );
    level.sentinel_guy1 thread decloak_wait_1();
    level.sentinel_guy1 overridematerial( "mtl_burke_sentinel_covert_headgear_a", "mc/mtl_burke_sentinel_covert_headgear_a_cloak" );
    level.sentinel_guy1 assign_cloak_model( level.sentinel_guy1.model );
    level.sentinel_guy1 cloak_on();
    level.sentinel_guy1 maps\_utility::magic_bullet_shield();
    level.sentinel_guy1.ignoreall = 1;
    level.sentinel_guy1.ignoreme = 1;
    level.sentinel_guy1.animname = "guy1";
    maps\_anim::anim_single_solo( level.sentinel_guy1, "sentinel_kva_reveal" );
    thread maps\_anim::anim_loop_solo( level.sentinel_guy1, "sentinel_kva_reveal_idle" );
    level waittill( "cleanup_sentinel_guys" );
    level.sentinel_guy1 maps\_utility::stop_magic_bullet_shield();
    level.sentinel_guy1 delete();
}

guy2_sentinel_kva_reveal()
{
    var_0 = getnode( "sentinel_cover_1", "targetname" );
    var_1 = getent( "sentinel_revealed_spawner2", "targetname" );
    var_1.count = 1;
    var_2 = var_1 maps\_utility::spawn_ai( 1 );
    var_2 character\gfl\randomizer_sentinel::main();
    var_2 thread unhide_me_on_flag( "show_sentinel_guys_now" );
    var_2 maps\_utility::forceuseweapon( "iw5_bal27_sp", "primary" );
    var_2 thread decloak_wait_2();
    var_2 overridematerial( "mtl_burke_sentinel_covert_headgear_a", "mc/mtl_burke_sentinel_covert_headgear_a_cloak" );
    var_2 assign_cloak_model( var_2.model );
    var_2 cloak_on();
    var_2 maps\_utility::magic_bullet_shield();
    var_2.ignoreall = 1;
    var_2.ignoreme = 1;
    var_2.animname = "guy2";
    maps\_anim::anim_single_solo( var_2, "sentinel_kva_reveal" );
    thread maps\_anim::anim_loop_solo( var_2, "sentinel_kva_reveal_idle" );
    level waittill( "cleanup_sentinel_guys" );
    var_2 maps\_utility::stop_magic_bullet_shield();
    var_2 delete();
}

guy3_sentinel_kva_reveal()
{
    var_0 = getnode( "sentinel_cover_3", "targetname" );
    var_1 = getent( "sentinel_revealed_spawner1", "targetname" );
    var_1.count = 1;
    var_2 = var_1 maps\_utility::spawn_ai( 1 );
    var_2 character\gfl\randomizer_sentinel::main();
    var_2 thread unhide_me_on_flag( "show_sentinel_guys_now" );
    var_2 maps\_utility::forceuseweapon( "iw5_bal27_sp", "primary" );
    var_2 thread decloak_wait_3();
    var_2 overridematerial( "mtl_burke_sentinel_covert_headgear_a", "mc/mtl_burke_sentinel_covert_headgear_a_cloak" );
    var_2 assign_cloak_model( var_2.model );
    var_2 cloak_on();
    var_2 maps\_utility::magic_bullet_shield();
    var_2.ignoreall = 1;
    var_2.ignoreme = 1;
    var_2.animname = "guy3";
    maps\_anim::anim_single_solo( var_2, "sentinel_kva_reveal" );
    thread maps\_anim::anim_loop_solo( var_2, "sentinel_kva_reveal_idle" );
    maps\_utility::battlechatter_on( "axis" );
    level waittill( "cleanup_sentinel_guys" );
    var_2 maps\_utility::stop_magic_bullet_shield();
    var_2 delete();
}

reverse_cloak()
{
    common_scripts\utility::flag_wait( "decloak" );
}

temporary_sentinel_reveal_timing()
{
    wait 8.87;
    common_scripts\utility::flag_set( "vo_sentinel_reveal" );
}

kva_ambush_last_group_reveal()
{
    var_0 = getentarray( "sentinel_fight_kva_spawner", "targetname" );
    common_scripts\utility::flag_wait( "begin_kva_assault_on_sentinel" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );
        var_3.accuracy = 0;
        var_3.goalradius = 15;
        var_3 thread maps\_utility::set_grenadeammo( 0 );
        var_3 thread kill_me_on_sentrev_cleanup();
    }

    maps\_utility::trigger_wait_targetname( "bikes_reached" );

    if ( level.currentgen )
    {
        level.burke_bike show();
        level.joker_bike show();
        level.bones_bike show();

        if ( isdefined( level.player_bike ) )
            level.player_bike show();
    }

    var_5 = getent( "player_backtracking_sentinel_warning_vol", "targetname" );
    common_scripts\utility::flag_set( "vo_exit_drive_bikes_reached" );
    level notify( "cleanup_sentinel_guys" );
    var_6 = getent( "player_trying_to_exit_garage_warning", "targetname" );
    thread maps\detroit_school::player_exiting();
    thread mission_fail_warning( var_6 );
}

mission_fail_warning( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        level endon( "ok_to_stop_sentinel_reveal_warnings" );

    level.player endon( "death" );

    for (;;)
    {
        if ( level.player istouching( var_0 ) )
        {
            maps\_utility::hint( &"DETROIT_LEAVING_MISSION", 3 );
            wait 8;
        }

        wait 0.05;
    }
}

kill_me_on_sentrev_cleanup()
{
    level waittill( "cleanup_sentinel_guys" );
    wait(randomfloatrange( 0.25, 0.8 ));

    if ( isdefined( self ) )
        self kill();
}

cloak_again()
{
    wait 21;
    wait(randomfloatrange( 3.0, 8.0 ));

    if ( isdefined( self ) )
        cloak_on();
}

run_train_with_shaking( var_0, var_1, var_2, var_3 )
{
    var_4 = 650;
    var_5 = 3;

    if ( !isdefined( var_3 ) )
    {
        var_6 = "vehicle_civ_det_train_car_01";
        var_3 = spawn( "script_model", var_0.origin );
        var_3 setmodel( var_6 );
        var_3 thread maps\detroit_exit_drive::run_train_shaker( var_4, var_5 );
    }

    var_7 = common_scripts\utility::spawn_tag_origin();
    var_7 linkto( var_3, "", ( 300, 0, 80 ), ( 25, 0, 0 ) );
    var_8 = common_scripts\utility::spawn_tag_origin();
    var_8 linkto( var_3, "", ( 300, 0, 80 ), ( 0, 0, 0 ) );
    var_9 = common_scripts\utility::spawn_tag_origin();
    var_9 linkto( var_3, "", ( 200, 0, 15 ), ( 0, 90, 0 ) );
    thread maps\detroit_lighting::train_lighting( var_7, var_8, var_9 );

    if ( !isdefined( var_3.tags ) )
        var_3.tags = [];

    var_3.tags[var_3.tags.size] = var_7;
    var_3.tags[var_3.tags.size] = var_8;
    var_3.tags[var_3.tags.size] = var_9;
    var_3.origin = var_0.origin;
    var_3.angles = var_0.angles;
    var_1 = sortbydistance( var_1, var_0.origin );
    var_3 thread maps\detroit_streets::train_gopath( var_1, var_2 );
    return var_3;
}

delay_linkto_anim()
{
    level.player common_scripts\utility::delaycall( 10.94, ::playerlinktodelta, self, "tag_player", 15, 15, 15, 15, 0, 1 );
}

mission_fail_on_dead()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage" );

        if ( isdefined( self.lastattacker ) && self.lastattacker == level.player )
        {
            maps\_player_death::set_deadquote( &"DETROIT_DOCTOR_DEAD" );
            maps\_utility::missionfailedwrapper();
            common_scripts\utility::flag_set( "doctor_can_be_killed_now" );
        }

        wait 0.05;
    }
}

passoja_death_wait_function()
{
    self endon( "death" );
    level endon( "doctor_cant_die_anymore" );
    common_scripts\utility::flag_wait( "doctor_can_be_killed_now" );

    if ( isalive( self ) )
    {
        maps\_utility::stop_magic_bullet_shield();
        self stopanimscripted();
        doimmediateragdolldeath();
    }
}

doimmediateragdolldeath()
{
    animscripts\shared::dropallaiweapons();
    self.skipdeathanim = 1;
    var_0 = 10;
    var_1 = common_scripts\_destructible::getdamagetype( self.damagemod );

    if ( isdefined( self.attacker ) && self.attacker == level.player && var_1 == "melee" )
        var_0 = 5;

    var_2 = self.damagetaken;

    if ( var_1 == "bullet" )
        var_2 = max( var_2, 300 );

    var_3 = var_0 * var_2;
    var_4 = max( 0.3, self.damagedir[2] );
    var_5 = ( self.damagedir[0], self.damagedir[1], var_4 );

    if ( isdefined( self.ragdoll_directionscale ) )
        var_5 *= self.ragdoll_directionscale;
    else
        var_5 *= var_3;

    if ( self.forceragdollimmediate )
        var_5 += self.prevanimdelta * 20 * 10;

    if ( isdefined( self.ragdoll_start_vel ) )
        var_5 += self.ragdoll_start_vel * 10;

    self startragdollfromimpact( self.damagelocation, var_5 );
    wait 0.05;
}

doctor_capture_dialogue()
{
    level waittill( "can_takedown_doctor" );
    common_scripts\utility::flag_set( "vo_hospital_capture" );
}

doctor_capture_check_takedown()
{
    level endon( "can_takedown_doctor" );

    for (;;)
    {
        if ( level.guys_to_wait == 3 )
        {
            wait 2;
            level notify( "can_takedown_doctor" );
            common_scripts\utility::flag_set( "show_grab_doctor_prompt" );
        }

        wait 0.1;
    }
}

doctor_capture_breach_door_prompt()
{
    var_0 = getent( "kickdown", "targetname" ) maps\_shg_utility::hint_button_trigger( "use", 200 );
    maps\_utility::trigger_wait_targetname( "kickdown" );
    var_0 maps\_shg_utility::hint_button_clear();
}

doctor_capture_new_breach_doctor_takedown()
{
    thread doctor_capture_stop_spawning_school_trains();
    var_0 = getent( "breach_clip", "targetname" );
    var_1 = getent( "hospital_outside_clip", "targetname" );
    var_2 = getent( "dr_capture_pcap_animnode", "targetname" );
    var_3 = getent( "dr_carry_animnode", "targetname" );
    var_4 = getent( "dr_pickup_placed_org", "targetname" );
    var_5 = getnode( "burke_first_wait_after_capture_node", "targetname" );
    var_6 = getent( "kickdown", "targetname" );
    var_6 usetriggerrequirelookat();
    var_6 sethintstring( &"DETROIT_PROMPT_BREACH" );
    var_6 waittill( "trigger" );
    thread breach_backtrack_fail();
    objective_position( maps\_utility::obj( "Capture the doctor" ), ( 0, 0, 0 ) );
    maps\_player_exo::player_exo_deactivate();
    common_scripts\utility::flag_set( "doctor_inside_office_now" );
    level notify( "player breached and survived" );
    thread maps\detroit::battle_chatter_off_both();
    var_6 delete();
    maps\detroit::spawn_doctor();
    level.doctor thread mission_fail_on_dead();
    level.doctor thread passoja_death_wait_function();
    thread doctor_capture_player_breach();
    var_7 = getent( "breach_kva_guard1", "targetname" );
    var_8 = getent( "breach_kva_guard2", "targetname" );
    var_9 = getent( "breach_kva_guard3", "targetname" );
    var_10 = [];
    var_10[var_10.size] = var_7 maps\_utility::spawn_ai( 1 );
    var_10[var_10.size] = var_8 maps\_utility::spawn_ai( 1 );
    var_10[var_10.size] = var_9 maps\_utility::spawn_ai( 1 );
    level.guys_to_wait = 0;
    thread doctor_capture_check_takedown();
    var_10[0] thread doctor_capture_firstguy_breach();
    var_10[1] thread doctor_capture_thirdguy_breach();
    var_10[1] thread doctor_capture_thirdguy_notify_when_dead();
    var_10[2] thread doctor_capture_forthguy_breach();
    thread doctor_capture_doctor_breach();
    thread doctor_capture_bookshelf1();
    thread doctor_capture_bookshelf2();
    soundscripts\_snd::snd_message( "hospital_breach_gun_away" );
    level waittill( "breach_begin" );
    thread maps\detroit_lighting::hospital_breach_dof();
    soundscripts\_snd::snd_message( "hostpital_breach_start" );
    thread doctor_capture_bones_breach_functionality();
    var_0 delete();
    var_1 delete();
    level waittill( "can_takedown_doctor" );
    var_11 = getent( "dr_capture_use_trigger", "targetname" );
    level.doctor thread doctor_capture_doctor_takedown_xprompt( var_11 );
    objective_setpointertextoverride( maps\_utility::obj( "Capture the doctor" ), &"OBJECTIVE_CAPTURE" );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_doctor_breached" );

    if ( level.nextgen )
        setsaveddvar( "r_mbEnable", "0" );

    var_11 sethintstring( &"DETROIT_DOCTOR_GRAB" );
    var_11 waittill( "trigger" );
    common_scripts\utility::flag_set( "doctor_grabbed" );
    maps\_player_exo::player_exo_deactivate();
    thread clear_doctor_head();
    thread maps\detroit_streets::sneaky_reload();
    level notify( "begin_takedown_animation" );
    var_11 delete();
    var_12 = maps\_utility::spawn_anim_model( "world_body" );
    var_12 hide();
    var_2 thread maps\_anim::anim_first_frame_solo( var_12, "doctor_capture" );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    var_13 = 0.3;
    var_12 hide();
    level.player playerlinktoblend( var_12, "tag_player", var_13, var_13 * 0.5, var_13 * 0.5 );
    level.player common_scripts\utility::delaycall( var_13, ::playerlinktodelta, var_12, "tag_player", 0, 0, 0, 0, 0, 1 );
    level.player common_scripts\utility::delaycall( var_13, ::enableslowaim );
    var_12 common_scripts\utility::delaycall( var_13, ::show );
    thread maps\detroit_lighting::capture_lighting();
    common_scripts\utility::flag_set( "player_captured_doctor" );
    thread wait_for_trigger_set_flag();
    soundscripts\_snd::snd_message( "capture_doctor_scene_start" );
    maps\_utility::delaythread( 2, common_scripts\utility::flag_set, "obj_capture_doctor_complete" );
    level.doctor thread doctor_capture_doctor_head_swap_function();
    var_2 notify( "stop_doctor_loop" );
    var_12 thread doctor_capture_player_capture_thread();
    var_14 = maps\_utility::spawn_anim_model( "capture_bag" );
    var_14 hide();
    var_2 thread doctor_capture_bag_capture_anim( var_14 );
    level.burke stopanimscripted();
    level notify( "kill_burke_loop" );
    var_2 notify( "no_more_door_looping_burke" );
    var_15 = [ level.joker, level.doctor ];
    thread doctor_blood_swap();
    var_2 thread maps\_anim::anim_single_solo( level.burke, "doctor_capture" );
    thread doctor_capture_set_new_objective_outside_breach();
    level.burke setgoalnode( var_5 );
    var_2 thread maps\_anim::anim_single_solo( var_14, "doctor_capture" );
    var_2 thread maps\_anim::anim_single( var_15, "doctor_capture" );
    wait 24;
    level.player enableweapons();
    wait 6;
    level.doctor setanimrate( level.doctor maps\_utility::getanim( "doctor_capture" ), 0 );
    common_scripts\utility::flag_set( "capture_animation_complete" );
    common_scripts\utility::flag_set( "obj_escape_detroit_give" );
    level.burke maps\_utility::set_moveplaybackrate( 1 );

    if ( isalive( level.doctor ) )
        thread maps\_utility::autosave_by_name( "seeker" );

    var_16 = getnode( "joker_with_doctor_waitnode", "targetname" );
    thread doctor_carry_wait_breach( var_2, "reveal_the_sentinels", var_16 );
    common_scripts\utility::flag_set( "swap_to_head_bagged" );
    var_14 delete();
    thread escape_hospital_trains();
}

doctor_capture_set_new_objective_outside_breach()
{
    wait 26.3;
    common_scripts\utility::flag_set( "obj_escape_detroit_give" );
}

doctor_capture_doctor_takedown_xprompt( var_0 )
{
    var_1 = maps\_shg_utility::hint_button_tag( "x", "j_spine4", 128, 200, undefined, var_0 );
    level waittill( "begin_takedown_animation" );
    var_1 maps\_shg_utility::hint_button_clear();
}

doctor_capture_stop_spawning_school_trains()
{
    maps\_utility::disable_trigger_with_targetname( "no_more_trains_trigger" );
    common_scripts\utility::flag_wait( "player_captured_doctor" );
    maps\_utility::enable_trigger_with_targetname( "no_more_trains_trigger" );
    common_scripts\utility::flag_wait( "no_more_trains" );
    common_scripts\utility::flag_set( "hospital_escape_trains_only" );
}

doctor_blood_swap()
{
    wait 5.12;
    level.doctor overridematerial( "mtl_dr_pas_head", "mtl_dr_pas_head_damaged" );
    level.doctor maps\_utility::dialogue_queue( "det_dcr_painreaction" );
}

doctor_capture_hospital_breach_autosave()
{
    maps\_utility::trigger_wait_targetname( "hospital_breach_autosave" );
    maps\_utility::disable_trigger_with_targetname( "hospital_breach_autosave" );
}

doctor_capture_xprompt()
{
    common_scripts\utility::flag_wait( "show_grab_doctor_prompt" );
    var_0 = getent( "dr_pickup_placed_prompt", "targetname" ) maps\_shg_utility::hint_button_trigger( "use", 200 );
    level waittill( "begin_takedown_animation" );
    var_0 maps\_shg_utility::hint_button_clear();
}

doctor_capture_bag_capture_anim( var_0 )
{
    common_scripts\utility::flag_wait( "show_capture_bag" );
    var_0 show();
}

doctor_capture_doctor_head_swap_function()
{
    common_scripts\utility::flag_wait( "swap_to_head_bagged" );
    // self detach( "dr_pas_head" );
    // self attach( "det_doctor_head_bagA" );
}

doctor_capture_player_capture_thread()
{
    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    var_0 thread maps\_anim::anim_single_solo( self, "doctor_capture" );
    wait 0.8;
    maps\detroit::controller_rumble_heavy0();
    wait 0.22;
    maps\detroit::controller_rumble_light1();
    wait 1;
    maps\detroit::controller_rumble_heavy0();
    wait 3.05;
    maps\detroit::controller_rumble_light1();
    wait 13.25;
    maps\detroit::controller_rumble_heavy0();
    wait 5.25;
    level.player unlink();
    level.player disableslowaim();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    maps\_player_exo::player_exo_activate();
    level notify( "doctor_cant_die_anymore" );
    self delete();
}

doctor_carry_wait_breach( var_0, var_1, var_2 )
{
    var_0 thread maps\_anim::anim_loop_solo( level.joker, "doctor_capture_idle" );
    common_scripts\utility::flag_wait( "joker_pickup_doctor_is_ok_now" );
    level notify( "pick_up_doctor_move_on" );
    wait 2.3;
    var_0 notify( "stop_loop" );
    thread doctor_capture_doctor_carry( var_0, var_1, var_2 );
}

keep_stair_override( var_0 )
{
    while ( !common_scripts\utility::flag( var_0 ) )
    {
        if ( isdefined( self.a.moveanimset ) )
        {
            self.a.moveanimset["stairs_up"] = level.scr_anim[self.animname]["carry_doc_upstairs_loop"];
            self.a.moveanimset["stairs_down"] = level.scr_anim[self.animname]["carry_doc_downstairs_loop"];
            self.a.moveanimset["stairs_down_out"] = self.a.moveanimset["stairs_down"];
            self.a.moveanimset["stairs_up_out"] = self.a.moveanimset["stairs_up"];
            self.a.moveanimset["stairs_down_in"] = self.a.moveanimset["stairs_down"];
            self.a.moveanimset["stairs_up_in"] = self.a.moveanimset["stairs_up"];
        }

        waitframe();
    }
}

#using_animtree("generic_human");

doctor_capture_doctor_carry( var_0, var_1, var_2 )
{
    if ( isai( level.doctor ) )
    {
        level.doctor setcontents( 0 );
        level.doctor notify( "killanimscript" );
        level.doctor maps\_utility::disable_pain();
        level.doctor maps\_utility::disable_bulletwhizbyreaction();
        level.doctor maps\_utility::disable_danger_react();
        level.doctor notify( "internal_stop_magic_bullet_shield" );
        level.doctor notify( "death" );
        level.doctor stop_current_animations( var_0 );
        var_3 = spawn( "script_model", level.doctor.origin );
        var_3.angles = level.doctor.angles;
        var_4 = level.doctor.animname;
        var_3.animname = var_4;
        var_3 useanimtree( #animtree );
        var_3 setmodel( level.doctor getmodelfromentity(), 0 );
        var_3 character\character_doctor_pas::main();
        // var_3 attach( "det_doctor_head_bagA" );
        var_3.name = "scriptmodelDoc";
        var_3 setcandamage( 1 );
        var_3.health = 100;
        var_3 thread mission_fail_on_dead();
        var_3 setlookattext( "Doctor", &"" );
        level.doctor delete();
        level.doctor = var_3;
    }

    level.joker stop_current_animations( var_0 );
    var_0 maps\_anim::anim_single( [ level.joker, level.doctor ], "carry_doc_lift" );
    var_0 maps\_anim::anim_first_frame_solo( level.doctor, "carry_doc_stop" );
    level.joker maps\_utility::ai_ignore_everything();
    level.joker pushplayer( 1 );
    level.joker maps\_utility::disable_turnanims();
    level.joker.run_overrideanim_hasstairanimarray = 1;
    level.joker.disablearrivals = 1;
    level.joker.disableexits = 1;
    level.joker.run_overrideanim = level.scr_anim[level.joker.animname]["carry_doc_walk"];
    level.joker.walk_overrideanim = level.scr_anim[level.joker.animname]["carry_doc_walk"];
    level.joker.specialidleanim = [ level.scr_anim[level.joker.animname]["carry_doc_stop"] ];
    level.joker allowedstances( "stand" );
    level.joker animmode( "gravity" );
    level.joker orientmode( "face default" );
    level.joker thread keep_stair_override( var_1 );
    level.doctor setanimknob( level.scr_anim[level.doctor.animname]["carry_doc_stop"], 1, 0, 0 );
    level.doctor setanimtime( level.scr_anim[level.doctor.animname]["carry_doc_stop"], 0 );
    level.doctor linkto( level.joker, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.doctor dontinterpolate();
    level.doctor thread sync_anim_times_with_carrier( level.joker, var_1 );
    level.joker setgoalnode( var_2 );
    common_scripts\utility::flag_wait( var_1 );
    level.doctor unlink();
    level.joker maps\_utility::ai_unignore_everything();
    level.joker pushplayer( 0 );
    level.joker maps\_utility::enable_turnanims();
    level.joker allowedstances( "stand", "crouch", "prone" );
    level.joker.run_overrideanim_hasstairanimarray = undefined;
    level.joker.disablearrivals = undefined;
    level.joker.disableexits = undefined;
    level.joker.run_overrideanim = undefined;
    level.joker.walk_overrideanim = undefined;
    level.joker.specialidleanim = undefined;
}

clear_doctor_head()
{
    level.doctor clearanim( %head, 0.1 );
}

doctor_capture_bones_breach_functionality()
{
    var_0 = getnode( "bones_guard_capture_node", "targetname" );
    var_1 = getnode( "bones_guard_doctor_node", "targetname" );
    var_2 = getnode( "bones_guard_bikes_node", "targetname" );
    level.bones setgoalnode( var_0 );
    common_scripts\utility::flag_wait( "capture_animation_complete" );
    level.bones setgoalnode( var_1 );
    common_scripts\utility::flag_wait( "sentinel_reveal_animation_complete" );
    level.bones setgoalnode( var_2 );
}

doctor_capture_bookshelf1()
{
    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "shelf" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "det_hos_breach_success_shelf01" );
    var_2 = getent( "det_hos_breach_shelf_01", "targetname" );
    var_2 hide();
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles + ( 0, 90, 0 );
    var_2 linkto( var_1, "TAG_ORIGIN" );
    level waittill( "begin_second_half_of_breach" );
    var_0 maps\_anim::anim_single_solo( var_1, "det_hos_breach_success_shelf01" );
    common_scripts\utility::flag_wait( "player_captured_doctor" );
    wait 1.25;
    var_2 show();
    var_1 delete();
}

doctor_capture_bookshelf2()
{
    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "shelf" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "det_hos_breach_success_shelf02" );
    var_2 = getent( "det_hos_breach_shelf_02", "targetname" );
    var_2 hide();
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles + ( 0, 90, 0 );
    var_2 linkto( var_1, "TAG_ORIGIN" );
    level waittill( "begin_second_half_of_breach" );
    var_0 maps\_anim::anim_single_solo( var_1, "det_hos_breach_success_shelf02" );
    common_scripts\utility::flag_wait( "player_captured_doctor" );
    wait 1.25;
    var_2 show();
    var_1 delete();
}

doctor_capture_lerp_wait_function( var_0 )
{
    wait(var_0);
    iprintlnbold( "this is the right slowmo function" );
    maps\_utility::slowmo_lerp_in();
}

doctor_capture_door_breach_anim()
{
    if ( level.currentgen )
    {
        if ( !istransientloaded( "detroit_hospital_interior_tr" ) )
        {
            for (;;)
            {
                wait 0.25;

                if ( istransientloaded( "detroit_hospital_interior_tr" ) )
                    break;
            }
        }
    }

    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "hospital_door" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "hospital_breach" );
    wait 0.05;
    var_2 = getent( "reflection_green", "targetname" );
    var_1 overridereflectionprobe( var_2.origin );
    var_1 overridelightingorigin( var_2.origin );
    level waittill( "breach_begin" );
    var_0 maps\_anim::anim_single_solo( var_1, "hospital_breach" );
}

doctor_capture_player_breach()
{
    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "world_body", level.player.origin );
    var_1.animname = "world_body";
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "det_hos_breach_vm" );
    var_1 hide();
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 1.5, 100 );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    var_2 = 0.3;
    var_1 hide();
    level.player playerlinktoblend( var_1, "tag_player", var_2, var_2 * 0.5, var_2 * 0.5 );
    wait(var_2);
    var_1 show();
    level.player playerlinktodelta( var_1, "tag_player", 0, 0, 0, 0, 0, 1 );
    thread doctor_capture_burke_enter_doctor_room();
    thread doctor_capture_burke_takedown_finish();
    level notify( "breach_begin" );
    thread maps\detroit_streets::sneaky_reload();
    var_0 maps\_anim::anim_single_solo( var_1, "det_hos_breach_vm" );

    if ( common_scripts\utility::flag( "qte_success_breach" ) )
    {
        soundscripts\_snd::snd_message( "player_exo_breach_begin" );
        thread maps\_utility::slowmo_lerp_out();
        var_0 thread maps\_anim::anim_single_solo( var_1, "det_hos_breach_fail_vm" );
        wait 3;
        var_1 setanimrate( var_1 maps\_utility::getanim( "det_hos_breach_fail_vm" ), 0 );
    }
    else
    {
        soundscripts\_snd::snd_message( "push_dude_into_shelves" );
        var_0 maps\_anim::anim_single_solo( var_1, "det_hos_breach_success_vm" );
        level.player unlink();
        var_1 delete();
        level.player maps\_shg_utility::setup_player_for_gameplay();
        wait 2;
        maps\_utility::slowmo_lerp_out();
        soundscripts\_snd::snd_message( "breach_slo_mo_exit" );
        maps\_player_exo::player_exo_activate();
    }
}

doctor_capture_burke_enter_doctor_room()
{
    level endon( "begin_takedown_animation" );
    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    var_1 = "det_hos_breach_burke";
    var_2 = getanimlength( level.burke maps\_utility::getanim( var_1 ) );
    var_3 = 3;
    wait(var_3);
    thread doctor_capture_burke_shooting();
    var_0 thread maps\_anim::anim_single_solo( level.burke, var_1 );
    wait 0.05;
    level.burke setanimtime( level.burke maps\_utility::getanim( var_1 ), ( var_3 + 0.05 ) / var_2 );
    wait(var_2 - var_3);
    doctor_capture_burke_alternate_point_anim();
}

doctor_capture_burke_alternate_point_anim()
{
    level endon( "begin_takedown_animation" );
    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    common_scripts\utility::flag_set( "grab_the_doctor" );
    doctor_capture_burke_doctorroom_idle();
}

doctor_capture_burke_doctorroom_idle()
{
    level endon( "begin_takedown_animation" );
    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "doctor_capture_idle", "stop_burke_idling_before_capture" );
}

doctor_capture_burke_takedown_finish()
{
    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    common_scripts\utility::flag_wait( "player_captured_doctor" );
    var_0 notify( "stop_burke_idling_before_capture" );
    level.burke notify( "stop_burke_idling_before_capture" );
    thread burke_pre_sentinel_kva_reveal();
}

doctor_capture_burke_shooting()
{
    wait 5;

    if ( !common_scripts\utility::flag( "player_captured_doctor" ) )
        level notify( "burke_shoot_1" );

    wait 1.25;

    if ( !common_scripts\utility::flag( "player_captured_doctor" ) )
        level notify( "burke_shoot_2" );
}

doctor_capture_doctor_breach()
{
    waitframe();
    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    level waittill( "breach_begin" );
    var_0 maps\_anim::anim_single_solo( level.doctor, "det_hos_breach_doctor" );
    var_0 thread maps\_anim::anim_loop_solo( level.doctor, "det_hos_breach_idle_doctor", "stop_doctor_loop" );
}

doctor_capture_shoot_the_player()
{
    self endon( "death" );
    self endon( "stop_shooting" );

    for (;;)
    {
        wait(randomfloatrange( 0.25, 1 ));

        if ( isalive( self ) )
        {
            magicbullet( "iw5_bal27_sp", self gettagorigin( "tag_flash" ), level.player.origin );
            continue;
        }

        return;
    }
}

breach_backtrack_fail()
{
    var_0 = getent( "backtrack_warning_breach", "targetname" );
    thread mission_fail_warning( var_0 );
    thread player_exit_breach_fail();
}

player_exit_breach_fail()
{
    level endon( "player_progressed_to_exit_drive" );
    maps\_utility::trigger_wait_targetname( "backtrack_breach_fail_trigger" );
    maps\_player_death::set_deadquote( &"DETROIT_ABANDONED" );
    maps\_utility::missionfailedwrapper();
}

doctor_capture_firstguy_breach()
{
    self endon( "death" );
    self.animname = "generic";
    self.ignoreme = 1;
    thread doctor_capture_guy1_health_check_killfunction();
    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    var_0 maps\_anim::anim_first_frame_solo( self, "det_hos_breach_guy1" );
    level waittill( "breach_begin" );
    thread doctor_capture_did_burke_kill_me_1();
    var_0 maps\_anim::anim_single_solo( self, "det_hos_breach_guy1" );

    if ( isalive( self ) )
    {
        thread doctor_capture_shoot_the_player();
        self.ignoreme = 0;
        var_0 maps\_anim::anim_loop_solo( self, "det_hos_breach_aim_idle_guy1" );
    }
}

doctor_capture_guy1_health_check_killfunction()
{
    var_0 = getent( "player_success_hospital_glass_clip", "targetname" );
    var_0 notsolid();
    var_1 = getglass( "player_success_hospital_glass" );
    var_2 = 0.2;
    var_3 = getent( "dr_capture_pcap_animnode", "targetname" );
    var_4 = self.health;

    for (;;)
    {
        var_5 = self.health;

        if ( var_4 > var_5 )
        {
            self notify( "stop_shooting" );
            level.guys_to_wait += 1;
            self.allowdeath = 1;
            soundscripts\_snd::snd_message( "shoot_dude_through_window" );
            self.a.nodeath = 1;
            self.ignoreall = 1;
            self.ignoreme = 1;
            self setcontents( 0 );
            thread doctor_capture_destroy_this_glass( var_1, var_2 );
            var_0 solid();
            var_3 maps\_anim::anim_single_solo( self, "det_hos_breach_success_guy1" );
            self delete();
            return;
        }

        wait 0.05;
    }
}

doctor_capture_destroy_this_glass( var_0, var_1 )
{
    wait(var_1);

    if ( isdefined( var_0 ) )
        destroyglass( var_0 );
}

doctor_capture_thirdguy_notify_when_dead()
{
    self waittill( "death" );
    self stopanimscripted();
}

doctor_capture_guy3_health_check_killfunction()
{
    var_0 = getent( "guy3_death_animnode", "targetname" );
    var_1 = self.health;

    for (;;)
    {
        if ( var_1 > self.health )
        {
            self notify( "stop_shooting" );
            level.guys_to_wait += 1;
            soundscripts\_snd::snd_message( "breach_bad_guy2_gets_shot" );
            self.a.nodeath = 1;
            self.ignoreall = 1;
            self.ignoreme = 1;
            var_0 maps\_anim::anim_single_solo( self, "det_hos_breach_success_guy3" );
            return;
        }

        wait 0.05;
    }
}

doctor_capture_thirdguy_breach()
{
    self endon( "death" );
    self.ignoreme = 1;
    self.animname = "generic";
    thread doctor_capture_guy3_health_check_killfunction();
    var_0 = getent( "guy3_death_animnode", "targetname" );
    var_0 maps\_anim::anim_first_frame_solo( self, "det_hos_breach_guy3" );
    level waittill( "breach_begin" );
    thread doctor_capture_did_burke_kill_me_2();
    thread doctor_capture_guy_3_kill_player();
    var_0 maps\_anim::anim_single_solo( self, "det_hos_breach_guy3" );

    if ( isalive( self ) )
    {
        thread doctor_capture_shoot_the_player();
        self.ignoreme = 0;
        var_0 thread maps\_anim::anim_loop_solo( self, "det_hos_breach_aim_idle_guy3" );
    }
}

doctor_capture_guy_3_kill_player()
{
    var_0 = self.health;
    wait 6.5;

    if ( var_0 == self.health )
    {
        magicbullet( "iw5_bal27_sp", self geteye(), level.player geteye() );
        level.player kill();
        maps\_player_death::set_deadquote( &"DETROIT_QTE_FAIL" );
        maps\_utility::missionfailedwrapper();
    }
}

doctor_capture_did_burke_kill_me_2()
{
    level waittill( "burke_shoot_2" );

    if ( isalive( self ) )
    {
        var_0 = magicbullet( "iw5_bal27_sp", level.burke gettagorigin( "tag_flash" ), self gettagorigin( "tag_eye" ) );
        wait 0.02;

        if ( isalive( self ) )
            var_0 = magicbullet( "iw5_bal27_sp", level.burke gettagorigin( "tag_flash" ), self gettagorigin( "tag_eye" ) );

        var_0 = magicbullet( "iw5_bal27_sp", level.burke gettagorigin( "tag_flash" ), self gettagorigin( "tag_eye" ) );
        var_0 = magicbullet( "iw5_bal27_sp", level.burke gettagorigin( "tag_flash" ), self gettagorigin( "tag_eye" ) );
    }
}

doctor_capture_did_burke_kill_me_1()
{
    level waittill( "burke_shoot_1" );

    if ( isalive( self ) )
    {
        var_0 = magicbullet( "iw5_bal27_sp", level.burke gettagorigin( "tag_flash" ), self gettagorigin( "tag_eye" ) );
        var_0 = magicbullet( "iw5_bal27_sp", level.burke gettagorigin( "tag_flash" ), self gettagorigin( "tag_eye" ) );
        wait 0.02;

        if ( isalive( self ) )
            var_0 = magicbullet( "iw5_bal27_sp", level.burke gettagorigin( "tag_flash" ), self gettagorigin( "tag_eye" ) );
    }
}

doctor_capture_forthguy_breach()
{
    common_scripts\utility::flag_set( "qte_success_breach" );
    self endon( "death" );
    self.animname = "generic";
    self.ignoreme = 1;
    var_0 = getent( "dr_capture_pcap_animnode", "targetname" );
    var_0 maps\_anim::anim_first_frame_solo( self, "det_hos_breach_guy4" );
    level waittill( "breach_begin" );
    thread doctor_capture_success_trigger();
    var_0 maps\_anim::anim_single_solo( self, "det_hos_breach_guy4" );

    if ( common_scripts\utility::flag( "qte_success_breach" ) )
    {
        var_0 thread maps\_anim::anim_single_solo( self, "det_hos_breach_fail_guy4" );
        wait 2.25;
        self setanimrate( maps\_utility::getanim( "det_hos_breach_fail_guy4" ), 0 );
    }
    else
    {
        level.guys_to_wait += 1;
        self.allowdeath = 1;
        self.a.nodeath = 1;
        self.ignoreall = 1;
        self.ignoreme = 1;
        common_scripts\utility::delaycall( 3, ::kill );
        level notify( "begin_second_half_of_breach" );
        var_0 maps\_anim::anim_single_solo( self, "det_hos_breach_success_guy4" );
        var_0 maps\_anim::anim_last_frame_solo( self, "det_hos_breach_success_guy4" );
        return;
    }
}

doctor_capture_success_trigger()
{
    level.player endon( "death" );
    level.player endon( "success" );
    wait 1.95;
    thread doctor_capture_use_hint_blinks_melee();

    for ( var_0 = 0; var_0 < 2; var_0 += 0.05 )
    {
        if ( level.player meleebuttonpressed() )
        {
            thread fade_out_use_hint( 0.1 );
            common_scripts\utility::flag_clear( "qte_success_breach" );
            level.player notify( "success" );
            return;
        }

        wait 0.05;
    }

    thread fade_out_use_hint( 0.1 );
}

doctor_capture_draw_use_hint()
{
    var_0 = 200;
    var_1 = 0;
    var_2 = level.player maps\_hud_util::createclientfontstring( "default", 2 );
    var_2.x = var_1 * -1;
    var_2.y = var_0;
    var_2.horzalign = "center";
    var_2.alignx = "center";
    var_2 settext( &"DETROIT_FLASH_USE" );
    var_3 = [];
    var_3["text"] = var_2;
    level.use_hint = var_3;
}

doctor_capture_draw_use_hint_melee()
{
    var_0 = 200;
    var_1 = 0;
    var_2 = level.player maps\_hud_util::createclientfontstring( "default", 2 );
    var_2.x = var_1 * -1;
    var_2.y = var_0;
    var_2.horzalign = "center";
    var_2.alignx = "center";
    var_2 settext( &"DETROIT_MELEE" );
    var_3 = [];
    var_3["text"] = var_2;
    level.use_hint = var_3;
}

doctor_capture_use_hint_blinks_melee( var_0 )
{
    level notify( "fade_out_use_hint" );
    level endon( "fade_out_use_hint" );

    if ( !isdefined( var_0 ) )
        var_0 = 3;

    doctor_capture_draw_use_hint_melee();
    var_1 = 0.1;
    var_2 = 0.2;
    level.use_hint_active = 1;

    foreach ( var_4 in level.use_hint )
    {
        var_4 fadeovertime( 0.1 );
        var_4.alpha = 0.95;
    }

    wait 0.1;
    var_6 = level.use_hint["text"];

    for (;;)
    {
        if ( isdefined( level.use_hint["icon"] ) )
            level.use_hint["icon"].alpha = 0.95;

        var_6 fadeovertime( 0.01 );
        var_6.alpha = 0.95;
        var_6 changefontscaleovertime( 0.01 );
        var_6.fontscale = var_0;
        wait 0.1;
        var_6 fadeovertime( var_1 );
        var_6.alpha = 0.0;
        var_6 changefontscaleovertime( var_1 );
        var_6.fontscale = 0.25;
        wait(var_2);

        if ( !isdefined( level.use_hint_active ) )
        {
            foreach ( var_4 in level.use_hint )
                var_4.alpha = 0;

            return;
        }
    }
}

doctor_capture_inner_fight()
{
    common_scripts\utility::flag_wait( "hospital_inner_fight" );
    var_0 = getentarray( "kva_hospital_ar_special3", "targetname" );

    foreach ( var_2 in var_0 )
        var_3 = var_2 maps\_utility::spawn_ai();
}

escape_hospital_trains()
{
    level endon( "no_more_random_trains" );
    common_scripts\utility::flag_wait( "spawn_escape_train1" );
    maps\detroit_school::spawn_right_hospital_train( 1500 );
    common_scripts\utility::flag_wait( "spawn_escape_train2" );
    maps\detroit_school::spawn_left_hospital_train( 1500 );

    for (;;)
    {
        var_0 = randomint( 2 ) + 1;

        if ( var_0 == 1 )
            maps\detroit_school::spawn_right_hospital_train( 1500 );
        else if ( var_0 == 2 )
            maps\detroit_school::spawn_left_hospital_train( 1500 );

        wait 20;
    }
}

fade_out_use_hint( var_0 )
{
    level notify( "fade_out_use_hint" );

    if ( !isdefined( var_0 ) )
        var_0 = 1.5;

    if ( !isdefined( level.use_hint ) )
        doctor_capture_draw_use_hint();

    foreach ( var_2 in level.use_hint )
    {
        var_2 fadeovertime( var_0 );
        var_2.alpha = 0;
    }

    level.use_hint_active = undefined;
}

use_hint_blinks( var_0 )
{
    level notify( "fade_out_use_hint" );
    level endon( "fade_out_use_hint" );

    if ( !isdefined( var_0 ) )
        var_0 = 3;

    if ( !isdefined( level.use_hint ) )
        doctor_capture_draw_use_hint();

    var_1 = 0.1;
    var_2 = 0.2;
    level.use_hint_active = 1;

    foreach ( var_4 in level.use_hint )
    {
        var_4 fadeovertime( 0.1 );
        var_4.alpha = 0.95;
    }

    wait 0.1;
    var_6 = level.use_hint["text"];

    for (;;)
    {
        if ( isdefined( level.use_hint["icon"] ) )
            level.use_hint["icon"].alpha = 0.95;

        var_6 fadeovertime( 0.01 );
        var_6.alpha = 0.95;
        var_6 changefontscaleovertime( 0.01 );
        var_6.fontscale = var_0;
        wait 0.1;
        var_6 fadeovertime( var_1 );
        var_6.alpha = 0.0;
        var_6 changefontscaleovertime( var_1 );
        var_6.fontscale = 0.25;
        wait(var_2);

        if ( !isdefined( level.use_hint_active ) )
        {
            foreach ( var_4 in level.use_hint )
                var_4.alpha = 0;

            return;
        }
    }
}

joker_advance_hospital()
{
    var_0 = getnode( "joker_hospital", "targetname" );
    var_1 = getnode( "joker_cover_inside_hospital", "targetname" );
    var_2 = getnode( "joker_holdup_before_going_upstairs_node", "targetname" );
    level.joker.ignoreall = 0;
    level.joker.goalradius = 15;
    level.joker setgoalnode( var_0 );
    level.joker waittill( "goal" );
    wait 5;
    level.joker setgoalnode( var_2 );
    common_scripts\utility::flag_wait( "send_all_teammates_upstairs" );
    wait 1.5;
    level.joker setgoalnode( var_1 );
}

bones_advance_hospital()
{
    var_0 = getnode( "bones_cover_outside", "targetname" );
    var_1 = getnode( "bones_cover_inside_hospital", "targetname" );
    var_2 = getnode( "bones_holdup_before_going_upstairs_node", "targetname" );
    level.bones.ignoreall = 0;
    level.bones.goalradius = 15;
    level.bones setgoalnode( var_0 );
    level.bones waittill( "goal" );
    wait 4;
    level.bones setgoalnode( var_2 );
    common_scripts\utility::flag_wait( "send_all_teammates_upstairs" );
    wait 2;
    level.bones setgoalnode( var_1 );
}

hospital_stairs_autosave()
{
    maps\_utility::trigger_wait_targetname( "hospital_stairs_autosave" );
    maps\_utility::disable_trigger_with_noteworthy( "hospital_stairs_autosave" );
}

stop_current_animations( var_0 )
{
    self endon( "death" );
    self stopanimscripted();
    self notify( "drone_stop" );
    self notify( "stop_loop" );
    self notify( "single anim", "end" );
    self notify( "looping anim", "end" );

    if ( isdefined( var_0 ) )
    {
        var_0 notify( "drone_stop" );
        var_0 notify( "stop_loop" );
        var_0 notify( "single anim", "end" );
        var_0 notify( "looping anim", "end" );
    }
}

sync_anim_times_with_carrier( var_0, var_1 )
{
    self endon( "death" );
    var_2 = [ "carry_doc_walk", "carry_doc_stop", "carry_doc_downstairs_loop", "carry_doc_upstairs_loop" ];
    var_3 = undefined;

    while ( !common_scripts\utility::flag( var_1 ) )
    {
        waittillframeend;

        if ( common_scripts\utility::flag( var_1 ) )
            return;

        var_4 = var_0 getactiveanimations();

        foreach ( var_6 in var_4 )
        {
            foreach ( var_8 in var_2 )
            {
                if ( var_6["animation"] == level.scr_anim[var_0.animname][var_8] )
                {
                    if ( !isdefined( var_3 ) || var_3 != var_6["animation"] )
                    {
                        self setanimknobrestart( level.scr_anim[self.animname][var_8], 1, 0.2, 1 );
                        var_3 = var_6["animation"];
                    }

                    self setanimtime( level.scr_anim[self.animname][var_8], var_6["currentAnimTime"] );
                }
            }
        }

        waitframe();
    }
}

kva_ar()
{
    var_0 = getent( "hospital_fight_goal1", "targetname" );
    var_1 = getentarray( "kva_hospital_ar", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = var_3 maps\_utility::spawn_ai( 1 );
        var_4 setgoalvolumeauto( var_0 );
    }

    maps\_utility::trigger_wait_targetname( "doctor_chase_gate_close_trig" );
    common_scripts\utility::flag_set( "hospital_wave_2" );
    wait 2;
    var_6 = getentarray( "kva_hospital_ar_wave2", "targetname" );

    foreach ( var_3 in var_6 )
    {
        var_4 = var_3 maps\_utility::spawn_ai();

        if ( isdefined( var_4 ) )
            var_4 maps\_utility::player_seek_enable();

        wait 0.05;
    }
}

kva_heavy()
{
    var_0 = getent( "hospital_fight_goal1", "targetname" );
    wait 6;
    var_1 = getentarray( "kva_hospital_heavy", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = var_3 maps\_utility::spawn_ai();
        var_4 maps\_utility::set_moveplaybackrate( 0.75 );
        var_4 setgoalvolumeauto( var_0 );
    }

    maps\_utility::trigger_wait_targetname( "doctor_chase_gate_close_trig" );
    var_1 = getentarray( "kva_hospital_heavy", "targetname" );
    wait 2;

    foreach ( var_3 in var_1 )
    {
        var_4 = var_3 maps\_utility::spawn_ai();

        if ( isdefined( var_4 ) )
        {
            var_0 = getent( "hospital_fight_goal1", "targetname" );
            var_4 maps\_utility::set_moveplaybackrate( 0.75 );
            var_4.combatmode = "no_cover";
            var_4 setgoalvolumeauto( var_0 );
            wait 4;
        }

        wait 0.05;
    }
}

kva_last_heavy()
{

}

special_kva()
{
    maps\_utility::trigger_wait_targetname( "kva_grenade_throw_trigger" );
    var_0 = getent( "kva_hospital_ar_special1", "targetname" );
    var_1 = getent( "kva_hospital_ar_special2", "targetname" );
    var_2 = getnode( "kva_special_spot_1", "targetname" );
    var_3 = getnode( "kva_special_spot_2", "targetname" );
    var_4 = var_0 maps\_utility::spawn_ai( 1 );
    var_5 = var_1 maps\_utility::spawn_ai( 1 );
    var_4.goalradius = 15;
    var_5.goalradius = 15;
    var_4 setgoalnode( var_2 );
    var_5 setgoalnode( var_3 );
}

final_approach()
{
    maps\_utility::trigger_wait_targetname( "last_room_setup_trigger" );
    level.burke maps\_utility::disable_careful();
    level.joker maps\_utility::disable_careful();
    level.bones maps\_utility::disable_careful();
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
    maps\_utility::setflashbangimmunity( 1 );
}

enable_awareness()
{
    self.ignoreall = 0;
    self.dontmelee = undefined;
    self.ignoresuppression = 0;

    if ( isdefined( self.suppressionwait_old ) )
    {
        self.suppressionwait = self.suppressionwait_old;
        self.suppressionwait_old = undefined;
    }

    maps\_utility::enable_surprise();
    self.ignorerandombulletdamage = 0;
    maps\_utility::enable_bulletwhizbyreaction();
    maps\_utility::enable_pain();
    self.grenadeawareness = 1;
    self.ignoreme = 0;
    maps\_utility::disable_dontevershoot();
    self.disablefriendlyfirereaction = undefined;
    maps\_utility::setflashbangimmunity( 0 );
}

cloak_off( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.75;

    var_1 = 0;
    self setmaterialscriptparam( 1.0, var_0 );
    wait(var_0);
    self drawpostresolveoff();
    self setmodel( self.defaultmodel );
    self.cloak = "off";
    self overridematerialreset();
    self overridematerial( "mtl_burke_sentinel_covert_headgear_a", "mc/mtl_burke_sentinel_covert_headgear_a_cloak" );
}

set_cloak_material_for_npc_weapon()
{
    if ( self.weapon != "iw5_unarmed" )
    {
        self overridematerial( "_base_black", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "_iron_sights_black", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "_iron_sights_color", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_weapon_suppressor_b", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_bal27_screen_a_green", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_bal27_magazine_out", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_bal27_magazine_inside", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_optics_variable_red_dot", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_optics_variable_red_dot_lens_02", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_bal27_iron_sights", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
    }
}

assign_cloak_model( var_0 )
{
    self.cloakedmodel = var_0;
    self.defaultmodel = self.model;
}

cloak_on( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.75;

    var_1 = 0;
    self setmodel( self.cloakedmodel );
    self drawpostresolve();
    self setmaterialscriptparam( 0.0, var_0 );
    self.cloak = "on";
    wait 0.1;
    set_cloak_material_for_npc_weapon();
}

disable_enable_exit_flags()
{
    maps\_utility::disable_trigger_with_targetname( "send_burke_to_stairs_waitpoint" );
    maps\_utility::disable_trigger_with_targetname( "send_burke_to_railway_half" );
    maps\_utility::disable_trigger_with_targetname( "send_burke_fully_across" );
    maps\_utility::disable_trigger_with_targetname( "make_burke_anim_reach_sentinel" );
    common_scripts\utility::flag_wait( "player_captured_doctor" );
    maps\_utility::enable_trigger_with_targetname( "send_burke_to_stairs_waitpoint" );
    maps\_utility::enable_trigger_with_targetname( "send_burke_to_railway_half" );
    maps\_utility::enable_trigger_with_targetname( "send_burke_fully_across" );
    maps\_utility::enable_trigger_with_targetname( "make_burke_anim_reach_sentinel" );
}

set_helmet_open( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.5;

    wait(var_1);
    self setanimknobrestart( %sentinel_covert_helmet_open_idle, 1, var_0 );
}

set_helmet_closed( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.5;

    wait(var_1);
    self setanimknobrestart( %sentinel_covert_helmet_closed_idle, 1, var_0 );
}

setup_hospital_bodies()
{
    maps\_utility::trigger_wait_targetname( "hospital_start" );
    var_0 = getent( "dead_spot", "targetname" );
    var_1 = getent( "civ_spawner_hospital_2", "targetname" );
    var_2 = maps\detroit_school::school_drone_spawn( var_1 );
    var_2 setcontents( 0 );
    var_0 maps\_anim::anim_first_frame_solo( var_2, "deadpose_1" );
}
