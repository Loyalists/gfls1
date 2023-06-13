// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_m14::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "M14";
	self setmodel("s1_gfl_m14_body");
	self.headmodel = "s1_gfl_m14_head";
	self.accessorymodels = [ "s1_gfl_m14_hair" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_m14::precache();
		return;
	}

	precachemodel("s1_gfl_m14_body");
	precachemodel("s1_gfl_m14_head");
	precachemodel("s1_gfl_m14_hair");
}
