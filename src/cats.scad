/*
 * Root Box Inserts
 * Marquise de Cat
 * Project units: millimeters (mm)
 */

include <common.scad>

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
      translate([0,
                 FACTION_BEZEL + (i * (FACTION_BEZEL + slot_width(CAT_WIDTH))),
                 0]) {
        if (i < 3) {
          translate([(FACTION_WIDTH - slot_length(CAT_DEPTH, 7)) / 2,
                     0,
                     faction_height - CAT_HEIGHT - PIECE_PAD]) {
            warrior_slot(CAT_WIDTH, CAT_HEIGHT, CAT_DEPTH, 7);
          }
        }
        else {
          translate([FACTION_BEZEL,
                     0,
                     faction_height - CAT_HEIGHT - PIECE_PAD]) {
            warrior_slot(CAT_WIDTH, CAT_HEIGHT, CAT_DEPTH, 4);
          }
        }
        
        translate([0,
                   (slot_width(CAT_WIDTH) - FINGER_WIDTH) / 2,
                   faction_height - FINGER_HEIGHT]) {
          finger_slot(CAT_WIDTH, faction_height);
        }
      }
                 
                 
    }

    /* Row 5 */
    translate([0,
               FACTION_LEN - FACTION_BEZEL,
               0]) {
      translate([FACTION_BEZEL,
                 -slot_width(BUILDING_WIDTH),
                 faction_height - slot_width(BUILDING_WIDTH)]) {
        building_slot(CAT_BUILDINGS, faction_height);
        
      }
      translate([0,
                 (slot_width(BUILDING_WIDTH) - FINGER_WIDTH) / 2 - slot_width(BUILDING_WIDTH),
                 faction_height - FINGER_HEIGHT]) {
        finger_slot(BUILDING_WIDTH, faction_height);
      }
  
      translate([FACTION_WIDTH - FACTION_BEZEL,
                 -slot_width(TOKEN_WIDTH),
                 faction_height - slot_width(TOKEN_WIDTH)])
      mirror([1, 0, 0]) {
        token_slot(CAT_TOKENS, faction_height);
      }
    }

    /*faction_text_transform(CAT_TEXT_LEN, "l") {
      text_emboss(CAT_NAME);
    }

    faction_text_transform(CAT_TEXT_LEN, "r") {
      text_emboss(CAT_NAME);
    }*/

    translate([1.0, 0, FACTION_HEIGHT_PAD + CAT_HEIGHT + PIECE_PAD]) {
      lid_cutout();
    }
  }
}

//cat_box();
lid(/*CAT_NAME*/);
