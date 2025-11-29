/*
 * Root Box Inserts
 * Project units: millimeters (mm)
 * Common Modules and Functions
 */

FACTION_WIDTH = 70.0;
FACTION_LEN = 95.5;
FACTION_BEZEL = 1.5;
FACTION_HEIGHT_PAD = 1.5;

LID_WIDTH = FACTION_WIDTH - 2.0;
LID_LEN = FACTION_LEN - 1.0;
LID_SLOT_PAD = 3.5;
LID_DEPTH = 2.3;
LID_BEZEL = 5.0;
LID_TEXT_LEN = LID_WIDTH - (LID_BEZEL * 2);

LID_HEX_RAD = 2.0;
LID_HEX_PAD = 0.6;

FINGER_WIDTH = 14.0;
FINGER_HEIGHT = 11.0;

PIECE_PAD = 0.5;

TEXT_HEIGHT = 4.0;
TEXT_SIZE = 8.0;
TEXT_DEPTH = 0.5;

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
  cube(size = [FACTION_WIDTH, FACTION_LEN, faction_height + LID_SLOT_PAD],
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

module lid_cutout() {
  union() {
      cube(size = [LID_WIDTH + 0.1, LID_LEN + 0.1, LID_DEPTH + 0.1],
           center = false);

    translate([FACTION_BEZEL - 1.0, 0, 0]) {
      cube(size = [FACTION_WIDTH - (2 * FACTION_BEZEL),
                   FACTION_LEN - FACTION_BEZEL,
                   LID_SLOT_PAD],
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
  

  difference() {
    cube(size = [LID_WIDTH, LID_LEN, LID_DEPTH],
         center = false);
  
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
                 LID_DEPTH])
      rotate([-90, 0, 0])
      resize([LID_TEXT_LEN, TEXT_DEPTH, TEXT_SIZE]) {
          text_emboss(t);
      }
    }
  }
}
