//
// gCore POTS shield board
//

pcb_width = 69;
pcb_depth = 95;
pcb_thickness = 1.6;
pcb_mnt_inset = 2.5;

ag_width = 11;
ag_depth = 61;
ag_height = 12;

rj_width = 13;
rj_depth = 18;
rj_height = 12;

module gCore_pots_shield() {
    difference() {
        union() {
            cube([pcb_width, pcb_depth, pcb_thickness]);
            
            // AG1171 bounding box
            translate([pcb_width - 13.5 - ag_width, 2.6, pcb_thickness]) {
                cube([ag_width, ag_depth, ag_height]);
            }
            
            // 470 uF Cap
            translate([pcb_width - 32, 23, pcb_thickness]) {
                cylinder(h=10, r = 4, $fn=120);
            }
            
            // RJ11 connector
            translate([(pcb_width - rj_width)/2, 80, pcb_thickness]) {
                cube([rj_width, rj_depth, rj_height]);
            }
        }
        
        // Mounting holes
        translate([pcb_mnt_inset, pcb_mnt_inset, -1]) {
            cylinder(h=pcb_thickness + 2, r=1.4, $fn=120);
        }
        translate([pcb_width - pcb_mnt_inset, pcb_mnt_inset, -1]) {
            cylinder(h=pcb_thickness + 2, r=1.4, $fn=120);
        }
        translate([pcb_mnt_inset, pcb_depth - pcb_mnt_inset, -1]) {
            cylinder(h=pcb_thickness + 2, r=1.4, $fn=120);
        }
        translate([pcb_width - pcb_mnt_inset, pcb_depth - pcb_mnt_inset, -1]) {
            cylinder(h=pcb_thickness + 2, r=1.4, $fn=120);
        }
    }
}

gCore_pots_shield();