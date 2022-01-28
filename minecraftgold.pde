import java.awt.Robot;
Robot rbt;
boolean skipFrame;

//colour pallette
color black = #000000;//oakplanks
color white = #FFFFFF;
color green = #c4d500;//emptyspace
color dullBlue = #7092be;//golder
//textures
PImage iron,diamond,gold;
//Map var
int gridSize;
PImage map, mapsta;




boolean wkey, akey, skey, dkey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, upX, upY, upZ;
float leftRightHeadAngle, upDownHeadAngle;


void setup() {
  noCursor();
  size (displayWidth, displayHeight, P3D);
  textureMode(NORMAL);
  wkey = akey = skey = dkey = false;
  eyeX= width/2;
  eyeY= 9*height/11;
  eyeZ=height/2;
  
  
  focusX=width/2;
  focusY=height/2;
  focusZ=height/2-100;
  upX=0;
  upY=1;

  upZ=0;

  //initialize map
  map = loadImage("mapster.png");
  mapsta = loadImage("mapsta.png");
  gold = loadImage("golder.png");
  iron = loadImage("iron.png");
  gridSize=100;
  //initialize texture
  diamond = loadImage("diamond.png");
  textureMode(NORMAL);





  leftRightHeadAngle=radians(270);
  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  skipFrame = false;
}


void draw() {


  background(0);
  lights();
 pointLight(100,50,100,eyeX,eyeY,eyeZ);
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, upX, upY, upZ);
  drawFloor(-2000,2000,height,gridSize); //floor
  drawFloor(-2000,2000,height-gridSize*4,gridSize);
  drawMap();
  drawFocalPoint();
  controlCamera();

}


void drawMap() {
  for (int x  = 0; x<mapsta.width; x++) {
    for (int y = 0; y< mapsta.height; y++) {
      color c = map.get(x, y);
      if (c==dullBlue) {
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, diamond, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, diamond, gridSize);
            texturedCube(x*gridSize-2000,height-gridSize*3,y*gridSize-2000, diamond,gridSize);
      }
      if(c == black) {
       
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, gold, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, gold, gridSize);
            texturedCube(x*gridSize-2000,height-gridSize*3,y*gridSize-2000, gold,gridSize);
      }
    }
  }
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(5);
  popMatrix();
}

void drawFloor(int start, int end, int level, int gap) {
  stroke(255);
  strokeWeight(1);
  int x = start;
  int z =start;
  while (z<end){
texturedCube(x,level,z,diamond,gap);
    x = x+gap;
    if (x>=end){
      x = start;
      z = z +gap;
     
    
  }}
}

void controlCamera() {
  if (wkey) {
    eyeX = eyeX +cos(leftRightHeadAngle) *10;
    eyeZ=eyeZ +sin(leftRightHeadAngle) *10;
  }
  if (skey) {
    eyeX = eyeX -cos(leftRightHeadAngle) *10;
    eyeZ=eyeZ -sin(leftRightHeadAngle) *10;
  }
  if (akey) {
    eyeX = eyeX -cos(leftRightHeadAngle+PI/2) *10;
    eyeZ=eyeZ -sin(leftRightHeadAngle + PI/2) *10;
  }
  if (dkey) {
    eyeX = eyeX -cos(leftRightHeadAngle-PI/2) *10;
    eyeZ=eyeZ -sin(leftRightHeadAngle - PI/2) *10;
  }

if(skipFrame == false) {
  leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX)*0.01;
  upDownHeadAngle = upDownHeadAngle + (mouseY-pmouseY) *0.01;
}
  if (upDownHeadAngle> PI/2.5) upDownHeadAngle= PI/2.5;
  if (upDownHeadAngle < -PI/2.5) upDownHeadAngle = -PI/2.5;



  focusX = eyeX+cos(leftRightHeadAngle)*300;
  focusZ= eyeZ +sin(leftRightHeadAngle) *300;
  focusY= eyeY + tan(upDownHeadAngle) *300;



  // println(eyeX, eyeY, eyeZ);
  
  if(mouseX<2) {
   
 rbt.mouseMove(width-3, mouseY);
 skipFrame = true;
  }
  else if (mouseX>width -2) {
    rbt.mouseMove(3,mouseY);
    skipFrame = true;
    
}else{
  skipFrame = false;
}
}

void keyPressed() {
  if (key== 'W' || key =='w') wkey = true;
  if (key== 'A' || key =='a') akey = true;
  if (key== 'S' || key =='s') skey = true;
  if (key== 'D' || key =='d') dkey = true;
}
void keyReleased() {
  if (key== 'W'|| key =='w') wkey = false;
  if (key== 'A' || key =='a') akey = false;
  if (key== 'S' || key =='s') skey = false;
  if (key== 'D' || key =='d') dkey = false;
}
