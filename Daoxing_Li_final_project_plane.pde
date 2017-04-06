import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import ddf.minim.*;

AudioPlayer shoot;//the variable for the shoot sound
AudioPlayer bomb;//the variable for the bomb sound
AudioPlayer bgmusic;//the variable for the background music
Minim minim;//audio context
Background bg=new Background();//This object is going to make background animation
Bullet[] bullets=new Bullet[200];//This is bullet array,it means during the game,it only can dispaly 200 bullets
Enemy[] enemys=new Enemy[20];//The total of enemies is 20
Player user=new Player();//This is player,which decides the state of whole game.
int counterOfenemy=20;//This variable is going to count how many enemies the player should kill,cause there is exception that the enemy is killed by collision with player.
boolean Iswin=true;//This variable controls the result of game whether the play is win or not.
int Score=0;
void setup()
{
  minim = new Minim(this);
  size(1500, 800);
  //This part will initialize enemy array and user.
  for (int i=0; i<200; i++)
  {
    bullets[i]=new Bullet(-10, -10);
    if (i<20) {
      enemys[i]=new Enemy(int(random(50, 1450)), int(random(50, 100)), int(random(3, 7)));
    }
  }
  user.State="CHOOSE";
  bgmusic = minim.loadFile("backgroundmusic.mp3", 2048);
  bgmusic.play();
  bgmusic.loop();//this can make the background music play over and over.
}

void draw()
{
  background(0);
  bg.Display();//background is needed in every scene,so in here I draw background first.
  //I use 3 conditional statement to control the scene on the screen.
  if (user.State=="CHOOSE")//CHOOSE scene.
  {
    DisplayChoices();//display 8 choices
    fill(255);
    textSize(30);
    textAlign(LEFT, TOP);
    //display the introduction
    text("First,you need to choose a plane.\nNext you can use arrow keys to control the plane and the SPACE key can shoot enemies.\nThe game will be over untill you die or all enemies die.\nEnjoy it!!!!!GOOD LUCK", 50, 50);
  }
  if (user.State=="GAMING")
  {
    //check the collisions
    for (int i=0; i<200; i++)
    {
      //check the collision bullets and enemys
      for (int countenemy=0; countenemy<20; countenemy++)
      {
        if (bullets[i].Collision(enemys[countenemy]))
        {
          user.Score++;//record player's score.
          bomb = minim.loadFile("bomb.wav", 2048);
          bomb.play();
          if (user.Score>=counterOfenemy) {
            user.State="OVER";
            Score=user.Score;
          }
        }
        //check the collision fly fighter and enemys
        if (enemys[countenemy].Collision(user))
        {
          /*the player's score increase by killing enemies,so the counterOfenemy count how many enemies 
           the player should killed.Sometimes the enemy is killed by collision with player,so this enemy 
           cannot be killed by player's bullet.For example:There are 20 enemies,if there is a collision 
           between player and enemy,so the player just need to kill 19 enemies,that one does not count.
           If the player's score equals counterOfenemy,it proves that the player killed all enemies,and 
           he can win.That is why I use counterOfenemy.
           */
          user.Life--;
          counterOfenemy--;
          bomb = minim.loadFile("bomb.wav", 2048);
          bomb.play();//play the sound
          if (user.Life<=0) {
            user.State="OVER";//Change the state.
            Score=user.Score;
            Iswin=false;
          }
        }
      }
      //when the bullet do not kill enemy or off the top edge,it is active.
      if (bullets[i].active)
      {
        bullets[i].Display();
      }
      if (i<20)enemys[i].Display();
    }
    user.Display();
  }
  if (user.State=="OVER")
  {
    //different result will display different message
    if (Iswin) {
      textAlign(CENTER, CENTER);
      textSize(50);
      fill(random(255), random(255), random(255));
      text("You Are The Winner!!!\nScore: "+Score, 750, 400);
    } else {
      textAlign(CENTER, CENTER);
      textSize(50);
      fill(255);
      text("You Are Loser!!!", 750, 400);
    }
    //initialize whole thing.
    user=new Player();
    user.State="OVER";
    for (int i=0; i<200; i++)
    {
      bullets[i]=new Bullet(-10, -10);
      if (i<20) {
        enemys[i]=new Enemy(int(random(50, 1450)), int(random(50, 100)), int(random(2, 5)));
      }
    }
    counterOfenemy=20;
  }
  if (Check()) {
    user.State="OVER";
    Score=user.Score;
  }
}
//monitor the key event.
void keyPressed()
{
  if (user.State=="CHOOSE")
  {
  }
  if (user.State=="GAMING")
  {
    if (key=='a')exit();//if you press a the application will exit.
    if (key==' ')Shoot();
    if (keyCode==UP) {
      user.MoveUp();
    }
    if (keyCode==DOWN) {
      user.MoveDown();
    }
    if (keyCode==LEFT) {
      user.MoveLeft();
    }
    if (keyCode==RIGHT) {
      user.MoveRight();
    }
  }
  if (user.State=="OVER")
  {
    //initialize whole thing.
    Iswin=true;
    user=new Player();
    for (int i=0; i<200; i++)
    {
      bullets[i]=new Bullet(-10, -10);
      if (i<20) {
        enemys[i]=new Enemy(int(random(50, 1450)), int(random(50, 100)), int(random(2, 5)));
      }
    }
    counterOfenemy=20;
    if (frameCount/60>5)user.State="CHOOSE";
  }
}
//monitor mouse press event
void mousePressed()
{
  if (user.State=="CHOOSE")
  {
    int No=0;
    //I use for loop to draw 8 choices,I also use embed for loop to check mouse position.
    //then set the planeNo and jump next scene.
    for (int x=640; x<880; x+=110)
    {
      for (int y=290; y<530; y+=110)
      {
        if (x==750&&y==400)continue;
        if (mouseX<x+50&&mouseX>x-50&&mouseY<y+50&&mouseY>y-50)
        {
          user.PlaneNo=No;
          user.State="GAMING";
        }
        No++;
      }
    }
  }
  if (user.State=="GAMING")
  {
    /*
    if(user.Life==0)
     {
     user.State="OVER";
     Score=user.Score;
     }
     */
  }
  if (user.State=="OVER")
  {
    Iswin=true;
    user=new Player();
    for (int i=0; i<200; i++)
    {
      bullets[i]=new Bullet(-10, -10);
      if (i<20) {
        enemys[i]=new Enemy(int(random(50, 1450)), int(random(50, 100)), int(random(2, 5)));
      }
    }
    counterOfenemy=20;
    if (frameCount/60>5)user.State="CHOOSE";
  }
}

void DisplayChoices()
{
  int No=0;//create image's filename
  PImage plane;
  for (int x=640; x<880; x+=110)
  {
    for (int y=290; y<530; y+=110)
    {
      fill(random(255), random(255), random(255), 155);
      noStroke();
      rectMode(CENTER);
      if (x==750&&y==400)continue;//Cause I do not draw things in center,so I use continue to skip the center.
      rect(x, y, 100, 100, 10);
      imageMode(CENTER);
      plane=loadImage("Images/plane"+No+".png");
      image(plane, x, y, 100, 100);
      No++;
    }
  }
}


void Shoot()
{
  shoot = minim.loadFile("shoot.wav", 2048);
  shoot.play();
  int NoOfBullet;
  //I use random to choose one of 200 bullet to shoot,sometimes it choose one bullet which is active.
  //If that happens,I will let it to create a new number until there is one who is not active.
  //I quit use append because if I press too much,there will be lots of useless bullet our of screen.
  //It is not effective,so I deny to use append.
  do {
    NoOfBullet=int(random(50));
    if (!bullets[NoOfBullet].active)
    {
      bullets[NoOfBullet]=new Bullet(user.x, user.y);
      bullets[NoOfBullet].active=true;
      break;
    } else continue;
  }
  while (true);
}
//Check whether all enemies die.
boolean Check()
{
  boolean result=true;
  for (int i=0; i<20; i++)
  {
    if (enemys[i].dead==true) {
      result=true;
    } else return false;
  }
  return result;
}

