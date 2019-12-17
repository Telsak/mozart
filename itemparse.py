#!/usr/bin/python3

import re

def armorLine(itemtype,keywords,longname,slot,ac,effects,attributes):
    """
    Format the parsed item data into a single-line for storing in a file.
    attributes is a dict containing the item stat bonuses, like +hitpoints etc.
    effects is a dict containing permanent spell effects, like Darksight etc.
    """

    attributestring, effectstring = "", ""
    for key in attributes: # iterate over the dict to turn it into a long string
        attributestring += (key + ':' + str(attributes[key]) + ',') 
    for key in effects: # same here as with attributes
        effectstring += str(key) + ','
    attributestring = attributestring[:-1] # get rid of trailing commas
    effectstring = effectstring[:-1]
    return ','.join([itemtype,keywords,longname,slot,ac,attributestring,effectstring])

def weaponLine(itemtype,keywords,longname,dice,damtype,effects,attributes):
    """
    Format the parsed item data into a single-line for storing in a file.
    attributes is a dict containing the item stat bonuses, like +hitpoints etc.
    effects is a dict containing permanent spell effects, like Darksight etc.
    dice and damtype is specific for weapons only.
    """
    
    attributestring, effectstring = "", ""
    for key in attributes: # iterate over the dict to turn it into a long string
        attributestring += (key + ':' + str(attributes[key]) + ',') 
    for key in effects: # same here as with attributes
        effectstring += str(key) + ','
    attributestring = attributestring[:-1] # get rid of trailing commas
    effectstring = effectstring[:-1]
    return ','.join([itemtype,keywords,longname,dice,damtype,attributestring,effectstring])

# Reset some tracking variables before we open the itemfile
spells, effects, attributes = {}, {},  {}
itemtype, dmgtype, dmgdice, armor  = "0", "0", "0", "0"
itemloop = 0

fw = open('itemlog.out','a')
f = open('item.in')
for line in f.readlines():
    if "ITEM" in line: # triggers each new ITEM, and pushes info from previous item to file
        if itemloop == 1:
            if dmgdice == "0": # If the last item found was NOT a weapon, use non-weapon formatting
                outputline = armorLine(itemtype,keywords,longname,equipslot,armor,effects,attributes)
            else: # format according to the weapon template
                outputline = weaponLine(itemtype,keywords,longname,dmgdice,dmgtype,effects,attributes)
            while outputline[-1:] == ",": # while to strip ALL trailing commas
                outputline = outputline[:-1]
            fw.write(outputline + "\n")
            spells, effects, attributes = {}, {},  {} # sets vars to empty for next item
            itemtype, dmgtype, dmgdice, armor  = "0", "0", "0", "0"
            itemloop = 0 # 
        keywords = line.split()[1].lstrip()
    elif "Item type:" in line: # grab Object name and itemtype
        longname = re.search('\".+?\"', line).group(0).replace('"','')
        itemtype = line.split(': ')[1].rstrip()
    elif "Armor Rating" in line:
        armor = line.split()[5].rstrip()
    elif "Can be equipped" in line: # which equipment slot?
        equipslot = line.split(': ')[1].replace('.','').rstrip()
        itemloop = 1
    elif "Dice" in line: # grab weapon dice and damage type
        dmgdice = line.split()[3][:-1]
        dmgtype = line.split()[-1][:-1]
    elif "spell" in line:
        level = line.split()[1]
        spell = "Spell-" + str(line.split()[4:][0].replace('.',''))
        spells[spell] = level
    elif line[0] == ' ':
        if ":" in line:
            attr = line.split(':')[0].lstrip()
            attr_val = line.split(':')[1].rstrip().replace('.','')
            attributes[attr] = attr_val
        else:
            attr = line.split('.')[0].lstrip()
            attr_val = 0
            effects[attr] = attr_val
f.close()
fw.close()
