/*
 * Root Box Inserts
 * Corvid Conspiracy
 * Project units: millimeters (mm)
 */

include <common.scad>

CROW_WIDTH = 17.5;
CROW_HEIGHT = 19.1;
CROW_DEPTH = 9.3;

CROW_BUILDINGS = 1;
CROW_TOKENS = 12;

CROW_NAME = "Corvid Conspiracy";
CROW_TEXT_LEN = 60.0;

faction_height = faction_height_add(CROW_HEIGHT + PIECE_PAD);

module crow_box() {
  difference() {
    faction_base(CROW_HEIGHT);

    num_warriors = 5;
    for (i = [0 : 2]) {
      translate([0,
                 FACTION_BEZEL + (i * (FACTION_BEZEL + slot_width(CROW_WIDTH))),
                 0]) {
        translate([(FACTION_WIDTH - slot_length(CROW_DEPTH, num_warriors)) / 2,
                    0,
                    faction_height - CROW_HEIGHT - PIECE_PAD]) {
          warrior_slot(CROW_WIDTH, CROW_HEIGHT, CROW_DEPTH, num_warriors);
        }

        translate([0,
                   (slot_width(CROW_WIDTH) - FINGER_WIDTH) / 2,
                   faction_height - FINGER_HEIGHT]) {
          finger_slot(CROW_WIDTH, faction_height);
        }
      }
    }

    /* Row 4 */
    translate([0,
               FACTION_LEN - (FACTION_BEZEL * 2),
               0]) {
      translate([FACTION_BEZEL,
                 -slot_width(BUILDING_WIDTH),
                 faction_height - slot_width(BUILDING_WIDTH)]) {
        building_slot(CROW_BUILDINGS, faction_height);
      }

      translate([FACTION_WIDTH - FACTION_BEZEL,
                 -slot_width(TOKEN_WIDTH),
                 faction_height - slot_width(TOKEN_WIDTH)])
      mirror([1, 0, 0]) {
        token_slot(CROW_TOKENS, faction_height);
      }

      translate([0,
                 (slot_width(BUILDING_WIDTH) - FINGER_WIDTH) / 2 - slot_width(BUILDING_WIDTH),
                 faction_height - FINGER_HEIGHT]) {
        finger_slot(BUILDING_WIDTH, faction_height);
      }
    }

    faction_text_transform(CROW_TEXT_LEN, "l") {
      text_emboss(CROW_NAME);
    }

    faction_text_transform(CROW_TEXT_LEN, "r") {
      text_emboss(CROW_NAME);
    }
  }
}

crow_box();

lid_test_position(faction_height) {
  lid(CROW_NAME, true);
}
