float imgx ;          //image x-axis co-ordinate
float imgy ;          //image y-axis co-ordinate
int hitcounter = 0;   //number of zombies hit by player
int miss = 0;         //number of zombies misssed by player on click
boolean alreadyhit;   //checks whether player has already clicked or not
boolean count=false;  //checks whether modval has already been decreased
boolean ingame = false;  //to check whether the game has been started or not
boolean startgame;    //to display the first text
boolean clicked = false;

PImage img;       //zombie image
int modval = 80;  //value that will control the speed with which the zombie will be displayed next
Maxim maxim;
AudioPlayer player;
AudioPlayer player2;
AudioPlayer player3;


void setup()
{
  startgame = false;
  size(640, 600);
  img = loadImage("zmbie.png");
  imageMode(CORNER);
  maxim = new Maxim(this);
  player = maxim.loadFile("wolf.wav");
  player.setLooping(true);
  player2 = maxim.loadFile("zombie.wav");
  player2.setLooping(false);
  player3 = maxim.loadFile("ring.wav");
  player.setLooping(true);
  player3.setLooping(true);
  player.volume(0.30);
  player2.volume(0.40);
  player.cue(0);
  player.play();
  player3.volume(0.40);
  player3.cue(0);
  player3.play();
 }

void draw()
{ // code that happens every frame
  player.cue(0); 
  player.play();
  player3.cue(0);
  player3.play();
  if(!startgame){
    background(0,250,0);
    textSize(30);
    text("Tap on the screen to start",150,200);
    startgame = true;
  }
  if(ingame){
    background(0);
    textAlign(CENTER);
    textSize(30);
    fill(255,255,255);
    text("Hit:",50,50);
    text(hitcounter,100,50);
    text("Life:", 250, 50);
    text(3-miss,310,50);
    text("Level:",450,50);
    text(9-(modval/10),510,50);
    clicked = false;

    if(hitcounter > 0 && hitcounter % 10 == 0) {
    count = true;
    }
    if(frameCount % modval == 0) {
     imgx = random(550);
     imgy = random(100,505);
     alreadyhit = true;
    }
 // tint(255,255,255);
  image(img, imgx, imgy);
  }
}

void mousePressed()
{// code that happens when the mouse button
// is pressed
if(ingame == false){
  ingame = true;
  }
if(ingame && alreadyhit == true){
//  clicked = true;
   if(mouseX <= imgx+img.width && mouseX > imgx && mouseY >= imgy && mouseY <= imgy+img.height){
       hitcounter++;
    //   tint(250,0,0);
       image(img, imgx, imgy);
       if(count == true){
         modval-=10;
         count = false;
         }
       alreadyhit = false;
        player2.stop();
        player2.play();
      }
      else{
        alreadyhit = false;
       //println(alreadyhit);
        miss++;
      }
   
   if(miss>3){
   textSize(30);
   fill(255,0,0);
   text("Game Over!",200,200);
   text("Tap on the screen to start again", 300, 300);

   miss = 0;
   hitcounter = 0;
   modval = 80;
   ingame = false;
   draw();
   }
}
}

