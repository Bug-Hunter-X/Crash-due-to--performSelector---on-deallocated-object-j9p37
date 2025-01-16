The solution is to use blocks with GCD instead of `performSelector:withObject:afterDelay:`.

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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ 
        if (myObject) { 
            [myObject myMethod]; 
        } else { 
            NSLog("Object was deallocated"); 
        } 
    });
    myObject = nil; //Deallocates myObject
}
@end
```
This revised code utilizes Grand Central Dispatch (GCD) to schedule the execution of the `myMethod` selector.  The block retains a strong reference to `myObject` in the GCD queue, ensuring that it is not deallocated before the method call.