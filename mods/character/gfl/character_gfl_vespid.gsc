// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_vespid::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Vespid";
	self setmodel("h2_gfl_vespid_fb");
	character\gfl\_utility::attach_all_attachments();
	self.voice = "russian";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_vespid::precache();
		return;
	}

	precachemodel("h2_gfl_vespid_fb");
}
