//
//  Comment.h
//  MeetMeUp
//
//  Created by Tewodros Wondimu on 1/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property NSString *member_name;
@property NSString *comment;
@property NSString *comment_url;

@property NSNumber *time;
@property NSNumber *group_id;
@property NSNumber *event_id;
@property NSNumber *event_comment_id;
@property NSNumber *member_id;

@end
