#include "Identify.h"

Identify::Identify() {

};

bool Identify::tick() {
  Bean.setLed(255, 0, 0);
  delay(500);
  Bean.setLed(0, 0, 0);
  return false;
};

bool Identify::end() {
  return this->tick();
}
