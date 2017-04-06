class Bullet
{
  int x=750;
  int y=745;
  /*
  active will decide whether this bullet can kill enemy and be displayed on the screen.There are two 
  situation that bullet will disappear,which is making the bullet not active:1.bullet hit a enemy,2.
  bullet is out of the screen.
  */
  boolean active=false;
  Bullet(int Initialx,int Initialy)
  {
    x=Initialx;
    y=Initialy;
  }
 
  void Move()
  {
    y-=10;
    if(y<-5)
    {
      active=false;
    }
  }
  void Display()
  {
    if(!active)return;
    noStroke();
    fill(255,0,0);
    ellipse(x,y-30,10,10);
    Move();
  }
  boolean Collision(Enemy e)
  {
    //if the distance between enemy and bullet is less than the sum of enemy's size and bullet's radius,it means they have intersect.
    //but when chech the collision,the bullet is suppose to be active and enemy is not dead.
    if(dist(e.x,e.y,x,y)<5+e.size-30&&e.dead==false&&active==true)
    {
      active=false;
      e.dead=true;
      return true;
    }else return false;
  }
}
