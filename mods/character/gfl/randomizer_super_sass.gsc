main()
{
	character\gfl\_utility::detach_all_attachments();

	switch( character\gfl\_utility::get_random_character(2) )
	{
	case 0:
		character\gfl\character_gfl_super_sass::main();
		break;
	case 1:
		character\gfl\character_gfl_super_sass_nocoat::main();
		break;
	}
	self.voice = "atlas";
}

precache()
{
	character\gfl\character_gfl_super_sass::precache();
	character\gfl\character_gfl_super_sass_nocoat::precache();
}