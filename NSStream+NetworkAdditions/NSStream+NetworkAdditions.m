//
//  NSStream+NetworkAdditions.m
//
//  Created by kkato on 2012/11/01.
//  Copyright (c) 2012 CrossBridge. All rights reserved.
//  Licensed under the Apache License, Version 2.0;
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "NSStream+NetworkAdditions.h"

@implementation NSStream (NetworkAdditions)

+ (BOOL)getStreamsToHostNamed:(NSString *)hostName
                         port:(NSInteger)port
                  inputStream:(NSInputStream **)inputStreamPointer
                 outputStream:(NSOutputStream **)outputStreamPointer {
  if (!hostName) {
    return NO;
  }
  
  if ((port <= 0) || (655356 <= port)) {
    return NO;
  }
  
  if (!inputStreamPointer && !outputStreamPointer) {
    return NO;
  }
  

  CFReadStreamRef readStream = NULL;
  CFWriteStreamRef writeStream = NULL;
  
  CFStreamCreatePairWithSocketToHost(NULL,
                                     (__bridge CFStringRef)hostName,
                                     port,
                                     ((inputStreamPointer  != NULL) ? &readStream : NULL),
                                     ((outputStreamPointer != NULL) ? &writeStream : NULL));
  
  if (inputStreamPointer) {
    *inputStreamPointer = CFBridgingRelease(readStream);
  }
  
  if (outputStreamPointer) {
    *outputStreamPointer = CFBridgingRelease(writeStream);
  }
  
  return YES;
}

@end
