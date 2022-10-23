import bs4
import requests
import re
import orjson

from dataclasses import dataclass
from typing import Optional

headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Max-Age': '3600',
    'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0'
    }

@dataclass
class Mount:
    spell_id: int
    name: str
    mount_type: int
    speed: Optional[int] = None

    def isEpic(self):
        return self.speed == 100 or self.speed > 150

    def isEpic310(self):
        return self.speed == 310

    def __str__(self):
        return f"Mount {self.name}: type {self.mount_type}, spell_id: {self.spell_id}, speed: {self.speed}"

    def data(self):
        return ( self.spell_id, self.name, self.mount_type, self.speed )

def get_mount_speed(spell_id):

    p = re.compile(r'Apply Aura: Mod (?:Mounted|Flight) Speed %Value:\s*(\d+)%')

    url = f"https://www.wowhead.com/wotlk/spell={spell_id}"
    req = requests.get(url, headers)
    soup = bs4.BeautifulSoup(req.content, 'html.parser')
    table = soup.find('table', attrs={'id':'spelldetails'})
    # print(table)

    try:
        rows = table.find_all('tr')
    except AttributeError:
        print(f"Bad speed: spell_id = {spell_id}")
        raise Exception("Not WotLK mount")

    for row in rows:
        cols = row.find_all('td')
        for e in cols:
            # if "Mod Flight Speed" in e.text:
            #     print(e.text)
            x = p.search(e.text)
            if x is not None:
                return int(x.group(1))

def build_mount_table():

    url = "https://wowpedia.fandom.com/wiki/MountID"
    req = requests.get(url, headers)
    soup = bs4.BeautifulSoup(req.content, 'html.parser')

    table = soup.find('table', attrs={'class':'sortable darktable zebra col1-center col2-center col3-center'})
    table_body = table.find('tbody')
    rows = table_body.find_all('tr')

    mount_table = {}

    for row in rows:
        cols = row.find_all('td')

        try:
            e = cols[2].contents[0]
        except IndexError:
            continue
        if isinstance(e, bs4.element.NavigableString):
            mount_type = int(e.text.strip())
        else:
            if 'horse' in e.find('img', alt=True)['alt']:
                mount_type = 230
            else:
                mount_type = 248

        name = cols[3].contents[0].text.strip()
        spell_id = int(cols[6].contents[0].text.strip())

        # print(f"Mount {name}: type {mount_type}, spell_id: {spell_id}")
        mount_table[spell_id] = Mount(spell_id, name, mount_type)

    # Sanitize the list by dropping all spell IDs that aren't present in WotLK
    sorted_spell_ids = sorted(set(mount_table.keys()))

    # X-53 Touring Rocket is the largest spell ID for WotLK
    index = sorted_spell_ids.index(75973)

    for id in sorted_spell_ids[index+1:]:
        del mount_table[id]

    l = list(mount_table.keys())
    for spell_id in l:
        mount = mount_table[spell_id]
        try:
            mount.speed = get_mount_speed(mount.spell_id)
            print(mount)
        except Exception:
            # Not a WotLK mount
            del mount_table[spell_id]

    return mount_table

def WotLKGetMountType(mount_table, output_file):

    sorted_spell_ids = sorted(mount_table.keys())
    mount_code_list = []

    start_id = sorted_spell_ids[0]
    last_id = sorted_spell_ids[0]
    last_type = mount_table[start_id].mount_type

    for spell_id in sorted_spell_ids:

        _, name, mount_type, _ = mount_table[spell_id].data()

        if mount_type == last_type:
            last_id = spell_id
        else:
            mount_code_list.append((start_id, last_id, last_type))
            start_id = spell_id
            last_id = spell_id
            last_type = mount_type

    mount_code_list.append((start_id, last_id, last_type))

    mount_type_names = {
        230 : "most ground mounts",
        231 : "[Riding Turtle] and Sea Turtle",
        232 : "[Vashj'ir Seahorse] (was named Abyssal Seahorse prior to Warlords of Draenor)",
        241 : "Blue, Green, Red, and Yellow Qiraji Battle Tank (restricted to use inside Temple of Ahn'Qiraj)",
        242 : "Swift Spectral Gryphon (hidden in the mount journal, used while dead in certain zones)",
        247 : "Red Flying Cloud",
        248 : "most flying mounts, including those that change capability based on riding skill",
        254 : "Subdued Seahorse",
        269 : "Azure and Crimson Water Strider",
        284 : "Chauffeured Mekgineer's Chopper and Chauffeured Mechano-Hog",
        # https://www.wowhead.com/spell=267270/kuafon
        398 : "Kua'fon"
    }

    output_file.write("\n")
    output_file.write("function Lunar.Items:WotLKGetMountType(mount)\n")
    output_file.write("\n")
    output_file.write("    local itemID = Lunar.Items:getMountID(mount)\n")
    output_file.write("\n")
    for m in mount_code_list:
        start_id, last_id, mount_type = m

        start_name = mount_table[start_id].name
        end_name = mount_table[last_id].name
        comment = f" -- {mount_type_names[mount_type]}"

        output_file.write(f"    if itemID >= {start_id} and itemID <= {last_id} then -- {start_name} -> {end_name}\n")
        output_file.write(f"        return {mount_type}{comment}\n")
        output_file.write("    end\n")

    output_file.write("\n")
    output_file.write("end\n")
    output_file.write("\n")

def WotLKIsMountEpic(mount_table, output_file):

    output_file.write("\n")
    output_file.write("function Lunar.Items:WotLKIsMountEpic(mount)\n")

    output_file.write("    local itemID = Lunar.Items:getMountID(mount)\n")
    output_file.write("    local mounts = {\n")

    for spell_id, mount in mount_table.items():
        print(mount)
        _, name, mount_type, speed = mount.data()
        if speed is not None and (speed == 100 or speed > 150):
            output_file.write(f"        {spell_id}, -- {name}\n")
    output_file.write("    }\n")
    output_file.write("\n")
    output_file.write("    return tContains(mounts, itemID)\n")
    output_file.write("end\n")
    output_file.write("\n")


def IsMountEpic310(mount_table, output_file):

    output_file.write("\n")
    output_file.write("function Lunar.Items:IsMountEpic310(mount)\n")

    output_file.write("    local itemID = Lunar.Items:getMountID(mount)\n")
    output_file.write("    local _, _, _, t = GetBuildInfo();\n")
    output_file.write("    local mounts\n")

    output_file.write("    mounts = {\n")

    for spell_id, mount in mount_table.items():
        _, name, mount_type, speed = mount.data()
        if speed == 310:
            output_file.write(f"        {spell_id}, -- {name}\n")
    output_file.write("    }\n")
    output_file.write("\n")
    output_file.write("end\n")
    output_file.write("\n")


def get_mount_table():

    try:
        with open("mount_table.json", "rb") as read_file:
            mount_list = orjson.loads(read_file.read())
            mount_table = {}
            for m in mount_list["mounts"]:
                # {"spell_id":458,"name":"Brown Horse","mount_type":230,"speed":null}
                spell_id = m["spell_id"]
                mount_table[spell_id] = Mount(m["spell_id"] , m["name"] , m["mount_type"], m["speed"])

    except FileNotFoundError:
        mount_table = build_mount_table()
        mount_list = { "mounts": list(mount_table.values()) }
        with open("mount_table.json", "wb") as write_file:
            write_file.write(orjson.dumps(mount_list))

    return mount_table

mount_table = get_mount_table()
with open("mounts.lua", "w") as file:
    WotLKGetMountType(mount_table, file)
    WotLKIsMountEpic(mount_table, file)
    IsMountEpic310(mount_table, file)
