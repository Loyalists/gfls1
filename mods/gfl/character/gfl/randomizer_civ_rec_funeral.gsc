main()
{
	character\gfl\_utility::detach_all_attachments();

	switch( codescripts\character::get_random_character(35) )
	{
	case 0:
		character\character_civ_rec_funeral_male_afr_a::main();
		break;
	case 1:
		character\character_civ_rec_funeral_male_afr_b::main();
		break;
	case 2:
		character\character_civ_rec_funeral_male_afr_c::main();
		break;
	case 3:
		character\character_civ_rec_funeral_male_afr_d::main();
		break;
	case 4:
		character\character_civ_rec_funeral_male_asi_a::main();
		break;
	case 5:
		character\character_civ_rec_funeral_male_cau_a::main();
		break;
	case 6:
		character\character_civ_rec_funeral_male_cau_b::main();
		break;
	case 7:
		character\character_civ_rec_funeral_male_cau_c::main();
		break;
	case 8:
		character\character_civ_rec_funeral_male_cau_d::main();
		break;
	case 9:
		character\character_civ_rec_funeral_male_cau_e::main();
		break;
	case 10:
		character\character_civ_scientist_s1_a::main();
		break;
	case 11:
		character\character_civ_scientist_s1_b::main();
		break;
	case 12:
		character\character_civ_scientist_s1_c::main();
		break;
	case 13:
		character\character_civ_scientist_s1_d::main();
		break;
	case 14:
		character\character_civ_scientist_s1_e::main();
		break;
	case 15:
		character\character_civ_scientist_s1_f::main();
		break;
	case 16:
		character\gfl\character_gfl_vespid::main();
		break;
	case 17:
		character\gfl\character_gfl_jaeger::main();
		break;
	case 18:
		character\gfl\character_gfl_jaeger_goggle_up::main();
		break;
	case 19:
		character\gfl\character_gfl_ripper::main();
		break;
	case 20:
		character\gfl\character_gfl_guard::main();
		break;
	case 21:
		character\gfl\character_gfl_guard_visor_up::main();
		break;
	case 22:
		character\gfl\character_gfl_p90::main();
		break;
	case 23:
		character\gfl\character_gfl_9a91::main();
		break;
	case 24:
		character\gfl\character_gfl_rfb::main();
		break;
	case 25:
		character\gfl\character_gfl_saiga12::main();
		break;
	case 26:
		character\gfl\character_gfl_sten::main();
		break;
	case 27:
		character\gfl\character_gfl_g36c::main();
		break;
	case 28:
		character\gfl\character_gfl_spas12::main();
		break;
	case 29:
		character\gfl\character_gfl_suomi::main();
		break;
	case 30:
		character\gfl\character_gfl_ppsh41::main();
		break;
	case 31:
		character\gfl\character_gfl_super_sass::main();
		break;
	case 32:
		character\gfl\character_gfl_sv98::main();
		break;
	case 33:
		character\gfl\randomizer_mp7_casual::main();
		break;
	case 34:
		character\gfl\character_gfl_m14::main();
		break;
	}

	self.voice = "atlas";
}

precache()
{
	character\character_civ_rec_funeral_male_afr_a::precache();
	character\character_civ_rec_funeral_male_afr_b::precache();
	character\character_civ_rec_funeral_male_afr_c::precache();
	character\character_civ_rec_funeral_male_afr_d::precache();
	character\character_civ_rec_funeral_male_asi_a::precache();
	character\character_civ_rec_funeral_male_cau_a::precache();
	character\character_civ_rec_funeral_male_cau_b::precache();
	character\character_civ_rec_funeral_male_cau_c::precache();
	character\character_civ_rec_funeral_male_cau_d::precache();
	character\character_civ_rec_funeral_male_cau_e::precache();
	character\character_civ_scientist_s1_a::precache();
	character\character_civ_scientist_s1_b::precache();
	character\character_civ_scientist_s1_c::precache();
	character\character_civ_scientist_s1_d::precache();
	character\character_civ_scientist_s1_e::precache();
	character\character_civ_scientist_s1_f::precache();
	character\gfl\randomizer_sf::precache();
	character\gfl\randomizer_atlas::precache();
	character\gfl\randomizer_mp7_casual::precache();
}