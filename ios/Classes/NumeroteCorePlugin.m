#import "NumeroteCorePlugin.h"
#if __has_include(<numerote_core/numerote_core-Swift.h>)
#import <numerote_core/numerote_core-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "numerote_core-Swift.h"
#endif

@implementation NumeroteCorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNumeroteCorePlugin registerWithRegistrar:registrar];
}
@end
