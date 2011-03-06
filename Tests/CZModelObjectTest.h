//
//  CZModelObjectTest.h
//  CZKit
//
//  Created by Carter Allen on 2/9/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <CZKit/CZKit.h>

@interface CZModelObjectTest : CZModelObject {}
@property (nonatomic, assign) id idProperty;
@property (nonatomic, assign) NSInteger integerProperty;
@property (nonatomic, assign) CGFloat floatProperty;
@property (nonatomic, retain) NSArray *objectProperty;
@property (nonatomic, assign) CGRect rectProperty;
@property (nonatomic, assign) CGSize sizeProperty;
@property (nonatomic, assign) CGPoint pointProperty;
@property (nonatomic, assign) NSRange rangeProperty;
@end

@interface CZModelObjectTestRunner : SenTestCase {}
@property (nonatomic, retain) CZModelObjectTest *modelObject;
@end
