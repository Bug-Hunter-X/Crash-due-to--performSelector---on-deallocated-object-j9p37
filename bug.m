This code snippet demonstrates a potential issue in Objective-C related to the use of `performSelector:withObject:afterDelay:` with objects that might be deallocated before the selector is invoked.  If the object `myObject` is deallocated before the delay expires, calling `[myObject performSelector: ... ]` will result in a crash. 

```objectivec
@interface MyObject : NSObject
- (void)myMethod;
@end

@implementation MyObject
- (void)myMethod {
    NSLog("My method was called");
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    MyObject *myObject = [[MyObject alloc] init];
    [self performSelector:@selector(delayedMethod:) withObject:myObject afterDelay:2.0];
    myObject = nil; //Deallocates myObject
}

- (void)delayedMethod:(MyObject *)obj {
    if (obj) {
        [obj myMethod];
    } else {
        NSLog("Object was deallocated");
    }
}
@end
```