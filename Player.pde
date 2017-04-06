class Player
{
  //state is going to control the scenes in game.
  String State="CHOOSE";
  //if the player got attack,he will lose one life.
  int Life=10;
  //Decide the image for player,it will be setted in CHOOSE state.
  int PlaneNo=7;
  //if the player kill one enemy,he got one point.
  int Score=0;
  int x=750;
  int y=750;
  PImage PlaneImage;
  
  Player()
  {
    State="CHOOSE";
    Life=10;
    PlaneNo=7;
    Score=0;
    x=750;
    y=750;
  }
  void Display()
  {
    imageMode(CENTER);
    PlaneImage=loadImage("Images/plane"+PlaneNo+".png");
    image(PlaneImage, x, y, 100, 100);
    DisplayScore();
    DisplayLife();
  }
  void DisplayLife()
  {
    fill(0,0,0,255);
    rectMode(CORNER);
    stroke(159,159,159);
    strokeWeight(4);
    rect(1353,43,102,13);
    //draw rectangles.The total depends on player's life.
    for (int i=0; i<Life; i++)
    {
      noStroke();
      fill(255, 0, 0);
      rectMode(CENTER);
      noStroke();
      rect(1450-i*10, 50, 10, 10);
    }
  }
  void DisplayScore()
  {
    fill(255);
    textSize(30);
    textAlign(LEFT, BOTTOM);
    text("Score: "+Score, 10, 40);
  }
  //4 functions as follow control player's position. 
  void MoveUp()
  {
    int speed=20;
    if (y<25)return;
    y-=speed;
  }
  void MoveDown()
  {
    int speed=20;
    if (y>775-speed)return;
    y+=speed;
  }
  void MoveLeft()
  {
    int speed=20;
    if (x<25)return;
    x-=speed;
  }
  void MoveRight()
  {
    int speed=20;
    if (x>1475-speed)return;
    x+=speed;
  }
}

