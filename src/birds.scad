/*
 * Root Box Inserts
 * Eyrie Dynasties
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

BIRD_WIDTH = 15.4;
BIRD_HEIGHT = 21.4;
BIRD_DEPTH = 9.0;

BIRD_WARRIORS = 20;
BIRD_BUILDINGS = 8;

BIRD_NAME = "Eyrie Dynasties";
BIRD_NAME_LEN = 60.0;

faction_height = faction_height_add(BIRD_HEIGHT + PIECE_PAD);

module bird_box() {
  pad = ((FACTION_LEN - FACTION_BEZEL) / 4) - BIRD_WIDTH;  

  difference() {
    faction_base(BIRD_HEIGHT);

    faction_warrior_slots(7, 3, BIRD_WARRIORS,
                          BIRD_WIDTH, BIRD_HEIGHT, BIRD_DEPTH, pad);

    faction_back_translate()
    translate([0, -FACTION_BEZEL, 0]) {
      faction_building_slot_translate(faction_height) {
        building_slot(BIRD_BUILDINGS, faction_height);
      }

      faction_cardboard_finger_translate(faction_height) {
        finger_slot(BUILDING_WIDTH, faction_height);
      }
    }

    faction_labels(BIRD_NAME, BIRD_NAME_LEN);
  }
}

bird_box();

/*lid_test_position(faction_height) {
  lid(BIRD_NAME, true);
}*/
