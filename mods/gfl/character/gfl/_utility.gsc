detach_all_attachments()
{
	if ( isdefined( self.headmodel ) ) 
	{
		self detach( self.headmodel );
		self.headmodel = undefined;
	}

	if ( isdefined( self.accessorymodels ) ) 
	{
		detach_accessorymodels();
	}

	if ( isdefined( self.charactername ) ) 
	{
		self.charactername = undefined;
	}
}

attach_all_attachments()
{
	if ( isdefined( self.headmodel ) ) 
	{
		self attach( self.headmodel, "", true );
	}

	if ( isdefined( self.accessorymodels ) ) 
	{
		attach_accessorymodels();
	}

	if ( isdefined( self.charactername ) ) 
	{
		thread set_character_name();
	}
}

attach_accessorymodels()
{
	if ( !isdefined( self.accessorymodels ) ) 
	{
		return;
	}

	foreach ( acc in self.accessorymodels ) 
	{
		self attach( acc, "", true );
	}
}

detach_accessorymodels()
{
	if ( !isdefined( self.accessorymodels ) ) 
	{
		return;
	}

	foreach ( acc in self.accessorymodels ) 
	{
		self detach( acc );
	}

	self.accessorymodels = undefined;
}

// because codescripts\character::get_random_character() sucks ass
get_random_character( num ) {
	if ( !isdefined( num ) ) {
		num = 1;
	}
	
	return randomint( num );
}

check_script_friendname() {
	if ( isdefined( self.script_friendname ) ) {
		if ( self.script_friendname == "Ozone" ) {
			return false;
		}

		if ( self.script_friendname == "Scarecrow" ) {
			return false;
		}
	}

	return true;
}

set_character_name() {
	while ( isdefined( self.charactername ) && isalive( self ) ) {
		self.name = self.charactername;
		chk = check_script_friendname();
		if ( chk ) {
			self.script_friendname = self.charactername;
		}
		wait 2;
	}
}

swap_character( ent ) 
{
	detach_all_attachments();
	self setmodel( ent.model );
	
	if ( isdefined( ent.headmodel ) ) 
	{
		self.headmodel = ent.headmodel;
	}

	if ( isdefined( ent.accessorymodels ) ) 
	{
		self.accessorymodels = ent.accessorymodels;
	}

	if ( isdefined( ent.charactername ) ) 
	{
		self.charactername = ent.charactername;
	}

	attach_all_attachments();
}

is_nolod_enabled()
{
    result = getdvarint( "gfl_enable_nolod" );
	if (result == 1) {
		return true;
	}

	return false;
}

check_npc_weapon_substr( arr )
{
	if ( !isdefined( arr ) ) {
		return false;
	}

	if ( !isdefined( self.weapon ) ) {
		return false;
	}

	foreach ( weapon_substr in arr ) 
	{
        if ( issubstr( self.weapon, weapon_substr ) )
        {
			return true;
		}
	}

	return false;
}