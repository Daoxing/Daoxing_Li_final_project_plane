class Enemy {
  int x;
  int y=int(random(-500,0));
  int size;
  int speed;
  /*
  dead will decide whether this can be displayed on the screen.There are two 
  situation that enemy will disappear,which is that enemy is dead:1.bullet hit this enemy,2.
  enemy has collision with player.
  */
  boolean dead=false;
  PImage img;
  int imgNo;//cause there are four kinds of enemies,so I use this variable to generate image's filename.
  Enemy(int xx, int si, int sp)
  {
    x=xx;
    size=si;
    speed=sp;
    imgNo=(int)random(4);
  }
  void Display()
  {
    if (dead==false) {
      img=loadImage("images/star"+imgNo+".png");
      image(img, x, y, size, size);
      Move();
    }
  }
  void Move()
  {
    y+=speed;
    //if the enemy is out of the window,its x coordinate,image and size will be changed.
    if (y>800+size) {
      y=-20;
      x=int(random(1500));
      imgNo=(int)random(4);
      size=int(random(50,100));
    }
  }
  //The principle of collision is same as bullet's.Actually,enemy will have collision with bullet and player
  //but I've checked the collision with bullet,so in here I just need to check collision with player.
  boolean Collision(Player p)
  {
    if (dist(p.x, p.y, x, y)<50+size/2-20&&dead==false)
    {
      dead=true;
      return true;
    } else return false;
  }
}

