final int GAME_START=0;
final int GAME_RUN=1;
final int GAME_WIN=2;
final int GAME_OVER=3;
final int ENEMY_1=1;
final int ENEMY_2=2;
final int ENEMY_3=3;
int gameState;
int enemyType;

PImage fighter,hp,treasure,enemy,bg1,bg2;
PImage start1,start2,end1,end2;
int bgx1,bgx2 = 0;
PImage[] flame = new PImage[5];
PImage[] shoot = new PImage[6];

float a,tx,ty,hpy;
int shipx,shipy;

int []enemyyy1={0,1,2,3,4};

float[] enemyy1={0,1,2,3,4};
float[] enemyx1={0,1,2,3,4};
float[] enemyy2={0,1,2,3,4};
float[] enemyx2={0,1,2,3,4};
float[] enemyy3={0,1,2,3,4,5,6,7};
float[] enemyx3={0,1,2,3,4,5,6,7};

float speed = 4;
int spacing = 70;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int timer = 0;
int flame_time=0;
float flameX = 1000;
float flameY = 1000;
PImage [] Flame;

//bullet
int [] bullet_x={0,1,2,3,4};
int [] bullet_y={0,1,2,3,4};

int bullet=1;
int space;

void setup () {
    size(640,480) ;  // must use this size.
    start1 = loadImage("img/start1.png");
    start2 = loadImage("img/start2.png");
    end1 = loadImage("img/end1.png");
    end2 = loadImage("img/end2.png");
    shipx = width-50;
    shipy = height/2;
    fighter = loadImage("img/fighter.png");
    hp = loadImage("img/hp.png");
    hpy = 40;
    fill(255,0,0);
    noStroke();
    treasure = loadImage("img/treasure.png");
    tx = random(600);
    ty = random(440);
    
    enemy = loadImage("img/enemy.png");
    
    bg1 = loadImage("img/bg1.png");
    bg2 = loadImage("img/bg2.png");
    
    float n=random(415);
    float m=random(269);
    //float p=random(220)+100;
    for(int i=0;i<enemyy1.length;i++){
        enemyy1[i]=n;
        if(i>0){
          enemyx1[i]=enemyx1[i-1]-spacing;
          enemyx2[i]=enemyx2[i-1]-spacing;
          enemyy2[i]=enemyy2[i-1]+30;
        }else{
          enemyx1[i]=-61;
          enemyx2[i]=-61;
          enemyy2[i]=m;
        }
    }
    gameState = GAME_START;
    enemyType = ENEMY_1;
    
    
    //bomb 
    flame = new PImage[5];
    for(int i = 0 ; i<flame.length;i++){
      flame[i] = loadImage("img/flame"+(i+1)+".png");
    }
    
    
    //bullet
    for(int i =0; i<shoot.length;i++){
      shoot[i]=loadImage("img/shoot.png"); 
    }
    for(int i=0;i<=4;i++){
      bullet_x[i]=-300;
      bullet_y[i]=-300;
    }
    
    }

void draw() {
  switch(gameState){
    case GAME_START:
      image(start2,0,0);
      if(mouseX > 205 && mouseX <455){
        if(mouseY >380 && mouseY <415){
          image(start1,0,0);
            if(mousePressed)
              gameState = GAME_RUN;
              bullet=1;
        }
      }
      break;
    case GAME_RUN:
      image (bg1,bgx1,0);
      image (bg2,bgx2-640,0);
      bgx1 = bgx1 +1;
      if(bgx1==640){
        bgx1=-640;
      }
      bgx1 = bgx1 % 641;
      bgx2 = bgx2 +1;
      if(bgx2==1280){
        bgx2=0;
      }
      bgx2 = bgx2 % 1281;
      image(treasure,tx,ty);
      image(fighter,shipx,shipy);
        do{
        switch(enemyType){
            //the first enemy
            case ENEMY_1:
                image(treasure,tx,ty);
                image(fighter,shipx,shipy);
                for(int i=0;i<enemyy1.length;i++){
                    image(enemy,enemyx1[i],enemyy1[i]); 
                    enemyx1[i]=enemyx1[i]+speed;//speed;
                    if(shipx<=enemyx1[i]+60 && shipx>=enemyx1[i]-50){
                      if(shipy<=enemyy1[i]+60 && shipy>=enemyy1[i]-50){
                        flameX = enemyx1[i];
                        flameY = enemyy1[i];
                        flame_time = 0;  
                              hpy=hpy-40;
                              enemyy1[i]=700;  
                
                        }
                      }
                    }
                    /*}*/
                    for(int i=0;i<enemyx1.length;i++){
                    for(int j=0;j<bullet_x.length;j++){
                      if(bullet_x[j]<=enemyx1[i]+60&&bullet_x[j]>=enemyx1[i]-30){
                        if(bullet_y[j]<=enemyy1[i]+60&&bullet_y[j]>=enemyy1[i]-30){
                        flameX = enemyx1[i];
                        flameY = enemyy1[i];
                        flame_time = 0;  
                        bullet_y[j]=-300;
                        bullet_x[j]=-300;
                        enemyy1[i]=600; }}}}
                image(flame[flame_time],flameX,flameY,60,60);
                timer++;
                if(timer>10){
                   flame_time++;
                   timer = 0;
                }
                if(flame_time>=flame.length){
                   flameX=1000;
                   flameY=1000;
                   flame_time=0;
                }
                //set enemy3
                float p=random(220)+100;
                for(int i=0;i<enemyy3.length;i++){
                    enemyy3[i]=p;
                    enemyx3[i]=-61;
                    if(i>=1){
                      enemyx3[i]=-61-int((i+1)/2)*spacing;
                    }
                    if(i==2||i==6){
                      enemyy3[i]=enemyy3[i]+50;
                    }
                    if(i==1||i==5){
                      enemyy3[i]=enemyy3[i]-50;
                    }
                    if(i==3){
                      enemyy3[i]=enemyy3[i]-100;
                    }
                    if(i==4){
                      enemyy3[i]=enemyy3[i]+100;
                    }
                }
                
                if(enemyx1[1]>900){
                      enemyType=ENEMY_2;
                    }
                if(hpy<=0){
                    hpy=40;
                    gameState = GAME_OVER;
                }
            break;
            //the second enemy
            case ENEMY_2:
                for(int i=0;i<enemyy2.length;i++){
                    image(enemy,enemyx2[i],enemyy2[i]); 
                    enemyx2[i]=enemyx2[i]+speed;
                    if(shipx<=enemyx2[i]+60 && shipx>=enemyx2[i]-50){
                      if(shipy<=enemyy2[i]+60 && shipy>=enemyy2[i]-50){
                        flameX = enemyx2[i];
                        flameY = enemyy2[i];
                        flame_time = 0;  
                              hpy=hpy-40;
                              enemyy2[i]=700;  
                   
                        }
                      }
                }
   
                for(int i=0;i<enemyx2.length;i++){
                for(int j=0;j<bullet_x.length;j++){
                      if(bullet_x[j]<=enemyx2[i]+60&&bullet_x[j]>=enemyx2[i]-30){
                        if(bullet_y[j]<=enemyy2[i]+60&&bullet_y[j]>=enemyy2[i]-30){
                        flameX = enemyx2[i];
                        flameY = enemyy2[i];
                        flame_time = 0;  
                        bullet_y[j]=-300;
                        bullet_x[j]=-300;
                        enemyy2[i]=600; }}}}
                 image(flame[flame_time],flameX,flameY,60,60);
                  timer++;
                  if(timer>10){
                     flame_time++;
                     timer = 0;
                  }
                  if(flame_time>=flame.length){
                     flameX=1000;
                     flameY=1000;
                     flame_time=0;
                  }
                 //set enemy1
                 float n = random(415);
                    for(int j=0;j<enemyy1.length;j++){
                      enemyy1[j]=n;
                      if(j==0){
                         enemyx1[j]=-61;
                      }else{
                         enemyx1[j]=enemyx1[j-1]-spacing;
                      }
                    }
                  if(enemyx2[1]>900){
                  enemyType=ENEMY_3;
                }
            break;
            //the thid enemy  
            case ENEMY_3:
                for(int i=0;i<enemyy3.length;i++){
                    image(enemy,enemyx3[i],enemyy3[i]); 
                    enemyx3[i]=enemyx3[i]+speed;
                    if(shipx<=enemyx3[i]+60 && shipx>=enemyx3[i]-50){
                      if(shipy<=enemyy3[i]+60 && shipy>=enemyy3[i]-50){
                        flameX = enemyx3[i];
                        flameY = enemyy3[i];
                        flame_time = 0;  
                        hpy=hpy-40;
                        enemyy3[i]=700;  
           
                        }
                      }
                 }
                for(int i=0;i<enemyx3.length;i++){
                for(int j=0;j<bullet_x.length;j++){
                      if(bullet_x[j]<=enemyx3[i]+60&&bullet_x[j]>=enemyx3[i]-30){
                        if(bullet_y[j]<=enemyy3[i]+60&&bullet_y[j]>=enemyy3[i]-30){
                        flameX = enemyx3[i];
                        flameY = enemyy3[i];
                        flame_time = 0;  
                        bullet_y[j]=-300;
                        bullet_x[j]=-300;
                        enemyy3[i]=600; }}}}             
                  image(flame[flame_time],flameX,flameY,60,60);
                  timer++;
                  if(timer>10){
                     flame_time++;
                     timer = 0;
                  }
                  if(flame_time>=flame.length){
                     flameX=1000;
                     flameY=1000;
                     flame_time=0;
                  }
                 //set enemy2
                 float m=random(269);
                 for(int i=0;i<enemyy2.length;i++){
                    if(i>0){
                      enemyx2[i]=enemyx2[i-1]-spacing;
                      enemyy2[i]=enemyy2[i-1]+30;
                    }else{
                      enemyx2[i]=-61;
                      enemyy2[i]=m;
                    }
                 }
                 
                 
                if(enemyx3[1]>900){
                  //enemyx3=0;
                  enemyType=ENEMY_1;
                }
              break;
            }
         }while(hpy<=0);
      
      
      //blood
      rect(18, 13, hpy, 20);
      image(hp,10,10); 
      //the ship 
       if(upPressed){
        shipy -= speed;
      }
      if(downPressed){
        shipy += speed;
      }
      if(leftPressed){
        shipx -= speed;
      }
      if(rightPressed){
        shipx += speed;
      }
      if(shipx>=width-50){
        shipx = width-50;
      }
      if(shipx<=0){
        shipx = 0;
      }
      if(shipy>=height-50){
        shipy = height-50;
      }
      if(shipy<=0){
        shipy = 0;
      }
      if(shipx<=tx+50 && shipx>=tx-50){
        if(shipy<=ty+50 && shipy>=ty-50){
          hpy=hpy+20;
          if(hpy>=200){
            hpy=200;
          }
          tx = random(600);
          ty = random(440);
        }        
      }

      if(space==1){
         
         //println(shipx);
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
         /*if(bullet_x[]<0)
           space=true;*/
         if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0){
           bullet=2;
         }else{
           bullet=7;
         }
       }
       image(shoot[1],bullet_x[0],bullet_y[0]);
       if(space==2){
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
         if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0){
           bullet=3;
         }else{
           bullet=8;
         }
         //bullet=3;
       }
       image(shoot[2],bullet_x[1],bullet_y[1]);
      if(space==3){
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
         if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0){
           bullet=4;
         }else{
           bullet=9;
         }
         //bullet=4;
       }
       image(shoot[3],bullet_x[2],bullet_y[2]);
       if(space==4){
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
         if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0){
           bullet=5;
         }else{
           bullet=10;
         }
         //bullet=5;
       }
       image(shoot[4],bullet_x[3],bullet_y[3]);
       if(space==5){
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
         if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0){
            bullet=1;
         }else{
            bullet=6;
      }  
       }
       image(shoot[5],bullet_x[4],bullet_y[4]);
       if(space==6){
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
          
           if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0)
        bullet=1;
       }
      
      
      if(bullet==7){
          if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0)
        bullet=2;
      }
      if(bullet==8){
          if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0)
        bullet=3;
      }
      if(bullet==9){
          if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0)
        bullet=4;
      }
      if(bullet==10){
          if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0)
        bullet=5;
      }
      
      
      
      break;
      case GAME_OVER:
        image(end2,0,0);
        float n = random(415);
          for(int j=0;j<enemyy1.length;j++){
             enemyy1[j]=n;
             if(j==0){
                enemyx1[j]=-61;
             }else{
                enemyx1[j]=enemyx1[j-1]-spacing;
             }
            }
            
          for(int i=0;i<=4;i++){
            bullet_x[i]=-300;
            bullet_y[i]=-300;
          }
        flameX=1000;
        flameY=1000;
        if(mouseX > 205 && mouseX <440){
          if(mouseY >305 && mouseY <350){
            image(end1,0,0);
              if(mousePressed){
                gameState = GAME_RUN;
                shipx = width-50;
                shipy = height/2;
              }
          }
        }
      break;
      }}

void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }

  if(key==' '){
    if(bullet==1){
      bullet_x[0]=shipx;
      bullet_y[0]=shipy;
      space = 1;

    }
    if(bullet==2){
      space = 2;
      bullet_x[1]=shipx;
      bullet_y[1]=shipy;
    }
    if(bullet==3){
      space = 3;
      bullet_x[2]=shipx;
      bullet_y[2]=shipy;
    }
    if(bullet==4){
      space = 4;
      bullet_x[3]=shipx;
      bullet_y[3]=shipy;
    }
    if(bullet==5){
      space = 5;
      bullet_x[4]=shipx;
      bullet_y[4]=shipy;
      
    }
    if(bullet==6){
      space=6;

    }
  }
}
void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }}}
