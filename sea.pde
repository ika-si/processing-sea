import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


Minim minim;
AudioPlayer player1;
AudioPlayer player2;


//ゴミの画像ランダム
class Position {
  float x,y,w,h;
  int count;
  boolean isShow = false;
  PImage garbage;
  
  Position (float x, float y, float w, float h, PImage garbage) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.count = (int)random(500,3000);
    this.garbage = garbage;
  }
  
  boolean Hit (float xpos, float ypos) {
    if (isShow && x < xpos && xpos < x + w && y < ypos && ypos < y+h) {
      return true;
    } else {
      return false;
    }
  }
  
  void picture(){
    count--;
    if (count == 0) {
      if (isShow) {
        isShow = false;
        count = (int)random(200,800);
        //count = 300;
      } else {
        isShow = true;
        count = (int)random(120,150);
        //count = 300;
      }
    }
    if (isShow) {
        image(garbage,x,y,w,h);
    }
  }
}


//maru
int c1 = 0;

//moji///深さ
int c2 = 0;

PImage[] imgs;
PImage gar1, gar2, gar3;
Position[] p = new Position[10];
int score = 0;
  
void setup(){
  size(900,600);
  
  //音楽
  minim = new Minim(this);
  player1 = minim.loadFile("test2.mp3");
  player1.play();
  player2 = minim.loadFile("sound.mp3");
  
  //画像
  imgs = new PImage[]{loadImage("dolphin.png"),loadImage("ika.png"),loadImage("maguro.png")};
  //gar = new PImage[]{loadImage("gomi.png"),loadImage("gomi1.png"),loadImage("gomi2.png")};
  gar1 = loadImage("gomi.png");
  gar2 = loadImage("gomi1.png");
  gar3 = loadImage("gomi2.png");
  p[0] = new Position(300,120,30,30,gar1);
  p[1] = new Position(400,120,30,30,gar2);
  p[2] = new Position(200,240,30,30,gar3);
  p[3] = new Position(320,240,30,30,gar2);
  p[4] = new Position(440,240,30,30,gar1);
  p[5] = new Position(560,240,30,30,gar2);
  p[6] = new Position(220,400,30,30,gar1);
  p[7] = new Position(350,360,30,30,gar3);
  p[8] = new Position(480,400,30,30,gar1);
  //p[9] = new Position(580,360,50,50,gar1);
  
}

void draw(){
  background(0);
  
  if (c2 >= 5000) {
    Finish();
  } else {
    //潜水艦
  maru();
  
  //画像
  getPicture();
  
  //深水
  moji();
  
  //生き物の画像
  creatureImage();
  
  //マウス
  mouseEllipse();
  
  }
  
}

void Finish () {
  fill(255);
  textSize(30);
  text("SCORE    "+score,400,300,200,200);
}


void creatureImage () {
  if (100 <= c2/5 && c2/5 <1000) {
    image(imgs[0],490,120,130,130);
  }
  
  if (300 <= c2/5 && c2/5 < 500) {
    image(imgs[1],200,470,100,100);
  }
  
  if (50 <= c2/5 && c2/5 <= 400) {
    image(imgs[2],250,300,100,100);
  }
}

void mousePressed(){
  player2.rewind();
  player2.play();
  
  //pictureを消す
  for (int i = 0; i < 9; i++) {
    if (p[i].Hit(mouseX ,mouseY)) {
      score++;
      p[i].isShow = false;
      p[i].count = (int)random(500,3000);
    }
  }
  
  //マウスの円
  colhue1 = random(0,255);
  colhue2 = random(0,255);
  colhue3 = random(0,255);
  
}

float colhue1;
float colhue2;
float colhue3;

void mouseEllipse () {
  for ( int i=0; i<360; i++ ) {
      fill(colhue1, colhue2, colhue3, 360-i);
      float posX = 20*(cos(radians(i))) + mouseX;
      float posY = 20*(sin(radians(i))) + mouseY;
      ellipse( posX, posY, 5, 5);
   }
}

void getPicture () {
  for (int i = 0; i < 9; i++) {
    p[i].picture();
  }
  fill(255);
  textSize(20);
  text("score: "+score,800,500,100,100);
}

void maru(){
  noStroke();
  fill(0,0,150);
  if (c1 > 100 && 600 <= c2/5) {
    c1--;
    fill(0,0,c1);
  } else if (600 <= c2/5) {
    fill(0,0,100);
  }
  ellipse(400,300,650,650);/////////////大きい丸
  
  
  if(c1 < 255 && c2/5 < 500){
    c1++;
    fill(0,0,c1);
  }else if (c1 == 255 && c2/5 < 500) {
    fill(0,0,c1);
  } else if (c1 > 150 && 500 <= c2/5) {
    c1--;
    fill(0,0,c1);
  } else if (500 <= c2/5) {
    fill(0,0,150);
  }
  ellipse(400,300,550,550);///////////////小さい丸
}

void moji(){
  fill(255);
  c2++;
  textSize(30);
  text("the depth of water     "+str(c2/5)+"m",610,20,320,200);
}
