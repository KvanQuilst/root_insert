/*
 * Root Box Inserts
 * Riverfolk Company
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

OTTER_WIDTH = 16.0;
OTTER_HEIGHT = 19.9;
OTTER_DEPTH = 8.1;

OTTER_WARRIORS = 15;
OTTER_BUILDINGS = 1;
OTTER_TOKENS = 9;

OTTER_NAME = "Riverfolk Company";
OTTER_TEXT_LEN = 60;

faction_height = faction_height_add(OTTER_HEIGHT + PIECE_PAD);

module rocks_slot() {
  union() {
    translate([FINGER_WIDTH / 2, 0, 0]) {
      translate([0, FINGER_WIDTH / 2, 0]) {
        cylinder(d = FINGER_WIDTH, h = faction_height, center = false);
      }
      cube(size = [25.0,
                   FINGER_WIDTH,
                   faction_height],
           center = false);
      translate([25.0, FINGER_WIDTH / 2, 0]) {
        cylinder(d = FINGER_WIDTH, h = faction_height, center = false);
      }
    }
  }
}

module otter_box() {
  pad = ((FACTION_LEN - FACTION_BEZEL) / 4) - OTTER_WIDTH;

  difference() {
    faction_base(OTTER_HEIGHT);

    faction_warrior_slots(5, 3, OTTER_WARRIORS,
                          OTTER_WIDTH, OTTER_HEIGHT, OTTER_DEPTH, pad);

    faction_back_translate()
    translate([0, -FACTION_BEZEL, 0]) {
      faction_building_slot_translate(faction_height) {
        building_slot(OTTER_BUILDINGS, faction_height);
      }

      faction_token_slot_translate(faction_height) {
        token_slot(OTTER_TOKENS, faction_height);
      }

      faction_cardboard_finger_translate(faction_height)
      translate([7.0, 0, 0]) {
        rocks_slot();
      }

      faction_cardboard_finger_translate(faction_height) {
        finger_slot(BUILDING_WIDTH, faction_height);
      }
    }

    /*faction_labels(OTTER_NAME, OTTER_TEXT_LEN);*/
  }
}

otter_box();

/*lid_test_position(faction_height) {
  lid(OTTER_NAME, true);
}*/
