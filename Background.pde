class Background
{
  //star object array
  Star[] stars=new Star[200];
  Background()
  {
    //use for loop to set their position and size.
    for(int i=0;i<200;i++)
    {
      stars[i]=new Star(int(random(1500)),int(random(800)),int(random(2,5)));
    }
  }
  void Display()
  {
    //use for loop to display them.
    for(int i=0;i<200;i++)
    {
      stars[i].Display();
    }
  }
  
}
