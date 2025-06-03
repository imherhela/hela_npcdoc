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

Config.Webhook = "YOUR WEBHOOK HERE"
Config.WHTitle = "Offline Doc Used By:"
Config.WHIcon =  ""
Config.WHFooter = "SERVER NAME | "
Config.WHColor = 0x916D44


