/*
 * Root Box Inserts
 * Project units: millimeters (mm)
 * Common Modules and Functions
 */

FACTION_WIDTH = 70.0;
FACTION_LEN = 97.5;
FACTION_BEZEL = 2.5;
FACTION_HEIGHT_PAD = 1.5;

LID_WIDTH = FACTION_WIDTH - ((FACTION_BEZEL - 0.5) * 2);
LID_LEN = FACTION_LEN - 2.0;
LID_SLOT_PAD = 3.5;
LID_DEPTH = 2.3;
LID_BEZEL = 5.0;
LID_TEXT_LEN = LID_WIDTH - (LID_BEZEL * 2);

LID_TAB_WIDTH = LID_WIDTH / 4;
LID_TAB_LEN = 10.0;
LID_TAB_DEPTH = 1.5;

LID_HEX_RAD = 2.0;
LID_HEX_PAD = 0.6;

NIB_WIDTH = LID_WIDTH / 4;
NIB_DEPTH = 1.5;

FINGER_WIDTH = 14.0;
FINGER_HEIGHT = 11.0;

PIECE_PAD = 0.5;

TEXT_HEIGHT = 4.0;
TEXT_SIZE = 8.0;
TEXT_DEPTH = 1.0;

BUILDING_WIDTH = 18.1;
TOKEN_WIDTH = 19.3;
CARDBOARD_DEPTH = 1.9;

function slot_width(piece_width) =
  piece_width + PIECE_PAD;

function slot_length(piece_depth, num_pieces) =
  (piece_depth + 0.1) * num_pieces;

function faction_height_add(warrior_height) =
  FACTION_HEIGHT_PAD + warrior_height;

module faction_base(warrior_height) {
  lid_width = LID_WIDTH + 0.1;
  lid_len = LID_LEN + 0.1;
  lid_depth = LID_TAB_LEN + 0.1;

  difference() {
    cube(size = [FACTION_WIDTH, FACTION_LEN, faction_height + LID_DEPTH + PIECE_PAD/*+ LID_SLOT_PAD*/],
         center = false);

    translate([(FACTION_WIDTH - lid_width) / 2, 0, faction_height + LID_DEPTH + PIECE_PAD])
    translate([lid_width / 2, 0, 0])
    rotate([0, 180, 0])
    resize([lid_width, lid_len, lid_depth])
    translate([-LID_WIDTH / 2, 0, 0]) {
      lid();
    }
  }
}

module faction_front_translate(width, row) {
  translate([0,
             FACTION_BEZEL + (row * (FACTION_BEZEL + slot_width(width))),
             0]) {
    children();
  }
}

module faction_warrior_finger_translate(width) {
  translate([0,
             (slot_width(width) - FINGER_WIDTH) / 2,
             faction_height - FINGER_HEIGHT]) {
    children();
  }
}

module faction_back_translate() {
  translate([0,
             FACTION_LEN - FACTION_BEZEL,
             0]) {
    children();
  }
}

module faction_building_slot_translate(faction_height) {
  translate([FACTION_BEZEL,
             -slot_width(BUILDING_WIDTH),
             faction_height - slot_width(BUILDING_WIDTH)]) {
    children();
  }
}

module faction_token_slot_translate(faction_height) {
  translate([FACTION_WIDTH - FACTION_BEZEL,
             -slot_width(TOKEN_WIDTH),
             faction_height - slot_width(TOKEN_WIDTH)]) 
  mirror([1, 0, 0]) {
    children();
  }
}

module faction_cardboard_finger_translate(faction_height) {
  translate([0,
             (slot_width(BUILDING_WIDTH) - FINGER_WIDTH) / 2 - slot_width(BUILDING_WIDTH),
             faction_height - FINGER_HEIGHT]) {
    children();
  }
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

module hexagon(radius) {
  translate([radius, radius, 0]) {
    circle(r = radius, $fn = 6);
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

module lid(t = "", hexagons = false) {
  lid_len = LID_LEN - (t == "" ? 0 : TEXT_SIZE);
  hex_space = (LID_HEX_RAD * 3) + LID_HEX_PAD;
  num_hex = floor((LID_WIDTH - (2 * LID_BEZEL)) / hex_space);
  hex_rows = floor((lid_len - (2 * LID_BEZEL)) / (hex_space / 2));
  hex_width = (num_hex * hex_space) - LID_HEX_PAD - LID_HEX_RAD;

  module nib(l = NIB_WIDTH) {
    resize([l, NIB_DEPTH, NIB_DEPTH]) {
      sphere(r = 2.0, $fn = 30);
    }
  }

  module tab() {
    union() {
      intersection() {
        cube([LID_TAB_WIDTH, LID_TAB_DEPTH, LID_TAB_LEN]);
        translate([LID_TAB_WIDTH / 2, 0, LID_TAB_LEN / 3])
        rotate([-90, 22.5, 0]) {
          cylinder(d = LID_TAB_WIDTH,
                   h = LID_TAB_DEPTH,
                   center = false,
                   $fn = 8);
        }
      }
      translate([LID_TAB_WIDTH / 2, LID_TAB_DEPTH, LID_TAB_LEN - 1.5]) {
        nib(NIB_WIDTH / 2);
      }
    }
  }

  difference() {
    union() {
      cube(size = [LID_WIDTH, LID_LEN, LID_DEPTH],
           center = false);

      /* Hinge Nibs */
      translate([0 , LID_LEN, LID_DEPTH / 2]) {
        translate([LID_WIDTH / 4, 0, 0])
          nib();
        translate([(3 * LID_WIDTH) / 4, 0, 0])
          nib();
      }

      /* Latch */
      translate([(LID_WIDTH - LID_TAB_WIDTH) / 2, 0, 0]) {
        tab();
      }
    }
  
    /* Hexagons */
    if (hexagons) {
      for (i = [0 : hex_rows - 1],
           j = [0 : num_hex - (i % 2) - 1]) {
        linear_extrude(height = LID_DEPTH)
        translate([((LID_WIDTH - hex_width) / 2) + (j * hex_space) + ((i % 2) * hex_space / 2),
                   LID_LEN - LID_BEZEL - (i * hex_space / 2) - (LID_HEX_RAD * 2),
                   0]) {
          hexagon(LID_HEX_RAD);
        }
      }
    }
    
    if (t != "") {
      translate([(LID_WIDTH - LID_TEXT_LEN) / 2,
                 LID_BEZEL,
                 0])
      translate([LID_TEXT_LEN / 2, 0, 0])
      rotate([-90, 180, 0])
      translate([-LID_TEXT_LEN / 2, 0, 0])
      resize([LID_TEXT_LEN, TEXT_DEPTH, TEXT_SIZE]) {
          text_emboss(t);
      }
    }
  }
}

module lid_test_position(faction_height) {
  translate([0, 0, faction_height])
  translate([(FACTION_WIDTH - LID_WIDTH) / 2, 0, LID_DEPTH + PIECE_PAD])
  translate([LID_WIDTH / 2, 0, 0])
  rotate([0, 180, 0])
  translate([-LID_WIDTH / 2, 0, 0]) {
    children();
  }
}
