# CZKit #

## Usage ##

### Installing CZKit in Your Xcode Project ###

#### Retrieval ####

First things first, you need to get a copy of CZKit. Currently I would recommend cloning the repository from GitHub (or your own fork, if you'd like):

	git clone git://github.com/CarterA/CZKit.git

You could also use submodules, if your project is currently tracked by git:

	mkdir Modules
	git submodule add git://github.com/CarterA/CZKit.git Modules/CZKit
	git submodule init
	git submodule update
		
You can run `git submodule update` at any time again to pull any revisions I make to your computer.

### Adding to a Mac Application ###

As a lucky Mac developer, you actually have a choice as to how you integrate CZKit (as opposed to iOS developers, see the next section). You can choose to either add the CZKit project itself to your own project and then set it as a dependency of your app (easiest for updating the framework), or to copy the compiled framework directly into your project (easiest to set up now).

#### Adding as a Dependency ####

1. Start by dragging `CZKit.xcodeproj` (from your copy of this repository) into your own project's Xcode organizer. It doesn't matter what group you put it in, do whatever makes the most sense to you. In the sheet that opens up, make sure to *uncheck* "Copy items into destination group's folder (if needed)". The rest of the settings can remain default.  

2. Click the disclosure triangle next to `CZKit.xcodeproj` in the organizer, as well as the triangle next to `Targets` and then your own application's target. Drag `CZKit.framework` from inside `CZKit.xcodeproj` into the "Link Binary with Libraries" group inside your application's target.  

3. Right click your application's target and select Add > New Build Phase > New Copy Files Build Phase. In the window that comes up, set the "Destination" to "Frameworks" and then close the window. Right click the build phase you just added and rename it to "Copy Frameworks". Drag `CZKit.framework` from `CZKit.xcodeproj` into the new "Copy Frameworks" build phase.  

4. Select your application's target and hit Command-I. Make sure you're in the "General" tab and hit the "+" button under the "Direct Dependencies" table. From the sheet that slides in, select `Framework` under `CZKit.xcodeproj`, then press "Add Target".  

You're done! You can now add `#import <CZKit/CZKit.h>` in any of your files and start using the framework.

#### Adding the Compiled Framework ####

1. Open `CZKit.xcodeproj` (from your copy of this repository) and build the "Framework" target in Release mode.  

2. Close the Xcode project and navigate in Finder to the `Products/Release` directory inside of the CZKit folder. Select `CZKit.framework` and drag it into your application's Xcode project.   Drop it anywhere you'd like. In the sheet that opens up, make sure to *uncheck* "Copy items into destination group's folder (if needed)". The rest of the settings can remain default.  

3. Click the disclosure triangle next to `Targets` and then your own application's target. Drag `CZKit.framework` into the "Link Binary with Libraries" group inside your application's target.

4. Right click your application's target and select Add > New Build Phase > New Copy Files Build Phase. In the window that comes up, set the "Destination" to "Frameworks" and then close the window. Right click the build phase you just added and rename it to "Copy Frameworks". Drag `CZKit.framework` into the new "Copy Frameworks" build phase.  

That's all! You can now add `#import <CZKit/CZKit.h>` in any of your files and start using the framework.

### Adding to an iOS Application ###

I'm afraid I have no good news for you if you want to use CZKit with an iOS app. First of all, a large portion of the code isn't iOS compatible (though that is dynamically removed from the iOS version). Second, the system Apple has set up for shared code is really annoying. Frameworks are not allowed because they are wrappers around dynamic libraries, which are banned on the App Store. What that means is that we have to use a static library, which does not include a way to package headers, resources, and code all together. Thus, this is way more complicated than it should have to be.

1. Follow step 1 in the "Adding as a Dependency" section (inside the "Adding to a Mac Application").  

2. Click the disclosure triangle next to `CZKit.xcodeproj` in the organizer, as well as the triangle next to `Targets` and then your own application's target. Drag `libCZKit.a` from inside `CZKit.xcodeproj` into the "Link Binary with Libraries" group inside your application's target.  

3. Select your application's target and hit Command-I. Make sure you're in the "General" tab and hit the "+" button under the "Direct Dependencies" table. From the sheet that slides in, select `CZKit` under `CZKit.xcodeproj`, then press "Add Target".  

4. Before you leave the Target Inspector, switch to the "Build" tab and search for the "Other Linker Flags" property. Double click it and add two flags:  `-ObjC` and `-all_load`.  

5. Confirm the previous sheet's changes and then search for the "Header Search Paths" property. Double click it. You need to add the relative path to a folder that doesn't actually exist yet, but that isn't as bad as it sounds, I promise. Get the relative path to the CZKit folder, then append "Products/$(CONFIGURATION)/Headers". This tells Xcode where to look for the CZKit headers.

Done! That was painful, right? So sorry. You can now add `#import "CZKit.h"` in any of your files and start using the framework.

## Coding Style ##

One of the nice things about CZKit is the uniformity of all of its source code. I strongly recommend the adoption of this style across other projects as well, though I have a feeling that it won't be, simply due to developers being stuck in their ways. **Here are the rules:**  

### General Rules ##

* There is **never** more then one empty line between any given pair of lines.  
* If it can go on one line, then it **does**.
* Any characters which are used to **close** a piece of code that is **multiple lines long**, should be **on their own line.** Examples of this include closing braces '}', closing parenthesis ')', and the end of a multi-line comment '*/'.
* Whenever pointers '\*' are used, they should be 'attached' to the variable *name*, not the variable type. For example, `NSString *theString;` is fine, but both `NSString* theString;` and `NSString * theString;` are not.  

### Comments ###

* Comments that describe code should have a space after the '//' or '/*', but lines of code that are commented out for debugging purposes should not.  
	Example:  
		// The following code is courtesy of some other person  
		//[class runMethod];
* All implementation code should be self-documenting whenever possible, so comments explaining code shouldn't be necessary. If they are, the comment should be brief, and added to the same line as the code file, one space after the ';'. Although brief, they should always be complete sentences, ending with a period.  
	Example:  
		TheClass *class = [[TheClass alloc] init]; // Create an instance of TheClass for us to work with.  
* Public headers must be documented with Doxygen-style comments, which follow this syntax:  
		/** The first line is a brief, one-sentence description of the function/method.  
		This are describes anything else someone might need to know about the function/method. It can describe the way it works, best practices, etc. and can use multiple sentences. It should be no more then a paragraph in length.
		@param paramName This describes what paramName means in the context of the function/method, in one sentence.  
		@return This describes the return value of the function, and can be multiple sentences if possible.
		*/  
		- (NSString *)runMethod:(TheParam *)paramName;  
		
### Methods ###

* Individual methods are never separated by a blank line. The only separator allowed for methods is a #pragma mark, and only when that is helpful.  
* There is no space before the initial hyphen '-' or plus sign '+' at the beginning of the method name, but there is a space after it.  
* There is no space between the closing parenthesis ')' of the return value and the beginning of the method name.  
* There is no space between the colon(s) ':' and the following variable type.  
* There is no space between the closing parenthesis ')' of the variable type and the name of the variable.  
* There is a space after a variable in a method name, unless it is the end of the method name.  
* In the implementation file, the end of a method name should not be suffixed with a semicolon. There should simply be a single space, and then an opening brace '{'.  
* The variable type in parenthesis (in any part of the method name) should always have a space after it, before the '*'. This only applies if it is a pointer, of course.

Here is an example of a properly formatted method name:  
`- (void)runMethodWithParameter:(TheParam *)paramName shouldRunImmediately:(BOOL)runImmediately {`  

Here are a few examples of how **not** to format method names:  
` -(void) runMethodWithParameter : ( TheParam*) paramName shouldRunImmediately: ( BOOL) runImmediately; {`  
`- (void)runMethodWithParameter:(TheParam *)paramName shouldRunImmediately:(BOOL)runImmediately; {`  
`- (void)runMethodWithParameter:(TheParam *)paramName shouldRunImmediately:(BOOL)runImmediately
 {`  