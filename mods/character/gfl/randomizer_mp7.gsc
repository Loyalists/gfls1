main()
{
	character\gfl\_utility::detach_all_attachments();

	switch( character\gfl\_utility::get_random_character(2) )
	{
	case 0:
		character\gfl\character_gfl_mp7::main();
		break;
	case 1:
		character\gfl\character_gfl_mp7_tights::main();
		break;
	}
	self.voice = "atlas";
}

precache()
{
	character\gfl\character_gfl_mp7::precache();
	character\gfl\character_gfl_mp7_tights::precache();
}