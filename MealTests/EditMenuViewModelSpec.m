//
//  EditMenuViewModelSpec.m
//  Meal
//
//  Created by JingZhao on 8/8/16.
//  Copyright 2016 JingZhao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "OCMock.h"
#import "EditMenuViewModel.h"
#import "Menu.h"

@interface EditMenuViewModel ()

- (void)saveEditTypeTheImage: (UIImage *)image
                     andName: (NSString *)name
                 andLocation: (NSString *)location
                    andPrice: (NSString *)price
                  andSuccess: (void(^)(NSString *successInfo))success
                    andError: (void(^)(NSString* errorInfo))error;

- (void)saveAddTypeTheImage: (UIImage *)image
                    andName: (NSString *)name
                andLocation: (NSString *)location
                   andPrice: (NSString *)price
                 andSuccess: (void(^)(NSString *successInfo))success
                   andError: (void(^)(NSString* errorInfo))error;
@end

SPEC_BEGIN(EditMenuViewModelSpec)

describe(@"EditMenuViewModel", ^{
    context(@"when model is nil", ^{
        EditMenuViewModel *viewModel = [[EditMenuViewModel alloc]init];
        it(@"type it should  equal addType", ^{
            [[theValue([viewModel getTheType]) should] equal: theValue(addType)];
        });
        it(@"TitleName should equal 添加食物 ", ^{
            [[[viewModel getTitleName] should] equal: @"添加食物"];
        });
    });
    context(@"when model is exist", ^{
        __block EditMenuViewModel *viewModel;
        beforeEach(^{
            id menuMock = [OCMockObject mockForClass: [Menu class]];
            viewModel = [[EditMenuViewModel alloc] init];
            [viewModel stub: @selector(menu) andReturn: menuMock];
        });
        it(@"type it should  equal editType", ^{
            [[theValue([viewModel getTheType]) should] equal: theValue(editType)];
        });
        it(@"TitleName should equal 编辑食物 ", ^{
            [[[viewModel getTitleName] should] equal: @"编辑食物"];
        });
    });
    context(@"SourceTypeAvailable Album", ^{
        it(@"source not available ", ^{
            [UIImagePickerController stub:@selector(isSourceTypeAvailable:) andReturn:theValue(false)];
            EditMenuViewModel *viewModel = [[EditMenuViewModel alloc] init];
            UIImagePickerController *picker = [viewModel getAlbumController];
            [[picker should] beNil];
        });
        it(@"Source available  should return sourceType equal UIImagePickerControllerSourceTypeCamera", ^{
            [UIImagePickerController stub: @selector(isSourceTypeAvailable:) andReturn: theValue(true)];
            EditMenuViewModel *viewModel = [[EditMenuViewModel alloc] init];
            UIImagePickerController *picker = [viewModel getAlbumController];
            [[theValue(picker.sourceType) should] equal: theValue(UIImagePickerControllerSourceTypePhotoLibrary)];
        });
    });
    context(@"SourceTypeAvailable ImagePicker", ^{
        it(@"source not available ", ^{
            [UIImagePickerController stub: @selector(isSourceTypeAvailable:) andReturn: theValue(false)];
            EditMenuViewModel *viewModel = [[EditMenuViewModel alloc]init];
            UIImagePickerController *picker = [viewModel getImageController];
            [[picker should] beNil];
        });
        it(@"Source available  should return sourceType equal UIImagePickerControllerSourceTypeCamera", ^{
            [UIImagePickerController stub: @selector(isSourceTypeAvailable:) andReturn:  theValue(true)];
            EditMenuViewModel *viewModel = [[EditMenuViewModel alloc]  init];
            UIImagePickerController *picker = [viewModel getImageController];
            [[theValue(picker.sourceType) should] equal: theValue(UIImagePickerControllerSourceTypeCamera)];
        });
    });
    context(@"call different function according", ^{
        it(@"type equal editType call saveEdit", ^{
            EditMenuViewModel *viewModel = [[EditMenuViewModel alloc]init];
            [viewModel stub: @selector(getTheType) andReturn: editType];
            [[viewModel should]receive: @selector(saveEditTypeTheImage:andName:andLocation:andPrice:andSuccess:andError:)];
            [viewModel saveTheImage: nil
                            andName: @""
                        andLocation: @""
                           andPrice: @""
                         andSuccess: nil
                           andError: nil];
        });
        it(@"type equal addType call saveAdd", ^{
            EditMenuViewModel *viewModel = [[EditMenuViewModel alloc]init];
            [viewModel stub:@selector(getTheType) andReturn: theValue(addType)];
            [[viewModel should]receive: @selector(saveAddTypeTheImage:andName:andLocation:andPrice:andSuccess:andError:)];
            [viewModel saveTheImage: nil
                            andName: @""
                        andLocation: @""
                           andPrice: @""
                         andSuccess: nil
                           andError: nil];
        });
    });
});

SPEC_END
