# highlight_capitals
Mod for Eve Development Killboard by Salvoxia.

Highlights kills and losses of capital ships in kill list tables.
It will highlight kills/losses for the following ship classes:

* Titan
* Supercarrier
* Dreadnought
* Carrier
* Freighter
* Capital Industrial Ship
* Industrial Command Ship

##Installation
Upload the highlight_capitals folder to your killboard/mods folder. Enable the mod in ACP -> Modules.

##Limitations:
This mod is NOT compatible with other mods overwriting the killlisttable.tbl template!

A popular example for such a mod is the [cynoCloakMod] (https://github.com/Salvoxia/cynoCloakMod). However, this mod supports the cynoCloakMod in particular.

In order to make it work with such mods, the changes to the killlisttable.tpl file need to be introduced to the one of the other mod (or vice versa, depending on which mod is loaded first (alphabetically ascending). But in that case I'll be glad to assist. 

Sadly, there's no way around this at the moment.

##Changelog

#####Version 1.1
* fixes for compatibility with PHP 7

#####Version 1.0
* Initial release