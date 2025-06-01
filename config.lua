Config = {}

Config.Language = "en" -- Options: "en", "es", "fr", "de", "it", "pt", "ru", "nl"

Config.UseSociety = true
Config.Society = "syn" -- Options: "syn" or "dl"

Config.Command = "offlinedoc"
Config.Negative = true -- Allow players to go negative in money
Config.Cooldown = 1 -- Cooldown in minutes

Config.Job = {"doctor", "medic"} -- Name of your medical job

-- Optional: Prefix for jobs that indicate "on duty" status.
-- If set, the script will check for jobs with this prefix (e.g., "on_police", "on_medic").
-- Leave as "" if no prefix is used.
Config.Prefix = "" 

Config.NPCDoctor = {
    model = "cs_sddoctor_01", 
    revivePrice = 30,
}

Config.Webhook = "https://discord.com/api/webhooks/1297726014373363723/5QK-HRpB1gPgb9RL8AtaC2GoocawjnJrby0mlYrZLDIda1NxRFKkfTobunrNRFNlOvAL"
Config.WHTitle = "Offline Doc Used By:"
Config.WHIcon =  "https://cdn.discordapp.com/attachments/1074598381705494579/1292467690442854461/Deadwood_RP.png?ex=67048096&is=67032f16&hm=548b74f46407bfcfd8f35ba9aaf8027d31e1ed255c15faba968b6ccb157d4c57&"
Config.WHFooter = "Deadwood County | "
Config.WHColor = 0x916D44


