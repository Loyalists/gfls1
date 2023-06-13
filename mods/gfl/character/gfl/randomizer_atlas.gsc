main()
{
	character\gfl\_utility::detach_all_attachments();

	switch( codescripts\character::get_random_character(13) )
	{
	case 0:
		character\gfl\character_gfl_p90::main();
		break;
	case 1:
		character\gfl\character_gfl_9a91::main();
		break;
	case 2:
		character\gfl\character_gfl_rfb::main();
		break;
	case 3:
		character\gfl\character_gfl_saiga12::main();
		break;
	case 4:
		character\gfl\character_gfl_sten::main();
		break;
	case 5:
		character\gfl\character_gfl_g36c::main();
		break;
	case 6:
		character\gfl\character_gfl_spas12::main();
		break;
	case 7:
		character\gfl\character_gfl_suomi::main();
		break;
	case 8:
		character\gfl\character_gfl_ppsh41::main();
		break;
	case 9:
		character\gfl\character_gfl_super_sass::main();
		break;
	case 10:
		character\gfl\character_gfl_sv98::main();
		break;
	case 11:
		character\gfl\randomizer_mp7::main();
		break;
	case 12:
		character\gfl\character_gfl_m14::main();
		break;
	}
	self.voice = "atlas";
}

precache()
{
	character\gfl\character_gfl_p90::precache();
	character\gfl\character_gfl_9a91::precache();
	character\gfl\character_gfl_rfb::precache();
	character\gfl\character_gfl_saiga12::precache();
	character\gfl\character_gfl_sten::precache();
	character\gfl\character_gfl_g36c::precache();
	character\gfl\character_gfl_spas12::precache();
	character\gfl\character_gfl_suomi::precache();
	character\gfl\character_gfl_ppsh41::precache();
	character\gfl\character_gfl_super_sass::precache();
	character\gfl\character_gfl_sv98::precache();
	character\gfl\randomizer_mp7::precache();
	character\gfl\character_gfl_m14::precache();
}