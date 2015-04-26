//
//  AnimationViewController.m
//  WWDC2015
//
//  Created by Jonathan Chan on 2015-04-25.
//  Copyright (c) 2015 Jonathan Chan. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation AnimationViewController

#pragma mark - VC lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self beginAnimating];
    [self playAudio];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self stopAudio];
}

#pragma mark - Audio

- (void)playAudio {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AnimationAudio" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.audioPlayer play];
}

- (void)stopAudio {
    [self.audioPlayer stop];
}

#pragma mark - Animations

#pragma mark World scene

- (void)beginAnimating {
    [self animateWorldScene];
}

- (void)animateWorldScene {
    [self animateWorldSceneSlideLaptop];
}

// Start: 3.5, End: 4.5, Time since last animation finished: 3.5
- (void)animateWorldSceneSlideLaptop {
    UIImageView *laptopView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaptopIcon"]];
    laptopView0.frame = CGRectMake(0, 0, 150, 100);
    laptopView0.contentMode = UIViewContentModeScaleAspectFit;
    laptopView0.center = self.view.center;
    [self.view addSubview:laptopView0];

    UIImageView *laptopView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaptopIcon"]];
    laptopView1.frame = CGRectMake(0, 0, 150, 100);
    laptopView1.contentMode = UIViewContentModeScaleAspectFit;
    laptopView1.center = CGPointMake(self.view.center.x + laptopView1.frame.size.width / 2, self.view.center.y);
    laptopView1.alpha = 0;
    [self.view addSubview:laptopView1];

    [UIView animateWithDuration:1 delay:3.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        laptopView0.center = CGPointMake(self.view.center.x - laptopView0.frame.size.width / 2, laptopView0.center.y);
        laptopView1.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [self animateWorldSceneShowWorldWithLaptop0:laptopView0 laptop1:laptopView1];
        }
    }];
}

// Start: 5.5, End: 6.5, Time since last animation finished: 1
- (void)animateWorldSceneShowWorldWithLaptop0:(UIImageView *)laptopView0 laptop1:(UIImageView *)laptopView1 {
    UIImageView *worldView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WorldTechnology"]];
    worldView.center = self.view.center;
    worldView.alpha = 0;
    [self.view addSubview:worldView];

    [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        laptopView0.frame = CGRectMake(self.view.center.x - 46, self.view.center.y - 124, laptopView0.frame.size.width * 0.167, laptopView0.frame.size.height * 0.167);
        laptopView1.frame = CGRectMake(self.view.center.x + 23, self.view.center.y - 124, laptopView1.frame.size.width * 0.167, laptopView1.frame.size.height * 0.167);
        laptopView0.alpha = 0;
        laptopView1.alpha = 0;
        worldView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [laptopView0 removeFromSuperview];
            [laptopView1 removeFromSuperview];
            [self animateWorldSceneSpinWorld:worldView];
        }
    }];
}

// Start: 7, End: 11, Time since last animation finished: 0.5
- (void)animateWorldSceneSpinWorld:(UIImageView *)worldView {
    [UIView animateWithDuration:4 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        worldView.transform = CGAffineTransformRotate(worldView.transform, M_PI);
    } completion:^(BOOL finished) {
        [self animateWorldSceneFadeIntoSmileWithWorld:worldView];
    }];
}

// Start: 11, End: 14, Time since last animation finished: 0
- (void)animateWorldSceneFadeIntoSmileWithWorld:(UIImageView *)worldView {
    UIImageView *smileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CircleSmile"]];
    smileView.center = self.view.center;
    smileView.alpha = 0;
    [self.view addSubview:smileView];

    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        worldView.alpha = 0;
        smileView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [worldView removeFromSuperview];
            [self animateTransitionToCodeSceneWithSmile:smileView];
        }
    }];
}

// Start: 14.833, End: 15.5, Time since last animation finished: 0.833
- (void)animateTransitionToCodeSceneWithSmile:(UIImageView *)smileView {
    [UIView animateWithDuration:0.667 delay:0.833 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        smileView.frame = CGRectMake(-smileView.frame.size.width, smileView.frame.origin.y, smileView.frame.size.width, smileView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [smileView removeFromSuperview];
            [self animateCodeScene];
        }
    }];
}

// Start: 15.5, End: 18.5, Time since last animation finished: 0
- (void)animateCodeScene {
    NSString *code = @"[self improveEnvironment:self.environment\n              completion:nil];\n// will probably never complete anyway";
    UILabel *codeLabel = [UILabel new];
    codeLabel.numberOfLines = 3;
    codeLabel.text = code;
    codeLabel.font = [UIFont fontWithName:@"Menlo-Regular" size:12];
    [codeLabel sizeToFit];
    codeLabel.center = self.view.center;
    codeLabel.text = nil;
    [self.view addSubview:codeLabel];
    [NSTimer scheduledTimerWithTimeInterval:3.0 / 111.0 /* 3 seconds / n chars */ target:self selector:@selector(appendCharaterFromStringToLabel:) userInfo:@[code, codeLabel] repeats:YES];
}

- (void)appendCharaterFromStringToLabel:(NSTimer *)sender {
    NSString *text = sender.userInfo[0];
    UILabel *label = sender.userInfo[1];
    label.text = [text substringToIndex:[label.text length] + 1];

    if ([label.text isEqualToString:text]) {
        [sender invalidate];
        [self animateTransitionToLeaderSceneWithCode:label];
    }
}

// Start: 18.5, End: 19.333, Time since last animation finished: 0
- (void)animateTransitionToLeaderSceneWithCode:(UILabel *)codeLabel {
    UIImageView *personView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Person"]];
    UIImageView *personView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Person"]];
    UIImageView *personWithGlassesView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PersonWithGlasses"]];
    personWithGlassesView.center = self.view.center;
    personWithGlassesView.alpha = 0;
    [self.view addSubview:personWithGlassesView];
    personView0.frame = CGRectMake(personWithGlassesView.frame.origin.x - personView0.frame.size.width, personWithGlassesView.frame.origin.y, personView0.frame.size.width, personView0.frame.size.height);
    personView0.alpha = 0;
    [self.view addSubview:personView0];
    personView1.frame = CGRectMake(personWithGlassesView.frame.origin.x + personView1.frame.size.width, personWithGlassesView.frame.origin.y, personView1.frame.size.width, personView1.frame.size.height);
    personView1.alpha = 0;
    [self.view addSubview:personView1];

    [UIView animateWithDuration:0.5 delay:0.333 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        codeLabel.frame = CGRectMake(-codeLabel.frame.size.width, codeLabel.frame.origin.y, codeLabel.frame.size.width, codeLabel.frame.size.height);
        personWithGlassesView.alpha = 1;
        personView0.alpha = 1;
        personView1.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [codeLabel removeFromSuperview];
            [self animateLeaderSceneWithPerson0:personView0 person1:personView1 personWithGlasses:personWithGlassesView];
        }
    }];
}

// Start: 19.333, End: 22, Time since last animation finished: 0
- (void)animateLeaderSceneWithPerson0:(UIImageView *)personView0 person1:(UIImageView *)personView1 personWithGlasses:(UIImageView *)personWithGlassesView {
    [UIView animateWithDuration:2.667 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        personWithGlassesView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
        if (finished) {
            [self animateTransitionToProgrammingClubSceneWithPerson0:personView0 person1:personView1 personWithGlasses:personWithGlassesView];
        }
    }];
}

// Start: 22.333, End: 22.667, Time since last animation finished: 0.333
- (void)animateTransitionToProgrammingClubSceneWithPerson0:(UIImageView *)personView0 person1:(UIImageView *)personView1 personWithGlasses:(UIImageView *)personWithGlassesView {
    UILabel *bracesLabel = [UILabel new];
    bracesLabel.text = @"{}";
    bracesLabel.font = [UIFont fontWithName:@"Menlo-Regular" size:48];
    [bracesLabel sizeToFit];
    bracesLabel.center = self.view.center;
    bracesLabel.alpha = 0;
    [self.view addSubview:bracesLabel];
    [UIView animateWithDuration:0.334 delay:0.333 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        personView0.frame = CGRectMake(-(personView0.frame.size.width + personView1.frame.size.width + personWithGlassesView.frame.size.width), personView0.frame.origin.y, personView0.frame.size.width, personView0.frame.size.height);
        personView1.frame = CGRectMake(-(personView0.frame.size.width + personView1.frame.size.width + personWithGlassesView.frame.size.width), personView0.frame.origin.y, personView0.frame.size.width, personView0.frame.size.height);
        personWithGlassesView.frame = CGRectMake(-(personView0.frame.size.width + personView1.frame.size.width + personWithGlassesView.frame.size.width), personView0.frame.origin.y, personView0.frame.size.width, personView0.frame.size.height);

        bracesLabel.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [personView0 removeFromSuperview];
            [personView1 removeFromSuperview];
            [personWithGlassesView removeFromSuperview];
            [self animateProgrammingClubSceneWithBraceLabel:bracesLabel];
        }
    }];
}

// Start: 24, End: 26, Time since last animation finished: 1.333
- (void)animateProgrammingClubSceneWithBraceLabel:(UILabel *)braceLabel {
    UIImageView *classroomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Classroom"]];
    classroomView.center = self.view.center;
    classroomView.alpha = 0;
    classroomView.layer.borderColor = [UIColor blackColor].CGColor;
    classroomView.layer.borderWidth = 1;
    [self.view addSubview:classroomView];
    [UIView animateWithDuration:2 delay:1.333 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        braceLabel.frame = CGRectMake(classroomView.frame.origin.x + 185, classroomView.frame.origin.y + 55, braceLabel.frame.size.width, braceLabel.frame.size.height);
        classroomView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [self animateTransitionToQuizBowlSceneWithClassroom:classroomView braceLabel:braceLabel];
        }
    }];
}

// Start: 27.667, End: 28, Time since last animation finished: 1.667
- (void)animateTransitionToQuizBowlSceneWithClassroom:(UIImageView *)classroomView braceLabel:(UILabel *)braceLabel {
    UIImageView *buzzerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Buzzer"]];
    buzzerView.center = self.view.center;
    buzzerView.alpha = 0;
    [self.view addSubview:buzzerView];
    [UIView animateWithDuration:0.333 delay:1.667 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        classroomView.frame = CGRectMake(-classroomView.frame.size.width, classroomView.frame.origin.y, classroomView.frame.size.width, classroomView.frame.size.height);
        braceLabel.frame = CGRectMake(braceLabel.frame.origin.x - classroomView.frame.size.width, braceLabel.frame.origin.y, braceLabel.frame.size.width, braceLabel.frame.size.height);
        buzzerView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [classroomView removeFromSuperview];
            [braceLabel removeFromSuperview];
            [self animateQuizBowlSceneWithBuzzerView:buzzerView];
        }
    }];
}

// Start: 31.5, End: 33, Time since last animation finished: 3.5
- (void)animateQuizBowlSceneWithBuzzerView:(UIImageView *)buzzerView {
    UIImageView *iphonesView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WirelessIphones"]];
    iphonesView.center = self.view.center;
    iphonesView.alpha = 0;
    [self.view addSubview:iphonesView];
    [UIView animateWithDuration:1.5 delay:3.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        iphonesView.alpha = 1;
        buzzerView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [buzzerView removeFromSuperview];
            [self animateTransisionToSrtSceneWithIphonesView:iphonesView];
        }
    }];
}

// Start: 34, End: 35, Time since last animation finished: 1
- (void)animateTransisionToSrtSceneWithIphonesView:(UIImageView *)iphonesView {
    UIFont *font = [UIFont systemFontOfSize:48];

    UILabel *studentsLabel = [UILabel new];
    studentsLabel.text = @"\u5b66\u751f";
    studentsLabel.font = font;
    [studentsLabel sizeToFit];
    studentsLabel.center = CGPointMake(self.view.center.x - 75, self.view.center.y);
    studentsLabel.alpha = 0;
    [self.view addSubview:studentsLabel];

    UILabel *teachersLabel = [UILabel new];
    teachersLabel.text = @"\u8001\u5e08";
    teachersLabel.font = font;
    [teachersLabel sizeToFit];
    teachersLabel.center = CGPointMake(self.view.center.x + 75, self.view.center.y);
    teachersLabel.alpha = 0;
    [self.view addSubview:teachersLabel];

    [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        iphonesView.frame = CGRectMake(-iphonesView.frame.size.width, iphonesView.frame.origin.y, iphonesView.frame.size.width, iphonesView.frame.size.height);
        studentsLabel.alpha = 1;
        teachersLabel.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [iphonesView removeFromSuperview];
            [self animateSrtSceneWithStudentsLabel:studentsLabel teachersLabel:teachersLabel];
        }
    }];
}

// Start: 38, End: 39, Time since last animation finished: 3
- (void)animateSrtSceneWithStudentsLabel:(UILabel *)studentsLabel teachersLabel:(UILabel *)teachersLabel {
    UIImageView *yinYangView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"YinYang"]];
    yinYangView.center = self.view.center;
    yinYangView.alpha = 0;
    [self.view addSubview:yinYangView];

    [UIView animateWithDuration:1 delay:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        yinYangView.alpha = 1;
        studentsLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 60);
        teachersLabel.center = CGPointMake(self.view.center.x, self.view.center.y + 60);
    } completion:^(BOOL finished) {
        if (finished) {
            [self animateTransitionToToDoSceneWithStudentsLabel:studentsLabel teachersLabel:teachersLabel yinYangView:yinYangView];
        }
    }];
}

// Start: 42, End: 43, Time since last animation finished: 3
- (void)animateTransitionToToDoSceneWithStudentsLabel:(UILabel *)studentsLabel teachersLabel:(UILabel *)teachersLabel yinYangView:(UIImageView *)yinYangView {
    UIImageView *toDoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ToDo"]];
    toDoView.center = self.view.center;
    toDoView.alpha = 0;
    [self.view addSubview:toDoView];

    [UIView animateWithDuration:1 delay:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        yinYangView.frame = CGRectMake(-yinYangView.frame.size.width, yinYangView.frame.origin.y, yinYangView.frame.size.width, yinYangView.frame.size.height);
        studentsLabel.frame = CGRectMake(studentsLabel.frame.origin.x - yinYangView.frame.size.width, studentsLabel.frame.origin.y, studentsLabel.frame.size.width, studentsLabel.frame.size.height);
        teachersLabel.frame = CGRectMake(teachersLabel.frame.origin.x - yinYangView.frame.size.width, teachersLabel.frame.origin.y, teachersLabel.frame.size.width, teachersLabel.frame.size.height);
        toDoView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [yinYangView removeFromSuperview];
            [studentsLabel removeFromSuperview];
            [teachersLabel removeFromSuperview];
            [self animateTransitionToHungrySceneWithToDoView:toDoView];
        }
    }];
}

// Start: 46.667, End: 47.5, Time since last animation finished: 3.667
- (void)animateTransitionToHungrySceneWithToDoView:(UIImageView *)toDoView {
    UILabel *hungryLabel = [UILabel new];
    hungryLabel.text = @"Stay hungry,\nstay foolish.";
    hungryLabel.numberOfLines = 2;
    hungryLabel.textAlignment = NSTextAlignmentCenter;
    hungryLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:48];
    [hungryLabel sizeToFit];
    hungryLabel.alpha = 0;
    hungryLabel.center = self.view.center;
    [self.view addSubview:hungryLabel];

    [UIView animateWithDuration:0.833 delay:3.667 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toDoView.frame = CGRectMake(-toDoView.frame.size.width, toDoView.frame.origin.y, toDoView.frame.size.width, toDoView.frame.size.height);
        hungryLabel.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [toDoView removeFromSuperview];
            [self animateTransitionToWwdcSceneWithHungryLabel:hungryLabel];
        }
    }];
}

// Start: 52.5, End: 54, Time since last animation finished: 5
- (void)animateTransitionToWwdcSceneWithHungryLabel:(UILabel *)hungryLabel {
    UILabel *wwdcLabel = [UILabel new];
    wwdcLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:48];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"Jonathan Chan\nWWDC15"];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:48] range:NSMakeRange(14, 4)];
    wwdcLabel.attributedText = attributedText;
    wwdcLabel.numberOfLines = 2;
    wwdcLabel.textAlignment = NSTextAlignmentCenter;
    [wwdcLabel sizeToFit];
    wwdcLabel.center = self.view.center;
    wwdcLabel.alpha = 0;
    [self.view addSubview:wwdcLabel];

    [UIView animateWithDuration:1.5 delay:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        hungryLabel.alpha = 0;
        wwdcLabel.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [hungryLabel removeFromSuperview];
        }
    }];
}

@end
