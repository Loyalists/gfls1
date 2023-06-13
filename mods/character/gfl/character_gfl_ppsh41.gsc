// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_ppsh41::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "PPSh-41";
	self setmodel("h1_gfl_ppsh41_body");
	self.headmodel = "h1_gfl_ppsh41_head";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "russian";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_ppsh41::precache();
		return;
	}

	precachemodel("h1_gfl_ppsh41_body");
	precachemodel("h1_gfl_ppsh41_head");
}
