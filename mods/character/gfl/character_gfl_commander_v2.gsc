// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_commander_v2::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Commander";
	self setmodel("s1_gfl_commander_v2_body");
	self.headmodel = "s1_gfl_commander_v2_head";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_commander_v2::precache();
		return;
	}

	precachemodel("s1_gfl_commander_v2_body");
	precachemodel("s1_gfl_commander_v2_head");
}
