//
//  Component.h
//  XVIEWPodsAppComponent
//
//  Created by yyj on 2018/12/26.
//  Copyright © 2018 zd. All rights reserved.
//

#ifndef Component_h
#define Component_h

#define TARGET(targetName) [NSString stringWithFormat:@"XVIEW%@Manager",[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"component" ofType:@"plist"]][targetName][@"target"]]

#define Name(targetName) [NSString stringWithFormat:@"%@",[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"component" ofType:@"plist"]][targetName][@"target"]]

#define SharedName(targetName) [NSString stringWithFormat:@"shared%@Manager",targetName]

#define ACTION(targetName,actionName) [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"component" ofType:@"plist"]][targetName][actionName]


#endif /* Component_h */
