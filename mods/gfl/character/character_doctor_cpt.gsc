// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "doctor_body" );
    codescripts\character::attachhead( "alias_civ_asi_male_heads_cpt", xmodelalias\alias_civ_asi_male_heads_cpt::main() );
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "doctor_body" );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_asi_male_heads_cpt::main() );
}
