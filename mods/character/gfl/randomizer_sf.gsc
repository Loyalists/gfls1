main()
{
	character\gfl\_utility::detach_all_attachments();

	switch( codescripts\character::get_random_character(6) )
	{
	case 0:
		character\gfl\character_gfl_vespid::main();
		break;
	case 1:
		character\gfl\character_gfl_jaeger::main();
		break;
	case 2:
		character\gfl\character_gfl_jaeger_goggle_up::main();
		break;
	case 3:
		character\gfl\character_gfl_ripper::main();
		break;
	case 4:
		character\gfl\character_gfl_guard::main();
		break;
	case 5:
		character\gfl\character_gfl_guard_visor_up::main();
		break;
	}
	self.voice = "kva";
}

precache()
{
	character\gfl\character_gfl_vespid::precache();
	character\gfl\character_gfl_jaeger::precache();
	character\gfl\character_gfl_jaeger_goggle_up::precache();
	character\gfl\character_gfl_ripper::precache();
	character\gfl\character_gfl_guard::precache();
	character\gfl\character_gfl_guard_visor_up::precache();
}