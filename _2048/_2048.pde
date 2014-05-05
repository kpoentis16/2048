#include <MeggyJrSimple.h>
void setup()
{
  MeggyJrSimpleSetup();
  Serial.begin(9600);
}
int blockDirection;
int numberOfBlocks = 4;

//create a struct block
struct Point
{
  int x;
  int y;
  int color;
  int dir;
};


Point s1 = {0,1,7,-1};
Point s2 = {0,3,3,-1};
Point s3 = {0,5,2,-1};
Point s4 = {0,7,1,-1};

//define the array
Point blockArray[64] = {s1, s2, s3, s4};

void loop()
{
  for (int i = 0; i < numberOfBlocks; i++)
  {
    drawBlock(blockArray[i].x,blockArray[i].y,blockArray[i].color);
  }
  
  DisplaySlate();
  delay(200);
  ClearSlate();
  
  
  CheckButtonsPress();
    if(Button_Left)
    {
      //updateBlockDirection();
      blockDirection=270;
      updateBlock();
    }
    if(Button_Up)
    {
      //updateBlockDirection();
      blockDirection=0;
      updateBlock();
    }
    if(Button_Right)
    {
      //updateBlockDirection();
      blockDirection=90;
      updateBlock();
    }
    if(Button_Down)
    {
      //updateBlockDirection();
      blockDirection=180;
      updateBlock();
    }
    
}    


//draw block
void drawBlock(int x, int y, int color)
{
  DrawPx(x,y,color);
  DrawPx(x+1,y,color);
  DrawPx(x+1,y-1,color);
  DrawPx(x,y-1,color);
 
}

/*void updateBlockDirection()
{
  for(int i; i < numberOfBlocks; i++)
  {
    blockArray[i].dir= blockDirection;
    
    if(blockArray[i].y > 7)
      blockArray[i].y = 7;
      
    if(blockArray[i].y < 1)
      blockArray[i].y = 1;
    
    if(blockArray[i].x > 6)
      blockArray[i].x = 6;
    
    if(blockArray[i].x < 0)
      blockArray[i].x = 0;
  }
  

  
}
*/

void updateBlock()
{
  for(int i = 0; i < numberOfBlocks; i++)
  {
    if(blockDirection == 270)
    {
      if(ReadPx(blockArray[i].x-2,blockArray[i].y)==0 && blockArray[i].x > 0) {
        blockArray[i].x-=2;
      }
    }
    
    if(blockDirection == 0)
    {
      if(ReadPx(blockArray[i].x,blockArray[i].y+2)==0 && blockArray[i].y < 7) {
        blockArray[i].y+=2;
       
      }
    }
   
    if(blockDirection == 90)
    {
      if(ReadPx(blockArray[i].x+2,blockArray[i].y)==0 && blockArray[i].x < 6) {
        blockArray[i].x+=2;
       
      }
    }
    
    if(blockDirection == 180)
    {
      if(ReadPx(blockArray[i].x,blockArray[i].y-2)==0 && blockArray[i].y > 1) {
        blockArray[i].y-=2;
       
      }
    }
  }
}
