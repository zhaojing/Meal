//
//  HistoryRequest.m
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "HistoryRequest.h"
#import <FMDB/FMDB.h>

@implementation HistoryRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createHistoryTable];
    }
    return self;
}

-(void)dealloc {
    FMDatabase *db = [self getDB];
    [db close];
}

-(FMDatabase *)getDB {
    NSString *documentDirectory  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [FMDatabase databaseWithPath:[documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"]];
}

-(BOOL)createHistoryTable {
    FMDatabase *db = [self getDB];
    if (![db open])
        return false;
    NSString * sql = @"create table if not exists 'History' ('id' text PRIMARY KEY  NOT NULL, 'menuid' text , 'name' VARCHAR(30) , 'location' text , 'price' text , 'date' DOUBLE , 'imageData' blob )";
    return [db executeUpdate:sql];

}

-(BOOL)addHistoryItem:(HistoryItem *)historyitem {
    FMDatabase *db = [self getDB];
    if (![db open])
        return false;
    NSString * sql = @"insert into History (id, menuid, name, location, price, date, imageData) values(?, ?, ?, ?, ?, ?, ?)";
    return [db executeUpdate:sql, historyitem.itemId , historyitem.menuId , historyitem.name , historyitem.location , historyitem.price , [NSString stringWithFormat:@"%lf",(double)[historyitem.date timeIntervalSince1970]], [self transformImage:historyitem.image]];
}

-(BOOL)deleteHistoryItem:(NSString *)itemId {
    FMDatabase *db = [self getDB];
    if (![db open])
        return false;
    NSString * sql = @"delete from History where id = ?";
    return [db executeUpdate:sql, itemId];
}

-(BOOL)modifyHistoryItem:(HistoryItem *)historyitem {
    FMDatabase *db = [self getDB];
    if (![db open])
        return false;
    NSString * sql = @"update History SET menuid = ? , name = ? , location = ? , price = ? , imageData = ? , date = ? WHERE id=?";
    return [db executeUpdate:sql, historyitem.menuId, historyitem.name, historyitem.location, historyitem.price, [self transformImage:historyitem.image], [historyitem.date timeIntervalSince1970], historyitem.itemId];
}

-(NSArray<HistoryItem *> *)getAllHistoryItems {
    FMDatabase *db = [self getDB];
    if (![db open])
        return @[];
    NSMutableArray *historyItems = [NSMutableArray array];
    NSString * sql = @"select * from History";
    FMResultSet * rs = [db executeQuery:sql];
    while ([rs next]) {
        HistoryItem *historyitem = [[HistoryItem alloc]initWithId:[rs stringForColumn:@"id"]
                                                        andMenuID:[rs stringForColumn:@"menuid"]
                                                          andName:[rs stringForColumn:@"name"]
                                                         andprice:[rs stringForColumn:@"price"]
                                                      andLocation:[rs stringForColumn:@"location"]
                                                          andDate:[NSDate dateWithTimeIntervalSince1970:[rs doubleForColumn:@"date"]]
                                                         andImage:[UIImage imageWithData:[rs dataForColumn:@"imageData"]]];
        [historyItems addObject:historyitem];
    }
    return historyItems;
}

-(NSData *)transformImage:(UIImage *)image {
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    return data;
}

@end
