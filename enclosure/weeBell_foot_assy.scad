//
// Foot assembly for weeBell enclosure
//
// Copyright 2023 (c) Dan Julio
//
// Apologies as I'm not a mechanical engineer and this is a bit of a
// hack...  But it gets the job done.
//
// Dimensions are mm.
//
// Version 1.0 - Initial release
//
// standalone_enclosure is free software: you can redistribute it and/or
// modify by it under the terms of the GNU General Public License as
// published the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// standalone_enclosure is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with standalone_enclosure.  If not, see <https://www.gnu.org/licenses/>.
//

// Dimensions
foot_mnt_plate_width = 74;
foot_mnt_plate_thickness = 2;
foot_width = 9;
foot_depth = 10;
foot_height = 22.5;
foot_wall_thickness = 2;
foot_support_width = 6.1;
foot_support_thickness = 1;
foot_mnt_hole_distance = 50;
foot_mnt_hole_diameter = 2.8;


// Foot
module foot() {
    difference() {
        union() {
            cube([foot_width, foot_depth, foot_height - (foot_depth / 2)]);
    
            translate([0, foot_depth/2, foot_height - (foot_depth / 2)]) {
                rotate([0, 90, 0]) {
                    cylinder(h = foot_width, d = foot_depth, $fn = 120);
                }
            }
        }
        
        // hollow inside
        translate([foot_wall_thickness, foot_wall_thickness, foot_wall_thickness]) {
            cube([foot_width - 2*foot_wall_thickness, foot_depth - 2*foot_wall_thickness, foot_height - (foot_depth / 2) - foot_wall_thickness]);
        }
    }
}


// Support triangle
module support_triangle() {    
    difference() {
        cube([foot_support_width, foot_support_thickness, foot_support_width]);
        
        translate([foot_support_width, 0, 0]) {
            rotate([0, -45, 0]) {
                translate([0, -0.1, -0.1]) {
                    cube([foot_support_width, foot_support_thickness + 0.2, 2*foot_support_width]);
                }
            }
        }
    }
}


// Foot Assembly
difference() {
    union() {
        // Mounting plate
        cube([foot_mnt_plate_width, foot_depth, foot_mnt_plate_thickness]);
        
        // Feet
        foot();
        
        translate([foot_mnt_plate_width - foot_width, 0, 0]) {
            foot();
        }
        
        // Supports
        translate([foot_width, 0, foot_mnt_plate_thickness]) {
            support_triangle();
        }
        
        translate([foot_width, foot_depth - foot_support_thickness, foot_mnt_plate_thickness]) {
            support_triangle();
        }
        
        translate([foot_mnt_plate_width - foot_width, foot_support_thickness, foot_mnt_plate_thickness]) {
            rotate([0, 0, 180]) {
                support_triangle();
            }
        }
        
        translate([foot_mnt_plate_width - foot_width, foot_depth, foot_mnt_plate_thickness]) {
            rotate([0, 0, 180]) {
                support_triangle();
            }
        }
    }
    
    // Foot mounting holes
    translate([(foot_mnt_plate_width - foot_mnt_hole_distance)/2, foot_depth/2, -1]) {
        cylinder(h = foot_depth + 2, r = foot_mnt_hole_diameter/2, $fn= 120);
    }
    
     translate([(foot_mnt_plate_width + foot_mnt_hole_distance)/2, foot_depth/2, -1]) {
        cylinder(h = foot_depth + 2, r = foot_mnt_hole_diameter/2, $fn= 120);
    }
}

