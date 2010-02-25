##Coding Style  
One of the nice things about CZKit is the uniformity of all of its source code. I strongly recommend the adoption of this style across other projects as well, though I have a feeling that it won't be, simply due to developers being stuck in their ways. **Here are the rules:**  

###General Rules  

* There is **never** more then one empty line between any given pair of lines.  
* If it can go on one line, then it **does**.
* Any characters which are used to **close** a piece of code that is **multiple lines long**, should be **on their own line.** Examples of this include closing braces '}', closing parenthesis ')', and the end of a multi-line comment '*/'.
* Whenever pointers '\*' are used, they should be 'attached' to the variable *name*, not the variable type. For example, `NSString *theString;` is fine, but both `NSString* theString;` and `NSString * theString;` are not.  

###Comments  

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
		
###Methods  

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