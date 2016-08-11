//
//  MenuRequest.m
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "MenuRequest.h"
#import <FMDB/FMDB.h>

@implementation MenuRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createTable];
    }
    return self;
}

- (void)dealloc {
    FMDatabase *db = [self getDB];
    [db close];
}

- (FMDatabase *)getDB {
    NSString *documentDirectory  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    return [FMDatabase databaseWithPath: [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"]];
}

- (BOOL)createTable {
    FMDatabase *db = [self getDB];
    if (![db open])
        return false;
    NSString * sql = @"create table if not exists 'Menu' ('id' text PRIMARY KEY  NOT NULL , 'name' VARCHAR(30) , 'location' text , 'price' text , 'imageData' blob )";
    return [db executeUpdate:sql];
}

- (BOOL)addMenu: (Menu *)menu {
    FMDatabase *db = [self getDB];
    if (![db open])
        return false;
    NSString * sql = @"insert into Menu (id, name, location, price, imageData) values(?, ?, ?, ?, ?)";
    return [db executeUpdate: sql, menu.menuId, menu.name, menu.location, menu.price, [self transformImage: menu.image]];
}

- (BOOL)deleteMenu: (NSString *)menuId {
    FMDatabase *db = [self getDB];
    if (![db open])
        return false;
    NSString * sql = @"delete from Menu where id = ?";
    return [db executeUpdate:sql, menuId];
}

- (BOOL)modifyMenu: (Menu *)menu {
    FMDatabase *db = [self getDB];
    if (![db open])
        return false;
    NSString * sql = @"update Menu SET name = ?, location = ?, price = ? , imageData = ? WHERE id=?";
    return [db executeUpdate:sql, menu.name, menu.location, menu.price, [self transformImage:menu.image], menu.menuId];
}

- (NSArray<Menu *> *)getAllMenus {
    FMDatabase *db = [self getDB];
    if (![db open])
        return @[];
    NSMutableArray *menus = [NSMutableArray array];
    NSString * sql = @"select * from Menu";
    FMResultSet * rs = [db executeQuery:sql];
    while ([rs next]) {
        Menu *menu = [[Menu alloc]initWithId: [rs stringForColumn:@"id"]
                                     andName: [rs stringForColumn:@"name"]
                                    andprice: [rs stringForColumn:@"price"]
                                 andLocation: [rs stringForColumn:@"location"]
                                    andImage: [UIImage imageWithData:[rs dataForColumn: @"imageData"]]];
        [menus addObject: menu];
    }
    return menus;
}

- (NSData *)transformImage: (UIImage *)image {
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    return data;
}

@end
