// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( level.script == "lab" ) {
        character\gfl\randomizer_atlas::main();
    }
    else 
    {
        character\gfl\randomizer_sf::main();
    }
    
    self.voice = "kva";
}

precache()
{
    character\gfl\randomizer_atlas::precache();
    character\gfl\randomizer_sf::precache();
    precachemodel( "kva_hazmat_body_low" );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_cau_male_heads_hazmat_nohat::main() );
}
