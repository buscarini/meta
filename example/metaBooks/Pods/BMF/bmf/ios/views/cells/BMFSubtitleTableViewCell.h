//
//  BMFSubtitleTableViewCell.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 26/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFTableViewCell.h"

@interface BMFSubtitleTableViewCell : BMFTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *marginConstraints;

@property (nonatomic, assign) CGFloat labelsMargin;

@end
