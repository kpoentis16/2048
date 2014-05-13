#include <MeggyJrSimple.h>
void setup()
{
  MeggyJrSimpleSetup();
  Serial.begin(9600);
}
int blockDirection;
int numberOfBlocks = 4;
boolean moveStart = false;
boolean newBlock = true;
int xblock = 3;
int yblock = 7;


struct Point
{
  int x;
  int y;
  int color;
  int dir;
};


Point s1 = {2,1,7,-1};
Point s2 = {0,3,3,-1};
Point s3 = {4,5,2,-1};
Point s4 = {6,7,1,-1};


Point blockArray[64] = {s1, s2, s3, s4};



void loop()
{
  ClearSlate();
  
  for (int i = 0; i < numberOfBlocks; i++)
  {
    drawBlock(blockArray[i].x,blockArray[i].y,blockArray[i].color);
  }
  drawNewBlock();
  DisplaySlate();
  delay(200);
  
  
  CheckButtonsPress();
    if(Button_Left)
    {
      blockDirection=270; 
      moveStart = true;
      newBlock = true;

    }
    
    if(Button_Up)
    {
      blockDirection=0;
      moveStart = true;
      newBlock = true;

    }
    
    if(Button_Right)
    {
      blockDirection=90;
      moveStart = true;
      newBlock = true;

    }
    
    if(Button_Down)
    {
      blockDirection=180;
      moveStart = true;
      newBlock = true;

    }
    
    
    if(moveStart==true)
      updateBlock();
    
    updateBlockDirection();
    
   /*
   
   0, 2, 4, 6
   0, 1, 2, 3
   
   1, 3, 5, 7
   0, 1, 2, 3
   
   */
    
     if(newBlock)
    {
      xblock = random (4)*2;
      yblock = random (4)*2+1;
      while (ReadPx(xblock, yblock) != 0)
      {
        xblock = random (8);
        yblock = random (8);
      }
      newBlock = false;
    }
    
    
    if (Button_A)
      printArray();
      
      
}    



void drawBlock(int x, int y, int color)
{
  DrawPx(x,y,color);
  DrawPx(x+1,y,color);
  DrawPx(x+1,y-1,color);
  DrawPx(x,y-1,color);
}

void drawNewBlock()
{
  DrawPx(xblock, yblock, Green);
  DrawPx(xblock, yblock-1, Green);
  DrawPx(xblock+1, yblock, Green);
  DrawPx(xblock+1, yblock-1, Green);
}


void updateBlockDirection() //changes the block direction 
{
  for(int i; i < numberOfBlocks; i++)
  {
    blockArray[i].dir= blockDirection;
  }
  
}


void updateBlock() //checks by reading px on screen and updates the block location accordling if px is dark
{
  for(int i = 0; i < numberOfBlocks; i++)
  {
    if(blockDirection == 270)
    {
      if(ReadPx(blockArray[i].x-2,blockArray[i].y)==0 && blockArray[i].x > 0) 
      {
       blockArray[i].x-=2;
      }
      
      if(ReadPx(blockArray[i].x-2,blockArray[i].y)==blockArray[i].color && blockArray[i].x > 0) 
      {
        blockArray[i].x-=2;
      }
       
    }
  
    
    if(blockDirection == 0)
    {
      if(ReadPx(blockArray[i].x,blockArray[i].y+2)==0 && blockArray[i].y < 7) 
      {
        blockArray[i].y+=2;
      }
      
      if(ReadPx(blockArray[i].x,blockArray[i].y+2)==blockArray[i].color && blockArray[i].y < 7) 
      {
        blockArray[i].y+=2;
      }
    }
   
    if(blockDirection == 90)
    {
      if(ReadPx(blockArray[i].x+2,blockArray[i].y)==0 && blockArray[i].x < 6) 
      {
        blockArray[i].x+=2;
      }
      
      if(ReadPx(blockArray[i].x+2,blockArray[i].y)==blockArray[i].color && blockArray[i].x < 6)
      {
        blockArray[i].x+=2; 
      }
    
    if(blockDirection == 180)
    {
      if(ReadPx(blockArray[i].x,blockArray[i].y-2)==0 && blockArray[i].y > 1) 
      {
        blockArray[i].y-=2;
      }
      
      if(ReadPx(blockArray[i].x,blockArray[i].y-2)==blockArray[i].color && blockArray[i].y > 1)
      {
        blockArray[i].y-=2;
      }
    }
  }
}


void printArray()
{
  for (int i = 0; i < numberOfBlocks; i++)
  {
    Serial.print("Block No. ");
    Serial.println(i);
    Serial.print("x:");
    Serial.println(blockArray[i].x);
    Serial.print("y:");
    Serial.println(blockArray[i].y);
    Serial.print("dir:");
    Serial.println(blockArray[i].dir);
    Serial.println();
  }
}



