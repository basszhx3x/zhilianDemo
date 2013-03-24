

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface myAnnotation : NSObject<MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic,assign)CGFloat centerlatitude;
@property(nonatomic,assign)CGFloat centerlongitude;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate; 
//-(id) initWithCoordinate:(CLLocationCoordinate2D) coords;
@end
