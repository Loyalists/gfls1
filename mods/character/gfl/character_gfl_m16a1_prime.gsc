// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_m16a1_prime::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "M16A1";
	self setmodel("h1_gfl_m16a1_prime_body");
	self.headmodel = "h1_gfl_m16a1_prime_head";
	self.accessorymodels = [ "h1_gfl_m16a1_prime_outline" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_m16a1_prime::precache();
		return;
	}

	precachemodel("h1_gfl_m16a1_prime_body");
	precachemodel("h1_gfl_m16a1_prime_head");
	precachemodel("h1_gfl_m16a1_prime_outline");
}
