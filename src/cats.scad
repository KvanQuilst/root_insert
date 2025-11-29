/*
 * Root Box Inserts
 * Marquise de Cat
 * Project units: millimeters (mm)
 */

FACTION_WIDTH = 70.0;
FACTION_LEN = 95.5;
FACTION_BEZEL = 1.5;
FACTION_HEIGHT_PAD = 1.5;

FINGER_WIDTH = 14.0;
FINGER_HEIGHT = 11.0;

PIECE_PAD = 0.5;

TEXT_HEIGHT = 4.0;
TEXT_SIZE = 8.0;
TEXT_DEPTH = 0.5;

BUILDING_WIDTH = 18.1;
TOKEN_WIDTH = 19.3;
CARDBOARD_DEPTH = 1.9;

CAT_WIDTH = 15.5;
CAT_HEIGHT = 21.6;
CAT_DEPTH = 8.6;
CAT_BUILDINGS = 19;
CAT_TOKENS = 9;

CAT_TEXT_LEN = 60.0;

faction_height = FACTION_HEIGHT_PAD + CAT_HEIGHT;

function slot_width(piece_width) =
  piece_width + PIECE_PAD;

function slot_length(piece_depth, num_pieces) =
  (piece_depth + 0.1) * num_pieces;

module faction_base(warrior_height) {
  cube(size = [FACTION_WIDTH, FACTION_LEN, faction_height],
       center = false);
}

module finger_slot(piece_width, insert_height) {
  union() {
    translate([0, 0, FINGER_WIDTH / 2]) {
      translate([0, FINGER_WIDTH / 2, 0])
      rotate([0, 90, 0]) {
        cylinder(h = FACTION_WIDTH, d = FINGER_WIDTH, center = false);
      }

      cube(size = [FACTION_WIDTH,
                   FINGER_WIDTH,
                   insert_height],
           center = false);
    }
  }
}

module text_emboss(t) {
  translate([0, TEXT_DEPTH, 0])
  rotate([90, 0, 0]) 
  linear_extrude(height = TEXT_DEPTH, center = false) {
    text(t, size = 9, font = "Luminari");
  }
}

module faction_text_transform(text_len, pos) {
  if (pos == "r") {
    translate([FACTION_WIDTH,
               (FACTION_LEN - text_len) / 2,
               TEXT_HEIGHT])
    rotate([0, 0, 90])
    resize([text_len, TEXT_DEPTH, TEXT_SIZE]) {
      children();
    }
  }
  else if (pos == "l") {
    translate([0,
               (FACTION_LEN - text_len) / 2,
               TEXT_HEIGHT])
    translate([0, text_len / 2, 0])
    rotate([0, 0, -90])
    translate([-(text_len / 2), 0, 0])
    resize([text_len, TEXT_DEPTH, TEXT_SIZE]) {
      children();
    }
  }
}

module warrior_slot(warrior_width, warrior_height,
                    warrior_depth = 0, num_warriors = 0) {
  cube(size = [num_warriors * (warrior_depth + 0.2),
               slot_width(warrior_width),
               faction_height],
       center = false);
}

module building_slot(num_buildings, insert_height) {
  cube(size = [num_buildings * (CARDBOARD_DEPTH + 0.1),
               slot_width(BUILDING_WIDTH),
               insert_height]);
}

module token_slot(num_tokens, insert_height) {
  union() {
    translate([0, 0, slot_width(TOKEN_WIDTH) / 2]) {
      translate([0, slot_width(TOKEN_WIDTH) / 2, 0])
      rotate([0, 90, 0]) {
          cylinder(h = num_tokens * (CARDBOARD_DEPTH + 0.1),
                   d = slot_width(TOKEN_WIDTH),
                   center = false);
      }

      cube(size = [num_tokens * (CARDBOARD_DEPTH + 0.1),
                   slot_width(TOKEN_WIDTH),
                   insert_height],
           center = false);
    }
  }
}

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

    faction_text_transform(CAT_TEXT_LEN, "l") {
      text_emboss("Marquise de Cat");
    }

    /*faction_text_transform(CAT_TEXT_LEN, "r") {
      text_emboss("Marquise de Cat");
    }*/
  }
}

cat_box();
