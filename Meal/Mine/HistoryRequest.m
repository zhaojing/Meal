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
    NSString * sql = @"create table if not exists 'History' ('id' text PRIMARY KEY  NOT NULL, 'menuid' text , 'name' VARCHAR(30) , 'location' text , 'date' text , 'year' INTEGER , 'month' INTEGER , 'price' text , 'imageData' blob )";
    return [db executeUpdate:sql];
}

-(BOOL)addHistoryItem:(HistoryItem *)historyitem {
    FMDatabase *db = [self getDB];
    if (![db open])
        return false;
    NSString * sql = @"insert into History (id, menuid, name, location, date, year, month, price, imageData) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
    return [db executeUpdate:sql, historyitem.itemId , historyitem.menuId , historyitem.name , historyitem.location, historyitem.date, [NSString stringWithFormat:@"%ld",(long)historyitem.year], [NSString stringWithFormat:@"%ld",(long)historyitem.month], historyitem.price, [self transformImage:historyitem.image]];
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
    NSString * sql = @"update History SET menuid = ? , name = ? , location = ? , date = ? , year = ? , month = ? , price = ? , imageData = ? WHERE id=?";
    return [db executeUpdate:sql, historyitem.menuId, historyitem.name, historyitem.location, historyitem.date, (long)historyitem.year, (long)historyitem.month, historyitem.price, [self transformImage:historyitem.image], historyitem.itemId];
    
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
                                                          andDate:[rs stringForColumn:@"date"]
                                                          andYear:[rs intForColumn:@"year"]
                                                         andMonth:[rs intForColumn:@"month"]
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
