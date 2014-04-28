#include <MeggyJrSimple.h>
void setup()
{
  MeggyJrSimpleSetup();
}

int marker = 4;
int direction

//create a struct block
struct Point
{
  int x;
  int y;
};


Point s1 = {0,5};
Point s2 = {0,4};
Point s3 = {1,5};
Point s4 = {1,4};

//define the array
Point blockArray[64] = {s1, s2, s3, s4};

void loop()
{
  drawBlock();
  
  DisplaySlate();
  delay(200);
  ClearSlate();
  
  CheckButtonsPress();
    if(Button_Up)
    
}



//draw block
void drawBlock()
{
  for(int i = 0; i < marker; i++)
  {
    DrawPx(blockArray[i].x, blockArray[i].y,White);
  }
}
//display slate, delay, clear slate
//check buttons press
//draw walls
//read the px
//update blocks
