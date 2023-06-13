main()
{
	character\gfl\_utility::detach_all_attachments();

	switch( character\gfl\_utility::get_random_character(2) )
	{
	case 0:
		character\gfl\character_gfl_guard::main();
		break;
	case 1:
		character\gfl\character_gfl_guard_visor_up::main();
		break;
	}
	self.voice = "kva";
}

precache()
{
	character\gfl\character_gfl_guard::precache();
	character\gfl\character_gfl_guard_visor_up::precache();
}