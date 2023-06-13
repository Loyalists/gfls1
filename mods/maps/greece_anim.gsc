// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( level.nextgen )
        anim.forced_s1_motionset = 1;

    player_setupanimations();
    burke_setupanimations();
    enemy_setupanimations();
    civilian_setupanimations();
    rope_setupanimation();
}

#using_animtree("player");

player_setupanimations()
{
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_rig"]["knockdown"] = %player_view_dog_knockdown_saved;
}

burke_setupanimations()
{

}

enemy_setupanimations()
{

}

civilian_setupanimations()
{

}

rope_setupanimation()
{

}
