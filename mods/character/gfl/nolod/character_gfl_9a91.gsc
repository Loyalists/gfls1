// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "9A-91";
	self setmodel("h2_gfl_9a91_body_nolod");
	self.headmodel = "h2_gfl_9a91_head_nolod";
	self.accessorymodels = [ "h2_gfl_9a91_hair_nolod" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("h2_gfl_9a91_body_nolod");
	precachemodel("h2_gfl_9a91_head_nolod");
	precachemodel("h2_gfl_9a91_hair_nolod");
}
