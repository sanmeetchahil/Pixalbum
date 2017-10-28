PImage img; // declares the album as a PImage
float theta = 0; // creates a float theta that will determine the difference in angle

void setup() { // setup part of code
  fullScreen(P3D); // declares 3d canvas
  img = loadImage("K2.jpg"); // loads image of album
  img.loadPixels(); // loads pixels
} // closes setup function

void draw() { // draw code
  background(255); // sets the background colour to white
  for (int y = 0; y < img.height; y+= 10) { // for loop for the y coordinate of the image, going every 10 pixels
    for (int x = 0; x < img.width; x+= 10) { // for loop for the x coordinate of the image, going every 10 pixels
      int loc = (y * img.width) + x; // creates a variable called loc that equals to the y value multiplied by the album width plus the X value from the other loop to draw each individual pixel 
      color c = img.pixels[loc]; // sets the colour of hte pixel to the location of the current iteration of the for loop
      float r = red(c); // sets the red float
      float g = green(c); // sets the green float
      float b = blue(c); // sets the blue float

      noStroke(); // ensures there are no borders
      fill(r, g, b); // sets the fill colour to that of the image
      rectMode(CENTER); // ensures the rectangle is drawn from its center
      pushMatrix(); // pushes matrix coordinate system
      translate(x, y); // translates pixel to the x and y of the iteration 
      rotateZ(theta*x* 0.01); // rotates the canvas to the change of the angle and the x iteration and a solid number 0.01 for a slower spin 
      rect(mouseX, mouseY, 12, 12); // draws a rectangle at the mouse x and y position with a size of 12
      theta += 0.000001; // increases the size of the theta variable by a little amount
      popMatrix(); // pops the matrix back into the coordinate system
    } // closes the for loop
  } // closes the for loop
} // closes draw loop

void keyPressed() { // function to manage key pressed events
  if (key == 'S' || key == 's') { // if the lowercase or uppercase letter 's' is pressed, then...
    saveFrame(); // it takes a screenshot
  } // closes the if statement
} // closes the key pressed event handler