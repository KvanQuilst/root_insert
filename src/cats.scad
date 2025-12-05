/*
 * Root Box Inserts
 * Marquise de Cat
 * Project units: millimeters (mm)
 */

include <faction-common.scad>

CAT_WIDTH = 15.5;
CAT_HEIGHT = 21.6;
CAT_DEPTH = 8.6;
CAT_BUILDINGS = 19;
CAT_TOKENS = 9;

CAT_NAME = "Marquise de Cat";
CAT_TEXT_LEN = 60.0;

faction_height = faction_height_add(CAT_HEIGHT + PIECE_PAD);

module cat_box() {
  difference() {
    faction_base(CAT_HEIGHT);

    for (i = [0 : 3]) {
      num_warriors = i < 3 ? 7 : 4;
      faction_front_translate(CAT_WIDTH, i) {
        translate([(FACTION_WIDTH - slot_length(CAT_DEPTH, num_warriors)) / 2,
                   0,
                   faction_height - CAT_HEIGHT - PIECE_PAD]) {
          warrior_slot(CAT_WIDTH, CAT_HEIGHT, CAT_DEPTH, num_warriors);
        }
        
        faction_warrior_finger_translate(CAT_WIDTH) {
          finger_slot(CAT_WIDTH, faction_height);
        }
      }
    }

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

    /*faction_text_transform(CAT_TEXT_LEN, "l") {
      text_emboss(CAT_NAME);
    }

    faction_text_transform(CAT_TEXT_LEN, "r") {
      text_emboss(CAT_NAME);
    }*/
  }
}

cat_box();

/*lid_test_position(faction_height) {
  lid(CAT_NAME, true);
}*/
