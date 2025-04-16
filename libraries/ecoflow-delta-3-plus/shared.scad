include <shared.scad>

// Approx. x 202 y 398 z 283.6 mm
ecoflow_stated_dims = [202, 398, 283.6]; // from ecoflow
// pizel total
// y 838 x z 598
// pixel main body
// y 738 x z 586

//main_boxy_y = 738/838 * 398; // 350.506
//main_body_z = 586/598 * 283.6; // 277.909

magnus_attachment_y = 100;

ecoflow_box_x = 202; // from ecoflow
ecoflow_box_y = 352; // laser measured
ecoflow_box_z = 279; // laser measured
ecoflow_dims = [ecoflow_box_x, ecoflow_box_y, ecoflow_box_z];

// foot
// 165 x
// 35 y
// feet
// 315 y
ecoflox_feet_x = 165; // ruler
ecoflow_feet_y = 35; // laser measured
ecoflow_feet_z = 283.6 - ecoflow_dims.z; // 4.6 mm;
ecoflow_feet = [ecoflox_feet_x, ecoflow_feet_y, ecoflow_feet_z];
ecoflow_feet_translate_y = 315 / 2; // laser measured 315
ecoflow_handles_y = 398; // from ecoflow

