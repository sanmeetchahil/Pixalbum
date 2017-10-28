import ddf.minim.*; // imports the minim sound library
PImage album; // declares the album as a PImage
float tracks; // creates a variable for the amount of tracks in the album

Minim minim; // names the Minim library to minim 
AudioPlayer uno;  // sets the audio player to uno

void setup() { // opens the setup function
  size(510, 510); // set the screen size to the size of the album cover  
  album = loadImage("Blond.jpg"); // loads the album image 
  album.loadPixels(); // loads the album pixels
  noStroke(); // ensures there is no outline for the pixels
  minim = new Minim(this); // makes the minim variable to the Minim library to this sketch
  uno = minim.loadFile("03 Pink + White.mp3"); // sets the variable uno to the mp3/m4a file of the selected album (in this case, Frank Ocean's Blonde track Pink + White)
  tracks = 17; // input the number of tracks the album has
  uno.play();
} // closes the setup function

void draw() { // opens the draw function
  for (int y = 0; y < album.height; y+= tracks - 1) { // for loop that goes into the height of the album
    for (int x = 0; x < album.width; x+= tracks - 1) { // nested for loop that goes into the width of the album
      int location = (y * album.width) + x; // creates a variable called location that equals to the y value multiplied by the album width plus the X value from the other loop to draw each individual pixel 
      color c = album.pixels[location]; // creates a colour variable c that depends on the pixel for its colour based on its location 
      float r = red(c); // sets the red colour to the pixel location
      float g = green(c); // sets the green colour to the pixel location
      float b = blue(c); // sets the blue colour to the pixel location
      fill(r, g, b); // fills each pixel in with its respective colour
      rectMode(CENTER); // sets the placement mode of each rectangle to the center to ensure that it fills the canvas
      pushMatrix(); // prepares the pixel to be moved
      translate(x, y); // moves the pixel to its designated x and y location
      rect(0+tracks/2, 0+tracks/2, tracks, tracks); // creates each pixel and ensures it fills the entire canvas, makes the size of each pixel according to the amount of tracks
      popMatrix(); // pops the matrix to the current coordinate system
      noStroke(); // ensures there is no outline for the pixels
    } // closes the nested for loop responsible for the x
  } // closes the for loop responsible for the y
  waveform(); // calls the waveform function after the drawing of the album cover
} // closes the draw loop

void waveform() { // function to draw the waveform
  for (int i=0; i<uno.bufferSize() -1; i++) { // a for loop to go through the audio file and create a waveform
    float x = map(i, 0, uno.bufferSize(), 0, width); // creates a float x and maps it to the buffersize and width of the canvas
    float x2 = map(i, 0, uno.bufferSize(), 0, width); // creates a float x2 and maps it to the buffersize and width of the canvas
    line( x, 250 +uno.left.get(i)*50, x2, 250 + uno.left.get(i+1)*50); // draws a line from the x float, and the max height of 250 to the buffersize to give the waveform effect
    stroke(255); // sets the stroke colour to white
    strokeWeight(5); // sets the thickness of the stroke to 5
  } // closes the for loop
} // closes the function to draw the waveform

void keyPressed() { // function to manage key pressed events
  if (key == 'S' || key == 's') { // if the lowercase or uppercase letter 's' is pressed, then...
    saveFrame(); // it takes a screenshot
  } // closes the if statement
  if (key == 'P'|| key == 'p') { // if the p key is pressed then...
    uno.pause(); // pause the track
  } // closes pause if statement
  if (key =='W'|| key == 'w') { // if the w key is pressed then...
    uno.play(); // play the track
  } // closes the play if statement
} // closes the key pressed event handler