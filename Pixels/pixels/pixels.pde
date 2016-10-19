PImage img;


void setup() {
  size(800,700);
  img = loadImage("rose.jpg");
}

void draw() {
  loadPixels();
  background(255);
  
  
  img.loadPixels();

 
  for (int y = 0; y < img.height; y++ ) {
    for (int x = 0; x < img.width; x++ ) {
      int imgloc = x + y*img.width;
      int x2= 600 -x;
      int y2= 600 -y;
      int imgloc2 = x2 + y2*width;
      pixels[imgloc2] = img.pixels[imgloc];
      
    }
    
  }
 updatePixels();
  
  noLoop();
}