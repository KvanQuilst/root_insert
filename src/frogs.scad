/*
 * Root Box Inserts
 * Lilypad Diaspora
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

FROG_WIDTH = 19.0;
FROG_HEIGHT = 19.0;
FROG_DEPTH = 8.5;

FROG_WARRIORS = 20;
FROG_BUILDINGS = 1;
FROG_TOKENS = 12;

FROG_NAME = "Lilypad Diaspora";
FROG_NAME_LEN = 60.0;

faction_height = faction_height_add(FROG_HEIGHT + PIECE_PAD);

module frog_box() {
  difference() {
    faction_base(FROG_HEIGHT);

    faction_warrior_slots(7, 3, FROG_WARRIORS,
                          FROG_WIDTH, FROG_HEIGHT, FROG_DEPTH);

    /* Row 4 */
    faction_back_translate()
    translate([0, -FACTION_BEZEL, 0]) {
      faction_building_slot_translate(faction_height) {
        building_slot(FROG_BUILDINGS, faction_height);
      }

      faction_token_slot_translate(faction_height) {
        token_slot(FROG_TOKENS, faction_height);
      }

      faction_cardboard_finger_translate(faction_height) {
        finger_slot(BUILDING_WIDTH, faction_height);
      }
    }

    /*faction_labels(FROG_NAME, FROG_NAME_LEN);*/
  }
}

frog_box();

/*lid_test_position(faction_height) {
  lid(FROG_NAME, true);
}*/
