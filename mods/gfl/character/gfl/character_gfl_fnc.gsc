// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_9a91::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "FNC";
	self setmodel("h2_gfl_fnc_body");
	self.headmodel = "h2_gfl_fnc_head";
	self.accessorymodels = [ "h2_gfl_fnc_clothes" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_9a91::precache();
		return;
	}

	precachemodel("h2_gfl_fnc_body");
	precachemodel("h2_gfl_fnc_head");
	precachemodel("h2_gfl_fnc_clothes");
}
