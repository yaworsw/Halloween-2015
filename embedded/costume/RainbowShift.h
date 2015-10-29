#include <Arduino.h>
#include "Action.h"
#include "config.h"
#include "strip.h"

class RainbowShift: public Action {
  public:
    RainbowShift();
    bool tick();
    bool end();
  protected:
    int frame = 0;

    byte hue = 0;
    byte inc;
};
