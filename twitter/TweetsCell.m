//
//  TweetsCell.m
//  twitter
//
//  Created by Saker Lin on 2015/6/28.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import "TweetsCell.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+DateTools.h"
#import "TwitterClient.h"
@interface TweetsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *authorImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UIImageView *tweetPhotoImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tweetPhotoImageHeight;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritedLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;



@end

@implementation TweetsCell
- (IBAction)onFav:(id)sender {
    if(self.tweet.favorited){
        [self.favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        self.tweet.favorited = false;
        self.tweet.favCount --;
                 [[TwitterClient sharedInstance] doUnFavorite:self.tweet.tweetId completion:nil];
    } else {
        [self.favButton setImage:[UIImage imageNamed:@"faved"] forState:UIControlStateNormal];
        self.tweet.favorited = true;
        self.tweet.favCount ++;
        [[TwitterClient sharedInstance] doFavorite:self.tweet.tweetId completion:nil];
    }
    self.favoritedLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.favCount];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    [self.authorImageView setImageWithURL:[NSURL URLWithString:self.tweet.profile_image_url]];
    self.author.text = [NSString stringWithFormat:@"@%@", self.tweet.screen_name];
    self.nickName.text = self.tweet.name;
    self.text.text = self.tweet.text;
    self.favoritedLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.favCount];
    self.retweetLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.retweetCount];
    self.timeStamp.text = self.tweet.createdAt.shortTimeAgoSinceNow;
    self.tweetPhotoImageHeight.constant = 0.0;
    // [self.replyButton setImage:[UIImage imageNamed: @"reply"] forState:UIControlStateNormal];
    
    //[self.retweetButton setImage:[UIImage imageNamed: @"retweet"] forState:UIControlStateNormal];
    if (self.tweet.favorited) {
        [self.favButton setImage:[UIImage imageNamed: @"faved"] forState:UIControlStateNormal];
    }
    if (self.tweet.tweetPhotoUrl != nil) {
        [self.tweetPhotoImage setImageWithURL:[NSURL URLWithString:self.tweet.tweetPhotoUrl] placeholderImage:[UIImage imageNamed:@"imagePlaceHolder"]];
    } else {
        [self.tweetPhotoImage setImage:nil];
        self.tweetPhotoImageHeight.constant = 0.0;
    }
}
-(void) layoutSubviews {
    [super layoutSubviews];
    self.nickName.preferredMaxLayoutWidth = self.nickName.frame.size.width;
    
}
@end
