# hela_npcdoc

This script introduces a reliable NPC-based medical system designed for RedM servers. When no human medics are available, NPC doctors will automatically take their place, offering healing services to injured players at configured medical locations. This ensures uninterrupted roleplay and server functionality at all times.

## :wrench: Features:

* :health_worker: **Dynamic NPC Spawning**
  Automatically spawns an NPC doctor when no medics are on duty.

* :speech_balloon: **Immersive Healing Interaction**
  Players receive an in-world prompt to be treated by the NPC doctor.

* :dollar: **Customizable Pricing**
  Healing costs can be adjusted to suit your economy and job structure.

* :hospital: **Always-On Medical Support**
  Guarantees that injured players can access care, even during low population hours.

* :gear: **Smart Duty Checks**
  Integrates with job systems to only activate when no medics are on duty.

## :package: Dependencies:

* `vorp_core`
* `syn_society`

## :test_tube: Development Status:

* Currently fully supported for **VORP Core** and **Syn Society**.
* **Work in progress** for other society/job systems (e.g., **DL\_Society**, **TPZ\_Core**, etc.) and broader framework compatibility.
