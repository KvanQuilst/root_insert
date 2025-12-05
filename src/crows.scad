/*
 * Root Box Inserts
 * Corvid Conspiracy
 * Project units: millimeters (mm)
 */

include <faction-common.scad>

CROW_WIDTH = 17.5;
CROW_HEIGHT = 19.1;
CROW_DEPTH = 9.3;

CROW_WARRIORS = 15;
CROW_BUILDINGS = 1;
CROW_TOKENS = 12;

CROW_NAME = "Corvid Conspiracy";
CROW_TEXT_LEN = 60.0;

faction_height = faction_height_add(CROW_HEIGHT + PIECE_PAD);

module crow_box() {
  difference() {
    faction_base(CROW_HEIGHT);

    faction_warrior_slots(5, 3, CROW_WARRIORS,
                          CROW_WIDTH, CROW_HEIGHT, CROW_DEPTH);

    /* Row 4 */
    faction_back_translate()
    translate([0, -FACTION_BEZEL, 0]) {
      faction_building_slot_translate(faction_height) {
        building_slot(CROW_BUILDINGS, faction_height);
      }

      faction_token_slot_translate(faction_height) {
        token_slot(CROW_TOKENS, faction_height);
      }

      faction_cardboard_finger_translate(faction_height) {
        finger_slot(BUILDING_WIDTH, faction_height);
      }
    }

    /*faction_text_transform(CROW_TEXT_LEN, "l") {
      text_emboss(CROW_NAME);
    }

    faction_text_transform(CROW_TEXT_LEN, "r") {
      text_emboss(CROW_NAME);
    }*/
  }
}

crow_box();

/*lid_test_position(faction_height) {
  lid(CROW_NAME, true);
}*/
