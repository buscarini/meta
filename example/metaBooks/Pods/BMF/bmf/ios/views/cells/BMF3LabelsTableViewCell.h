//
//  TRN3LabelsTableViewCell.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 20/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMFTableViewCell.h"

@interface BMF3LabelsTableViewCell : BMFTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *accessoryTextLabel;

@end
