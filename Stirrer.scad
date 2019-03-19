$fn=150;
motorDist=35;

/*
rotate([180,0,0])translate([0,0,1])difference(){
  translate([0,0,10.5+1.1])
    mainskif();
  lager();
}
*/

//purk();

// upper plate
upperPlate();

// outer box
outerBox();

//box


difference(){
  box();
  translate([0,0,1]){
    lager();
    translate([motorDist,0,0])motor();
  }
  cylinder(d=12.4,h=20);
  translate([motorDist-4,10,6])cube([3,10,10],true);
}




translate([0,0,1]){
  lager();
  translate([0,0,10.5+1.1])mainskif();
  translate([motorDist,0,0])motor();
}


module box(){
  translate([motorDist,0,0])cylinder(d=30,h=10,$fn=$fn/2);
  cylinder(d=20,h=10,$fn=$fn/2);

  difference(){
    union(){
      base_round();
      hull(){
        translate([motorDist,0,0])cylinder(d=30,h=6,$fn=$fn/2);
        cylinder(d=20,h=6,$fn=$fn/2);
      }
    }
    translate([0,0,1.5])hull(){
      translate([motorDist,0,0])cylinder(d=27,h=10,$fn=$fn/2);
      cylinder(d=17,h=10,$fn=$fn/2);
    }
  }
}

module outerBox(){
  difference(){
    union(){
      translate([0,0,-3]){
        difference(){
          union(){
            cylinder(d=88,h=26);
            translate([motorDist,0,0])cylinder(d=38,h=26);
          }
          translate([0,0,1.5]){
            cylinder(d=84,h=26);
            translate([motorDist,0,0])cylinder(d=34,h=26);
          }
          translate([0,0,24.5]){
            cylinder(d=86,h=3);
            translate([motorDist,0,0])cylinder(d=36,h=3);
          }
          //cube([100,100,100]);
        }
        
      }
      translate([-42.8,0,8])cube([2.4,10,10],true);
    }
    translate([-42.8,0,8])rotate([0,90,0])cylinder(d=3,h=10,center=true,$fn=20);
  }
}

module upperPlate(){
  difference(){
    translate([0,0,24.5-3]){
      cylinder(d=86-0.2,h=2.5);
      translate([motorDist,0,0])cylinder(d=36-0.2,h=2.5);
      translate([0,0,1.6]){
        cylinder(d=88,h=1);
        translate([motorDist,0,0])cylinder(d=38,h=1);
      }
    }
    cylinder(d=51,h=50);
    translate([0,0,24.5-3])cylinder(d1=60,d2=50,h=2.5);
  }
}

module base_round(){
    translate([0,0,0])cylinder(d=80,h=1);
  for(i=[0:45:330]){
    rotate([0,0,i])hull(){
      translate([-1,0,0])cube([2,1,6]);
      translate([-1,38,0])cube([2,1,1.5]);
    }
  }
}

module motor(){
  color("lightgrey"){
    cylinder(d=26.75+0.2,h=10.5,$fn=$fn/2);
    cylinder(d=5,h=10.5+1,$fn=$fn/4);
    cylinder(d=1,h=10.5+3.5,$fn=$fn/4);
  } 
    
  translate([0,0,10.5+1.1])color("white"){
    cylinder(d=7,h=0.1,$fn=$fn/4);
    cylinder(d1=6,d2=4,h=1.2,$fn=$fn/4);
    translate([0,0,1.2])cylinder(d1=4,d2=6,h=1.2,$fn=$fn/4);
    translate([0,0,1.2+1.2])cylinder(d=7,h=0.1,$fn=$fn/4);
  }
  
}

module lager(){
  color("LightGrey"){
    cylinder(d=5+0.15,h=20,$fn=$fn/2);
    translate([0,0,-1])cylinder(d=13.1+0.2,h=3.5,$fn=$fn/2);
    translate([0,0,6])cylinder(d=13.1+0.2,h=3,$fn=$fn/2);

    translate([0,0,-1.4])cylinder(d1=14.5,d2=13,h=1,$fn=$fn/2); // for better printing
  }
}


module mainskif(){
  color("darkgrey"){
    difference(){
      union(){
        translate([0,0,-2.5])cylinder(d1=8,d2=14,h=3,$fn=30);
        translate([0,0,-0.4])cylinder(d1=31.5,d2=30,h=0.4);
        translate([0,0,-0.8])cylinder(d=31.5,h=0.4);
        cylinder(d1=30,d2=28,h=1.2);
        translate([0,0,1.2])cylinder(d1=28,d2=30,h=1.2);
        translate([0,0,1.2+1.2])cylinder(d=32,h=0.4);
        translate([0,0,1.2+1.2+0.4])cylinder(d1=32,d2=52,h=1);
        translate([0,0,2.4+1.4])cylinder(d=52,h=4);
      }
      translate([0,0,2.4+5])cylinder(d1=5,d2=8,h=1,$fn=$fn/2);

      translate([34/2,0,5])cylinder(d=15,h=5,$fn=$fn/2);
      translate([-34/2,0,5])cylinder(d=15,h=5,$fn=$fn/2);
      translate([0,29/2,5])cylinder(d=19.8,h=5,$fn=$fn/2);
      translate([0,-29/2,5])cylinder(d=19.8,h=5,$fn=$fn/2);

      translate([34/2,0,7.3])cylinder(d1=15,d2=17,h=1,$fn=$fn/2);
      translate([-34/2,0,7.3])cylinder(d=15,d2=17,h=1,$fn=$fn/2);
      translate([0,29/2,7.3])cylinder(d=19.8,d2=22,h=1,$fn=$fn/2);
      translate([0,-29/2,7.3])cylinder(d=19.8,d2=22,h=1,$fn=$fn/2);
      
      translate([0,-29/2,5.5]){
        hull(){
          cube([20,5,1],true);
          translate([0,0,3])cube([30,5,1],true);
        }
      }
      translate([0,29/2,5.5]){
        hull(){
          cube([20,5,1],true);
          translate([0,0,3])cube([30,5,1],true);
        }
      }
    }
  }
}

module purk(){
translate([0,0,24])cylinder(d1=70,d2=80,h=10);
translate([0,0,34])cylinder(d=80,h=80);
}