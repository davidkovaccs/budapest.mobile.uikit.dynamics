//
//  UIDTestViewController.m
//  DynamicTest
//
//  Created by David Kovacs on 5/26/14.
//
//

#import "UIDTestViewController.h"

@interface UIDTestViewController ()

@property UIButton* redSquare;
@property UIDynamicAnimator* animator;
@property UIPushBehavior* pb;

@end

@implementation UIDTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"UIDTestViewController" bundle:nibBundleOrNil];
    
    return self;
}

-(void)initRedSquare
{
    [_redSquare removeFromSuperview];
    
    self.redSquare = [[UIButton alloc] initWithFrame:CGRectMake(110, 110, 100, 100)];
    [_redSquare addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    _redSquare.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redSquare];
    
    _redSquare.transform = CGAffineTransformMakeRotation(M_PI * 0.7);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initRedSquare];
}

-(void)tapped
{
    [_pb setAngle:90.0 magnitude:20];
    [_pb setActive:true];
}

- (IBAction)gravityClicked:(id)sender
{
    [self initRedSquare];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior* gb = [[UIGravityBehavior alloc] initWithItems:@[_redSquare]];

    [_animator addBehavior:gb];
}

- (IBAction)boundariesClicked:(id)sender
{
    [self gravityClicked:self];
    
    UICollisionBehavior* cb = [[UICollisionBehavior alloc] initWithItems:@[_redSquare]];
    cb.translatesReferenceBoundsIntoBoundary = YES;
    
    [_animator addBehavior:cb];
}

- (IBAction)dynamicItemClicked:(id)sender
{
    [self boundariesClicked:self];
    
    UIDynamicItemBehavior* di = [[UIDynamicItemBehavior alloc] initWithItems:@[_redSquare]];
    di.elasticity = 0.8;
    
    [_animator addBehavior:di];
}

- (IBAction)pushClicked:(id)sender
{
    [self dynamicItemClicked:self];
    
    self.pb = [[UIPushBehavior alloc] initWithItems:@[_redSquare] mode:UIPushBehaviorModeInstantaneous];
    
    [_animator addBehavior:_pb];
}

- (IBAction)attachmentClicked:(id)sender
{
    [self pushClicked:self];
    
    UIAttachmentBehavior* ab = [[UIAttachmentBehavior alloc] initWithItem:_redSquare attachedToAnchor:CGPointMake(20, 20)];
    
    UIAttachmentBehavior* ab2 = [[UIAttachmentBehavior alloc] initWithItem:_redSquare attachedToAnchor:CGPointMake(300, 20)];

    ab.damping = 0.2;
    ab.frequency = 1;
    ab2.damping = 0.2;
    ab2.frequency = 1;
    ab2.length = 300;
    ab.length = 300;
    
    [_animator addBehavior:ab];
    [_animator addBehavior:ab2];
}

@end
