# hela_npcdoc

A lightweight RedM resource that allows players to use an NPC doctor to revive or heal themselves when no medical staff are online. Supports society payments, configurable job checks, and Discord webhook logging.

## Installation

1. Drop the `hela_npcdoc` folder into your server's `resources` directory
2. Add the following to your `server.cfg`:
   ```
   ensure hela_npcdoc
   ```
3. Configure `config.lua` to match your setup
4. Start your server

## Configuration

All settings are in `config.lua`.

### General

| Option            | Description                                                                          | Default        |
|-------------------|--------------------------------------------------------------------------------------|----------------|
| `Config.Language` | UI language. Options: `"en"`, `"es"`, `"fr"`, `"de"`, `"it"`, `"pt"`, `"ru"`, `"nl"` | `"en"`         |
| `Config.Command`  | The command players use to access the NPC doctor                                     | `"offlinedoc"` |
| `Config.Cooldown` | Cooldown between uses, in minutes                                                    | `1`            |
| `Config.Negative` | Whether players can go negative in money when paying                                 | `true`         |

### Jobs

| Option          | Description                                                                       | Default               |
|-----------------|-----------------------------------------------------------------------------------|-----------------------|
| `Config.Job`    | List of job names considered medical staff                                        | `{"doctor", "medic"}` |
| `Config.Prefix` | Optional job prefix (e.g. `"on_"` matches `"on_medic"`). Leave as `""` to disable | `""`                  |

### Society / Payment

| Option              | Description                                          | Default |
|---------------------|------------------------------------------------------|---------|
| `Config.UseSociety` | Whether payment goes to a society account            | `true`  |
| `Config.Society`    | Society framework to use. Options: `"syn"` or `"dl"` | `"syn"` |

### NPC Doctor

| Option                         | Description                       | Default            |
|--------------------------------|-----------------------------------|--------------------|
| `Config.NPCDoctor.model`       | Ped model used for the NPC doctor | `"cs_sddoctor_01"` |
| `Config.NPCDoctor.revivePrice` | Cost to use the NPC doctor        | `30`               |

### Webhook (Discord Logging)

| Option            | Description                                   |
|-------------------|-----------------------------------------------|
| `Config.Webhook`  | Your Discord webhook URL                      |
| `Config.WHTitle`  | Title shown in the embed                      |
| `Config.WHIcon`   | Icon URL for the embed (leave empty for none) |
| `Config.WHFooter` | Footer text on the embed                      |
| `Config.WHColor`  | Embed color as a hex value (e.g. `0x916D44`)  |

## Usage

Players type the configured command (default: `/offlinedoc`) in-game. The NPC doctor is only accessible when no players with a listed medical job are currently on duty.

## Notes

- The NPC doctor is blocked if any player with a matching job (or on-duty prefix) is online
- Characters with a `NULL` or missing job value will not count as medical staff

## Dependencies:

* `vorp_core`
* `syn_society` or `dl_society`

## Development Status:

* Currently fully supported for **VORP Core** and **Syn Society**.
* **Work in progress** for other society/job systems (e.g., **DL\_Society**, **TPZ\_Core**, etc.) and broader framework compatibility.

# Made by ImHerHela
