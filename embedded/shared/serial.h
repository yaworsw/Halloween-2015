/**
 * serial.h
 */

#import <Arduino.h>

typedef struct serialEvent_
{
    int type;
    String params;
} serialEvent;

bool readSerial(serialEvent* event);
