#include "Off.h"

Off::Off() {

};

bool Off::tick() {
  for (int i = 0; i < NUM_PIXELS; i++) {
    strip.setPixelColor(i, 0, 0, 0);
  }
  return false;
};

bool Off::end() {
  return this->tick();
}
