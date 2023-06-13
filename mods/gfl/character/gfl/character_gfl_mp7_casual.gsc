// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_mp7_casual::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "MP7";
	self setmodel("s1_gfl_mp7_body");
	self.headmodel = "s1_gfl_mp7_head";
	self.accessorymodels = [ "s1_gfl_mp7_hat", "s1_gfl_mp7_headset" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_mp7_casual::precache();
		return;
	}

	precachemodel("s1_gfl_mp7_body");
	precachemodel("s1_gfl_mp7_head");
	precachemodel("s1_gfl_mp7_hat");
	precachemodel("s1_gfl_mp7_headset");
}
