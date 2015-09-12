// moving ball with mouse
// bouncing ball with everything in variables
// score counter
// difficultites

//variables for balls in middle
int gameState;
PImage m;
PImage p;
PImage b;
PImage w;
PImage l;
PImage bg;
int pa;
int pb;
int number=10;
float[]ballsX= new float[number];
float[]ballsY= new float[number];
float[]ballSize=new float[number];
float[]speedX=new float[number];
float[]speedY=new float[number];
float[]ma=new float[number];
float[]mb=new float[number];

//variables for control balls
float controlX;
float controlY;
int controlSize;

//other difficulties
boolean win;
boolean falious;
boolean begin;

void setup() {
  size(800, 500);
  gameState=0;
  p =loadImage("peach.png");
  m =loadImage("monkey.png");
  b =loadImage("begin.jpg");
  w = loadImage("win.jpg");
  l = loadImage("loose.jpg");
  bg = loadImage("gamebg.jpg");
  pa=30;
  pb=30;
  begin = true;
  imageMode(CENTER);
  for (int i=0; i<number; i++) {
    ballsX[i] = int(random(0, width));
    ballsY[i] = int(random(0, height));
    ballSize[i] = int(random(20, 50));
    speedX[i]=random(-1, 1);
    speedY[i]=random(-1, 1);
    float scaling = random(40, 100);
    ma[i]=scaling/2;
    mb[i]=scaling;
  }
  controlX = width-pa/2-10;
  controlY = height-pb/2-10;
}


void draw() {
  //®println(gameState);
  background(255);
  if (gameState==0) {                              //game start
    image(b, width/2, height/2, 800, 500);
  }
  if (gameState==1) {                              //game function
    //game things
    image(bg,width/2,height/2,width,height);
    noStroke();
    fill(random(100,255), random(100,255), 0);
    ellipse(0, 0, 100, 100);
    fill(0, 255, 0);
    ellipse(width, height, 100, 100);
     
     noFill();
     stroke(0);
     strokeWeight(12);
     rect(0,0,width,height);
    for (int i=0;  i<number; i++) {
      moveballs(i);
      moving(i);
      float d = dist(controlX, controlY, ballsX[i], ballsY[i]);
      if (d< ma[i]/2+pa/2) {
        gameState=3;
      }
      if (controlX<30 && controlY<30) {
        gameState=2;
      }
      fill(255, int(random(0, 255)), 0);
      image(p, controlX, controlY, pa, pb);
    }
    control();
    score();

  }
  if (gameState==2) {                                //game win
    win();
  }
  if (gameState==3) {                              //game loose
    loose();
  }
}

void mouseClicked() {
  if (gameState==0) {
    gameState = 1;
  }

  if (gameState == 2) {
    gameState = 1;
    for (int i=0; i<number; i++) {
      ballsX[i] = int(random(0, width));
      ballsY[i] = int(random(0, height));
      ballSize[i] = int(random(20, 50));
      speedX[i]=random(-3, 3);
      speedY[i]=random(-3, 3);
      float scaling = random(60, 150);
      ma[i]=scaling/2;
      mb[i]=scaling;
    }
    controlX = width-pa/2-10;
    controlY = height-pb/2-10;
  }
  if (gameState == 3) {
    gameState = 1;
    setup();
  }
}


void win() {
  image(w, width/2, height/2, width, height);
}
void loose() {
  image(l, width/2, height/2, width, height);
}
void score() {
  text("Protected", width-40, 0);
}
void control() {
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == UP) { 
        controlY=controlY-2;
      }
      if (keyCode == DOWN) {
        controlY=controlY+2;
      }
      if (keyCode == LEFT) {
        controlX=controlX-2;
      }
      if (keyCode == RIGHT) {
        controlX=controlX+2;
      }
      if (controlX>width-pa/2) {
        controlX=width-pa/2;
      }
      if (controlX<=pa/2) {
        controlX=pa/2;
      }
      if (controlY>=height-pb/2) {
        controlY=height-pb/2;
      }
      if (controlY<=pb/2) {
        controlY=pa/2;
      }
    }
  }
} 


void moveballs(int i) {
  image(m, ballsX[i], ballsY[i], ma[i], mb[i]);
  ballsX[i]=ballsX[i]+speedX[i];
  ballsY[i]=ballsY[i]+speedY[i];
}

void moving(int i) {
  if (ballsX[i]<ma[i]/2) {
    speedX[i]=-speedX[i];
    ballsX[i]=ma[i]/2;
  }

  if (ballsX[i]>width-ma[i]/2) {
    speedX[i]=-speedX[i];
    ballsX[i]=width-ma[i]/2;
  }
  if (ballsY[i]<mb[i]/2) {
    speedY[i]=-speedY[i];
    ballsY[i]=mb[i]/2;
  }
  if (ballsY[i]>height-mb[i]/2) {
    speedY[i]=-speedY[i];
    ballsY[i]=height-mb[i]/2;
  }
}

