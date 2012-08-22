//
//  GettingCoreContent.h
//  Restaurants
//
//  Created by Matrix Soft on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "XMLParse.h"

@interface GettingCoreContent : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSArray *arrayOfCoreData;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
- (NSArray *)getArrayFromCoreDatainEntetyName:(NSString *)entityName withSortDescriptor:(NSString *)attributeString;
//- (void) setArrauCoreatEntity:(NSString *)entityName;

//coommememmed
- (void) setCoreDataForEntityWithName:(NSString *)entityName 
                dictionaryOfAtributes:(NSDictionary *)attributeDictionary;
- (void) deleteAllObjectsFromEntity:(NSString *)entityDescription;
- (NSArray *)fetchAllRestaurantsWithDefaultLanguageAndCity;
- (NSArray *)fetchRootMenuWithDefaultLanguageForRestaurant:(NSString *)restaurnatId;
- (NSArray *)fetchChildMenuWithDefaultLanguageForParentMenu:(NSString *)parentMenuId;
- (NSArray *)fetchAllLanguages;
- (NSArray *)fetchAllCitiesByLanguage:(NSString *)languageId;
- (NSURL *)fetchImageURLbyPictureID:(NSString *)pictureId;
- (NSArray *)fetchAllProductsFromMenu:(NSString *)menuId;
- (void)SavePictureToCoreData:(NSString *)idPicture toData:(NSData *)data;
- (NSData *)fetchPictureDataByPictureId:(NSString *)pictureId;
- (NSDictionary *)fetchImageURLAndDatabyMenuID:(NSString *)menuId;

- (void)SaveProductToEntityName:(NSString *)entityName
                         WithId:(NSNumber *)underbarid
                      withCount:(int)countOfProducts
                      withPrice:(float)cost
                    withPicture:(NSData *)picture
                   withDiscountValue:(float)discountValue;

- (NSArray *)fetchAllProductsIdAndTheirCountWithPriceForEntity:(NSString *)entityName;

//- (void) deleteObjectFromEntity:(NSString *)entityName atIndexPath:(NSIndexPath *)indexPath;
- (void) deleteObjectFromEntity:(NSString *)entityName
                  withProductId:(NSNumber *)underbarid;

- (NSArray *) fetchObjectsFromCoreDataForEntity:(NSString *)entityName
                               withArrayObjects:(NSArray *)underbaridsArray
                          withDefaultLanguageId:(NSString *)languageId;

//для updatePHP, а саме параметра tag=param
- (NSNumber *) fetchMaximumNumberOfAttribute:(NSString *)fieldName
                                  fromEntity:(NSString *)entityName;


- (NSArray *) fetchAllIdsFromEntity:(NSString *)entityName;

- (int) fetchCountOfProductsInEntity:(NSString *)entityName;

-  (void) addObjectToEntity:(NSString *)entityName
 withDictionaryOfAttributes:(NSDictionary *)dictionary;

- (void) deleteAddressWithName:(NSString *)name;

- (NSArray *)fetchFavoritesFromEntityName:(NSString *)entityName;
- (void) changeFavoritesBoolValue:(BOOL)isFavorites forId:(NSNumber *)underbarid;
@end
