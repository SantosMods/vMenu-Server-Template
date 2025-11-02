# SantosMods.dev vMenu Server Template

> A clean, modular baseline for FiveM servers using **vMenu**.

---

## Features
- vMenu-based admin and player menus
- Curated core scripts and plugins
- Discord role → ACE permissions bridge
- Map expansion support (optional)
- Organized and txAdmin-ready

---

## Included Resources

### Scripts
| Resource | Description | Link |
|----------|-------------|------|
| **rpemotes-reborn** | Emote menu with synced animations | <https://github.com/alberttheprince/rpemotes-reborn/releases/tag/v1.9.1> |
| **Luxart Vehicle Control** | Vehicle siren/light controller | <https://github.com/TrevorBarns/luxart-vehicle-control/releases/tag/3.2.9> |
| **vMenu** | Core server-side interaction menu | <https://github.com/TomGrobbe/vMenu/releases/tag/v3.8.3> |

---

### Needs (Framework Dependencies)
| Resource | Purpose | Link |
|----------|---------|------|
| **RageUI** | UI framework for client/server menus | <https://github.com/ItsikNox/RageUI> |

---

### Discord Integration
| Resource | Purpose | Link |
|----------|---------|------|
| **Badger_Discord_API** | Discord API wrapper | <https://github.com/JaredScar/Badger_Discord_API> |
| **DiscordAcePerms** | Discord role → ACE permission bridge | <https://github.com/JaredScar/DiscordAcePerms> |

---

### Maps
| Resource | Description | Link |
|----------|-------------|------|
| **UrbanPlus: World Reimagined (v0.3.0-alpha)** | Open-world expansion for GTA V | <https://santosmods.dev/downloads/UrbanPlusWorld-Reimagined> |
| **Bob74 IPL** | Interior and map loader | <https://github.com/Bob74/bob74_ipl/tree/2.4.1> |

---

## Troubleshooting
| Issue | Check |
|-------|-------|
| vMenu not opening | Permissions or resource order issues |
| Discord roles not syncing | Bot permissions / intents / correct role IDs |
| UI / RageUI errors | Ensure `RageUI` loads before dependent scripts |
| Map not appearing | Correct folder name and `fxmanifest.lua` |

---

## Credits
- Scripts: rpemotes-reborn, Luxart Vehicle Control, vMenu
- Dependencies: RageUI
- Discord: Badger_Discord_API, DiscordAcePerms
- Maps: Bob74 IPL, UrbanPlus