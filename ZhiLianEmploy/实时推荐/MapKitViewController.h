

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "myAnnotation.h"
@interface MapKitViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,retain)MKMapView *mapView;
@property(nonatomic,assign)double  currentlatitude;
@property(nonatomic,assign)double currentlongitude;
@property(nonatomic,retain)CLLocationManager *locManager;
@property(nonatomic,retain)CLGeocoder *geocoder;
@property(nonatomic,retain)myAnnotation *place;

@end
