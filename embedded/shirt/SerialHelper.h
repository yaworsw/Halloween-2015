/**
 * SerialHelper.h
 */

#include <Arduino.h>

class SerialHelper {
  public:
    SerialHelper();
    bool readLine();

    int getCommand();
    String getParams();

  protected:
    bool newLine = true;
    String line  = "";
};
