/*
 * Root Box Inserts
 * Lizard Cult
 * Project units: millimeters (mm)
 *
 * Copyright (C) 2025 Dylan Eskew
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <https://www.gnu.org/licenses/>. 
 */

include <faction-common.scad>

LIZARD_WIDTH = 17.9;
LIZARD_HEIGHT = 19.5;
LIZARD_DEPTH = 7.9;

LIZARD_WARRIORS = 25;
LIZARD_BUILDINGS = 17;

LIZARD_NAME = "Lizard Cult";
LIZARD_TEXT_LEN = 50.0;

faction_height = faction_height_add(LIZARD_HEIGHT + PIECE_PAD);

module lizard_box() {
  pad = ((FACTION_LEN - FACTION_BEZEL) / 4) - LIZARD_WIDTH;

  difference() {
    faction_base(LIZARD_HEIGHT);

    faction_warrior_slots(8, 3, LIZARD_WARRIORS,
                          LIZARD_WIDTH, LIZARD_HEIGHT, LIZARD_DEPTH, pad);

    faction_back_translate() {
      translate([FACTION_WIDTH - FACTION_BEZEL,
                 -slot_width(LIZARD_WIDTH) - FACTION_BEZEL,
                 faction_height - LIZARD_HEIGHT - PIECE_PAD])
      mirror([1, 0, 0]) {
        warrior_slot(LIZARD_WIDTH, LIZARD_HEIGHT, LIZARD_DEPTH, 1);
      }
    
      faction_building_slot_translate(faction_height)
      translate([0, -FACTION_BEZEL, 0]) {
        building_slot(LIZARD_BUILDINGS, faction_height);
      }
  
      translate([0,
                 (slot_width(LIZARD_WIDTH) - FINGER_WIDTH) / 2 - slot_width(LIZARD_WIDTH) - FACTION_BEZEL,
                 faction_height - FINGER_HEIGHT]) {
        finger_slot(LIZARD_WIDTH, faction_height);
      }
    }

    /*faction_labels(LIZARD_NAME, LIZARD_TEXT_LEN);*/
  }
}

lizard_box();

/*lid_test_position(faction_height) {
  lid(LIZARD_NAME, true);
}*/
