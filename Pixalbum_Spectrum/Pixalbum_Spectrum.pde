import ddf.minim.*; // imports the minim sound library
import ddf.minim.analysis.*; // imports the ability to analyze a track
PImage album; // declares the album as a PImage
float tracks; // creates a variable for the amount of tracks in the album
float spectrumScale = 4; // creates a float spectrumScale and sets it to 4

Minim minim; // names the Minim library to minim 
AudioPlayer song;  // sets the audio player to uno
FFT fftLin; // creates fast fourier transform and calls it fftLin for lines

void setup() { // opens the setup function
  size(510, 510); // set the screen size to the size of the album cover  
  album = loadImage("damn.jpg"); // loads the album image 
  album.loadPixels(); // loads the album pixels
  noStroke(); // ensures there is no outline for the pixels
  tracks = 17; // input the number of tracks the album has
  minim = new Minim(this); // makes the minim variable to the Minim library to this sketch
  song = minim.loadFile("god.mp3"); // loads the song as a minim file
  song.loop(); // loops the song
  fftLin = new FFT(song.bufferSize(), song.sampleRate()); // sets the variable fftline to a new fft what is the length of the song buffer and the sample rate 
  fftLin.linAverages(30); // makes the average of the lines 30
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

  fftLin.forward(song.mix); // calculates the averages of the lines as the song goes on
  for (int i = 0; i < fftLin.specSize(); i++) { // a for loop that goes through the spectrum size and the frequency of the track at that instance
    stroke(255); // sets the stroke colour to white
    line(i, height, i, height - fftLin.getBand(i)*spectrumScale); // draws a line from the i in the for loop to the height of the canvas, and the frequency of the track at that instance multiplied by the scale of the spectrum
  } // closes for loop
} // closes the draw loop


void keyPressed() { // function to manage key pressed events
  if (key == 'S' || key == 's') { // if the lowercase or uppercase letter 's' is pressed, then...
    saveFrame(); // it takes a screenshot
  } // closes the if statement
  if (key == 'P'|| key == 'p') { // if the p key is pressed then...
    song.pause(); // pause the track
  } // closes pause if statement
  if (key =='W'|| key == 'w') { // if the w key is pressed then...
    song.play(); // play the track
  } // closes the play if statement
} // closes the key pressed event handler