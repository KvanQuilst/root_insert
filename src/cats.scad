/*
 * Root Box Inserts
 * Marquise de Cat
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

CAT_WIDTH = 15.5;
CAT_HEIGHT = 21.6;
CAT_DEPTH = 8.6;

CAT_WARRIORS = 25;
CAT_BUILDINGS = 19;
CAT_TOKENS = 9;

CAT_NAME = "Marquise de Cat";
CAT_NAME_LEN = 60.0;

faction_height = faction_height_add(CAT_HEIGHT + PIECE_PAD);

module cat_box() {
  difference() {
    faction_base(CAT_HEIGHT);

    faction_warrior_slots(7, 4, CAT_WARRIORS,
                          CAT_WIDTH, CAT_HEIGHT, CAT_DEPTH);

    /* Row 5 */
    faction_back_translate() {
      faction_building_slot_translate(faction_height) {
        building_slot(CAT_BUILDINGS, faction_height);
      }

      faction_token_slot_translate(faction_height) {
        token_slot(CAT_TOKENS, faction_height);
      }

      faction_cardboard_finger_translate(faction_height) {
        finger_slot(BUILDING_WIDTH, faction_height);
      }
    }

    /*faction_labels(CAT_NAME, CAT_NAME_LEN);*/
  }
}

cat_box();

/*lid_test_position(faction_height) {
  lid(CAT_NAME, true);
}*/
