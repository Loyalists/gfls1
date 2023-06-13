// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Saiga-12";
	self setmodel("h2_gfl_saiga12_body_nolod");
	self.headmodel = "h2_gfl_saiga12_head_nolod";
	self.accessorymodels = [ "h2_gfl_saiga12_clothes" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("h2_gfl_saiga12_body_nolod");
	precachemodel("h2_gfl_saiga12_head_nolod");
	precachemodel("h2_gfl_saiga12_clothes");
}
