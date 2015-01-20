//
//  Meetup.h
//  MeetMeUp
//
//  Created by Tewodros Wondimu on 1/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meetup : NSObject

@property NSString *status;
@property NSString *visibility;
@property NSString *event_url;
@property NSString *event_description;
@property NSString *name;

@property NSNumber *maybe_rsvp_count;
@property id event_id;
@property NSNumber *utc_offset;
@property NSNumber *distance;
@property NSNumber *duration;
@property NSNumber *time;
@property NSNumber *waitlist_count;
@property NSNumber *updated;
@property NSNumber *yes_rsvp_count;
@property NSNumber *created;
@property NSNumber *headcount;

@property NSDictionary *group;
@property NSDictionary *venue;

@end
