/*
 * Root Box Inserts
 * Underground Duchy
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

MOLE_WIDTH = 19.4;
MOLE_HEIGHT = 19.0;
MOLE_DEPTH = 8.7;

CROWN_WIDTH = 10.8;
CROWN_HEIGHT = 14.5;
CROWN_DEPTH = 9.0;

BURROW_WIDTH = 59.0;

MOLE_WARRIORS = 20;
MOLE_BUILDINGS = 7;
MOLE_TOKENS = 3;
MOLE_CROWNS = 9;

MOLE_NAME = "Underground Duchy";
MOLE_NAME_LEN = 60.0;

faction_height = faction_height_add(MOLE_HEIGHT + CARDBOARD_DEPTH + PIECE_PAD);

module crown_slot(num_crowns) {
  cube(size = [num_crowns * (CROWN_DEPTH + 0.1),
               slot_width(CROWN_WIDTH),
               faction_height],
       center = false);
}

module burrow() {
  cylinder(d =  BURROW_WIDTH + PIECE_PAD,
           h = CARDBOARD_DEPTH + PIECE_PAD,
           center = false);
}

module mole_box() {
  difference() {
    faction_base(MOLE_HEIGHT + CARDBOARD_DEPTH);

    faction_warrior_slots(7, 2, MOLE_WARRIORS,
                          MOLE_WIDTH, MOLE_HEIGHT + CARDBOARD_DEPTH, MOLE_DEPTH);

    /* Row 3 */
    faction_front_translate(MOLE_WIDTH, 2) {
      translate([FACTION_BEZEL,
                 0,
                 faction_height - CARDBOARD_DEPTH - MOLE_HEIGHT - PIECE_PAD]) {
        warrior_slot(MOLE_WIDTH, MOLE_HEIGHT, MOLE_DEPTH, 6);
      }

      translate([FACTION_WIDTH - FACTION_BEZEL,
                 0,
                 faction_height - slot_width(TOKEN_WIDTH)])
      mirror([1, 0, 0]) {
        token_slot(MOLE_TOKENS, faction_height);
      }

      faction_warrior_finger_translate(MOLE_WIDTH) {
        finger_slot(MOLE_WIDTH, faction_height);
      }
    }

    /* Row 4 */
    faction_back_translate()
    translate([0, -FACTION_BEZEL, 0]) {
      translate([FACTION_WIDTH - FACTION_BEZEL,
                 -slot_width(BUILDING_WIDTH),
                 faction_height - slot_width(BUILDING_WIDTH)])
      mirror([1, 0, 0]) {
        building_slot(MOLE_BUILDINGS, faction_height);
      }

      translate([FACTION_BEZEL, -slot_width(CROWN_WIDTH) + FACTION_BEZEL, faction_height - CROWN_HEIGHT - PIECE_PAD]) {
        crown_slot(5);
      }
      translate([FACTION_BEZEL, -(slot_width(CROWN_WIDTH) + FACTION_BEZEL / 4) * 2, faction_height - CROWN_HEIGHT - PIECE_PAD]) {
        crown_slot(4);
      }

      faction_cardboard_finger_translate(faction_height) {
        finger_slot((CROWN_WIDTH * 2) + (FACTION_BEZEL / 4), faction_height);
      }
    }

    /* Burrow */
    translate([FACTION_WIDTH / 2 - 2.0,
               BURROW_WIDTH / 2 + FACTION_BEZEL * 2,
               faction_height - CARDBOARD_DEPTH]) {
      burrow();
    }

    faction_labels(MOLE_NAME, MOLE_NAME_LEN);
  }
}

mole_box();

/*lid_test_position(faction_height) {
  lid(MOLE_NAME, true);
}*/
