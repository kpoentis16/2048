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
int xblock = 2;   //starting x-coord of new block
int yblock = 3;   //starting y-coord of new block



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
      moveStart = true;     //continuously moves the block in its direction
      newBlock = true;      //draws a new block when button is pressed
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
    
    if (Button_A)
      printArray();
   
    if (Button_B)
    {
      asm volatile ("  jmp 0");    //restarts the game (code from Arduino website)
    }
    
    
  if(moveStart==true) //continuously tries to move the block in its direction
      updateBlock(); 
   
  updateBlockDirection();
   
    
    
  if(newBlock)
  {
    Point n = {xblock,yblock,7,-1};    //draws new block white with random coordinates
    blockArray[numberOfBlocks] = n;
    numberOfBlocks++;
    xblock = random (4)*2; // get these values: 0, 2, 4, 6
    yblock = random (4)*2+1;  // get these values:  1, 3, 5, 7
    while (ReadPx(xblock, yblock) != 0)
    {
     xblock = random (4)*2; // keeps the new block moving properly
     yblock = random (4)*2+1;
    }
      
    newBlock = false;
  }
}    



void drawBlock(int x, int y, int color)
{
  DrawPx(x,y,color);      //draws the block of the array
  DrawPx(x+1,y,color);
  DrawPx(x+1,y-1,color);
  DrawPx(x,y-1,color);
}

void drawNewBlock()
{
  DrawPx(xblock, yblock, 7);        //draw the 4 points of the block white
  DrawPx(xblock, yblock-1, 7);
  DrawPx(xblock+1, yblock, 7);
  DrawPx(xblock+1, yblock-1, 7);
}


void updateBlockDirection() //changes the block direction 
{
  for(int i; i < numberOfBlocks; i++)
  {
    blockArray[i].dir= blockDirection;
  }
  
}


void updateBlock() 
{
  for(int i = numberOfBlocks-1; i >= 0; i--)
  {
    if(blockDirection == 270)  //left
    {
      if(ReadPx(blockArray[i].x-2,blockArray[i].y)==0 && blockArray[i].x > 0) // if the block space to the left is dark, and is greater than 0
      {
       blockArray[i].x-=2; //move the block left until it cannot move anymore
      }
      
       else if(ReadPx(blockArray[i].x-2,blockArray[i].y)==blockArray[i].color && blockArray[i].x > 0) //else if the block space to the left is the same color, and is greater than 0
      {
        blockArray[i].x-=2; //then take its space
        if(blockArray[i].color==7)        //if two blocks collide and they are white, turn yellow
          blockArray[i].color=3;
        else if (blockArray[i].color==3)    //if two blocks are yellow, turn orange
          blockArray[i].color=2;  
        else if (blockArray[i].color==2)    //if two blocks are orange, turn red
          blockArray[i].color=1;
        else if (blockArray[i].color==1)    //if two blocks are red, turn violet
          blockArray[i].color = 6;
        else if (blockArray[i].color==6)     //if two blocks are violet, turn green
        {   
          blockArray[i].color = 4;
        }   
      }
       
    }
  
    
    if(blockDirection == 0) //up
    {
      if(ReadPx(blockArray[i].x,blockArray[i].y+2)==0 && blockArray[i].y < 7) 
      {
        blockArray[i].y+=2;
      }
      
      else if(ReadPx(blockArray[i].x,blockArray[i].y+2)==blockArray[i].color && blockArray[i].y < 7) 
      {
        blockArray[i].y+=2;
        if(blockArray[i].color==7)    //if two blocks collide and they are white, turn yellow
          blockArray[i].color=3;
        else if (blockArray[i].color==3)    //if two blocks are yellow, turn orange
          blockArray[i].color=2;
        else if (blockArray[i].color==2)    //if two blocks are orange, turn red
          blockArray[i].color=1;
        else if (blockArray[i].color==1)    //if two blocks are red, turn violet
          blockArray[i].color = 6;
        else if (blockArray[i].color==6)     //if two blocks are violet, turn green
          blockArray[i].color = 4;  
      }
    }
   
    if(blockDirection == 90)  //right
    {
      if(ReadPx(blockArray[i].x+2,blockArray[i].y)==0 && blockArray[i].x < 6) 
      {
        blockArray[i].x+=2;
      }
      
      if(ReadPx(blockArray[i].x+2,blockArray[i].y)==blockArray[i].color && blockArray[i].x < 6)
      {
        blockArray[i].x+=2; 
        if(blockArray[i].color==7)      //if two blocks collide and they are white, turn yellow
          blockArray[i].color=3;
        else if (blockArray[i].color==3)    //if two blocks are yellow, turn orange
          blockArray[i].color=2;
        else if (blockArray[i].color==2)    //if two blocks are orange, turn red
          blockArray[i].color=1;
         else if (blockArray[i].color==1)    //if two blocks are red, turn violet
          blockArray[i].color = 6;
         else if (blockArray[i].color==6)     //if two blocks are violet, turn green  
          blockArray[i].color = 4;   
      }
    }
    
    if(blockDirection == 180)   //down
    {
      if(ReadPx(blockArray[i].x,blockArray[i].y-2)==0 && blockArray[i].y > 1) 
      {
        blockArray[i].y-=2;
      }
      
      else if(ReadPx(blockArray[i].x,blockArray[i].y-2)==blockArray[i].color && blockArray[i].y > 1)
      {
        blockArray[i].y-=2;
        if(blockArray[i].color==7)   //if two blocks come together and are white, turn yellow
          blockArray[i].color=3;
        else if (blockArray[i].color==3)  //if two blocks are yellow, turn orange
          blockArray[i].color=2;
        else if (blockArray[i].color==2)    //if two blocks are orange, turn red
          blockArray[i].color=1;
        else if (blockArray[i].color==1)    //if two blocks are red, turn violet
          blockArray[i].color = 6;
        else if (blockArray[i].color==6)     //if two blocks are violet, turn green 
          blockArray[i].color = 4;
      }
    }
  }
}

void printArray()              //used for the serial monitor
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



