class Star
{
  int x;
  int y;
  int size;  
  Star(int xx,int yy,int s)
  {
    x=xx;
    y=yy;
    size=s;
  }
  //display small circle.
  void Display()
  {
    fill(255);
    noStroke();
    ellipse(x,y,size,size);
    Move();
  }
  //keep moving down.
  void Move()
  {
    y++;
    if(y>800)y=0;
  }
}
