#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <ReactAppDependencyProvider/RCTAppDependencyProvider.h>
// Force import to ensure linker includes the library
#if __has_include("BLEAdvertiser.h")
#import "BLEAdvertiser.h"
#elif __has_include(<react-native-ble-advertiser/BLEAdvertiser.h>)
#import <react-native-ble-advertiser/BLEAdvertiser.h>
#endif

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"Najah360";
  self.dependencyProvider =  [RCTAppDependencyProvider new];
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};

  // Force Linkage of BLEAdvertiser (legacy module)
  // This prevents dead-code stripping if the bridge doesn't automatically pick it up
  #if __has_include("BLEAdvertiser.h") || __has_include(<react-native-ble-advertiser/BLEAdvertiser.h>)
    [BLEAdvertiser class];
  #endif

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [self bundleURL];
}

- (NSURL *)bundleURL
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
