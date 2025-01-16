# Objective-C Crash: `performSelector:` on Deallocated Object

This repository demonstrates a common Objective-C error: performing a selector on an object that has already been deallocated. This often leads to crashes.

## The Problem
The issue arises when using `performSelector:withObject:afterDelay:` or similar methods. If the target object is deallocated before the delay expires, attempting to call a method on it results in an application crash.

## Solution
The solution involves using techniques to ensure the object remains in memory until the selector is executed, such as using weak references in conjunction with appropriate checks or utilizing Grand Central Dispatch's blocks.