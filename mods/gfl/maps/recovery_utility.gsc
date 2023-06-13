// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

play_rumble_funeral_gun_salute()
{
    level.player common_scripts\utility::delaycall( 0.8, ::playrumbleonentity, "damage_light" );
    level.player common_scripts\utility::delaycall( 4.9, ::playrumbleonentity, "damage_light" );
    level.player common_scripts\utility::delaycall( 8.5, ::playrumbleonentity, "heavy_3s" );
}

play_rumble_training_s1_mute_breach()
{
    level.player common_scripts\utility::delaycall( 1.8, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 2.2, ::playrumbleonentity, "heavy_1s" );
}

play_rumble_training_s1_reload_malfunction()
{
    level.player common_scripts\utility::delaycall( 0.5, ::playrumbleonentity, "heavy_3s" );
}

play_rumble_training_s1_president_load_fail()
{
    level.player common_scripts\utility::delaycall( 2.7, ::playrumbleonentity, "heavy_3s" );
    level.player common_scripts\utility::delaycall( 5.8, ::playrumbleonentity, "light_1s" );
    level.player common_scripts\utility::delaycall( 6.8, ::playrumbleonentity, "heavy_1s" );
    wait 21;
    level.player.rumble_entity = maps\_utility::get_rumble_ent( "steady_rumble" );
    level.player.rumble_entity.intensity = 0.1;
    level.player.rumble_entity common_scripts\utility::delaycall( 0.5, ::delete );
    wait 12;
    level.player.rumble_entity = maps\_utility::get_rumble_ent( "steady_rumble" );
    level.player.rumble_entity.intensity = 0.08;
    level.player.rumble_entity common_scripts\utility::delaycall( 1.5, ::delete );
}

play_rumble_elevator()
{
    wait 1.4;
    level.player.rumble_entity = maps\_utility::get_rumble_ent( "steady_rumble" );
    level.player.rumble_entity.intensity = 0.08;
    wait 15.0;
    level.player stoprumble( "steady_rumble" );
    level.player.rumble_entity delete();
}

play_rumble_jeep_ride()
{
    level.player.rumble_entity = maps\_utility::get_rumble_ent( "steady_rumble" );
    level.player.rumble_entity.intensity = 0.088;
    wait 94.0;
    level.player.rumble_entity.intensity = 0.08;
    wait 14;
    level.player stoprumble( "steady_rumble" );
    level.player.rumble_entity delete();
    wait 1.3;
    level.player playrumbleonentity( "heavy_1s" );
    wait 0.3;
    level.player stoprumble( "heavy_1s" );
}

play_rumble_training_s2_president_load()
{
    wait 1.5;
    level.player playrumbleonentity( "heavy_1s" );
    wait 0.5;
    level.player stoprumble( "heavy_1s" );
    wait 6.3;
    level.player playrumbleonentity( "heavy_1s" );
    wait 0.2;
    level.player stoprumble( "heavy_1s" );
    wait 0.6;
    level.player playrumbleonentity( "heavy_1s" );
    wait 0.1;
    level.player stoprumble( "heavy_1s" );
    wait 0.1;
    level.player playrumbleonentity( "heavy_1s" );
    wait 0.1;
    level.player stoprumble( "heavy_1s" );
}

play_rumble_walker_tank()
{
    for ( var_0 = 1; var_0 < 10; var_0++ )
    {
        level waittill( "titan_rumble" );

        if ( var_0 == 3 || var_0 == 4 || var_0 == 5 || var_0 == 6 || var_0 == 7 )
        {
            level.player playrumbleonentity( "heavy_1s" );
            wait 0.75;
            level.player stoprumble( "heavy_1s" );
        }
    }
}

play_rumble_arm_repair()
{
    common_scripts\utility::flag_wait( "tour_exo_arm" );
    wait 3.6;
    level.player playrumbleonentity( "steady_rumble" );
    wait 0.9;
    level.player stoprumble( "steady_rumble" );
    wait 1.7;
    level.player playrumbleonentity( "steady_rumble" );
    wait 0.9;
    level.player stoprumble( "steady_rumble" );
    wait 3.4;
    level.player playrumbleonentity( "damage_light" );
    wait 0.7;
    level.player stoprumble( "damage_light" );
    common_scripts\utility::flag_wait( "arm_repair_attempt_1" );
    common_scripts\utility::flag_wait( "arm_repair_attempt_2" );
    common_scripts\utility::flag_wait( "arm_repair_attempt_3" );
    common_scripts\utility::flag_waitopen( "arm_repair_attempt_3" );
    wait 2.2;
    level.player playrumbleonentity( "damage_light" );
    wait 0.5;
    level.player stoprumble( "damage_light" );
}

play_camera_shake_tour_ride()
{
    var_0 = 0.5;
    var_1 = 11;
    var_2 = 30.3;
    var_3 = 7.3;
    var_4 = 10.2;
    var_5 = 12.5;
    var_6 = 11.2;
    var_7 = 9.3;
    var_8 = 3;
    var_9 = 0.5;
    var_10 = 1.5;
    var_11 = 1.25;
    var_12 = 1.0;
    var_13 = 0.0;
    var_14 = 1.0;
    var_15 = 0.8;
    var_16 = 0.6;
    level.player screenshakeonentity( var_12, var_12, var_12, var_0, 0, 0, 0, var_14, var_15, var_16 );
    wait(var_0);
    level.player screenshakeonentity( var_10, var_10, var_10, var_1, 0, 0, 0, var_14, var_15, var_16 );
    wait(var_1);
    level.player screenshakeonentity( var_11, var_11, var_11, var_2, 0, 0, 0, var_14, var_15, var_16 );
    wait(var_2);
    level.player screenshakeonentity( var_12, var_12, var_12, var_3, 0, 0, 0, var_14, var_15, var_16 );
    wait(var_3);
    level.player screenshakeonentity( var_11, var_11, var_11, var_4, 0, 0, 0, var_14, var_15, var_16 );
    wait(var_4);
    level.player screenshakeonentity( var_10, var_10, var_10, var_5, 0, 0, 0, var_14, var_15, var_16 );
    wait(var_5);
    level.player screenshakeonentity( var_11, var_11, var_11, var_6, 0, 0, 0, var_14, var_15, var_16 );
    wait(var_6);
    level.player screenshakeonentity( var_10, var_10, var_10, var_7, 0, 0, 0, var_14, var_15, var_16 );
    wait(var_7);
    level.player screenshakeonentity( var_11, var_11, var_11, var_8, 0, 0, 0, var_14, var_15, var_16 );
    wait(var_8);
    level.player screenshakeonentity( var_12, var_12, var_12, var_9, 0, 0, 0, var_14, var_15, var_16 );
    wait(var_9);
}

mission_out_of_bounds_fail()
{
    common_scripts\utility::flag_wait( "training_player_left_encounter" );

    if ( !common_scripts\utility::flag( "flag_player_using_drone" ) )
    {
        common_scripts\utility::flag_clear( "training_out_of_bounds_warning" );

        if ( !common_scripts\utility::flag( "training_round_2" ) )
        {
            if ( !common_scripts\utility::flag( "training_s1_end_anim_started" ) )
                setdvar( "ui_deadquote", &"RECOVERY_PRESIDENT_ABANDONED" );
            else
                setdvar( "ui_deadquote", &"RECOVERY_OBJECTIVE_FAIL_JEEP_BOARD" );
        }
        else if ( !common_scripts\utility::flag( "training_s2_golf_course_vehicles" ) )
            setdvar( "ui_deadquote", &"RECOVERY_PRESIDENT_ABANDONED" );
        else
            setdvar( "ui_deadquote", &"RECOVERY_OBJECTIVE_FAIL_JEEP_BOARD" );

        setblur( 30, 2 );
        maps\_utility::missionfailedwrapper();
    }
}

mission_warn_out_of_bounds_fail()
{
    level endon( "training_player_left_encounter" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "training_out_of_bounds_warning" );

        if ( !common_scripts\utility::flag( "flag_player_using_drone" ) )
            thread maps\_utility::display_hint( "warning_prompt" );

        common_scripts\utility::flag_waitopen( "training_out_of_bounds_warning" );
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

delete_on_notify( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "level_cleanup";

    self endon( "death" );
    level waittill( var_0 );

    if ( common_scripts\utility::flag_exist( "_stealth_spotted" ) )
        common_scripts\utility::flag_waitopen( "_stealth_spotted" );

    if ( isdefined( self.magic_bullet_shield ) && self.magic_bullet_shield )
        maps\_utility::stop_magic_bullet_shield();

    self delete();
}

enable_jump_jet_pathing()
{
    if ( issubstr( self.classname, "jump" ) )
        self.canjumppath = 1;
}

recovery_thermal_manager()
{
    self thermaldrawenable();
}

training_set_up_player()
{
    common_scripts\utility::flag_clear( "flag_disable_exo" );
    level.player allowcrouch( 1 );
    level.player allowprone( 1 );
    level.player allowjump( 1 );
    level.player giveweapon( "iw5_bal27_sp_silencer01_variablereddot" );
    level.player giveweapon( "iw5_titan45_sp_silencerpistol" );
    level.player switchtoweapon( "iw5_bal27_sp_silencer01_variablereddot" );
    level.player enablehybridsight( "iw5_bal27_sp_silencer01_variablereddot", 1 );

    if ( level.nextgen )
        level.player overrideviewmodelmaterial( "m/mtl_bal27_base_black", "m/mtl_bal27_base_black_logo" );
    else
        level.player overrideviewmodelmaterial( "mq/mtl_bal27_base_black", "mq/mtl_bal27_base_black_logo" );

    level.player enableweapons();
    level.player allowfire( 1 );
    level.player allowads( 1 );
    level.player allowmelee( 1 );
    maps\_variable_grenade::give_player_variable_grenade();
    maps\_variable_grenade::set_variable_grenades_with_no_switch( "tracking_grenade_var", "paint_grenade_var" );
}

training_s2_start_set_up_player()
{
    common_scripts\utility::flag_clear( "flag_disable_exo" );
    common_scripts\utility::flag_set( "flag_enable_overdrive" );
    level.player allowcrouch( 1 );
    level.player allowprone( 1 );
    level.player allowjump( 1 );
    level.player enableweapons();
    level.player allowfire( 1 );
    level.player allowads( 1 );
    level.player allowmelee( 1 );
    maps\_variable_grenade::give_player_variable_grenade();
}

training_s1_squad_allow_run()
{
    if ( isalive( level.ally_squad_member_1 ) )
        level.ally_squad_member_1 allowedstances( "prone", "crouch", "stand" );

    if ( isalive( level.ally_squad_member_2 ) )
        level.ally_squad_member_2 allowedstances( "prone", "crouch", "stand" );

    if ( isalive( level.ally_squad_member_4 ) )
        level.ally_squad_member_4 allowedstances( "prone", "crouch", "stand" );

    if ( isalive( level.joker ) )
        level.joker allowedstances( "prone", "crouch", "stand" );

    if ( isalive( level.ally_squad_member_3 ) )
        level.ally_squad_member_3 allowedstances( "prone", "crouch", "stand" );
}

training_s1_windy_trees()
{
    var_0 = getentarray( "windy_trees", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread training_s1_windy_trees_think();
}

training_s1_windy_trees_think()
{
    wait(randomfloatrange( 1.5, 2.85 ));

    while ( common_scripts\utility::flag( "training_s1_enable_living_room" ) == 0 )
    {
        var_0 = self.angles;
        var_1 = randomintrange( 1, 3 );

        if ( var_1 == 2 )
            var_2 = 6;
        else
            var_2 = -6;

        self rotateto( var_0 + ( var_2, 0, 0 ), 4, 3, 1 );
        wait 4;
        self rotateto( var_0, 4, 3, 1 );
        wait 3.85;
    }
}

player_control_on()
{
    level.player unlink();
    level.player enableweapons();
    level.player allowstand( 1 );
    level.player allowcrouch( 1 );
    level.player allowprone( 1 );
    level.player allowsprint( 1 );
}

training_s1_opening_guy_think( var_0, var_1 )
{
    self endon( "death" );
    var_2 = common_scripts\utility::getstruct( var_0, "targetname" );
    self forceteleport( var_2.origin, var_2.angles );
    self setgoalpos( self.origin );
    self allowedstances( "crouch" );
    maps\_stealth_utility::stealth_plugin_basic();
    maps\_stealth_utility::stealth_plugin_accuracy();
    maps\_stealth_utility::stealth_plugin_smart_stance();
    maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01_variablereddot", "primary" );
    maps\_utility::disable_surprise();

    if ( !isdefined( level.allies_s1 ) )
        level.allies_s1 = [];

    level.allies_s1 = common_scripts\utility::array_add( level.allies_s1, self );
    common_scripts\utility::flag_wait( var_1 );

    if ( isdefined( self.magic_bullet_shield ) )
        maps\_utility::stop_magic_bullet_shield();

    bloody_death();
}

training_s1_starting_enemies_think( var_0, var_1, var_2 )
{
    self endon( "death" );
    thread attach_flashlight_on_gun();
    thread maps\_utility::set_battlechatter( 0 );
    maps\_utility::disable_long_death();
    thread training_s1_start_stealth_watch( var_0 );
    thread training_s1_starting_enemies_alerted( var_0 );
    common_scripts\utility::flag_wait( var_1 );
    wait(randomfloatrange( 0.5, 1.5 ));
    bloody_death();
}

training_s1_start_stealth_watch( var_0 )
{
    self endon( "death" );
    common_scripts\utility::waittill_any_ents( self, "patrol_alerted", self, "_stealth_spotted", self, "stealth_event", self, "_stealth_found_corpse", self, "alerted", self, "enemy" );
    wait 2;
    thread training_s1_alert();
    common_scripts\utility::flag_set( var_0 );
}

training_s1_starting_enemies_alerted( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( var_0 );
    self notify( "alerted" );
    thread maps\_utility::set_battlechatter( 1 );
    maps\_utility::player_seek();
}

training_s1_sniper_enemies_think( var_0, var_1, var_2 )
{
    self endon( "death" );
    self.health = 1;
    attach_flashlight_on_gun();
    maps\_utility::set_battlechatter( 0 );
    thread training_s1_start_stealth_watch( var_0 );
    common_scripts\utility::flag_wait( var_0 );
    self notify( "alerted" );
    maps\_utility::set_battlechatter( 1 );
    common_scripts\utility::flag_wait( var_1 );
    wait(randomfloatrange( 0.5, 1.5 ));
    bloody_death();
}

training_s1_starting_enemies_charge( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( var_0 );
    maps\_utility::player_seek();
}

training_s1_surprise_enemy_think()
{
    self endon( "death" );
    maps\_utility::disable_bulletwhizbyreaction();

    if ( !maps\_utility::ent_flag_exist( "_stealth_behavior_asleep" ) )
        maps\_utility::ent_flag_init( "_stealth_behavior_asleep" );

    maps\_utility::ent_flag_set( "_stealth_behavior_asleep" );
    self.ignoreall = 1;
    var_0 = self.health;
    thread maps\_utility::magic_bullet_shield();
    self.ignorerandombulletdamage = 1;
    maps\_utility::disable_long_death();
    thread attach_flashlight_on_gun();
    maps\_utility::set_battlechatter( 0 );
    thread training_s1_surprise_enemy_alert( var_0 );
    common_scripts\utility::flag_wait( "flag_training_s1_surprise_enemy_alert" );
    maps\_utility::enable_bulletwhizbyreaction();

    if ( isdefined( self.magic_bullet_shield ) )
    {
        thread maps\_utility::stop_magic_bullet_shield();
        self.noragdoll = undefined;
    }

    self.ignoreall = 0;
    self.health = var_0;
    self.ignorerandombulletdamage = 0;

    if ( maps\_utility::ent_flag_exist( "_stealth_behavior_asleep" ) )
        maps\_utility::ent_flag_clear( "_stealth_behavior_asleep" );
}

training_s1_surprise_enemy_alert( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "training_s1_start_alerted" );
    maps\_utility::enable_bulletwhizbyreaction();

    if ( isdefined( self.magic_bullet_shield ) )
    {
        thread maps\_utility::stop_magic_bullet_shield();
        self.noragdoll = undefined;
    }

    self.ignoreall = 0;
    self.health = var_0;
    self.ignorerandombulletdamage = 0;

    if ( maps\_utility::ent_flag_exist( "_stealth_behavior_asleep" ) )
        maps\_utility::ent_flag_clear( "_stealth_behavior_asleep" );

    self notify( " alerted" );
    maps\_utility::player_seek();
}

training_s1_surprise_enemy_go()
{
    wait 3;
    self.health = 1;

    if ( isdefined( self.magic_bullet_shield ) )
        thread maps\_utility::stop_magic_bullet_shield();

    if ( maps\_utility::ent_flag_exist( "_stealth_behavior_asleep" ) )
        maps\_utility::ent_flag_clear( "_stealth_behavior_asleep" );
}

training_surprise_enemy_move_to_patio( var_0 )
{
    self endon( "death" );

    if ( isdefined( var_0 ) )
    {
        self.goalradius = 8;
        maps\_utility::set_forcegoal();
        maps\_utility::set_goal_node( var_0 );
        self waittill( "goal" );
        maps\_utility::unset_forcegoal();
        self.ignoreall = 0;
    }
}

training_s1_alert_check()
{
    level endon( "training_s1_start_alerted" );
    level endon( "training_s1_clear_initial_spawn" );
    common_scripts\utility::flag_wait( "flag_training_s1_alert_starting_enemies" );
    thread training_s1_alert();
}

training_s1_alert()
{
    common_scripts\utility::flag_set( "training_s1_start_alerted" );
    common_scripts\utility::flag_set( "training_s1_snipers_attack" );
    common_scripts\utility::flag_set( "flag_vo_training_s1_joker_spotted_us" );
    level notify( "training_s1_start_enemies_alert" );
    thread training_s1_set_squad_active_and_target();
    thread training_s1_squad_allow_run();
    common_scripts\utility::flag_set( "flag_obj_rescue1_start_clear" );
    maps\_utility::waittill_aigroupcount( "training_s1_enemies_start", 2 );
    common_scripts\utility::flag_set( "training_s1_clear_initial_spawn" );
    maps\_utility::waittill_aigroupcleared( "training_s1_enemies_start" );
    common_scripts\utility::flag_set( "training_s1_start_alerted_enemies_dead" );
    common_scripts\utility::flag_set( "training_s1_clear_initial_spawn" );
    wait 1;
    common_scripts\utility::flag_set( "training_s1_prepare_breach_room" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_enter" );
    thread training_s1_set_squad_passive_and_ignore();
}

training_s1_monitor_surprise_enemy_death()
{
    self waittill( "death" );
    wait 2;

    if ( common_scripts\utility::flag( "flag_vo_training_s1_joker_got_him" ) == 0 )
        common_scripts\utility::flag_set( "flag_vo_training_s1_joker_good_kill" );
}

training_s1_kill_surprise_enemy()
{
    if ( isalive( level.surprise_enemy ) )
    {
        level.surprise_enemy.health = 1;
        magicbullet( level.joker.weapon, level.joker gettagorigin( "tag_flash" ), level.surprise_enemy geteye() );
        level.surprise_enemy bloody_death();
        common_scripts\utility::flag_set( "flag_vo_training_s1_joker_got_him" );
    }
}

training_s1_show_threat_text()
{
    level endon( "threat_grenade_hint_text_off" );
    wait 1;
    thread training_s1_show_threat_text_ender();

    for (;;)
    {
        level.player.showhint = 1;
        thread maps\_utility::display_hint( "threat_breach_prompt" );
        common_scripts\utility::flag_waitopen( "player_at_threat_breach" );
        level.player.showhint = 0;
        common_scripts\utility::flag_wait( "player_at_threat_breach" );
    }
}

training_s1_show_threat_text_ender()
{
    common_scripts\utility::flag_wait( "threat_grenade_hint_text_off" );
    level.player.showhint = 0;
}

training_s1_refill_threat_grenades()
{
    while ( !common_scripts\utility::flag( "threat_grenade_hint_text_off" ) )
    {
        if ( !common_scripts\utility::flag( "player_at_threat_breach" ) )
            common_scripts\utility::flag_wait( "player_at_threat_breach" );

        if ( level.player setweaponammostock( "paint_grenade_var" ) == 0 )
            level.player setweaponammostock( "paint_grenade_var", 1 );

        wait 0.2;
    }
}

training_s1_threat_enemies()
{
    wait 1.5;
    var_0 = self;

    for ( var_1 = 0; var_1 < 4 && var_0.size > 0; var_0 = maps\_utility::array_removedead( var_0 ) )
    {
        foreach ( var_3 in var_0 )
        {
            var_4 = randomfloatrange( 1.5, 2.5 );
            wait(var_4);
            var_1 += var_4;

            if ( !isalive( var_3 ) )
                continue;

            var_5 = 7;
            var_6 = ( randomfloat( var_5 ), randomfloat( var_5 ), randomfloat( var_5 ) );
            magicbullet( level.joker.weapon, level.joker gettagorigin( "tag_flash" ), var_3 geteye() + var_6 );
            var_4 = randomfloatrange( 0.2, 0.35 );
            wait(var_4);
            var_1 += var_4;
            var_6 = ( randomfloat( var_5 ), randomfloat( var_5 ), randomfloat( var_5 ) );

            if ( common_scripts\utility::cointoss() )
                magicbullet( level.joker.weapon, level.joker gettagorigin( "tag_flash" ), var_3 geteye() + var_6 );

            if ( !isalive( var_3 ) )
                continue;
        }
    }

    level.ally_squad_member_3 maps\_utility::stop_magic_bullet_shield();
    level.ally_squad_member_3 bloody_death();
}

training_s1_flash_door()
{
    var_0 = common_scripts\utility::getstruct( "training_s1_flashbang_animnode", "targetname" );
    var_1 = getent( "training_s1_flash_door", "targetname" );
    var_1.animname = "door_prop";
    var_1 maps\_utility::assign_animtree();
    var_2 = getent( "living_room_door_clip", "targetname" );
    var_2 linkto( var_1, "door" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "training_s1_flash_door_open" );
    common_scripts\utility::flag_wait( "training_s1_peak_flash_door" );
    var_0 maps\_anim::anim_single_solo( var_1, "training_s1_flash_door_open" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "training_s1_flash_door_open_idle", "stop_loop" );
    common_scripts\utility::flag_wait( "training_s1_open_flash_door" );
    var_0 notify( "stop_loop" );
    var_0 maps\_anim::anim_single_solo( var_1, "training_s1_flash_door_out" );
    var_2 connectpaths();
    common_scripts\utility::flag_wait( "training_s1_close_living_room_door" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "training_s1_flash_door_open" );
    wait 1;
    var_2 disconnectpaths();
}

training_s1_flash_enemies_think( var_0, var_1 )
{
    self endon( "death" );
    self.pacifist = 1;
    self.ignoreall = 1;
    self.ignoreme = 1;
    maps\_utility::disable_long_death();

    if ( isdefined( self.animation ) )
    {
        self.animname = "generic";
        thread maps\_anim::anim_loop_solo( self, self.animation, "stop_loop" );
        maps\_utility::set_allowdeath( 1 );
        thread training_s1_flash_death_check();
    }

    common_scripts\utility::flag_wait( var_0 );
    maps\_utility::anim_stopanimscripted();

    if ( level.flash_attack == 1 )
        maps\_utility::flashbangstart( 4 );
    else
        maps\_stealth_shared_utilities::enemy_reaction_state_alert();

    self.pacifist = 0;
    self.ignoreall = 0;
    self.ignoreme = 0;
    common_scripts\utility::flag_wait( var_1 );
    bloody_death( 1 );
}

training_s1_flash_death_check()
{
    self waittill( "death" );

    if ( common_scripts\utility::flag( "training_s1_open_flash_door" ) == 0 )
    {
        level.flash_attack = 0;
        common_scripts\utility::flag_set( "training_s1_flag_flash" );
    }
}

training_s1_enemies_living_room_think()
{
    self endon( "death" );
    self.ignoreall = 1;
    thread maps\_utility::set_battlechatter( 0 );
    maps\_utility::disable_long_death();
    thread training_s1_threat_death_check();

    if ( isdefined( self.animation ) )
    {
        self.animname = "generic";
        maps\_utility::set_allowdeath( 1 );
        thread maps\_anim::anim_loop_solo( self, self.animation, "stop_loop" );
    }
}

training_s1_threat_death_check()
{
    level endon( "threat_thrown" );
    self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

    if ( common_scripts\utility::flag( "training_s1_flag_thermal" ) == 0 && var_1 == level.player )
    {
        level.threat_attack = "nil";
        common_scripts\utility::flag_set( "training_s1_flag_thermal" );
    }
}

training_s1_living_room_check()
{
    maps\_utility::waittill_aigroupcleared( "flash_enemies" );
    level.living_room_clear = 1;
}

training_s1_living_room_timer()
{
    wait 15;
    level.living_room_clear = 1;
}

training_s1_threat_door()
{
    var_0 = common_scripts\utility::getstruct( "training_s1_flashbang_animnode", "targetname" );
    var_1 = getent( "training_s1_flash_door", "targetname" );
    var_1.animname = "door_prop";
    var_1 maps\_utility::assign_animtree();
    var_2 = getent( "living_room_door_clip", "targetname" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "training_s1_threat_door_open" );
    var_2 linkto( var_1, "door" );
    common_scripts\utility::flag_wait( "training_s1_peak_thermal_door" );
    var_0 maps\_anim::anim_single_solo( var_1, "training_s1_threat_door_open" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "training_s1_threat_door_open_idle", "stop_loop" );
    common_scripts\utility::flag_wait( "training_s1_open_thermal_door" );

    if ( level.threat_attack == "smart" )
        wait 3;

    var_0 notify( "stop_loop" );
    var_0 maps\_anim::anim_single_solo( var_1, "training_s1_threat_door_out" );
    var_2 connectpaths();
    common_scripts\utility::flag_wait( "training_s1_breach_done" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "training_s1_threat_door_open" );
    wait 1;
    var_2 disconnectpaths();
}

training_s1_shoot_monitor()
{
    level endon( "flag_obj_rescue1_breach" );
    level.threat_attack = "nil";

    for (;;)
    {
        level.player waittill( "weapon_fired", var_0 );

        if ( common_scripts\utility::flag( "player_at_threat_breach" ) )
        {
            level.threat_attack = var_0;
            common_scripts\utility::flag_set( "threat_grenade_hint_text_off" );
            common_scripts\utility::flag_set( "threat_breach_kickoff_gunfire" );
            break;
        }
    }
}

training_s1_flash_monitor()
{
    level.threat_attack = "nil";

    for (;;)
    {
        level.player waittill( "grenade_fire", var_0, var_1 );

        if ( common_scripts\utility::flag( "player_at_threat_breach" ) )
            break;
    }

    if ( var_1 == "paint_grenade_var" )
        level notify( "threat_thrown" );

    level notify( "training_s1_joker_threat_grenade_nag_off" );
    common_scripts\utility::flag_set( "threat_grenade_hint_text_off" );
    var_0 waittill( "death" );

    if ( var_1 == "paint_grenade_var" )
        level.threat_attack = "threat";
    else if ( var_1 == "tracking_grenade_var" )
        level.threat_attack = "smart";
    else
        level.threat_attack = "other";

    common_scripts\utility::flag_set( "training_s1_flag_thermal" );
}

training_s1_kill_threat_enemies()
{
    self endon( "death" );
    wait 5;

    if ( isalive( self ) )
    {
        magicbullet( level.gideon.weapon, level.gideon gettagorigin( "tag_flash" ), self geteye() );
        bloody_death();
    }
}

training_surprise_enemy_think()
{
    if ( !isalive( self ) )
        return;

    self endon( "death" );
    thread maps\_stealth_shared_utilities::enemy_reaction_state_alert();
    thread maps\_utility::set_battlechatter( 1 );
    self.ignoreall = 0;
    self.health = 1;
    var_0 = getent( "training_s1_surprise_enemy_cover_node", "targetname" );

    if ( isdefined( var_0 ) )
    {
        self.goalradius = 32;
        maps\_utility::set_forcegoal();
        maps\_utility::set_goal_node( var_0 );
        self waittill( "goal" );
        maps\_utility::unset_forcegoal();
    }
}

training_s2_open_bedroom_door_2()
{
    var_0 = getent( "bedroom_2_door", "targetname" );
    getent( var_0.target, "targetname" ) linkto( var_0 );
    var_0.angles += ( 0, 85, 0 );
    var_0 connectpaths();
}

training_s1_president_setup( var_0 )
{
    self endon( "death" );
    maps\_utility::magic_bullet_shield();
    self.animname = "president";
    self.pacifist = 1;
    self.ignoreme = 1;
    self.ignoreall = 1;
    maps\_utility::set_battlechatter( 0 );
    self.team = "allies";
    level maps\_utility::clear_color_order( "y", "allies" );
    maps\_utility::set_force_color( "y" );
    common_scripts\utility::flag_wait( var_0 );

    if ( isdefined( self.magic_bullet_shield ) )
        maps\_utility::stop_magic_bullet_shield();

    self delete();
}

training_s1_set_up_search_drones( var_0, var_1 )
{
    self endon( "death" );
    thread maps\_shg_utility::make_emp_vulnerable();
    self.ignoreall = 1;
    self.ignoreme = 1;
    thread training_s1_search_drones_damage_check( var_0 );
    thread training_s1_search_drones_death_check();
    thread training_s1_search_drones_cleanup( var_1 );

    if ( isdefined( self.animation ) )
    {
        thread training_s1_search_drones_play_ainm();
        thread maps\recovery_fx::drone_search_light_fx();
    }
    else
        self laseron();

    common_scripts\utility::flag_wait( var_0 );
    self.ignoreall = 0;
    self.ignoreme = 0;

    if ( isdefined( self.animation ) )
        self stopanimscripted();

    thread vehicle_scripts\_pdrone::stop_scripted_move_and_attack();
}

training_s1_search_drones_play_ainm()
{
    wait 2;
    self.animname = "pdrone";
    self.allowdeath = 1;
    var_0 = getent( "training_s1_drone_attack_scene", "targetname" );
    var_0 maps\_anim::anim_first_frame_solo( self, self.animation );
    var_0 maps\_anim::anim_single_solo( self, self.animation );

    if ( isalive( self ) )
        self delete();
}

training_s1_search_drones_damage_check( var_0 )
{
    self endon( "death" );
    self endon( "training_s1_search_drones_done" );
    self waittill( "damage" );

    if ( !common_scripts\utility::flag( "training_s1_search_drones_done" ) )
        common_scripts\utility::flag_set( var_0 );
}

training_s1_search_drones_death_check()
{
    self waittill( "death" );
    level.search_drones_count += 1;
}

training_s1_search_drones_cleanup( var_0 )
{
    self endon( "death" );
}

training_s1_drone_ambush_scene()
{
    wait 1;
    var_0 = common_scripts\utility::getstruct( "attacklocation1", "targetname" );
    var_1 = level.ally_squad_member_1;
    var_1 maps\_utility::enable_long_death();
    var_1 maps\_utility::stop_magic_bullet_shield();
    magicbullet( "iw5_bal27_sp", var_0.origin, var_1.origin );
    magicbullet( "iw5_bal27_sp", var_0.origin, var_1.origin );
    wait 0.5;
    magicbullet( "iw5_bal27_sp", var_0.origin, var_1.origin );
    wait 0.25;
    magicbullet( "iw5_bal27_sp", var_0.origin, var_1.origin );

    if ( isalive( var_1 ) )
        var_1 kill();

    wait 5;
    var_2 = common_scripts\utility::getstruct( "attacklocation2", "targetname" );
    var_3 = level.ally_squad_member_4;
    var_3 maps\_utility::enable_long_death();
    var_3 maps\_utility::stop_magic_bullet_shield();
    magicbullet( "iw5_bal27_sp", var_2.origin, var_3.origin );
    magicbullet( "iw5_bal27_sp", var_2.origin, var_3.origin );
    wait 0.15;
    magicbullet( "iw5_bal27_sp", var_2.origin, var_3.origin );
    magicbullet( "iw5_bal27_sp", var_2.origin, var_3.origin );
    wait 0.25;
    magicbullet( "iw5_bal27_sp", var_2.origin, var_3.origin );
    magicbullet( "iw5_bal27_sp", var_2.origin, var_3.origin );

    if ( isalive( var_3 ) )
        var_3 kill();
}

training_s1_terrace_enemies_think( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( var_0 );
    bloody_death( 1 );
}

training_s1_patio_enemies_think( var_0, var_1 )
{
    self endon( "death" );
    thread maps\_utility::disable_long_death();
    var_2 = self.health;
    self.health = 1;
    thread maps\_utility::set_battlechatter( 0 );

    if ( randomint( 10 ) < 5 )
        thread attach_flashlight_on_gun();

    thread training_s1_patio_enemies_alert( var_0, var_2 );
    thread training_s1_patio_enemies_alert_check( var_0 );
    common_scripts\utility::flag_wait( var_1 );
    bloody_death();
}

training_s1_patio_enemies_alert( var_0, var_1 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( var_0 );
    self.health = var_1;
    thread maps\_utility::set_battlechatter( 1 );
    self notify( "alerted" );
}

training_s1_patio_enemies_alert_check( var_0 )
{
    self endon( "death" );
    common_scripts\utility::waittill_any_ents( self, "patrol_alerted", self, "_stealth_spotted", self, "stealth_event", self, "_stealth_found_corpse", self, "alerted", self, "enemy" );
    wait 3;
    common_scripts\utility::flag_set( var_0 );
    training_s1_set_squad_active_and_target();
}

training_s1_allies_advance()
{
    level endon( "training_s1_hide" );
    thread training_s1_check_snipers();
    thread training_s1_patio_joker_loc_check();

    while ( common_scripts\utility::flag( "training_s1_spawn_patio_wave1_dead" ) == 0 && common_scripts\utility::flag( "training_s1_spawn_patio_enemies_wave2" ) == 0 )
        waitframe();

    if ( common_scripts\utility::flag( "training_s1_patio_alerted" ) == 1 && common_scripts\utility::flag( "training_s1_spawn_patio_wave1_dead" ) == 0 )
    {
        maps\_utility::activate_trigger( "training_s1_color_trigger_patio_lower1", "targetname" );
        level.joker maps\_utility::cqb_walk( "off" );
    }

    while ( common_scripts\utility::flag( "training_s1_spawn_patio_wave1_dead" ) == 0 && common_scripts\utility::flag( "training_s1_spawn_patio_enemies_wave3" ) == 0 )
        waitframe();

    if ( common_scripts\utility::flag( "training_s1_patio_alerted" ) == 1 && common_scripts\utility::flag( "training_s1_spawn_patio_wave1_dead" ) == 0 )
    {
        maps\_utility::activate_trigger( "training_s1_color_trigger_patio_lower", "targetname" );
        level.joker maps\_utility::cqb_walk( "off" );
    }
}

training_s1_patio_joker_loc_check()
{
    level endon( "training_s1_hide" );
    common_scripts\utility::flag_wait( "training_s1_patio_alerted" );

    if ( common_scripts\utility::flag( "training_s1_spawn_patio_enemies_wave2" ) )
    {
        maps\_utility::activate_trigger( "training_s1_color_trigger_patio_lower1", "targetname" );
        level.joker maps\_utility::cqb_walk( "off" );
    }

    if ( common_scripts\utility::flag( "training_s1_spawn_patio_enemies_wave3" ) )
    {
        maps\_utility::activate_trigger( "training_s1_color_trigger_patio_lower", "targetname" );
        level.joker maps\_utility::cqb_walk( "off" );
    }
}

training_s1_check_snipers()
{
    maps\_utility::waittill_aigroupcleared( "patio_ambush1" );
    common_scripts\utility::flag_set( "training_s1_spawn_patio_wave1_dead" );
}

training_s1_pool_house_doors()
{
    var_0 = getent( "pool_house_door01", "targetname" );
    getent( var_0.target, "targetname" ) linkto( var_0 );
    var_1 = getent( "pool_house_door02", "targetname" );
    getent( var_1.target, "targetname" ) linkto( var_1 );
    var_0 rotateto( var_0.angles + ( 0, 90, 0 ), 1, 0, 1 );
    var_1 rotateto( var_1.angles + ( 0, -90, 0 ), 1, 0, 1 );
    var_0 connectpaths();
    var_1 connectpaths();
    wait 3;
    var_0 rotateto( var_0.angles + ( 0, -90, 0 ), 1, 0, 1 );
    var_1 rotateto( var_1.angles + ( 0, 90, 0 ), 1, 0, 1 );
    var_0 disconnectpaths();
    var_1 disconnectpaths();
}

training_s1_terrace_vehicles_think( var_0, var_1, var_2 )
{
    self endon( "death" );
    thread training_s1_terrace_vehicles_cleanup( var_0 );
    thread training_s1_golf_course_encounter( var_1 );

    foreach ( var_4 in self.riders )
    {
        var_4 thread attach_flashlight_on_vehicle_unload();
        var_4 thread maps\_utility::set_battlechatter( 0 );
        var_4 thread training_s1_terrace_vehicles_riders_think( var_1 );
        var_4 thread training_s1_terrace_vehicles_riders_cleanup( var_0, var_1 );
        var_4 thread training_s1_golf_course_alert( var_1 );
    }

    common_scripts\utility::flag_wait( var_1 );
    var_6 = getent( "golf_course_watch_out", "targetname" );
    badplace_brush( "watch_out", -1, var_6, "axis" );
    var_7 = getentarray( "training_s1_vehicle_attack_node", "script_noteworthy" );

    foreach ( var_9 in var_7 )
    {
        var_10 = 2;

        if ( isdefined( var_9.speed ) )
            var_9.speed *= var_10;
    }

    common_scripts\utility::flag_wait( var_2 );
    badplace_delete( "watch_out" );
    soundscripts\_snd::snd_message( "rec_train1_stealth_car_stop", self );
    maps\_vehicle::vehicle_stop_named( "stop_to_kill_player", 15, 10 );
    maps\_vehicle::vehicle_unload( "all_but_gunner" );
}

training_s1_golf_course_encounter( var_0 )
{
    while ( common_scripts\utility::flag( "training_s1_hide_from_patrols_done" ) == 0 )
    {
        common_scripts\utility::flag_wait( var_0 );
        maps\_utility::waittill_aigroupcleared( "golf_course_ambush1" );
        common_scripts\utility::flag_set( "training_s1_hide_from_patrols_done" );
    }
}

training_s1_golf_course_encounter_track_deaths()
{
    maps\_utility::waittill_aigroupcleared( "golf_course_ambush1" );
    common_scripts\utility::flag_set( "training_s1_hide_from_patrols_done" );
}

training_s1_terrace_vehicles_riders_cleanup( var_0, var_1 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "training_s1_golf_course_vehicles" );

    if ( !common_scripts\utility::flag( var_1 ) )
        self delete();
    else
    {
        common_scripts\utility::flag_wait( var_0 );
        self delete();
    }
}

training_s1_terrace_vehicles_riders_think( var_0 )
{
    self endon( "death" );
    self.pacifist = 1;
    self.ignoreall = 1;
    self.ignoreme = 1;
    maps\_utility::disable_long_death();
    common_scripts\utility::flag_wait( var_0 );
    self.pacifist = 0;
    self.ignoreall = 0;
    thread maps\_utility::set_battlechatter( 1 );
    self.ignoreme = 0;
}

training_s1_terrace_vehicles_cleanup( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( var_0 );

    foreach ( var_2 in self.riders )
        var_2 delete();

    self delete();
}

training_s1_golf_course_alert( var_0 )
{
    var_1 = common_scripts\utility::waittill_any_return( "patrol_alerted", "_stealth_spotted", "stealth_event", "alerted", "enemy", "damage", "death" );
    wait 2;

    if ( isalive( self ) )
    {
        self notify( "alerted" );
        thread maps\_utility::clear_run_anim();
        thread maps\_utility::player_seek_enable();
    }

    if ( !common_scripts\utility::flag( var_0 ) )
        common_scripts\utility::flag_set( var_0 );
}

training_s1_runner_enemy_think( var_0, var_1 )
{
    self endon( "death" );
    maps\_utility::disable_long_death();
    attach_flashlight_on_gun();
    thread training_s1_golf_course_alert( var_1 );
    var_2 = [];
    var_2["saw"] = ::training_s1_runner_enemy_found_corpse;
    var_2["found"] = ::training_s1_runner_enemy_found_corpse;
    maps\_stealth_utility::stealth_corpse_behavior_custom( var_2 );
    force_patrol_anim_set( "patroljog", 0 );
    maps\_utility::set_moveplaybackrate( 1.1 );
    training_s1_runner_enemy_think_cleanup( var_1 );
    common_scripts\utility::flag_wait( var_0 );
    bloody_death();
}

training_s1_runner_enemy_think_cleanup( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "training_s1_golf_course_vehicles" );

    if ( !common_scripts\utility::flag( var_0 ) )
        self delete();
}

training_s1_runner_enemy_found_corpse()
{
    clearallcorpses();
}

force_patrol_anim_set( var_0, var_1, var_2 )
{
    maps\_patrol_extended::force_patrol_anim_set( var_0, var_1, 0, var_2 );
}

training_prone_hint_text()
{
    wait 1;
    level.player.showhint = 1;

    if ( level.player common_scripts\utility::is_player_gamepad_enabled() )
        thread maps\_utility::display_hint( "prone_prompt" );
    else
        thread maps\_utility::display_hint( "pc_prone_prompt" );

    thread training_prone_hint_monitor();
    var_0 = 8;
    level common_scripts\utility::waittill_notify_or_timeout( "player_prone", var_0 );
    level.player.showhint = 0;
}

training_prone_hint_monitor()
{
    level endon( "training_s1_hide_from_patrols_done" );

    while ( level.player getstance() != "prone" && common_scripts\utility::flag( "training_s1_spotted" ) == 0 )
        wait 0.5;

    level notify( "player_prone" );
}

training_s1_escape_vehicle_think( var_0, var_1 )
{
    self endon( "death" );

    foreach ( var_3 in self.riders )
        var_3 thread training_s1_escape_vehicle_driver( var_0 );

    common_scripts\utility::flag_wait( var_1 );
    maps\_utility::stop_magic_bullet_shield();
    self delete();
}

training_s1_escape_vehicle_driver( var_0 )
{
    self endon( "death" );
    self.health = 1;
    common_scripts\utility::flag_wait( var_0 );
    bloody_death();
}

training_s1_ambush_vehicles_think( var_0, var_1 )
{
    self endon( "death" );

    foreach ( var_3 in self.riders )
        var_3 thread training_s1_unload1_think( var_0, var_1 );

    self waittill( "reached_end_node" );
    maps\_vehicle::vehicle_unload();
    common_scripts\utility::flag_wait( var_0 );
    self.pacifist = 1;

    foreach ( var_3 in self.riders )
    {
        var_3.ignoreall = 1;
        var_3.pacifist = 1;
    }

    common_scripts\utility::flag_wait( var_1 );
    self delete();
}

training_s1_unload1_think( var_0, var_1 )
{
    self endon( "death" );

    if ( isdefined( self.vehicle_position ) )
        thread attach_flashlight_on_vehicle_unload();

    common_scripts\utility::flag_wait( var_0 );
    self.pacifist = 1;
    self.ignoreall = 1;
    common_scripts\utility::flag_wait( var_1 );
    bloody_death();
}

training_s1_kva_ambush1_think( var_0, var_1 )
{
    self endon( "death" );
    thread maps\_utility::disable_long_death();
    thread attach_flashlight_on_gun();
    common_scripts\utility::flag_wait( var_0 );
    self.pacifist = 1;
    self.ignoreall = 1;
    self.ignoreme = 1;
    maps\_utility::set_battlechatter( 0 );
    common_scripts\utility::flag_wait( var_1 );
    bloody_death();
}

training_s1_kva_ambush2_think( var_0, var_1 )
{
    self endon( "death" );
    thread maps\_utility::disable_long_death();
    thread attach_flashlight_on_gun();
    self.ignoreall = 1;
    maps\_utility::set_goal_radius( 40 );
    self waittill( "goal" );

    if ( isdefined( self ) && isalive( self ) )
        self.ignoreall = 0;

    common_scripts\utility::flag_wait( var_0 );
    self.pacifist = 1;
    self.ignoreall = 1;
    self.ignoreme = 1;
    maps\_utility::set_battlechatter( 0 );
    common_scripts\utility::flag_wait( var_1 );
    bloody_death();
}

training_s1_guard_house_doors()
{
    var_0 = getent( "guard_door_01", "targetname" );
    getent( var_0.target, "targetname" ) linkto( var_0 );
    var_1 = getent( "guard_door_02", "targetname" );
    getent( var_1.target, "targetname" ) linkto( var_1 );
    wait(randomint( 10 ));
    var_0 rotateto( var_0.angles + ( 0, -90, 0 ), 1, 0, 1 );
    wait(randomint( 5 ));
    var_1 rotateto( var_1.angles + ( 0, 90, 0 ), 1, 0, 1 );
    var_0 connectpaths();
    var_1 connectpaths();
    wait 30;
    var_0 rotateto( var_0.angles + ( 0, 90, 0 ), 1, 0, 1 );
    wait(randomint( 5 ));
    var_1 rotateto( var_1.angles + ( 0, -90, 0 ), 1, 0, 1 );
    var_0 disconnectpaths();
    var_1 disconnectpaths();
}

training_door_cover_cloak_think()
{
    var_0 = self getmodelfromentity();
    self setmodel( var_0 + "_cloak" );
    self drawpostresolve();
    self setmaterialscriptparam( 1, 0 );
    wait 1;
    self setmaterialscriptparam( 0, 1.5 );
    wait 1.5;
    common_scripts\utility::hide_notsolid();
    common_scripts\utility::flag_wait( "training_round_2" );
    self setmodel( var_0 );
    common_scripts\utility::show_solid();
}

gideon_change_outfit()
{
    if ( level.gideon.model == "kva_body_assault" )
    {
        if ( isdefined( level.gideon.magic_bullet_shield ) )
            level.gideon maps\_utility::stop_magic_bullet_shield();

        level.gideon delete();
        maps\_utility::clear_color_order( "b", "allies" );
        level.gideon = getent( "gideon", "targetname" ) maps\_utility::spawn_ai( 1 );
        level.gideon.script_pushable = 0;
        var_0 = common_scripts\utility::getstruct( "gideon_exo_exit", "targetname" );
        level.gideon forceteleport( var_0.origin, var_0.angles );
        level.gideon maps\_utility::gun_remove();
    }
}

gideon_change_mask( var_0 )
{
    wait 5.5;
    // level.gideon detach( "head_hero_gideon_mask" );
    // level.gideon attach( "head_hero_gideon_mask_down" );
}

stack_make()
{
    var_0 = spawnstruct();
    var_0.contents = [];
    var_0.top = -1;
    var_0.isstack = 1;
    return var_0;
}

stack_push( var_0 )
{
    var_1 = self;
    var_1.top++;
    var_1.contents[var_1.top] = var_0;
}

stack_pop()
{
    var_0 = self;

    if ( var_0.top < 0 )
        return undefined;

    var_1 = var_0.contents[var_0.top];
    var_0.top--;
    return var_1;
}

stack_peek()
{
    var_0 = self;
    return var_0.contents[var_0.top];
}

aim_assist_using_bmodels_init()
{
    if ( isdefined( level.aim_assist_with_bmodels ) )
        return;

    level.aim_assist_with_bmodels = spawnstruct();
    level.aim_assist_with_bmodels.entities = getentarray( "script_brushmodel_for_aim_assist", "targetname" );
    level.aim_assist_with_bmodels.entitiesinuse = [];
    var_0 = stack_make();
    level.aim_assist_with_bmodels.stack = var_0;

    foreach ( var_2 in level.aim_assist_with_bmodels.entities )
    {
        var_2.maxhealth = 1000;
        var_2 setnormalhealth( var_2.maxhealth );
        var_2 hide();
        var_0 stack_push( var_2 );
    }
}

is_aim_assist_enabled_on_script_model( var_0 )
{
    return isdefined( var_0.aim_assist_bmodel );
}

enable_aim_assist_on_script_model( var_0, var_1 )
{
    var_2 = level.aim_assist_with_bmodels.stack;
    var_3 = var_2 stack_pop();
    var_3.health = var_3.maxhealth;
    var_3 enableaimassist();
    var_3 linkto( var_0, var_1, ( 4, 0, 0 ), ( 0, 0, 0 ) );
    var_0.aim_assist_bmodel = var_3;
    level.aim_assist_with_bmodels.entitiesinuse = common_scripts\utility::array_add( level.aim_assist_with_bmodels.entitiesinuse, var_3 );
}

disable_aim_assist_on_script_model( var_0 )
{
    var_1 = var_0.aim_assist_bmodel;
    var_1 unlink();
    var_2 = level.aim_assist_with_bmodels.stack;
    var_1 disableaimassist();
    var_2 stack_push( var_1 );
    var_0.aim_assist_bmodel = undefined;
    level.aim_assist_with_bmodels.entitiesinuse = common_scripts\utility::array_remove( level.aim_assist_with_bmodels.entitiesinuse, var_1 );
}

score_manager_print_final_score( var_0 )
{
    var_1 = level.score_keeper.count;
    var_2 = level.score_keeper.max;

    if ( var_0 == "holo_range" )
    {
        if ( var_1 > 2375 )
            common_scripts\utility::flag_set( "flag_vo_shooting_range_result_ilona" );

        if ( var_1 < 600 )
            common_scripts\utility::flag_set( "flag_vo_shooting_range_result_bad" );

        if ( var_1 >= 600 && var_1 < 1200 )
            common_scripts\utility::flag_set( "flag_vo_shooting_range_result_average" );

        if ( var_1 >= 1200 && var_1 < 2000 )
            common_scripts\utility::flag_set( "flag_vo_shooting_range_result_good" );

        if ( var_1 >= 2000 && var_1 < 3000 )
            common_scripts\utility::flag_set( "flag_vo_shooting_range_result_excellent" );

        if ( var_1 >= 3000 )
            common_scripts\utility::flag_set( "flag_vo_shooting_range_result_perfect" );

        if ( var_1 >= 2000 )
            maps\_utility::giveachievement_wrapper( "LEVEL_2A" );
    }
    else if ( var_0 == "grenade_range" )
    {
        switch ( var_1 )
        {
            case 0:
                iprintlnbold( "TRY AGAIN" );
                break;
            case 1:
                iprintlnbold( "AWFUL" );
                break;
            case 2:
                iprintlnbold( "TERRIBLE" );
                break;
            case 3:
                iprintlnbold( "TERRIBLE" );
                break;
            case 4:
                iprintlnbold( "POOR" );
                break;
            case 5:
                iprintlnbold( "POOR" );
                break;
            case 6:
                iprintlnbold( "AVERAGE" );
                break;
            case 7:
                iprintlnbold( "AVERAGE" );
                break;
            case 8:
                iprintlnbold( "DECENT" );
                break;
            case 9:
                iprintlnbold( "DECENT" );
                break;
            case 10:
                iprintlnbold( "GOOD" );
                break;
            case 11:
                iprintlnbold( "GOOD" );
                break;
            case 12:
                iprintlnbold( "GREAT" );
                break;
            case 13:
                iprintlnbold( "GREAT" );
                break;
            case 14:
                iprintlnbold( "AWESOME" );
                break;
            case 15:
                iprintlnbold( "AWESOME" );
                break;
            case 16:
                iprintlnbold( "PERFECT" );
                break;
        }
    }
    else if ( var_0 == "drone_range" )
        return;
}

score_manager_print_current_score()
{

}

score_manager_detect_timeout( var_0 )
{
    level.score_keeper endon( "score_manager_timed_out" );
    wait(var_0);
    level.score_keeper notify( "score_manager_timed_out" );
}

score_manager_increase_score( var_0, var_1 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.team ) && var_0.team == level.player.team )
    {
        common_scripts\utility::flag_set( "flag_vo_shooting_range_friendly" );
        level.score_keeper.count -= var_1;

        if ( var_1 == 25 )
            playfx( level._effect["recovery_scoring_minus25"], var_0.origin + ( 0, 0, 80 ) );

        if ( var_1 == 50 )
            playfx( level._effect["recovery_scoring_minus50"], var_0.origin + ( 0, 0, 80 ) );

        if ( var_1 == 75 )
            playfx( level._effect["recovery_scoring_minus75"], var_0.origin + ( 0, 0, 80 ) );

        if ( var_1 == 100 )
            playfx( level._effect["recovery_scoring_minus100"], var_0.origin + ( 0, 0, 80 ) );
    }
    else
    {
        level.score_keeper.count += var_1;

        if ( var_1 == 25 )
            playfx( level._effect["recovery_scoring_add25"], var_0.origin + ( 0, 0, 80 ) );

        if ( var_1 == 50 )
            playfx( level._effect["recovery_scoring_add50"], var_0.origin + ( 0, 0, 80 ) );

        if ( var_1 == 75 )
            playfx( level._effect["recovery_scoring_add75"], var_0.origin + ( 0, 0, 80 ) );

        if ( var_1 == 100 )
            playfx( level._effect["recovery_scoring_add100"], var_0.origin + ( 0, 0, 80 ) );
    }

    level.score_keeper notify( "score_manager_score_increased" );
    score_manager_print_current_score();
}

score_manager_waittill_timeout_or_maxscore( var_0, var_1 )
{
    level.score_keeper endon( "score_manager_timed_out" );
    level.score_keeper thread score_manager_detect_timeout( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = level.score_keeper.max - level.score_keeper.count;

    while ( var_1 > 0 )
    {
        level.score_keeper waittill( "score_manager_score_increased" );
        var_1--;
    }

    level.score_keeper notify( "score_manager_timed_out" );
}

score_manager_force_stop()
{
    level.score_keeper notify( "score_manager_timed_out" );
}

score_manager_init( var_0 )
{
    if ( !isdefined( level.score_keeper ) )
        level.score_keeper = spawnstruct();

    level.score_keeper.count = 0;
    level.score_keeper.max = var_0;
    level.score_keeper notify( "score_manager_timed_out" );
}

score_manager_detect_enemy_death()
{
    level.score_keeper endon( "score_manager_timed_out" );
    self endon( "score_manager_detect_enemy_death_stop" );
    common_scripts\utility::waittill_either( "death", "pain_death" );
    score_manager_increase_score( self );
}

score_manager_detect_damage( var_0, var_1 )
{
    level.score_keeper endon( "score_manager_timed_out" );
    var_2 = level.score_keeper.stats;
    self setcandamage( 1 );
    var_3 = undefined;
    var_4 = undefined;

    while ( !isdefined( var_3 ) || var_3 == "MOD_CRUSH" )
        self waittill( "damage", var_5, var_6, var_7, var_8, var_3, var_9, var_10, var_4, var_11 );

    if ( isdefined( var_0 ) && var_0 == 1 )
    {
        var_12 = self gettagorigin( "tag_head" );
        var_13 = self gettagorigin( "tag_chest" );
        var_14 = self gettagorigin( "tag_arms" );
        var_15 = self gettagorigin( "tag_legs" );
        level.score_keeper notify( "score_change" );
        playfx( level._effect["expround_asphalt_1"], self.origin );

        if ( isdefined( var_1 ) && var_1 )
        {
            playfx( level._effect["recovery_scoring_target_shutter_enemy"], var_13 );
            var_2.enemy_kills++;

            if ( var_4 == "tag_head" )
            {
                score_manager_increase_score( self, 100 );
                var_2.enemy_headshots++;
            }
            else if ( var_4 == "tag_chest" )
            {
                score_manager_increase_score( self, 75 );
                var_2.enemy_chestshots++;
            }
            else if ( var_4 == "tag_arms" )
            {
                score_manager_increase_score( self, 50 );
                var_2.enemy_armshots++;
            }
            else if ( var_4 == "tag_legs" )
            {
                score_manager_increase_score( self, 50 );
                var_2.enemy_legshots++;
            }

            soundscripts\_snd::snd_message( "shooting_range_enemy_shot", self, var_4 );
        }
        else
        {
            playfx( level._effect["recovery_scoring_target_shutter_friendly"], var_13 );
            var_2.civ_kills++;

            if ( var_4 == "tag_head" )
            {
                score_manager_increase_score( self, 100 );
                var_2.civ_headshots++;
            }
            else if ( var_4 == "tag_chest" )
            {
                score_manager_increase_score( self, 75 );
                var_2.civ_chestshots++;
            }
            else if ( var_4 == "tag_arms" )
            {
                score_manager_increase_score( self, 50 );
                var_2.civ_armshots++;
            }
            else if ( var_4 == "tag_legs" )
            {
                score_manager_increase_score( self, 50 );
                var_2.civ_legshots++;
            }

            soundscripts\_snd::snd_message( "shooting_range_friendly_shot", self, var_4 );
        }
    }
    else
    {
        score_manager_increase_score( self, 1 );
        playfx( level._effect["frag_grenade_default"], self.origin );
        soundscripts\_snd_playsound::snd_play_linked( "wpn_grenade_exp" );
    }

    self notify( "target_hit" );
}

wait_for_primary_weapon_pickup()
{
    level endon( "shooting_range_started_once" );
    level.player waittill( "weapon_switch_started" );

    for (;;)
    {
        var_0 = level.player getcurrentweapon();

        if ( var_0 != "none" )
            break;

        waitframe();
    }

    common_scripts\utility::flag_set( "flag_obj_equip_firing_range" );
    common_scripts\utility::flag_set( "flag_vo_shooting_range_02" );
}

attach_flashlight_on_gun()
{
    hand_flashlight_remove();

    if ( !isdefined( self.gun_flashlight ) || !self.gun_flashlight )
    {
        playfxontag( level._effect["flashlight"], self, "tag_flash" );
        self.gun_flashlight = 1;
        self notify( "flashlight_on_gun" );
    }
}

gun_flashlight_off()
{
    if ( isdefined( self.gun_flashlight ) && self.gun_flashlight )
    {
        stopfxontag( level._effect["flashlight"], self, "tag_flash" );
        self.gun_flashlight = 0;
    }
}

attach_flashlight_in_hand()
{
    if ( isdefined( self.hand_flashlight ) )
        return;

    gun_flashlight_off();
    var_0 = "TAG_INHAND";
    self.hand_flashlight = spawn( "script_model", self.origin );
    var_1 = self.hand_flashlight;
    var_1.owner = self;
    var_1.origin = self gettagorigin( var_0 );
    var_1.angles = self gettagangles( var_0 );
    var_1 setmodel( "com_flashlight_on" );
    var_1 linkto( self, var_0 );
    var_1 thread hand_flashlight_watch_for_drop();
    thread hand_flashlight_handle_alert();
    thread hand_flashlight_handle_node_pause();
    thread hand_flashlight_handle_effects();
    hand_flashlight_on();
}

hand_flashlight_watch_for_drop()
{
    self endon( "death" );

    for (;;)
    {
        if ( !isdefined( self.owner ) || self.owner.health <= 0 )
        {
            stopfxontag( common_scripts\utility::getfx( "flashlight" ), self, "tag_light" );
            return;
        }

        wait 0.2;
    }
}

hand_flashlight_on()
{
    self.hand_flashlight setmodel( "com_flashlight_on" );
    playfxontag( common_scripts\utility::getfx( "flashlight" ), self.hand_flashlight, "tag_light" );
}

hand_flashlight_off()
{
    self.hand_flashlight setmodel( "com_flashlight_off" );
    stopfxontag( common_scripts\utility::getfx( "flashlight" ), self.hand_flashlight, "tag_light" );
}

hand_flashlight_remove()
{
    if ( isdefined( self.hand_flashlight ) )
    {
        hand_flashlight_off();
        self.hand_flashlight delete();
        self notify( "stop_flashlight_thread" );
    }
}

hand_flashlight_should_hide( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( isdefined( var_0.script_animation ) && var_0.script_animation != "pause" )
        return 1;

    if ( isdefined( var_0.script_delay ) )
        return 1;

    return 0;
}

hand_flashlight_handle_alert()
{
    self endon( "death" );
    self endon( "stop_flashlight_thread" );
    common_scripts\utility::waittill_any( "death", "remove_flashlight", "enemy", "reached_path_end" );
    wait 0.1;

    if ( isalive( self ) )
        thread attach_flashlight_on_gun();
}

hand_flashlight_handle_node_pause()
{
    self endon( "death" );
    self endon( "remove_flashlight" );
    self endon( "stop_flashlight_thread" );

    for (;;)
    {
        self waittill( "goal" );

        if ( hand_flashlight_should_hide( self.last_patrol_goal ) )
        {
            self notify( "flashlight_off" );
            self waittill( "release_node" );
            self notify( "flashlight_on" );
        }
    }
}

hand_flashlight_handle_effects()
{
    self endon( "death" );
    self endon( "remove_flashlight" );
    self endon( "stop_flashlight_thread" );

    for (;;)
    {
        self waittill( "flashlight_off" );
        hand_flashlight_off();
        self waittill( "flashlight_on" );
        hand_flashlight_on();
    }
}

attach_flashlight_on_vehicle_unload()
{
    self waittill( "jumping_out" );
    attach_flashlight_on_gun();
}

training_stealth_spotted()
{
    common_scripts\utility::flag_wait( "_stealth_spotted" );
    thread training_s2_set_squad_active_and_target();
    common_scripts\utility::flag_set( "training_s2_start_alerted" );
    common_scripts\utility::flag_set( "flag_vo_training_s2_joker_here_they" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_entrance_clear" );
    wait 3;

    if ( level.player maps\_player_exo::overdrive_is_on() == 0 )
    {
        if ( level.player.exobatterylevel == 0 )
            maps\recovery_code::give_overdrive_battery();

        common_scripts\utility::flag_set( "flag_vo_training_s2_gideon_use_overdrive" );
        thread maps\_utility::display_hint_timeout( "overdrive_prompt_sim", 3 );
    }
}

training_s1_golf_course_custom_stealth()
{
    var_0 = [];
    var_0["prone"] = 150;
    var_0["crouch"] = 400;
    var_0["stand"] = 400;
    maps\_stealth_visibility_system::system_set_detect_ranges( var_0 );
    var_1 = [];
    var_1["player_dist"] = 1500;
    var_1["sight_dist"] = 480;
    var_1["detect_dist"] = 240;
    var_1["found_dist"] = 96;
    var_1["found_dog_dist"] = 60;
    maps\_stealth_utility::stealth_corpse_ranges_custom( var_1 );
}

training_reset_stealth_settings()
{
    maps\_stealth_utility::stealth_corpse_ranges_default();
}

training_s2_squad_allow_run()
{
    if ( isalive( level.gideon ) )
        level.gideon allowedstances( "prone", "crouch", "stand" );

    if ( isalive( level.joker ) )
        level.joker allowedstances( "prone", "crouch", "stand" );

    if ( isalive( level.ally_s2_squad_member_1 ) )
        level.ally_s2_squad_member_1 allowedstances( "prone", "crouch", "stand" );
}

training_s2_enemies_start_think( var_0, var_1, var_2 )
{
    self endon( "death" );
    thread attach_flashlight_on_gun();
    thread maps\_utility::set_battlechatter( 0 );
    maps\_utility::disable_long_death();
    thread training_s2_enemies_start_think_alerted( var_0 );
    thread training_s2_starting_enemy_charge( var_1 );
    common_scripts\utility::flag_wait( var_2 );
    bloody_death();
}

training_s2_enemies_start_think_alerted( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( var_0 );
    maps\_utility::waittill_aigroupcount( "training_s2_starting_enemies", 17 );
    self notify( "alerted" );
    maps\_utility::set_battlechatter( 1 );
    var_1 = getnode( "training_s2_enemy_attack_node4", "targetname" );

    if ( isdefined( var_1 ) )
    {
        self.goalradius = 200;
        maps\_utility::set_forcegoal();
        maps\_utility::set_goal_node( var_1 );
        self waittill( "goal" );
        maps\_utility::unset_forcegoal();
    }
}

training_s2_enemies_start2_think( var_0, var_1, var_2 )
{
    self endon( "death" );
    thread attach_flashlight_on_gun();
    thread maps\_utility::set_battlechatter( 0 );
    maps\_utility::disable_long_death();
    thread training_s2_enemies_start2_think_alerted( var_0 );
    thread training_s2_starting_enemy_charge( var_1 );
    common_scripts\utility::flag_wait( var_2 );
    bloody_death();
}

training_s2_enemies_start2_think_alerted( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( var_0 );
    maps\_utility::waittill_aigroupcount( "training_s2_starting_enemies", 11 );
    self notify( "alerted" );
    var_1 = getnode( "training_s2_enemy_attack_node8", "targetname" );
    thread maps\_utility::set_battlechatter( 1 );

    if ( isdefined( var_1 ) )
    {
        self.goalradius = 32;
        maps\_utility::set_forcegoal();
        maps\_utility::set_goal_node( var_1 );
        self waittill( "goal" );
        maps\_utility::unset_forcegoal();
    }
}

training_s2_enemies_patrol_think( var_0, var_1, var_2 )
{
    self endon( "death" );
    thread attach_flashlight_on_gun();
    thread maps\_utility::set_battlechatter( 0 );
    maps\_utility::disable_long_death();
    thread training_s2_enemy_notify( var_0 );
    thread training_s2_enemies_patrol_think_alerted( var_0 );
    thread training_s2_starting_enemy_charge( var_1 );
    common_scripts\utility::flag_wait( var_2 );
    bloody_death();
}

training_s2_starting_enemy_charge( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( var_0 );
    maps\_utility::player_seek();
}

training_s2_enemy_notify( var_0 )
{
    self endon( "death" );
    common_scripts\utility::waittill_any_ents( self, "patrol_alerted", self, "_stealth_spotted", self, "stealth_event", self, "_stealth_found_corpse", self, "alerted", self, "enemy" );
    wait 2;
    self notify( "alerted" );
    common_scripts\utility::flag_set( "_stealth_spotted" );
    common_scripts\utility::flag_set( var_0 );
}

training_s2_enemies_patrol_think_alerted( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( var_0 );
    self.ignoreall = 0;
    self.ignoreme = 0;
    thread maps\_stealth_shared_utilities::enemy_reaction_state_alert();
    self notify( "alerted" );
    maps\_utility::set_battlechatter( 1 );
}

training_s2_enemies_living_room_think( var_0 )
{
    self endon( "death" );

    if ( isdefined( self.animation ) )
        thread maps\_utility::anim_stopanimscripted();

    var_1 = getent( "training_s1_threat_react_origin", "targetname" );
    var_2 = var_1.origin;
    thread maps\_stealth_shared_utilities::enemy_reactto_and_lookaround( var_2 );
    self notify( "alert" );
    thread maps\_stealth_shared_utilities::enemy_reaction_state_alert();
    thread maps\_stealth_utility::disable_stealth_for_ai();
    thread maps\_utility::set_battlechatter( 1 );
    wait(randomfloatrange( 0.25, 1 ));
    var_3 = self findbestcovernode();

    if ( isdefined( var_3 ) )
        maps\_utility::set_goal_node( var_3 );
}

training_s2_threat_death_check()
{
    self waittill( "death" );

    if ( common_scripts\utility::flag( "training_s2_flag_thermal" ) == 0 )
    {
        level.threat_attack = "nil";
        common_scripts\utility::flag_set( "training_s2_flag_thermal" );
    }
}

training_s2_living_room_check()
{
    maps\_utility::waittill_aigroupcleared( "training_s2_enemies_living_room" );
    level.living_room_clear = 1;
}

training_s2_living_room_timer()
{
    wait 15;
    level.living_room_clear = 1;
}

training_s2_enemies_hall_think()
{
    self endon( "death" );
    maps\_utility::disable_long_death();
}

training_s2_threat_door()
{
    var_0 = common_scripts\utility::getstruct( "training_s1_flashbang_animnode", "targetname" );
    var_1 = getent( "training_s1_flash_door", "targetname" );
    var_1.animname = "door_prop";
    var_1 maps\_utility::assign_animtree();
    var_2 = getent( "living_room_door_clip", "targetname" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "training_s2_threat_door_open" );
    var_2 linkto( var_1, "door" );
    common_scripts\utility::flag_wait( "training_s2_peak_thermal_door" );
    var_0 maps\_anim::anim_single_solo( var_1, "training_s2_threat_door_open" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "training_s2_threat_door_open_idle", "stop_loop" );
    common_scripts\utility::flag_wait( "training_s2_open_thermal_door" );
    var_0 notify( "stop_loop" );
    var_0 maps\_anim::anim_single_solo( var_1, "training_s2_threat_door_out" );
    var_2 connectpaths();
    common_scripts\utility::flag_wait( "training_s2_breach_done" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "training_s2_threat_door_open" );
    wait 1;
    var_2 disconnectpaths();
}

training_s2_flash_monitor()
{
    level.threat_attack = "nil";
    level.player waittill( "grenade_fire", var_0, var_1 );
    var_0 waittill( "death" );

    if ( var_1 == "paint_grenade_var" )
        level.threat_attack = "threat";
    else
        level.threat_attack = "other";

    common_scripts\utility::flag_set( "training_s2_flag_thermal" );
}

training_s2_kill_threat_enemies()
{
    self endon( "death" );
    wait 5;

    if ( isalive( self ) )
    {
        magicbullet( level.gideon.weapon, level.gideon gettagorigin( "tag_flash" ), self geteye() );
        bloody_death();
    }
}

training_s2_start_squad_attack( var_0 )
{
    common_scripts\utility::flag_wait( var_0 );
    training_s2_set_squad_active_and_target();
}

training_s2_opening_guy_think( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );
    self forceteleport( var_1.origin, var_1.angles );
    self setgoalpos( self.origin );
    self allowedstances( "crouch" );
    maps\_stealth_utility::stealth_plugin_basic();
    maps\_stealth_utility::stealth_plugin_accuracy();
    maps\_stealth_utility::stealth_plugin_smart_stance();
    maps\_utility::disable_surprise();

    if ( !isdefined( level.allies_s2 ) )
        level.allies_s2 = [];

    level.allies_s2 = common_scripts\utility::array_add( level.allies_s2, self );
}

training_s1_clear_bedrooms( var_0 )
{
    wait 2;
    var_1 = getent( "bedroom_1_door", "targetname" );
    getent( var_1.target, "targetname" ) linkto( var_1 );
    var_2 = 1;
    var_1 rotateto( var_1.angles + ( 0, 145, 0 ), var_2, 0.05, 0.05 );
    var_1 common_scripts\utility::delaycall( var_2, ::connectpaths );
    var_1 common_scripts\utility::delaycall( 2, ::disconnectpaths );
    var_3 = getent( "bedroom_2_door", "targetname" );
    getent( var_3.target, "targetname" ) linkto( var_3 );
    var_3.angles += ( 0, 85, 0 );
    var_3 connectpaths();
    var_3 disconnectpaths();
    maps\_utility::array_spawn_noteworthy( "training_s1_bedroom_spawners", 1 );
    common_scripts\utility::flag_wait( var_0 );
    var_1 rotateto( var_1.angles + ( 0, -145, 0 ), var_2, 0.05, 0.05 );
    var_1 common_scripts\utility::delaycall( var_2, ::connectpaths );
    var_1 common_scripts\utility::delaycall( 2, ::disconnectpaths );
    var_3.angles += ( 0, -85, 0 );
    var_3 connectpaths();
    var_3 disconnectpaths();
}

training_s1_bedroom_spawners_think()
{
    maps\_utility::set_battlechatter( 0 );
    bloody_death();
}

training_s2_drone_manager()
{
    common_scripts\utility::flag_set( "training_s2_drone_start" );
    level notify( "training_s2_drone_start" );
    level.player setweaponhudiconoverride( "actionslot3", "dpad_icon_drone_off" );
    common_scripts\utility::flag_set( "flag_disable_exo" );
    training_s2_player_drone_control();
    common_scripts\utility::flag_clear( "flag_disable_exo" );
    common_scripts\utility::flag_clear( "flag_player_using_drone" );
    common_scripts\utility::flag_set( "training_s2_drone_attack_done" );
}

training_s2_player_drone_control()
{
    var_0 = getent( "training_s2_pdrone", "targetname" );
    var_1 = common_scripts\utility::getstruct( "pdrone_player_spawnstruct_1", "targetname" );
    var_2 = common_scripts\utility::getstruct( "pdrone_player_nothreat_return", "targetname" );
    var_3 = getnode( "pdrone_player_spawnnode_1", "targetname" );
    var_4 = vehicle_scripts\_pdrone_player::pdrone_deploy( var_0, 0, var_1 );
    vehicle_scripts\_pdrone_player::pdrone_player_use( var_4, "training_drone_space", undefined, undefined );
    var_4 vehicle_scripts\_pdrone_player::pdrone_player_add_vehicle_target( "script_noteworthy", "training_s2_patio_vehicles" );
    level.player.drone = var_4;
    var_4 vehicle_scripts\_pdrone_player::pdrone_player_enter( 1, var_3, var_2 );
    soundscripts\_snd::snd_message( "rec_player_drone_start", var_4 );
    var_4 vehicle_scripts\_pdrone_player::pdrone_player_loop();
    soundscripts\_snd::snd_message( "rec_player_drone_end" );

    if ( var_4.customhealth <= 0 )
        common_scripts\utility::flag_set( "flag_vo_training_s2_gideon_drone_down" );

    var_4 vehicle_scripts\_pdrone_player::pdrone_player_exit( 1 );
    var_4 delete();
}

training_s2_enemies_patio_think( var_0, var_1, var_2 )
{
    self endon( "death" );
    thread maps\_stealth_utility::enable_stealth_for_ai();
    maps\_utility::disable_long_death();
    self thermaldrawenable();
    thread attach_flashlight_on_gun();
    thread maps\_stealth_utility::disable_stealth_system();
    self notify( "awareness_alert_level", "warning" );
    thread maps\_utility::set_battlechatter( 1 );
    common_scripts\utility::flag_wait( var_2 );
    thread maps\_utility::player_seek_enable();
    common_scripts\utility::flag_wait( var_0 );
    bloody_death();
}

training_s2_patio_enemies_alert_think()
{
    self endon( "death" );
    common_scripts\utility::waittill_any_ents( self, "patrol_alerted", self, "_stealth_spotted", self, "stealth_event", self, "_stealth_found_corpse", self, "alerted", self, "enemy" );
    self notify( "alerted" );
    common_scripts\utility::flag_set( "training_s2_patio_alert" );
}

training_s2_patio_enemies_damaged( var_0 )
{
    self endon( "death" );
    self waittill( "damage" );
    maps\_stealth_utility::disable_stealth_system();
    common_scripts\utility::flag_set( var_0 );
}

training_s2_shield_tutorial()
{
    if ( level.player maps\_player_exo::exo_shield_is_on() == 0 )
    {
        if ( level.player.exobatterylevel == 0 )
            maps\recovery_code::give_overdrive_battery();

        common_scripts\utility::flag_set( "flag_vo_training_s2_gideon_use_your_shield" );
        thread maps\_utility::display_hint_timeout( "shield_prompt_sim", 3 );
    }
}

training_s1_drone_attack_think()
{
    self endon( "death" );
    thread maps\_shg_utility::make_emp_vulnerable();
    self laseron();

    if ( isdefined( self.animation ) )
    {
        self.animname = "drone";
        var_0 = getent( "training_s1_drone_attack_scene", "targetname" );
        var_0 maps\_anim::anim_first_frame_solo( self, self.animation );
        var_0 thread maps\_anim::anim_single_solo( self, self.animation );
    }
}

training_s2_drone_ambush_attack_think()
{
    self endon( "death" );
    thread maps\_shg_utility::make_emp_vulnerable();
    self laseron();
    common_scripts\utility::flag_wait( "training_s2_living_room_drone_attack_done" );
    wait(randomfloatrange( 0.5, 1.5 ));
    self notify( "death" );
}

training_s2_drone_attack_think( var_0, var_1 )
{
    self endon( "death" );
    self.pacifist = 1;
    thread maps\_shg_utility::make_emp_vulnerable();
    self laseron();
    thread training_s2_drone_damaged( var_1 );
    thread training_s2_drone_attack_death( var_1 );
    common_scripts\utility::flag_wait( var_1 );
    self notify( "awareness_alert_level", "warning" );
    self.pacifist = 0;
    self.ignoreall = 0;
    self.engage_enemy = 1;
    common_scripts\utility::flag_wait( var_0 );
    self delete();
}

training_s2_drone_damaged( var_0 )
{
    self endon( "death" );
    self waittill( "damage" );
    maps\_stealth_utility::disable_stealth_system();
    common_scripts\utility::flag_set( var_0 );
}

training_s2_drone_attack_death( var_0 )
{
    self waittill( "death" );
    level.drones_s2_dead += 1;
    maps\_stealth_utility::disable_stealth_system();
    common_scripts\utility::flag_set( var_0 );
}

set_tv_screen_broken()
{
    var_0 = getentarray( "tv_screen_broken", "targetname" );
    var_1 = getentarray( "tv_screen_unbroken", "targetname" );

    foreach ( var_3 in var_0 )
        var_3 common_scripts\utility::show_solid();

    foreach ( var_3 in var_1 )
        var_3 common_scripts\utility::hide_notsolid();
}

set_tv_screen_unbroken()
{
    var_0 = getentarray( "tv_screen_broken", "targetname" );
    var_1 = getentarray( "tv_screen_unbroken", "targetname" );

    foreach ( var_3 in var_0 )
        var_3 common_scripts\utility::hide_notsolid();

    foreach ( var_3 in var_1 )
        var_3 common_scripts\utility::show_solid();
}

training_s1_breack_tv_screen()
{
    set_tv_screen_unbroken();
    common_scripts\utility::flag_wait( "training_s1_flag_screen_smash" );
    set_tv_screen_broken();
}

training_s1_breach_enemy_think()
{
    self endon( "death" );
    var_0 = common_scripts\utility::getstruct( "training_s1_exo_breach_marker", "targetname" );
    self.animname = "generic";
    self.ignoreme = 1;
    maps\_utility::disable_long_death();
    self.ignoresonicaoe = 1;

    if ( self.animation == "training_s1_exo_breach_kva2_start" )
    {
        thread training_s1_breach_enemy_death_check();
        self endon( "killed" );
        var_0 maps\_anim::anim_first_frame_solo( self, self.animation );
        thread training_s1_breach_enemy_stop_death_check();
        var_0 maps\_anim::anim_single_solo( self, self.animation );
        self.noragdoll = 1;
        self.a.nodeath = 1;
        self.allowdeath = 1;
        maps\_utility::set_battlechatter( 0 );
        self kill();
    }
    else
    {
        if ( self.animation == "training_s1_exo_breach_kva3_start" )
            self disableaimassist();

        self.allowdeath = 0;
        var_0 maps\_anim::anim_first_frame_solo( self, self.animation );
        var_0 maps\_anim::anim_single_solo( self, self.animation );
        self.noragdoll = 1;
        self.allowdeath = 1;
        self.a.nodeath = 1;
        maps\_utility::set_battlechatter( 0 );
        self kill();
    }
}

training_s1_breach_enemy_stop_death_check()
{
    self endon( "death" );
    self endon( "killed" );
    wait 7;
    self notify( "killed2" );
}

training_s1_breach_enemy_death_check()
{
    self endon( "death" );
    self endon( "killed2" );
    var_0 = 0;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;

    for ( var_4 = undefined; var_0 < 5; var_0 += var_5 )
        self waittill( "damage", var_5, var_4, var_6, var_1, var_2, var_7, var_8, var_3, var_9, var_10 );

    if ( isdefined( var_1 ) && isdefined( var_2 ) && isplayer( var_4 ) )
    {
        if ( var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_EXPLOSIVE_BULLET" )
        {
            playfx( common_scripts\utility::getfx( "flesh_hit" ), var_1 );
            soundscripts\_snd::snd_message( "rec_chair_kva_gets_shot", var_1 );
        }

        self notify( "killed" );
        self stopanimscripted();
        var_11 = common_scripts\utility::getstruct( "training_s1_exo_breach_marker", "targetname" );
        var_11 maps\_anim::anim_single_solo( self, "training_s1_exo_breach_kva2_death" );
        self.noragdoll = 1;
        self.allowdeath = 1;
        self.a.nodeath = 1;
        maps\_utility::set_battlechatter( 0 );
        self kill();
    }
}

training_s1_breach_enemy_monitor_death()
{
    var_0 = 0;
    var_1 = undefined;
    var_2 = undefined;

    for ( var_3 = undefined; var_0 < 5; var_0 += var_4 )
        self waittill( "damage", var_4, var_5, var_6, var_1, var_2, var_7, var_8, var_3, var_9, var_10 );

    if ( isdefined( var_1 ) && isdefined( var_2 ) )
    {
        if ( var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_EXPLOSIVE_BULLET" )
        {
            playfx( common_scripts\utility::getfx( "flesh_hit" ), var_1 );
            soundscripts\_snd::snd_message( "rec_kva_with_president_gets_shot", var_1 );
        }
    }

    thread training_s1_breach_slomo_end();

    if ( common_scripts\utility::flag( "training_s1_flag_president_dead" ) == 0 )
    {
        common_scripts\utility::flag_set( "training_s1_breach_enemy_dead" );
        var_11 = common_scripts\utility::getstruct( "training_s1_exo_breach_marker", "targetname" );
        var_11 thread maps\_anim::anim_single_solo( self, "training_s1_exo_breach_kva1_success" );
        waitframe();
        self.noragdoll = 1;
        self.allowdeath = 1;
        self.a.nodeath = 1;
        maps\_utility::set_battlechatter( 0 );
        self kill();
    }
    else
    {
        self.allowdeath = 1;
        maps\_utility::set_battlechatter( 0 );
        self kill();
    }

    if ( var_3 == "j_head" )
    {
        waittillframeend;
        level.player.hud_damagefeedback fadeovertime( 0.05 );
        level.player.hud_damagefeedback.alpha = 0;
        level.player maps\_damagefeedback::updatedamagefeedback( self, 1 );
        level.player maps\_upgrade_challenge::give_player_challenge_headshot( 1 );
    }
    else
        level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );

    wait 1;
    level.player.hud_damagefeedback fadeovertime( 1 );
}

training_s1_breach_slomo_end()
{
    var_0 = 0.65;
    maps\_utility::slowmo_setlerptime_out( var_0 );
    maps\_utility::slowmo_lerp_out();
    maps\_utility::slowmo_end();
    level.player setmovespeedscale( 1.0 );
}

training_s1_breach_kva_think()
{
    self endon( "shot" );
    self endon( "death" );
    self.ignoresonicaoe = 1;
    self.animname = "generic";
    self.ignoreme = 1;
    self.allowdeath = 0;
    maps\_utility::disable_long_death();
    maps\_utility::forceuseweapon( "iw5_titan45_sp", "primary" );
    thread maps\_utility::set_battlechatter( 0 );
    var_0 = common_scripts\utility::getstruct( "training_s1_exo_breach_marker", "targetname" );
    thread training_s1_breach_enemy_monitor_death();
    var_0 maps\_anim::anim_first_frame_solo( self, "training_s1_exo_breach_kva1_start" );
    var_0 maps\_anim::anim_single_solo( self, "training_s1_exo_breach_kva1_start" );
    var_0 thread maps\_anim::anim_loop_solo( self, "training_s1_exo_breach_kva1_idle", "stop_loop" );
    wait 1.5;
    var_0 notify( "stop_loop" );
    level.president notify( "stop_idle_loop_s1" );

    if ( common_scripts\utility::flag( "training_s1_breach_enemy_dead" ) == 0 )
        var_0 maps\_anim::anim_single_solo( self, "training_s1_exo_breach_kva1_fail" );
}

training_s1_president_breach_setup( var_0 )
{
    self endon( "death" );
    self.allowdeath = 0;
    self.animname = "president";
    self.name = "POTUS";
    self.pacifist = 1;
    self.ignoreme = 1;
    self.ignoreall = 1;
    thread maps\_utility::set_battlechatter( 0 );
    thread training_s1_president_breach_monitor_death();
    self.team = "allies";
    level maps\_utility::clear_color_order( "y", "allies" );
    maps\_utility::set_force_color( "y" );
    common_scripts\utility::flag_wait( var_0 );

    if ( isdefined( self.magic_bullet_shield ) )
        maps\_utility::stop_magic_bullet_shield();

    self delete();
}

training_s1_president_dead()
{
    common_scripts\utility::flag_wait( "training_s1_flag_president_shot" );
    playfxontag( common_scripts\utility::getfx( "recovery_blood_impact_burst" ), level.president, "j_head" );
    common_scripts\utility::flag_set( "training_s1_flag_president_dead" );
    level.president notify( "shot" );
    soundscripts\_snd::snd_message( "rec_s1_president_killed" );
    wait 2;
    setdvar( "ui_deadquote", &"RECOVERY_PRESIDENT_DEAD" );
    maps\_utility::missionfailedwrapper();
}

training_s1_president_breach_monitor_death()
{
    self endon( "breach_s1_end" );
    var_0 = 0;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;

    for ( var_4 = undefined; var_0 < 5; var_0 += var_5 )
        self waittill( "damage", var_5, var_4, var_6, var_1, var_2, var_7, var_8, var_3, var_9, var_10 );

    if ( isdefined( var_1 ) && isdefined( var_2 ) && isplayer( var_4 ) )
    {
        if ( var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_EXPLOSIVE_BULLET" )
        {
            playfx( common_scripts\utility::getfx( "flesh_hit" ), var_1 );
            soundscripts\_snd::snd_message( "rec_plr_kills_president", var_1 );
        }
    }

    common_scripts\utility::flag_set( "training_s1_flag_president_dead" );
    self.allowdeath = 1;
    self kill();

    if ( isplayer( var_4 ) )
        setdvar( "ui_deadquote", &"RECOVERY_PRESIDENT_MURDERED" );
    else
        setdvar( "ui_deadquote", &"RECOVERY_PRESIDENT_DEAD" );

    maps\_utility::missionfailedwrapper();
}

training_s1_bathroom_enemy_think()
{
    self endon( "death" );
    self.ignoresonicaoe = 1;
    self.animname = "kva";
    self.ignoreme = 1;
    self.allowdeath = 1;
    self.health = 1;
    maps\_utility::disable_long_death();
    thread training_s1_bathroom_enemy_flag_death();
    thread training_s1_bathroom_force_death();
    thread maps\_utility::set_battlechatter( 0 );
    var_0 = common_scripts\utility::getstruct( "training_s1_exo_breach_marker", "targetname" );
    thread training_s1_bathroom_enemy_dialog();
    var_0 maps\_anim::anim_first_frame_solo( self, "training_s1_exo_breach_kva_bathroom_start" );
    var_0 maps\_anim::anim_single_solo( self, "training_s1_exo_breach_kva_bathroom_start" );
    self.allowdeath = 0;
    self.health = 100;
    var_0 thread maps\_anim::anim_loop_solo( self, "training_s1_exo_breach_kva_bathroom_idle", "stop_loop" );
    self.ignoreme = 0;
    level.joker.ignoreall = 0;
    thread training_s1_bathroom_enemy_monitor_death();
    self waittill( "shot" );
    var_0 notify( "stop_loop" );
    var_0 maps\_anim::anim_single_solo( self, "training_s1_exo_breach_kva_bathroom_death" );
    self.noragdoll = 1;
    self.allowdeath = 1;
    self.a.nodeath = 1;
    wait 0.05;
    self kill();
}

training_s1_bathroom_enemy_dialog()
{
    self endon( "death" );
    wait 3.5;
    common_scripts\utility::flag_set( "flag_vo_training_s1_kva_what" );
}

training_s1_bathroom_enemy_monitor_death()
{
    self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

    if ( isdefined( var_3 ) && isdefined( var_4 ) )
    {
        if ( var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET" )
            playfx( common_scripts\utility::getfx( "flesh_hit" ), var_3 );
    }

    self notify( "shot" );
}

training_s1_bathroom_enemy_flag_death()
{
    self waittill( "death" );
    common_scripts\utility::flag_set( "training_s1_bathroom_enemy_dead" );
}

training_s1_bathroom_force_death()
{
    common_scripts\utility::flag_wait( "training_s1_flag_bathroom_guy_shot" );
    self kill();
}

training_s1_exo_breach_monitor_enemy_group_death()
{
    maps\_utility::waittill_aigroupcleared( "training_s1_enemies_breach" );
    common_scripts\utility::flag_set( "training_s1_exo_breach_clear" );
}

training_s1_enemies_ambush_think( var_0 )
{
    self endon( "death" );
    thread maps\_utility::disable_long_death();
    attach_flashlight_on_gun();
    common_scripts\utility::flag_wait( var_0 );
    bloody_death();
}

training_s2_enemies_ambush_think( var_0 )
{
    self endon( "death" );
    thread maps\_utility::disable_long_death();
    attach_flashlight_on_gun();
    common_scripts\utility::flag_wait( var_0 );
    bloody_death();
}

training_s1_joker_move()
{
    level endon( "training_s1_living_room_scene" );
    var_0 = common_scripts\utility::getstruct( "training_s1_flashbang_animnode", "targetname" );
    common_scripts\utility::flag_wait( "training_s1_start_alerted" );
    maps\_utility::waittill_aigroupcleared( "training_s1_start" );
    maps\_utility::waittill_aigroupcleared( "training_s1_enemies_start" );
    var_0 maps\_anim::anim_reach_solo( level.joker, "training_s1_threat_guy_in" );
    var_0 maps\_anim::anim_single_solo( level.joker, "training_s1_threat_guy_in" );
}

training_s1_patio_door_breach()
{
    var_0 = common_scripts\utility::getstruct( "training_s2_patio_door_animnode", "targetname" );
    common_scripts\utility::flag_set( "training_s1_patio_doors_joker_in" );
    var_0 maps\_anim::anim_reach_solo( level.joker, "training_s1_patio_joker_door_in" );
    var_0 maps\_anim::anim_single_solo( level.joker, "training_s1_patio_joker_door_in" );
    var_0 thread maps\_anim::anim_loop_solo( level.joker, "training_s1_patio_joker_door_idle", "stop_loop1" );
    thread training_s1_patio_door_breach_monitor( var_0 );
    common_scripts\utility::flag_wait( "training_s1_joker_search_drones_cover" );
    level.joker maps\_utility::cqb_walk( "on" );

    if ( common_scripts\utility::flag( "training_s1_search_drones_attack" ) == 1 )
    {
        var_0 notify( "stop_loop2" );
        var_0 thread maps\_anim::anim_single_solo_run( level.joker, "training_s1_patio_joker_door_out" );
        common_scripts\utility::flag_set( "training_s1_breach_patio_doors_open" );
    }
    else
    {
        var_0 notify( "stop_loop1" );
        var_0 maps\_anim::anim_single_solo( level.joker, "training_s1_patio_joker_door_slow_in" );
        common_scripts\utility::flag_set( "training_s1_slow_patio_doors_open" );
        var_0 maps\_anim::anim_single_solo( level.joker, "training_s1_patio_joker_door_slow_open" );
        var_0 thread maps\_anim::anim_single_solo_run( level.joker, "training_s1_patio_joker_door_slow_out" );
    }

    level notify( "advance_to_patio" );
}

training_s1_patio_door_breach_monitor( var_0 )
{
    self endon( "training_s1_search_drones_done" );
    common_scripts\utility::flag_wait( "training_s1_search_drones_attack" );
    var_0 notify( "stop_loop1" );
    var_0 thread maps\_anim::anim_loop_solo( level.joker, "training_s1_patio_joker_door_alert_idle", "stop_loop2" );
}

training_s1_patio_door_clip()
{
    var_0 = getent( "french_door_clip_01", "targetname" );
    var_1 = getent( "french_door_clip_02", "targetname" );
    var_2 = getent( "training_patio_french_doors", "targetname" );
    var_0 linkto( var_2, "door_r" );
    var_1 linkto( var_2, "door_l" );
    var_0 connectpaths();
    var_1 connectpaths();
    common_scripts\utility::flag_wait( "training_s1_end" );
    wait 1;
    var_0 disconnectpaths();
    var_1 disconnectpaths();
}

training_s2_breach_enemy_think()
{
    self endon( "death" );
    self.ignoresonicaoe = 1;
    self.animname = "generic";
    self.ignoreme = 1;
    self.allowdeath = 1;
    self.health = 5;
    maps\_utility::disable_long_death();
    thread maps\_utility::set_battlechatter( 0 );

    if ( isdefined( self.animation ) )
    {
        var_0 = common_scripts\utility::getstruct( "training_s1_exo_breach_marker", "targetname" );
        var_0 maps\_anim::anim_first_frame_solo( self, self.animation );
        var_0 maps\_anim::anim_single_solo( self, self.animation );
    }
}

training_s2_breach_enemy_stop_death_check()
{
    self endon( "death" );
    self endon( "killed" );
    wait 7;
    self notify( "killed2" );
}

training_s2_breach_enemy_death_check()
{
    self endon( "death" );
    self endon( "killed2" );
    self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

    if ( isdefined( var_3 ) && isdefined( var_4 ) && isplayer( var_1 ) )
    {
        if ( var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET" )
        {
            playfx( common_scripts\utility::getfx( "flesh_hit" ), var_3 );
            soundscripts\_snd::snd_message( "rec_slomo_kill_bad_guy", var_3 );
        }

        self notify( "killed" );
        self stopanimscripted();
        var_5 = common_scripts\utility::getstruct( "training_s1_exo_breach_marker", "targetname" );
        var_5 maps\_anim::anim_single_solo( self, "training_s2_exo_breach_kva2_death" );
        self.noragdoll = 1;
        self.allowdeath = 1;
        self.a.nodeath = 1;
        thread maps\_utility::set_battlechatter( 0 );
        self kill();
    }
}

training_s2_breach_kva_think()
{
    self endon( "shot" );
    self endon( "death" );
    self.ignoresonicaoe = 1;
    self.animname = "generic";
    self.ignoreme = 1;
    self.allowdeath = 0;
    maps\_utility::disable_long_death();
    maps\_utility::forceuseweapon( "iw5_titan45_sp", "primary" );
    thread maps\_utility::set_battlechatter( 0 );
    var_0 = common_scripts\utility::getstruct( "training_s1_exo_breach_marker", "targetname" );
    thread training_s2_breach_enemy_monitor_death();
    var_0 maps\_anim::anim_first_frame_solo( self, "training_s2_exo_breach_kva1_react" );
    var_0 maps\_anim::anim_single_solo( self, "training_s2_exo_breach_kva1_react" );
    var_0 thread maps\_anim::anim_loop_solo( self, "training_s2_exo_breach_kva1_react_idle", "stop_loop" );
    wait 3;
    var_0 notify( "stop_loop" );
    level.president notify( "stop_idle_loop_s2" );

    if ( common_scripts\utility::flag( "training_s2_breach_enemy_dead" ) == 0 )
        var_0 maps\_anim::anim_single_solo( self, "training_s2_exo_breach_kva1_fail" );
}

training_s1_bathroom_breach_door()
{
    var_0 = common_scripts\utility::getstruct( "training_s1_exo_breach_marker", "targetname" );
    var_1 = getent( "training_exo_breach_bathroom_door", "targetname" );
    var_1.animname = "door_prop";
    var_1 maps\_utility::assign_animtree();
    var_2 = getent( "breach_bathroom_door_clip", "targetname" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "training_s1_bathroom_door" );
    soundscripts\_snd::snd_message( "rec_bathroom_guy", var_1 );
    var_2 linkto( var_1, "door" );
    var_0 maps\_anim::anim_single_solo( var_1, "training_s1_bathroom_door" );
    var_2 connectpaths();
}

training_s2_breach_enemy_monitor_death()
{
    var_0 = 0;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;

    for ( var_4 = undefined; var_0 < 5; var_0 += var_5 )
        self waittill( "damage", var_5, var_4, var_6, var_1, var_2, var_7, var_8, var_3, var_9, var_10 );

    if ( isdefined( var_1 ) && isdefined( var_2 ) && isplayer( var_4 ) )
    {
        if ( var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_EXPLOSIVE_BULLET" )
        {
            playfx( common_scripts\utility::getfx( "flesh_hit" ), var_1 );
            soundscripts\_snd::snd_message( "rec_slomo_kill_bad_guy", var_1 );
        }
    }

    if ( common_scripts\utility::flag( "training_s2_flag_president_dead" ) == 0 )
    {
        common_scripts\utility::flag_set( "training_s2_breach_enemy_dead" );
        self notify( "shot" );
        var_11 = common_scripts\utility::getstruct( "training_s1_exo_breach_marker", "targetname" );
        var_11 thread maps\_anim::anim_single_solo( self, "training_s2_exo_breach_kva1_success" );
        waitframe();
        self.noragdoll = 1;
        self.allowdeath = 1;
        self.a.nodeath = 1;
        thread maps\_utility::set_battlechatter( 0 );
        self kill();
    }
    else
    {
        common_scripts\utility::flag_set( "training_s2_breach_enemy_dead" );
        self notify( "shot" );
        self.allowdeath = 1;
        thread maps\_utility::set_battlechatter( 0 );
        self kill();
    }

    if ( var_3 == "j_head" )
    {
        waittillframeend;
        level.player.hud_damagefeedback fadeovertime( 0.05 );
        level.player.hud_damagefeedback.alpha = 0;
        level.player maps\_damagefeedback::updatedamagefeedback( self, 1 );
        level.player maps\_upgrade_challenge::give_player_challenge_headshot( 1 );
    }
    else
        level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );

    wait 1;
    level.player.hud_damagefeedback fadeovertime( 1 );
}

training_s2_breach_enemies_monitor()
{
    common_scripts\utility::flag_wait( "training_s2_breach_enemy_dead" );
    maps\_utility::waittill_aigroupcleared( "training_s2_enemies_breach" );
    var_0 = 0.65;
    maps\_utility::slowmo_setlerptime_out( var_0 );
    maps\_utility::slowmo_lerp_out();
    maps\_utility::slowmo_end();
    level.player setmovespeedscale( 1.0 );
    common_scripts\utility::flag_set( "training_s2_breach_enemies_dead" );
}

training_s2_president_setup()
{
    self endon( "death" );
    maps\_utility::magic_bullet_shield();
    self.animname = "president";
    self.name = "POTUS";
    self.pacifist = 1;
    self.ignoreme = 1;
    self.ignoreall = 1;
    thread maps\_utility::set_battlechatter( 0 );
    self.team = "allies";
    level maps\_utility::clear_color_order( "y", "allies" );
    maps\_utility::set_force_color( "y" );
}

training_s2_breach_president_setup()
{
    self endon( "death" );
    self.allowdeath = 0;
    self.animname = "president";
    self.name = "POTUS";
    self.pacifist = 1;
    self.ignoreme = 1;
    self.ignoreall = 1;
    thread maps\_utility::set_battlechatter( 0 );
    thread training_s2_president_breach_monitor_death();
    self.team = "allies";
    level maps\_utility::clear_color_order( "y", "allies" );
    maps\_utility::set_force_color( "y" );
}

training_s2_president_breach_monitor_death()
{
    self endon( "breach_s2_end" );
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;

    for ( var_3 = 0; var_0 < 5; var_0 += var_4 )
        self waittill( "damage", var_4, var_3, var_5, var_1, var_2 );

    if ( isdefined( var_1 ) && isdefined( var_2 ) && isplayer( var_3 ) )
    {
        if ( var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_EXPLOSIVE_BULLET" )
        {
            playfx( common_scripts\utility::getfx( "flesh_hit" ), var_1 );
            soundscripts\_snd::snd_message( "rec_slomo_kill_bad_guy", var_1 );
        }
    }

    common_scripts\utility::flag_set( "training_s2_flag_president_dead" );
    self.allowdeath = 1;
    self kill();

    if ( isplayer( var_3 ) )
        setdvar( "ui_deadquote", &"RECOVERY_PRESIDENT_MURDERED" );
    else
        setdvar( "ui_deadquote", &"RECOVERY_PRESIDENT_DEAD" );

    maps\_utility::missionfailedwrapper();
}

training_s2_president_dead()
{
    common_scripts\utility::flag_wait( "training_s2_flag_president_shot" );
    wait 0.2;
    playfxontag( common_scripts\utility::getfx( "recovery_blood_impact_burst" ), level.president, "j_head" );
    common_scripts\utility::flag_set( "training_s2_flag_president_dead" );
    level.president notify( "shot_s2" );
    wait 2;
    setdvar( "ui_deadquote", &"RECOVERY_PRESIDENT_DEAD" );
    maps\_utility::missionfailedwrapper();
}

training_s2_exo_breach_knife()
{
    var_0 = maps\_utility::spawn_anim_model( "knife_prop" );
    var_0.animname = "knife_prop";
    var_1 = common_scripts\utility::getstruct( "training_s1_exo_breach_marker", "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( var_0, "training_s2_exo_knife" );
    var_1 maps\_anim::anim_single_solo( var_0, "training_s2_exo_knife" );
    var_0 delete();
}

training_s2_open_patio_door()
{
    var_0 = common_scripts\utility::getstruct( "training_s2_patio_door_animnode", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.gideon, "training_s2_patio_gideon_door_in" );
    level.patio_doors notify( "in2" );
    var_0 maps\_anim::anim_single_solo( level.gideon, "training_s2_patio_gideon_door_in" );
    var_0 thread maps\_anim::anim_loop_solo( level.gideon, "training_s2_patio_gideon_door_idle", "stop_loop" );
    common_scripts\utility::flag_wait( "training_s2_living_room_drone_attack_done" );
    var_0 notify( "stop_loop" );

    if ( level.broken_door == 0 )
    {
        common_scripts\utility::flag_set( "training_s2_gideon_smash_french_door" );
        var_0 maps\_anim::anim_reach_solo( level.gideon, "training_s2_patio_gideon_door_out" );
        level.patio_doors notify( "go2" );
        level.gideon maps\_utility::cqb_walk( "on" );
        var_0 thread maps\_anim::anim_single_solo_run( level.gideon, "training_s2_patio_gideon_door_out" );
    }

    maps\_utility::activate_trigger( "training_s2_patio_color_trigger", "targetname" );
}

training_s2_player_drone()
{
    level endon( "training_s2_drone_enemies_killed" );
    level.player.showhint = 1;
    maps\_utility::display_hint_timeout( "drone_deploy_prompt", 10 );

    for (;;)
    {
        level.player waittill( "use_drone" );

        while ( level.player isjumping() )
            waitframe();

        if ( vehicle_scripts\_pdrone_player::pdrone_deploy_check( 85 ) )
            break;
        else
        {
            level.player.showhint = 0;
            wait 0.25;
            level.player.showhint = 1;
            maps\_utility::display_hint_timeout( "drone_deploy_fail_prompt", 2 );
            wait 2.0;
            level.player.showhint = 0;
            wait 0.25;
            level.player.showhint = 1;
            maps\_utility::display_hint_timeout( "drone_deploy_prompt", 10 );
        }
    }

    level.player.showhint = 0;

    if ( common_scripts\utility::flag( "training_s2_drone_attack_done" ) == 0 )
    {
        common_scripts\utility::flag_set( "training_s2_drone_start" );
        level notify( "training_s2_drone_start" );
        maps\_utility::array_spawn_noteworthy( "training_s2_enemies2_patio", 1 );
        common_scripts\utility::flag_set( "training_s2_patio_alert" );
        common_scripts\utility::flag_set( "flag_player_using_drone" );
        thread training_s2_drone_manager();
    }
}

training_s2_player_drone_delete()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "training_s2_drone_start" );
    self delete();
}

training_s2_spawn_search_vehicle()
{
    var_0 = getent( "training_s2_patio_vehicles", "script_noteworthy" );
    var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
    var_1 thread training_s2_drone_attack_vehicles_think();
}

training_s2_drone_attack_vehicles_think()
{
    self endon( "death" );
    playfxontag( common_scripts\utility::getfx( "car_tread_mud" ), self, "tag_wheel_back_right" );
    playfxontag( common_scripts\utility::getfx( "car_tread_mud" ), self, "tag_wheel_back_left" );
    playfxontag( common_scripts\utility::getfx( "car_tread_mud" ), self, "tag_wheel_front_right" );
    playfxontag( common_scripts\utility::getfx( "car_tread_mud" ), self, "tag_wheel_front_left" );

    foreach ( var_1 in self.riders )
        var_1 thread training_s2_unload_drone_attack_think();

    self waittill( "reached_end_node" );
    maps\_vehicle::vehicle_unload( "all_but_gunner" );
}

training_s2_unload_drone_attack_think()
{
    self endon( "death" );

    if ( isdefined( self.vehicle_position ) )
    {
        thread attach_flashlight_on_vehicle_unload();
        thread maps\_utility::set_battlechatter( 0 );
    }

    common_scripts\utility::flag_wait( "training_s2_patio_alert" );
    self notify( "awareness_alert_level", "warning" );
    thread maps\_utility::set_battlechatter( 1 );
    common_scripts\utility::flag_wait( "flag_training_s2_patio_enemies_charge" );
    thread maps\_utility::player_seek_enable();
    common_scripts\utility::flag_wait( "training_s2_clear_patio_spawn" );
    bloody_death( randomfloatrange( 0.5, 1.5 ) );
}

training_s2_patio_enemies_alert_check()
{
    self endon( "death" );
    self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

    if ( var_1 == level.player )
    {
        wait 2;
        common_scripts\utility::flag_set( "training_s2_patio_alert" );
        self notify( "alerted" );
    }
}

training_s2_ambush_vehicles_think( var_0 )
{
    self endon( "death" );

    foreach ( var_2 in self.riders )
        var_2 thread training_s2_unload1_think( var_0 );

    self waittill( "reached_end_node" );
    maps\_vehicle::vehicle_unload();
    common_scripts\utility::flag_wait( var_0 );
    wait(randomfloatrange( 0.5, 4.5 ));
    self kill();
}

training_s2_unload1_think( var_0 )
{
    self endon( "death" );

    if ( isdefined( self.vehicle_position ) )
    {
        thread attach_flashlight_on_vehicle_unload();
        maps\_utility::disable_long_death();
    }

    common_scripts\utility::flag_wait( var_0 );
    wait(randomintrange( 1, 6 ));
    bloody_death();
}

training_s2_kva_ambush1_think( var_0 )
{
    self endon( "death" );
    thread attach_flashlight_on_gun();
    maps\_utility::disable_long_death();
    maps\_utility::ai_ignore_everything();
    maps\_utility::delaythread( 3, maps\_utility::ai_unignore_everything );
    common_scripts\utility::flag_wait( var_0 );
    wait(randomintrange( 1, 6 ));
    bloody_death();
}

training_s2_drone_end_think( var_0 )
{
    self endon( "death" );
    thread maps\_shg_utility::make_emp_vulnerable();
    self laseron();
    common_scripts\utility::flag_wait( var_0 );
    self delete();
}

training_s2_guard_house_doors()
{
    var_0 = getent( "guard_door_01", "targetname" );
    getent( var_0.target, "targetname" ) linkto( var_0 );
    var_1 = getent( "guard_door_02", "targetname" );
    getent( var_1.target, "targetname" ) linkto( var_1 );
    var_0 rotateto( var_0.angles + ( 0, -90, 0 ), 1, 0, 1 );
    var_1 rotateto( var_1.angles + ( 0, 90, 0 ), 1, 0, 1 );
    var_0 connectpaths();
    var_1 connectpaths();
    wait 4;
    var_0 rotateto( var_0.angles + ( 0, 90, 0 ), 1, 0, 1 );
    var_1 rotateto( var_1.angles + ( 0, -90, 0 ), 1, 0, 1 );
    var_0 disconnectpaths();
    var_1 disconnectpaths();
}

training_s1_set_squad_passive_and_ignore()
{
    level.allies_s1 = maps\_utility::array_removedead( level.allies_s1 );
    common_scripts\utility::array_thread( level.allies_s1, maps\_utility::set_ignoreall, 1 );
    common_scripts\utility::array_thread( level.allies_s1, maps\_utility::set_ignoreme, 1 );
    common_scripts\utility::array_thread( level.allies_s1, maps\_utility::set_battlechatter, 0 );
}

training_s1_set_sqaud_cqb_enable()
{
    level.allies_s1 = maps\_utility::array_removedead( level.allies_s1 );
    common_scripts\utility::array_thread( level.allies_s1, maps\_utility::enable_cqbwalk );
}

training_s1_set_squad_active_and_target()
{
    level.allies_s1 = maps\_utility::array_removedead( level.allies_s1 );
    common_scripts\utility::array_thread( level.allies_s1, maps\_utility::set_ignoreall, 0 );
    common_scripts\utility::array_thread( level.allies_s1, maps\_utility::set_ignoreme, 0 );
    common_scripts\utility::array_thread( level.allies_s1, maps\_utility::set_battlechatter, 1 );
}

training_s1_set_sqaud_cqb_disable()
{
    level.allies_s1 = maps\_utility::array_removedead( level.allies_s1 );
    common_scripts\utility::array_thread( level.allies_s1, maps\_utility::disable_cqbwalk );
}

training_s2_set_squad_passive_and_ignore()
{
    level.allies_s2 = maps\_utility::array_removedead( level.allies_s2 );
    common_scripts\utility::array_thread( level.allies_s2, maps\_utility::set_ignoreall, 1 );
    common_scripts\utility::array_thread( level.allies_s2, maps\_utility::set_ignoreme, 1 );
    common_scripts\utility::array_thread( level.allies_s2, maps\_utility::set_battlechatter, 0 );
}

training_s2_set_squad_active_and_target()
{
    level.allies_s2 = maps\_utility::array_removedead( level.allies_s2 );
    common_scripts\utility::array_thread( level.allies_s2, maps\_utility::set_ignoreall, 0 );
    common_scripts\utility::array_thread( level.allies_s2, maps\_utility::set_ignoreme, 0 );
    common_scripts\utility::array_thread( level.allies_s2, maps\_utility::set_battlechatter, 1 );
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

#using_animtree("generic_human");

military_drone_stationary_think( var_0 )
{
    self endon( "death" );

    if ( isdefined( self.script_parameters ) )
        self.script_noteworthy = self.script_parameters;

    if ( isdefined( self.animation ) )
        self.idleanim = self.animation;
    else
        self.idleanim = %patrol_bored_idle;

    self.spawner thread maps\_anim::anim_generic_loop( self, self.idleanim );
    self.name = " ";
    self setlookattext( self.name, &"" );
    common_scripts\utility::flag_wait( var_0 );
    self delete();
}

military_drone_runners_think( var_0 )
{
    self endon( "death" );

    if ( isdefined( self.script_parameters ) )
        self.script_noteworthy = self.script_parameters;

    self.animname = "generic";
    self.name = " ";
    self.runanim = maps\_utility::getanim( self.animation );
    self.idleanim = %patrol_bored_idle;
    common_scripts\utility::flag_wait( var_0 );
    self delete();
}

military_drone_guards_stationary_think( var_0 )
{
    self endon( "death" );

    if ( isdefined( self.script_parameters ) )
        self.script_noteworthy = self.script_parameters;

    if ( isdefined( self.animation ) )
        self.idleanim = self.animation;
    else
        self.idleanim = %patrol_bored_idle;

    thread maps\_anim::anim_generic_loop( self, self.idleanim );
    common_scripts\utility::flag_waitopen( var_0 );
    self delete();
}

military_drone_guards_patrol_think( var_0 )
{
    self pushplayer( 1 );
    self.animname = "generic";
    self.idleanim = %patrol_bored_idle;
    maps\_utility::set_run_anim( "active_patrolwalk_gundown" );
    maps\_utility::ai_ignore_everything();
    maps\_utility::disable_arrivals();
    maps\_utility::disable_exits();
    self.goalradius = 16;
    maps\_utility::set_battlechatter( 0 );
    common_scripts\utility::flag_waitopen( var_0 );
    self delete();
}

grenade_range_enemy_think()
{
    self waittill( "death", var_0 );
    level.grenade_range_container.aikills++;
    level.grenade_range_container notify( "score_change" );

    if ( !isplayer( var_0 ) )
        return;

    if ( common_scripts\utility::flag( "flag_obj_grenade_range_tutorial_complete" ) )
    {

    }

    level notify( "grenade_range_point_scored_100" );
}

grenade_range_drone_think()
{
    self endon( "no_score" );
    grenade_range_drone_death_detect();
    level.grenade_range_container.dronekills++;
    level.grenade_range_container notify( "score_change" );
    var_0 = self.mod;

    if ( var_0 == "EMP" )
    {
        if ( common_scripts\utility::flag( "flag_obj_grenade_range_tutorial_complete" ) )
        {

        }

        level notify( "grenade_range_point_scored_100" );
    }

    if ( var_0 == "grenade" )
    {
        if ( common_scripts\utility::flag( "flag_obj_grenade_range_tutorial_complete" ) )
        {

        }

        level notify( "grenade_range_point_scored_100" );
    }

    if ( var_0 == "bullet" )
    {
        if ( common_scripts\utility::flag( "flag_obj_grenade_range_tutorial_complete" ) )
        {

        }

        level notify( "grenade_range_point_scored_50" );
    }
}

grenade_range_drone_death_detect()
{
    self.mod = "EMP";
    self endon( "emp_death" );
    self waittill( "death", var_0, var_1, var_2 );

    switch ( var_1 )
    {
        case "MOD_RIFLE_BULLET":
        case "MOD_PISTOL_BULLET":
            self.mod = "bullet";
            break;
        case "MOD_EXPLOSIVE":
        case "MOD_GRENADE_SPLASH":
        case "MOD_GRENADE":
            self.mod = "grenade";
            break;
        default:
            break;
    }
}

civilian_drone_repair_think( var_0 )
{
    self endon( "death" );

    if ( isdefined( self.script_parameters ) )
        self.script_noteworthy = self.script_parameters;

    if ( self.weapon != "none" )
        maps\_utility::gun_remove();

    if ( isdefined( self.animation ) )
        self.idleanim = self.animation;
    else
        self.idleanim = %cliffhanger_welder_engine;

    self.eaniment = self.spawner;
    self.eaniment.origin += ( 0, 0, -3 );
    self attach( "machinery_welder_handle", "tag_inhand" );
    thread flashing_welding();
    self.spawner thread maps\_anim::anim_generic_loop( self, "cliffhanger_welder_engine" );
    common_scripts\utility::flag_wait( var_0 );
    self delete();
}

civilian_drone_stationary_think( var_0 )
{
    self endon( "death" );

    if ( isdefined( self.script_parameters ) )
        self.script_noteworthy = self.script_parameters;

    if ( self.weapon != "none" )
        maps\_utility::gun_remove();

    if ( isdefined( self.animation ) )
        self.idleanim = self.animation;
    else
        self.idleanim = %civilian_stand_idle;

    self.spawner thread maps\_anim::anim_generic_loop( self, self.idleanim );
    common_scripts\utility::flag_wait( var_0 );
    self delete();
}

civilian_drone_runners_think( var_0 )
{
    self endon( "death" );

    if ( isdefined( self.script_parameters ) )
        self.script_noteworthy = self.script_parameters;

    self.animname = "generic";
    self.runanim = maps\_utility::getanim( self.animation );

    if ( self.weapon != "none" )
        maps\_utility::gun_remove();

    self.idleanim = %civilian_stand_idle;
    common_scripts\utility::flag_wait( var_0 );
    self delete();
}

flashing_welding()
{
    self endon( "death" );
    thread stop_sparks();
    playfxontag( level._effect["welding_sparks_oneshot_sml"], self, "tag_tip_fx" );
}

stop_sparks()
{
    self endon( "death" );

    for (;;)
    {
        self waittillmatch( "looping anim", "spark off" );
        self notify( "spark off" );
    }
}

setup_deck_deploy_warbird()
{
    waittillframeend;
    self notify( "warbird_fire" );
    var_0 = get_passengers();
    var_0 thread ignore_until_unloaded();
}

get_passengers()
{
    var_0 = self.riders;
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.drivingvehicle ) )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

ignore_until_unloaded()
{
    var_0 = 1;

    foreach ( var_2 in self )
    {
        var_2.ignoreme = 1;
        var_2 thread wait_until_unloaded( var_0 );
        var_0++;
    }
}

wait_until_unloaded( var_0 )
{
    self endon( "death" );
    self waittill( "jumpedout" );
    self.ignoreme = 0;
    goto_node( "zipline_path0" + var_0, 0, 256 );
    self waittill( "goal" );
    wait 5;
    self delete();
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

prep_user_for_drone()
{
    self disableweapons();
    self.ignoreme = 1;
    self enableinvulnerability();
    var_0 = getaiarray( "axis" );

    foreach ( var_2 in var_0 )
        var_2 thermaldrawenable();

    var_4 = getaiarray( "allies" );

    foreach ( var_2 in var_4 )
        var_2 thermaldrawenable();

    waitframe();
    level.player thermalvisionon();
}

make_drone_fully_controllable( var_0 )
{
    var_0 endon( "death" );
    level.player thread monitor_drone_stick_deflection( var_0 );
    waitframe();

    for (;;)
    {
        var_1 = level.player.drone_control["stick_input_move"] * 10;
        var_2 = getdroneperlinovertime( 5, 3, 2, 0.5 );
        var_3 = var_0 setvehgoalpos( var_0.origin + var_1 + var_2 );
        waitframe();
    }
}

getdroneperlinovertime( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 1;

    var_4 = ( perlinnoise2d( gettime() * 0.001 * 0.05, 10, var_0, var_1, var_2 ) * var_3, perlinnoise2d( gettime() * 0.001 * 0.05, 20, var_0, var_1, var_2 ) * var_3, perlinnoise2d( gettime() * 0.001 * 0.05, 30, var_0, var_1, var_2 ) * var_3 );
    return var_4;
}

monitor_drone_stick_deflection( var_0 )
{
    var_0 endon( "death" );

    for (;;)
    {
        var_1 = self getnormalizedmovement();
        var_1 = ( var_1[0], var_1[1] * -1, 0 );
        var_2 = self.angles;
        var_3 = vectortoangles( var_1 );
        var_4 = common_scripts\utility::flat_angle( combineangles( var_2, var_3 ) );
        var_5 = anglestoforward( var_4 ) * length( var_1 );
        self.drone_control["stick_input_move"] = var_5;
        waitframe();
    }
}

unlink_player_from_drone( var_0 )
{
    level.player.dronetag unlink();
    level.player unlink();
    level.player maps\_utility::teleport_player( var_0 );
    waitframe();
    level.player remove_user_from_drone();
    level.player lerpfov( 65, 0 );
}

remove_user_from_drone()
{
    self enableweapons();
    self.ignoreme = 0;
    self disableinvulnerability();
    level.player thermalvisionoff();
}

recovery_breach_setup_player()
{
    level.player enableinvulnerability();
    level.player disableweaponswitch();
    level.player disableoffhandweapons();
    level.player allowcrouch( 0 );
    level.player allowprone( 0 );
    level.player allowsprint( 0 );
    level.player allowjump( 0 );
}

recovery_breach_cleanup_player()
{
    level.player disableinvulnerability();
    level.player enableweaponswitch();
    level.player enableoffhandweapons();
    level.player allowcrouch( 1 );
    level.player allowprone( 1 );
    level.player allowsprint( 1 );
    level.player allowjump( 1 );
}

breach_slow_down( var_0 )
{

}

enable_player_control( var_0 )
{
    level.player unlink();
    level.player_rig delete();
}

spawn_player_rig( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "player_rig";

    if ( !isdefined( var_1 ) )
        var_1 = level.player.origin;

    var_2 = maps\_utility::spawn_anim_model( var_0 );
    return var_2;
}

disable_trigger_while_player_animating( var_0 )
{
    level endon( var_0 );

    for (;;)
    {
        if ( isdefined( self.trigger_off ) )
            common_scripts\utility::trigger_on();

        wait 0.05;
    }
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

leaderboard_precache()
{
    precachemodel( "rec_sb_row" );

    for ( var_0 = 0; var_0 <= 9; var_0++ )
        precachemodel( "rec_sb_" + var_0 );

    for ( var_0 = 1; var_0 <= 9; var_0++ )
        precachemodel( "rec_sb_name_0" + var_0 );

    precachemodel( "rec_sb_name_10" );
    precachemodel( "rec_sb_name_11" );
    precachemodel( "rec_sb_drone_range" );
    precachemodel( "rec_sb_ar_range" );
    precachemodel( "rec_sb_shooting_range" );
}

leaderboard_make( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.isleaderboard = 1;
    var_3.maxentries = var_0;
    var_3.range_name = var_1;

    if ( isdefined( var_2 ) )
        var_3.shouldsortscoresinascendingorder = var_2;
    else
        var_3.shouldsortscoresinascendingorder = 0;

    var_3.playerscores = [];
    var_3 leaderboard_defaults( var_1 );
    var_3.leaderboard_screen = var_3 leaderboard_screen_make();
    var_3 leaderboard_screen_update();
    return var_3;
}

leaderboard_compare_scores( var_0, var_1 )
{
    var_2 = self;
    return var_2.shouldsortscoresinascendingorder && var_1 < var_0 || !var_2.shouldsortscoresinascendingorder && var_1 > var_0;
}

leaderboard_sort_scores()
{
    var_0 = self.playerscores;

    for ( var_1 = 0; var_1 < var_0.size - 1; var_1++ )
    {
        for ( var_2 = var_1 + 1; var_2 < var_0.size; var_2++ )
        {
            if ( leaderboard_compare_scores( var_0[var_1].playerscore, var_0[var_2].playerscore ) || var_0[var_2].playerscore == var_0[var_1].playerscore && var_0[var_2].playername == "player" )
            {
                var_3 = var_0[var_2];
                var_0[var_2] = var_0[var_1];
                var_0[var_1] = var_3;
            }
        }
    }

    self.playerscores = var_0;
}

leaderboard_record( var_0, var_1 )
{
    var_2 = self;

    if ( var_0 == "player" )
    {
        for ( var_3 = 0; var_3 < var_2.playerscores.size; var_3++ )
        {
            var_4 = var_2.playerscores[var_3];

            if ( var_4.playername == var_0 )
            {
                if ( var_2 leaderboard_compare_scores( var_4.playerscore, var_1 ) )
                {
                    var_4.playerscore = var_1;
                    var_2 leaderboard_sort_scores();
                }

                return;
            }
        }
    }

    if ( var_2.playerscores.size == var_2.maxentries && var_2 leaderboard_compare_scores( var_1, var_2.playerscores[var_2.maxentries - 1].playerscore ) )
        return;

    var_4 = spawnstruct();
    var_4.isleaderboardentry = 1;
    var_4.playername = var_0;
    var_4.playerscore = var_1;

    if ( var_2.playerscores.size == var_2.maxentries )
        var_2.playerscores[var_2.maxentries - 1] = var_4;
    else
        var_2.playerscores[var_2.playerscores.size] = var_4;

    var_2 leaderboard_sort_scores();
}

leaderboard_defaults( var_0 )
{
    var_1 = [];
    var_1["drone_range"] = "sb_drone_range";
    var_1["grenade_range"] = "sb_grenade_range";
    var_1["shooting_range"] = "sb_shooting_range";
    var_2 = [];
    var_2["drone_range"] = "rec_sb_drone_range";
    var_2["grenade_range"] = "rec_sb_ar_range";
    var_2["shooting_range"] = "rec_sb_shooting_range";

    if ( var_0 == "shooting_range" )
    {
        leaderboard_record( "name_01", 2375 );
        leaderboard_record( "name_02", 2050 );
        leaderboard_record( "name_03", 1825 );
        leaderboard_record( "name_04", 1650 );
        leaderboard_record( "name_05", 1300 );
        leaderboard_record( "name_06", 1150 );
        leaderboard_record( "name_07", 975 );
        leaderboard_record( "name_08", 775 );
        leaderboard_record( "name_09", 425 );
        leaderboard_record( "name_10", 200 );
        leaderboard_record( "player", 0 );
    }
    else if ( var_0 == "grenade_range" )
    {
        leaderboard_record( "name_01", 1800 );
        leaderboard_record( "name_02", 1550 );
        leaderboard_record( "name_03", 1400 );
        leaderboard_record( "name_04", 1200 );
        leaderboard_record( "name_05", 950 );
        leaderboard_record( "name_06", 750 );
        leaderboard_record( "name_07", 600 );
        leaderboard_record( "name_08", 300 );
        leaderboard_record( "name_09", 250 );
        leaderboard_record( "name_10", 100 );
    }
    else if ( var_0 == "drone_range" )
    {
        leaderboard_record( "name_01", 15 );
        leaderboard_record( "name_02", 21 );
        leaderboard_record( "name_03", 26 );
        leaderboard_record( "name_04", 31 );
        leaderboard_record( "name_05", 34 );
        leaderboard_record( "name_06", 36 );
        leaderboard_record( "name_07", 40 );
        leaderboard_record( "name_08", 49 );
        leaderboard_record( "name_09", 57 );
        leaderboard_record( "name_10", 60 );
    }

    var_3 = [];
    var_3["player"] = "rec_sb_name_01";
    var_3["name_01"] = "rec_sb_name_11";
    var_3["name_02"] = "rec_sb_name_02";
    var_3["name_03"] = "rec_sb_name_03";
    var_3["name_04"] = "rec_sb_name_04";
    var_3["name_05"] = "rec_sb_name_05";
    var_3["name_06"] = "rec_sb_name_06";
    var_3["name_07"] = "rec_sb_name_07";
    var_3["name_08"] = "rec_sb_name_08";
    var_3["name_09"] = "rec_sb_name_09";
    var_3["name_10"] = "rec_sb_name_10";
    var_4 = spawnstruct();
    var_4.titlemap = var_2;
    var_4.namemodelmap = var_3;
    var_4.screennamemap = var_1;
    self.settings = var_4;
}

leaderboard_screen_make()
{
    var_0 = self.range_name;
    var_1 = getent( self.settings.screennamemap[var_0], "targetname" );
    var_1.isleaderboardscreen = 1;
    var_2 = spawn( "script_model", var_1.origin );
    var_2 setmodel( self.settings.titlemap[var_0] );
    var_2 linkto( var_1, "title", ( 0, 0, 0 ), ( 0, 90, 0 ) );
    var_1.rows = [];

    for ( var_3 = 0; var_3 < 10; var_3++ )
    {
        var_4 = spawn( "script_model", var_1.origin );
        var_4.isleaderboardscreenrow = 1;
        var_1.rows[var_3] = var_4;
        var_4 setmodel( "rec_sb_row" );
        var_4 linkto( var_1, "row" + ( var_3 + 1 ), ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var_4.nametagmodel = spawn( "script_model", var_1.origin );
        var_4.nametagmodel linkto( var_4, "name1", ( 0, 0, 0 ), ( 0, 90, 0 ) );
        var_4.digitmodels = [];
        var_4.digitmodels[0] = spawn( "script_model", var_1.origin );
        var_4.digitmodels[0] linkto( var_4, "digit1", ( 0, 0, 0 ), ( 0, 90, 0 ) );
        var_4.digitmodels[1] = spawn( "script_model", var_1.origin );
        var_4.digitmodels[1] linkto( var_4, "digit2", ( 0, 0, 0 ), ( 0, 90, 0 ) );
        var_4.digitmodels[2] = spawn( "script_model", var_1.origin );
        var_4.digitmodels[2] linkto( var_4, "digit3", ( 0, 0, 0 ), ( 0, 90, 0 ) );
        var_4.digitmodels[3] = spawn( "script_model", var_1.origin );
        var_4.digitmodels[3] linkto( var_4, "digit4", ( 0, 0, 0 ), ( 0, 90, 0 ) );
    }

    return var_1;
}

leaderboard_score_to_digits( var_0 )
{
    var_1 = [];
    var_2 = var_0;
    var_3 = var_2 % 10;
    var_2 = int( var_2 / 10 );
    var_1[0] = "rec_sb_" + var_3;
    var_3 = var_2 % 10;
    var_2 = int( var_2 / 10 );
    var_1[1] = "rec_sb_" + var_3;
    var_3 = var_2 % 10;
    var_2 = int( var_2 / 10 );
    var_1[2] = "rec_sb_" + var_3;
    var_3 = var_2 % 10;
    var_2 = int( var_2 / 10 );
    var_1[3] = "rec_sb_" + var_3;
    var_1 = common_scripts\utility::array_reverse( var_1 );
    return var_1;
}

leaderboard_screen_update()
{
    var_0 = self;
    var_1 = self.leaderboard_screen;

    for ( var_2 = 0; var_2 < 10; var_2++ )
    {
        var_3 = var_1.rows[var_2];
        var_4 = var_0.playerscores[var_2];
        var_5 = var_0.settings.namemodelmap[var_4.playername];
        var_3.nametagmodel setmodel( var_5 );
        var_6 = leaderboard_score_to_digits( var_4.playerscore );
        var_3.digitmodels[0] setmodel( var_6[0] );
        var_3.digitmodels[1] setmodel( var_6[1] );
        var_3.digitmodels[2] setmodel( var_6[2] );
        var_3.digitmodels[3] setmodel( var_6[3] );
    }
}

#using_animtree("player");

play_reload_malfunction_on_next_reload( var_0 )
{
    level notify( "play_reload_malfunction_on_next_reload_stop" );
    level endon( "play_reload_malfunction_on_next_reload_stop" );

    if ( !common_scripts\utility::flag_exist( "reload_malfunction" ) )
        common_scripts\utility::flag_init( "reload_malfunction" );

    common_scripts\utility::flag_set( "reload_malfunction" );

    if ( isdefined( var_0 ) )
        level endon( var_0 );

    if ( !isdefined( level.player.numofreloadmalfunctions ) )
        level.player.numofreloadmalfunctions = 0;

    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    childthread reload_malfunction_disable_on_grenade_throw();

    for (;;)
    {
        waitframe();

        if ( !common_scripts\utility::flag( "reload_malfunction" ) )
            common_scripts\utility::flag_wait( "reload_malfunction" );

        var_1 = level.player getcurrentweapon();
        var_2 = weaponclipsize( var_1 );
        var_3 = level.player getweaponammoclip( var_1 );
        var_4 = [];
        var_5 = [];

        if ( issubstr( var_1, "bal27" ) )
        {
            var_4 = [ 1, 2 ];
            var_5 = [ %vm_bal_27_reload_exo_malfunction_1, %vm_bal_27_reload_exo_malfunction_2 ];
        }
        else if ( issubstr( var_1, "titan45" ) )
        {
            var_4 = [ 3, 4 ];
            var_5 = [ %vm_titan45_reload_exo_malfunction_1, %vm_titan45_reload_exo_malfunction_2 ];
        }
        else if ( issubstr( var_1, "ak12" ) )
        {
            var_4 = [ 5, 6 ];
            var_5 = [ %vm_ak12_reload_exo_malfunction_1, %vm_ak12_reload_exo_malfunction_2 ];
        }
        else if ( issubstr( var_1, "vbr" ) )
        {
            var_4 = [ 7, 8 ];
            var_5 = [ %vm_vbr_reload_exo_malfunction_1, %vm_vbr_reload_exo_malfunction_2 ];
        }
        else if ( issubstr( var_1, "kf5" ) )
        {
            var_4 = [ 11, 12 ];
            var_5 = [ %vm_kf5_reload_exo_malfunction_1, %vm_kf5_reload_exo_malfunction_2 ];
        }
        else if ( issubstr( var_1, "rhino" ) )
        {
            var_4 = [ 9, 10 ];
            var_5 = [ %vm_rhino_reload_exo_malfunction_1, %vm_rhino_reload_exo_malfunction_2 ];
        }
        else
            continue;

        if ( var_3 < var_2 && level.player usebuttonpressed() && !level.player isholdinggrenade() && !level.player isreloading() )
            break;

        if ( var_3 < 2 )
            break;
    }

    thread play_reload_malfunction( var_4[level.player.numofreloadmalfunctions], var_5[level.player.numofreloadmalfunctions], var_1, var_2, var_3 );
    level.player.numofreloadmalfunctions = ( level.player.numofreloadmalfunctions + 1 ) % var_4.size;
    level notify( "play_reload_malfunction_on_next_reload_stop" );
}

reload_malfunction_disable_on_grenade_throw()
{
    for (;;)
    {
        level.player common_scripts\utility::waittill_any( "grenade_fire", "grenade_pullback" );
        common_scripts\utility::flag_clear( "reload_malfunction" );
        wait 1.5;
        common_scripts\utility::flag_set( "reload_malfunction" );
    }
}

play_reload_malfunction( var_0, var_1, var_2, var_3, var_4 )
{
    thread play_rumble_training_s1_reload_malfunction();
    common_scripts\utility::flag_set( "flag_vo_training_s1_reload_malfunction" );
    level.player allowmantle( 0 );
    level.player allowads( 0 );
    level.player disableweaponpickup();
    level.player disableweaponswitch();
    level.player enableinvulnerability();
    setsaveddvar( "ammoCounterHide", "1" );
    soundscripts\_snd::snd_message( "camp_david_reload_malfunction", var_0, var_2 );
    level.player setviewmodelanim( var_0 );
    var_5 = level.player setweaponammostock( var_2 );
    level.player setweaponammoclip( var_2, var_3 );
    level.player setweaponammostock( var_2, var_5 - ( var_3 - var_4 ) );
    wait(getanimlength( var_1 ));
    level.player allowads( 1 );
    level.player enableweaponpickup();
    level.player enableweaponswitch();
    level.player allowmantle( 1 );
    level.player disableinvulnerability();
    setsaveddvar( "ammoCounterHide", "0" );
}

lerp_anim_weight_on_actor_over_time( var_0, var_1, var_2, var_3 )
{
    var_4 = int( var_1 / 0.05 );
    var_5 = ( var_3 - var_2 ) / var_4;
    var_6 = var_2;

    for ( var_7 = 0; var_7 < var_4; var_7++ )
    {
        self setanim( var_0, var_6, 0.05, 1 );
        var_6 += var_5;
        waitframe();
    }
}

lerp_in_turn_rate( var_0 )
{
    var_1 = 0;
    var_2 = 1 / ( var_0 / 0.05 );
    var_3 = getdvarint( "aim_turnrate_pitch" );
    var_4 = getdvarint( "aim_turnrate_pitch_ads" );
    var_5 = getdvarint( "aim_turnrate_yaw" );
    var_6 = getdvarint( "aim_turnrate_yaw_ads" );

    for ( var_7 = getdvarint( "aim_accel_turnrate_lerp" ); var_1 <= 1; var_1 += var_2 )
    {
        setsaveddvar( "aim_turnrate_pitch", int( var_1 * var_3 ) );
        setsaveddvar( "aim_turnrate_pitch_ads", int( var_1 * var_4 ) );
        setsaveddvar( "aim_turnrate_yaw", int( var_1 * var_5 ) );
        setsaveddvar( "aim_turnrate_yaw_ads", int( var_1 * var_6 ) );
        setsaveddvar( "aim_accel_turnrate_lerp", int( var_1 * var_7 ) );
        waitframe();
    }

    setsaveddvar( "aim_turnrate_pitch", var_3 );
    setsaveddvar( "aim_turnrate_pitch_ads", var_4 );
    setsaveddvar( "aim_turnrate_yaw", var_5 );
    setsaveddvar( "aim_turnrate_yaw_ads", var_6 );
    setsaveddvar( "aim_accel_turnrate_lerp", var_7 );
}

waittill_drones_dead( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && !isremovedentity( var_2 ) )
            var_2 waittill( "death" );
    }
}

waittill_s2_drone_ambush_done( var_0 )
{
    while ( var_0.size > 0 && !common_scripts\utility::flag( "training_s2_start_enter_patio" ) )
    {
        var_0 = maps\_utility::array_removedead( var_0 );
        waitframe();
    }
}

training_s2_drone_ambush_attack()
{
    level endon( "training_s2_living_room_drone_attack_done" );
    var_0 = common_scripts\utility::getstruct( "attacklocation3", "targetname" );
    var_1 = common_scripts\utility::getstructarray( var_0.target, "targetname" );
    magicbullet( "iw5_bal27_sp_silencer01_variablereddot", var_0.origin, var_1[0].origin );
    wait 1;
    magicbullet( "iw5_bal27_sp_silencer01_variablereddot", var_0.origin, var_1[1].origin );
    wait 0.5;
    magicbullet( "iw5_bal27_sp_silencer01_variablereddot", var_0.origin, var_1[2].origin );
    wait 0.5;
    magicbullet( "iw5_bal27_sp_silencer01_variablereddot", var_0.origin, var_1[3].origin );
    wait 0.5;
    magicbullet( "iw5_bal27_sp_silencer01_variablereddot", var_0.origin, var_1[4].origin );
    wait 0.25;
    magicbullet( "iw5_bal27_sp_silencer01_variablereddot", var_0.origin, var_1[5].origin );
    wait 0.5;
    magicbullet( "iw5_bal27_sp_silencer01_variablereddot", var_0.origin, var_1[6].origin );
    wait 0.5;
    magicbullet( "iw5_bal27_sp_silencer01_variablereddot", var_0.origin, var_1[7].origin );
}
