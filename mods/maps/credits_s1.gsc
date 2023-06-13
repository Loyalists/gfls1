// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.dodgeloadout = 1;
    level.credits_active = 1;
    maps\_utility::template_level( "credits_s1" );
    maps\createart\credits_s1_art::main();
    maps\credits_s1_fx::main();
    maps\credits_s1_precache::main();
    maps\_load::main();
    maps\credits_s1_lighting::main();
    maps\credits_s1_aud::main();
    maps\_credits::initcredits( "all" );
    level.player freezecontrols( 1 );
    level.player takeallweapons();
    maps\_hud_util::create_client_overlay( "black", 1 );
    thread maps\_credits::allow_early_back_out();
    maps\_credits::playcredits();
    maps\_endmission::end_mission_fade_audio_and_video( 1 );
    changelevel( "", 0 );
}
