// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_an94_nocoat::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "AN-94";
	self setmodel("s1_gfl_an94_body");
	self.headmodel = "s1_gfl_an94_head";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_an94_nocoat::precache();
		return;
	}

	precachemodel("s1_gfl_an94_body");
	precachemodel("s1_gfl_an94_head");
}
