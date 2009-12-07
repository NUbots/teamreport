#include "colors.inc" // The include files contain
//#include "stones.inc" // pre-defined scene elements    


background { color White }
global_settings { ambient_light colour White }
//camera {
//	location <0, 0, 6000>    
//        look_at <0, 0, 1000>
//}     

                                                               
#declare grassGreen = colour rgb <0.0, 0.3, 0>;                                                                
#declare grass = pigment { grassGreen }  
#declare BeaconBlue = rgb <0.07, 0.58, 0.95>; 
#declare BeaconPink = rgb <0.86, 0.13, 0.75>;
#declare BallOrange = rgb <1, 0.39, 0.1>;
#declare grassBase = -5;
#declare GoalDepth = 300;
#declare GoalWidth = 800;
#declare GoalHeight = 300;
#declare GoalWoodThickness = 6;
#declare HGoalWidth = GoalWidth/2;                         
#declare FieldLength = 6000;
#declare FieldWidth = 4000;
#declare HFieldLength = FieldLength/2;
#declare HFieldWidth = FieldWidth/2;
#declare BeaconBaseHeight = 200;
#declare BeaconColHeight = 100;
#declare BeaconRadius = 50;          
#declare BeaconCentreOffset = HFieldLength/2;     
#declare BeaconSideOffset = HFieldWidth-BeaconRadius;
#declare BeaconPostTexture = pigment { colour White }
#declare LightHeight = 3500;
#declare LineHeight = 0.1;  // 0.1mm == essentially 0
#declare LineWidth = 25;
#declare LineTexture = pigment { colour White }
#declare PenaltyBoxWidth = 1300;
#declare HPenaltyBoxWidth = PenaltyBoxWidth/2;
#declare PenaltyBoxDepth = 650;
#declare CentreCircleRadius = 190;
#declare EdgeBoundaryInset = 200;
#declare BoundaryHeight = 10;
#declare BoundaryWidth = 10;
#declare BoundaryTexture = pigment { colour White }
#declare BOYMarkRadius = 12.5;
#declare BOYMarkEdgeOffset = HFieldWidth/4;
#declare BOYMarkEndOffset = PenaltyBoxDepth*2;
#declare BOYTexture = pigment { colour Red } 
#declare RoofHeight = 5000;
                          
#declare cameraAboveField = camera {
  location <0,0,RoofHeight>
  up    <0,1,0>
  right  <-1.33,0,0>  
  look_at <0,0,0>
 }
 
 
#declare cameraTowardsYellowGoal = camera {          
  location <1500,0,1000>         
  sky       <1.0, 0,  0.0>        // direction of the camera "sky"
  look_at <-4000,0,10> 
  right     x*image_width/image_height         
 }          
 
#declare cameraAwayYellowGoal = camera {          
  location <-4500,0,500>        
  sky       <1.0, 0,  0.0>        // direction of the camera "sky"
  look_at <-1000,0,10> 
  right     x*image_width/image_height         
 }          
  
 
#declare cameraDiagonalYellowGoal = camera {          
  location <-1500,1500,600>
  sky       <0, 0,  1>        // direction of the camera "sky"
  look_at <-HFieldLength-1000,-HFieldWidth,10> 
  right     x*image_width/image_height         
 } 
 
   
#declare aboveYellowGoal = camera {          
  location <-FieldLength/2+GoalDepth/2,0,2500>
  sky       <0, 0,  1>        // direction of the camera "sky"
  look_at <-FieldLength/2+GoalDepth/2,0,10> 
  right     x*image_width/image_height         
 }       
 
 
#declare sideYellowGoal = camera {          
  location <-FieldLength/2+GoalDepth/2,1500,600>
  sky       <0, 0,  1>        // direction of the camera "sky"
  look_at <-FieldLength/2+GoalDepth/2,0,10> 
  right     x*image_width/image_height         
 }
 
 #declare cameraTest = camera {          
  location <-7000,3000,4000>
  sky       <0, 0,  1>        // direction of the camera "sky"
  look_at <HFieldLength,-HFieldWidth,10> 
  right     x*image_width/image_height         
 }  

camera {  cameraAboveField }     

// An area light (creates soft shadows)
// WARNING: This special light can significantly slow down rendering times!
  
light_source { <-HFieldLength-100, HFieldWidth+100, LightHeight> color White}
light_source { <HFieldLength+100, HFieldWidth+100, LightHeight> color White}
light_source { <-HFieldLength-100, -HFieldWidth-100, LightHeight> color White}
light_source { <HFieldLength+100, -HFieldWidth-100, LightHeight> color White}       


                                                                                     
#macro OrangeBall(X,Y)
        sphere { 
        <X, Y, 40>, 40 
        texture { pigment { colour BallOrange } }
        }        
#end     

#macro PinkBall(X,Y)
        sphere { 
        <X, Y, 30>, 30 
        texture { pigment { colour BeaconPink } }
        }        
#end    
        
#macro Beacon(X,Y,Top,Bottom)
merge {
	cylinder {	// white post
		<X, Y, 0>,
		<X, Y, BeaconBaseHeight>,
		BeaconRadius
		texture { BeaconPostTexture }
	}
	cylinder {	// bottom patch
		<X, Y, BeaconBaseHeight>,
		<X, Y, BeaconBaseHeight+BeaconColHeight>,
		BeaconRadius
		open
		texture { pigment { colour Top } }
	}
	cylinder {	// top patch
		<X, Y, BeaconBaseHeight+BeaconColHeight>,
		<X, Y, BeaconBaseHeight+2*BeaconColHeight>,
		BeaconRadius
		open
		texture { pigment { colour Bottom } }
	}
	cylinder {	// the cap
		<X, Y, BeaconBaseHeight+2*BeaconColHeight>,
		<X, Y, BeaconBaseHeight+2*BeaconColHeight+LineHeight>,
		BeaconRadius
		texture { BeaconPostTexture }
	}
}
#end
#macro Goal(Col,Trans)
merge {                   


	box {	// Back wall
		<-GoalDepth-GoalWoodThickness, -HGoalWidth, 0>,
		<-GoalDepth, HGoalWidth, GoalHeight>
		texture { pigment { colour Col } }
	}
	box {	// Inside side
		<-GoalDepth-GoalWoodThickness, -HGoalWidth, 0>,
		<0, -HGoalWidth-1, GoalHeight>
		texture { pigment { colour Col } }
	}                               
        box {	// side
		<-GoalDepth-GoalWoodThickness, -HGoalWidth-1, 0>,
		<0, -HGoalWidth-1-GoalWoodThickness, GoalHeight>
		texture { pigment { colour White } }
	}
	box {	// Inside side
		<-GoalDepth-GoalWoodThickness, HGoalWidth, 0>,
		<0, HGoalWidth+1, GoalHeight>
		texture { pigment { colour Col } }
	}                                                     
	box {	// side
		<-GoalDepth-GoalWoodThickness, HGoalWidth+1, 0>,
		<0, HGoalWidth+1+GoalWoodThickness, GoalHeight>
		texture { pigment { colour White } }
	}
	box {	// grass
		<-GoalDepth, -HGoalWidth, grassBase>,
		<0, HGoalWidth, 0>
		texture { grass }
	}
	transform Trans
}
#end

#declare GoalPostRadius = 50;
#declare CrossbarRadius = 25;
#declare RearGoalHeight = 100;
#macro NewGoal(Col,Trans)
merge {                   
	box {	// Back wall
		<-GoalDepth-GoalWoodThickness, -HGoalWidth, 0>,
		<-GoalDepth, HGoalWidth, RearGoalHeight>
		texture { pigment { colour Col } }
	}
	box {	// Inside side
		<-GoalDepth-GoalWoodThickness, -HGoalWidth, 0>,
		<0, -HGoalWidth-1, RearGoalHeight>
		texture { pigment { colour Col } }
	}                               
        box {	// side
		<-GoalDepth-GoalWoodThickness, -HGoalWidth-1, 0>,
		<0, -HGoalWidth-1-GoalWoodThickness, RearGoalHeight>
		texture { pigment { colour White } }
	}
	box {	// Inside side
		<-GoalDepth-GoalWoodThickness, HGoalWidth, 0>,
		<0, HGoalWidth+1, RearGoalHeight>
		texture { pigment { colour Col } }
	}                                                     
	box {	// side
		<-GoalDepth-GoalWoodThickness, HGoalWidth+1, 0>,
		<0, HGoalWidth+1+GoalWoodThickness, RearGoalHeight>
		texture { pigment { colour White } }
	}           
	cylinder {	// right post
		<-GoalPostRadius+1, HGoalWidth-1, 0>,
		<-GoalPostRadius+1, HGoalWidth-1, GoalHeight+50>,
		GoalPostRadius
		texture { pigment { colour Col } }
	}                  
	cylinder {	// left post
		<-GoalPostRadius+1, -HGoalWidth+1, 0>,
		<-GoalPostRadius+1, -HGoalWidth+1, GoalHeight+50>,
		GoalPostRadius
		texture { pigment { colour Col } }
	}                          
//	box {	// crossbar
//		<-GoalPostRadius+1, HGoalWidth+1, GoalHeight-RearGoalHeight/2>,
//		<-GoalPostRadius+1, -HGoalWidth-1, GoalHeight+RearGoalHeight/2>
//		texture { pigment { colour Col } }
//	}
	cylinder {	// crossbar
		<-GoalPostRadius, HGoalWidth+GoalPostRadius, GoalHeight+GoalPostRadius/2>,
		<-GoalPostRadius, -HGoalWidth-GoalPostRadius, GoalHeight+GoalPostRadius/2>,
		CrossbarRadius
		texture { pigment { colour Col } }
        }
 
	box {	// grass
		<-GoalDepth, -HGoalWidth, grassBase>,
		<0, HGoalWidth, 0>
		texture { grass }
	}
	transform Trans
}
#end

#macro GoalLines(Trans)
	merge {
		difference {	// define the main 'box' part as the outer rect with an inner rect removed from it
			box {
				<0, -(HPenaltyBoxWidth+LineWidth), 0>,
				<PenaltyBoxDepth+LineWidth, HPenaltyBoxWidth+LineWidth, LineHeight>
			}
			box {
				<0, -HPenaltyBoxWidth, -LineHeight>,
				<PenaltyBoxDepth, HPenaltyBoxWidth, 2*LineHeight>
			}
			texture { LineTexture }
		}
		box {	// the line across the goal mouth
			<-LineWidth, -HGoalWidth, 0>,
			<0, HGoalWidth, LineHeight>
			texture { LineTexture }
		}
		transform Trans
	}
#end         
// field
	box {
		<-HFieldLength, -HFieldWidth, grassBase>,
		<HFieldLength, HFieldWidth, 0>
		texture { grass }
	}
#declare goalATrans = transform {
	rotate <0, 0, 180>
	translate <HFieldLength-GoalDepth, 0, 0>
}
#declare goalBTrans = transform {
	translate <-(HFieldLength-GoalDepth), 0, 0>
}       
    
   
#macro DRobot(X,Y)
        box {	// Inside side
        <(-X*10)-20, (Y*10)-50, 0>,
        <(-X*10)+180, (Y*10)+50, 100>
        texture { pigment { colour Blue } }
        }   
#end    
#macro ORobot(X,Y,angl)
        box {	// Inside side
        <(-X*10)-20, (Y*10)-50, 0>,
        <(-X*10)+180, (Y*10)+50, 100>
        texture { pigment { colour BeaconBlue }  } 
        rotate z*-10
        }             
#end                        

// goals
Goal(BeaconBlue, goalATrans)
Goal(Yellow, goalBTrans)
// beacons                                      
Beacon(BeaconCentreOffset, -BeaconSideOffset, BeaconPink, BeaconBlue)
Beacon(BeaconCentreOffset, BeaconSideOffset, BeaconBlue, BeaconPink)
Beacon(-BeaconCentreOffset, -BeaconSideOffset, BeaconPink, Yellow)
Beacon(-BeaconCentreOffset, BeaconSideOffset, Yellow, BeaconPink) 
        
DRobot(-265,0)  // GK  
//DRobot(-180,80)  // LB
DRobot(-135,0)  // CB  
DRobot(-190,0)  // SW  
//DRobot(-180,-80)  // RB
                         
//DRobot(150,80)  // LF
DRobot(120,0)  // CF 
//DRobot(150,-80)  // RF

ORobot(-265,0,30)  // GK  
//ORobot(-180,80)  // LB
//ORobot(-135,0)  // CB  
//ORobot(-190,0)  // SW  
//ORobot(-180,-80)  // RB
                         
//ORobot(150,80)  // LF
//ORobot(120,0)  // CF 
//ORobot(150,-80)  // RF
                           
// ball                    
OrangeBall(1250,1100)                 
//PinkBall(150,1000)    
//PinkBall(2000,1000)
// lines
GoalLines(goalATrans)
GoalLines(goalBTrans)    
box {	// centre line
	<-LineWidth/2, -HFieldWidth+200, 0>,
	<LineWidth/2, HFieldWidth-200, LineHeight>
	texture { LineTexture }
}
difference {	// centre circle
	cylinder {	// outer part of circle
		<0, 0, 0>,
		<0, 0, LineHeight>,
		CentreCircleRadius+LineWidth/2
	}
	cylinder {	// with inner circle subtracted
		<0, 0, -LineHeight>,
		<0, 0, 2*LineHeight>,
		CentreCircleRadius-LineWidth/2
	}
	texture { LineTexture }
}
// Boundaries
	// sides
	box {
		<-(HFieldLength-GoalDepth+BoundaryWidth), HFieldWidth-EdgeBoundaryInset, 0>
		<HFieldLength-GoalDepth+BoundaryWidth, HFieldWidth-EdgeBoundaryInset+BoundaryWidth, BoundaryHeight>
		texture { BoundaryTexture }
	}
	box {
		<-(HFieldLength-GoalDepth+BoundaryWidth), -(HFieldWidth-EdgeBoundaryInset), 0>
		<HFieldLength-GoalDepth+BoundaryWidth, -(HFieldWidth-EdgeBoundaryInset+BoundaryWidth), BoundaryHeight>
		texture { BoundaryTexture }
	}
	// ends
	box {
	<-(HFieldLength-GoalDepth+BoundaryWidth), -(HFieldWidth-EdgeBoundaryInset), 0>,
		<-(HFieldLength-GoalDepth), -HGoalWidth, BoundaryHeight>
		texture { BoundaryTexture }
	}
	box {
		<(HFieldLength-GoalDepth+BoundaryWidth), -(HFieldWidth-EdgeBoundaryInset), 0>,
		<(HFieldLength-GoalDepth), -HGoalWidth, BoundaryHeight>
		texture { BoundaryTexture }
	}
	box {
		<-(HFieldLength-GoalDepth+BoundaryWidth), (HFieldWidth-EdgeBoundaryInset), 0>,
		<-(HFieldLength-GoalDepth), HGoalWidth, BoundaryHeight>
		texture { BoundaryTexture }
	}
	box {
		<(HFieldLength-GoalDepth+BoundaryWidth), (HFieldWidth-EdgeBoundaryInset), 0>,
		<(HFieldLength-GoalDepth), HGoalWidth, BoundaryHeight>
		texture { BoundaryTexture }
	}   
	                                                     