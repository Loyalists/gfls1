// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_spas12::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "SPAS-12";
	self setmodel("s1_gfl_spas12_body");
	self.headmodel = "s1_gfl_spas12_head";
	self.accessorymodels = [ "s1_gfl_spas12_hair", "s1_gfl_spas12_outline" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_spas12::precache();
		return;
	}

	precachemodel("s1_gfl_spas12_body");
	precachemodel("s1_gfl_spas12_head");
	precachemodel("s1_gfl_spas12_hair");
	precachemodel("s1_gfl_spas12_outline");
}
