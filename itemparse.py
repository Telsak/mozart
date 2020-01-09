#!/usr/bin/python3
import sys
import os
import re
import csv

def staffLine(itemtype,keywords,longname,slot,ac,charges,spell,effects,attributes):
    """
    For staffs and wands we pull spell+level and max charges of the item
    """
    attributestring, effectstring, chargestring = "", "", ""
    for key in attributes: # iterate over the dict to turn it into a long string
        attributestring += (key + ':' + str(attributes[key]) + ',') 
    for key in effects: # same here as with attributes
        effectstring += str(key) + ','
    for key in spell:
        chargestring += "{}:lvl-{}:charge-{},".format(key, spell[key], charges)
    
    attributestring = attributestring[:-1] # get rid of trailing commas
    effectstring = effectstring[:-1]
    chargestring = chargestring[:-1]

    return ','.join([itemtype,keywords,longname,slot,ac,chargestring,attributestring,effectstring])

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

def grabNumLines(path, fileName, wordMatch):
    """ Find the number of hits on the word in wordMatch, same as wc -L in bash """

    if os.path.isfile(path + fileName):
        with open(fileName) as f:
            numLines = sum(wordMatch in line for line in f)
            return numLines
    else:
        return 0

def changeVNUM(path, fileName, itemID, newVnum):
    """ Replacing the existing VNUM by using the Item ID as a key """

    f = csv.reader(open(path+fileName))
    lines = list(f)
    for line in lines:
        if line[0] == itemID:
            line[1] = newVnum
            break
    writer = csv.writer(open(path+fileName, 'w'))
    writer.writerows(lines)

# Set some tracking variables before we open the itemfile
spells, effects, attributes = {}, {},  {}
spellcharges, itemtype, dmgtype, dmgdice, armor  = "0", "0", "0", "0", "0"
filesPath = "/home/telsak/mud/"
watchFile = ".itemlog_temp"
outFile = "mozart.db"

# Only call the vnum replace function if we have sufficient arguments and first argument
# requests this directly. 
arguments = len(sys.argv) - 1
if arguments == 3 and sys.argv[1] == "setvnum":
    changeVNUM(filesPath, outFile, sys.argv[2], sys.argv[3])
    sys.exit(0)
    
# next itemID will be number of lines (items) in file + 1, only problem is if we manually delete an item
# there will be gaps. Each item has a , in it, which we match on to count items.
itemID = int(grabNumLines(filesPath, outFile, ',')) + 1 

f = open(watchFile)
for line in f.readlines():
    if "ITEM" in line: # Grabs keywords - its possible we dont need this anymore from the tt script
        keywords = line.split()[1].lstrip()
        if grabNumLines(filesPath,outFile,keywords) > 0:
            print("This item is already in the database! Exiting.")
            sys.exit(0)
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
        spell = "spell-" + str(line.split()[4:][0].replace('.',''))
        spells[spell] = level
    elif "charges" in line: # grab wand/staff charges
        spellcharges = line.split()[5].rstrip('.')
    elif line[0] == ' ': # This is for all attributes and active spell effects
        if ":" in line:
            attr = line.split(':')[0].lstrip()
            attr_val = line.split(':')[1].rstrip().replace('.','')
            attributes[attr] = attr_val
        else:
            attr = line.split('.')[0].lstrip()
            attr_val = 0
            effects[attr] = attr_val
f.close()

if dmgdice != "0": # format according to the weapon template
    outputline = str(itemID) + ",ROOMVNUM," + str(weaponLine(itemtype,keywords,longname,dmgdice,dmgtype,effects,attributes))

elif spellcharges != "0": # item has spell charges
    outputline = str(itemID) + ",ROOMVNUM," + str(staffLine(itemtype,keywords,longname,equipslot,armor,spellcharges,spells,effects,attributes))

else: # If the last item found was NOT a weapon or has no charges, use armor/clothing formatting
    outputline = str(itemID) + ",ROOMVNUM," + str(armorLine(itemtype,keywords,longname,equipslot,armor,effects,attributes))

while outputline[-1:] == ",": # while to strip ALL trailing commas
    outputline = outputline[:-1]

fw =open(outFile, 'a')
fw.write(outputline + "\n")

fw.close()
