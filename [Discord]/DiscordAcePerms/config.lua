Config = {
	Server_Name = "[SERVER_NAME]",
	Discord_Link = 'https://discord.gg/',
	Website_Link = 'https://badger.store/',
	Allow_Refresh_Command = true, -- Allow usage of /refreshPerms command
	DebugScript = false,
	Print_Perm_Grants_And_Removals = true,
	Refresh_Throttle = 600, -- 10 minute refresh throttle
	roleList = {
		{Role_ID, "group.moderator"},
		{Role_ID, "group.admin"},
		{Role_ID, "group.founder"},
	},
}