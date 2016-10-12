
PImage img;

// Create floats to store the images x, y, rotation, etc;
float imgX, imgY, imgRotation, imgScale, imgScaleStep, imgXStep, imgYStep, imgTint, imgTintStep;

void setup() {
  size(700,400);
  
  img = loadImage("http://www.lit.ie/SiteImages/LIT_LogoNew.png");
  
  // Initialise values
  imgX = width/2;
  imgY = height/2;
  imgRotation = 0;
  imgScale = 1;
  imgScaleStep = -0.1;
  imgXStep = imgYStep = 1;
  imgTint = 255;
  imgTintStep = -5;
   
  frameRate(15);
}

void draw() {
  background(frameCount%255);
  
  // Translate the coordinate space
  translate(imgX, imgY);
  rotate(imgRotation); 
  scale(imgScale);
  
  imgTint += imgTintStep;
  
  if ((imgTint <= 0)|| (imgTint >= 255)){
    imgTintStep *= -1;
  }
  // Draw the image
  tint(255, imgTint);
  image(img,0,0);
  
  
  
  // Modify imgX and imgY
  imgX += imgXStep;
  imgY += imgYStep;
  
  if ((imgX >= (width-img.width)) || (imgX <= 0)) {
    imgXStep *= -1;
  }
  
  if ((imgY >= (height-img.height)) || (imgY <= 0)) {
    imgYStep *= -1;
  }
  
  // Modify imgScale
  imgScale += imgScaleStep;
  
  if ((imgScale <= 0) || (imgScale >= 1)) {
    imgScaleStep *= -1;
  }
  
  // Modify img rotation
  imgRotation +=1;
 
}