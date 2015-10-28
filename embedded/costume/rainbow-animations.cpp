#include "rainbow-animations.h"

// Sequence

Rainbow::Rainbow() {
  this->frames = NUM_PIXELS * 3;
  this->inc    = 255 / this->frames;
}

bool Rainbow::tick() {
  int pixel = this->frame % NUM_PIXELS;
  this->hue = (this->hue + this->inc) % 255;

  strip.setPixelColor(pixel, Wheel(this->hue));
  this->frame++;

  if (this->frame > this->frames) {
    this->frame = 0;
  }

  return true;
}

bool Rainbow::end() {
  return false;
}

// All

RainbowAll::RainbowAll() {
  this->frames = NUM_PIXELS * 3;
  this->inc    = 255 / this->frames;
}

bool RainbowAll::tick() {
  this->hue = (this->hue + this->inc) % 255;

  for (int i = 0; i < NUM_PIXELS; i++) {
    strip.setPixelColor(i, Wheel(this->hue));
  }
  this->frame++;

  if (this->frame > this->frames) {
    this->frame = 0;
  }

  return true;
}

bool RainbowAll::end() {
  return false;
}

// Shift

RainbowShift::RainbowShift() {
  this->inc = 255 / NUM_PIXELS;
}

bool RainbowShift::tick() {
  this->hue = (this->hue + this->inc) % 255;

  for (int i = 0; i < NUM_PIXELS; i++) {
    byte hue = (this->hue + (this->inc * i)) % 255;
    strip.setPixelColor(i, Wheel(hue));
  }
  this->frame++;

  if (this->frame > NUM_PIXELS) {
    this->frame = 0;
  }

  return true;
}

bool RainbowShift::end() {
  return false;
}
