// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_sv98::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "SV-98";
	self setmodel("s1_gfl_sv98_body");
	self.headmodel = "s1_gfl_sv98_head";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_sv98::precache();
		return;
	}

	precachemodel("s1_gfl_sv98_body");
	precachemodel("s1_gfl_sv98_head");
}
