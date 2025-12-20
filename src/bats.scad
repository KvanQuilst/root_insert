/*
 * Root Box Inserts
 * Twilight Council
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

BAT_WIDTH = 15.5;
BAT_HEIGHT = 28.0;
BAT_DEPTH = 8.5;

BAT_WARRIORS = 20;
BAT_BUILDINGS = 1;
BAT_TOKENS = 6;

BAT_NAME = "Twilight Council";
BAT_NAME_LEN = 60.0;

faction_height = faction_height_add(BAT_HEIGHT + PIECE_PAD);

module bat_box() {
  pad = ((FACTION_LEN - FACTION_BEZEL) / 4) - BAT_WIDTH;

  difference() {
    faction_base(BAT_HEIGHT);

    faction_warrior_slots(7, 3, BAT_WARRIORS,
                          BAT_WIDTH, BAT_HEIGHT, BAT_DEPTH, pad);

    /* Row 4 */
    faction_back_translate() {
      faction_building_slot_translate(faction_height) {
        building_slot(BAT_BUILDINGS, faction_height);
      }

      faction_token_slot_translate(faction_height) {
        token_slot(BAT_TOKENS, faction_height);
      }

      faction_cardboard_finger_translate(faction_height) {
        finger_slot(BUILDING_WIDTH, faction_height);
      }
    }

    /*faction_labels(BAT_NAME, BAT_NAME_LEN);*/
  }
}

bat_box();

/*lid_test_position(faction_height) {
  lid(BAD_NAME, true);
}*/
