#include <Arduino.h>
#include "Action.h"
#include "config.h"
#include "strip.h"

class RainbowAll: public Action {
  public:
    RainbowAll();
    bool tick();
    bool end();
  protected:
    int frame = 0;
    int frames;

    byte hue = 0;
    byte inc;
};
