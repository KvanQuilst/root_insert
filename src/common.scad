/*
 * Root Box Inserts
 * Project units: millimeters (mm)
 * Common Modules and Functions
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

$fn = 30;

module rounded_square(width, height, radius) {
  module corner() {
    difference() {
      square(radius, false);
      translate([radius, radius, 0]) {
        circle(r = radius);
      }
    }
  }

  difference() {
    square([width, height], false);

    corner();

    translate([width, 0, 0])
    rotate([0, 0, 90]) {
      corner();
    }

    translate([width, height, 0])
    rotate([0, 0, 180]) {
      corner();
    }

    translate([0, height, 0])
    rotate([0, 0, 270]) {
      corner();
    }
  }
}

module rounded_cube(width, depth, height, radius) {
  linear_extrude(height = height, center = false) {
    rounded_square(width, depth, radius);
  }
}

module hexagon(radius) {
  translate([radius, radius, 0]) {
    circle(r = radius, $fn = 6);
  }
}

module text_emboss(t) {
  translate([0, TEXT_DEPTH, 0])
  rotate([90, 0, 0]) 
  linear_extrude(height = TEXT_DEPTH, center = false) {
    text(t, size = 9, font = "Luminari");
  }
}
