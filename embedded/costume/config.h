#define DEBUG

#define DRESS

#ifdef  DRESS
#define NAME      "Dress"
#define PIXEL_PIN  0
#define BRIGHTNESS 255
#define NUM_PIXELS 40
// #define DOUBLE
// #define MIRROR
#endif

#ifdef  NECKLACE
#define NAME      "Necklace"
#define PIXEL_PIN  0
#define BRIGHTNESS 150
#define NUM_PIXELS 10
// #define DOUBLE
// #define MIRROR
#endif

#ifdef  EARRINGS
#define NAME      "Earrings"
#define PIXEL_PIN  0
#define BRIGHTNESS 150
#define NUM_PIXELS 7
#define DOUBLE
// #define MIRROR
#endif

#ifdef  VEST
#define NAME      "Vest"
#define PIXEL_PIN  4
#define BRIGHTNESS 255
#define NUM_PIXELS 15
#define DOUBLE
#define MIRROR
#endif

#ifdef  BELT
#define NAME      "Belt"
#define PIXEL_PIN  0
#define BRIGHTNESS 150
#define NUM_PIXELS 56
// #define DOUBLE
// #define MIRROR
#endif
