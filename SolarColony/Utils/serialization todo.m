/*Deserialize example. in header file:

#import "JSONModel.h"

@interface Person : JSONModel 
@property (nonatomic, strong) NSString* firstname;
@property (nonatomic, strong) NSString* surname;
@end
in implementation file:

#import "JSONModelLib.h"
#import "yourPersonClass.h"

NSString *responseJSON ;
Person *person = [[Person alloc] initWithString:responseJSON error:&err];
if (!err)
{
   NSLog(@"%@  %@", person.firstname, person.surname):
}
Serialize Example. In implementation file:

#import "JSONModelLib.h"
#import "yourPersonClass.h"

Person *person = [[Person alloc] init];
person.firstname = @"Jenson";
person.surname = @"Uee";

NSLog(@"%@", [person toJSONString]);*/