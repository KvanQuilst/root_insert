/*
 * Root Box Inserts
 * Keepers in Iron
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

BADGER_WIDTH = 21.1;
BADGER_HEIGHT = 23.9;
BADGER_DEPTH = 8.3;

BADGER_WARRIORS = 15;
BADGER_BUILDINGS = 4;
BADGER_TOKENS = 12;

BADGER_NAME = "Keepers in Iron";
BADGER_TEXT_LEN = 60;

faction_height = faction_height_add(BADGER_HEIGHT + PIECE_PAD);

module badger_box() {
  difference() {
    faction_base(BADGER_HEIGHT);

    faction_warrior_slots(6, 3, BADGER_WARRIORS,
                          BADGER_WIDTH, BADGER_HEIGHT, BADGER_DEPTH);

    /* Row 4 */
    faction_back_translate() {
      faction_building_slot_translate(faction_height) {
        building_slot(BADGER_BUILDINGS, faction_height);
      }

      faction_token_slot_translate(faction_height) {
        token_slot(BADGER_TOKENS, faction_height);
      }

      faction_cardboard_finger_translate(faction_height) {
        finger_slot(BUILDING_WIDTH, faction_height);
      }
    }

    faction_labels(BADGER_NAME, BADGER_TEXT_LEN);
  }
}

badger_box();

/*lid_text_position(faction_height0 {
  lid(BADGER_NAME, true);
}*/
