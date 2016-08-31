//
//  SPViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "SPViewController.h"
#import "SPCollectionViewCell.h"
#import <Photos/Photos.h>
#import "PhotoModel.h"
@interface SPViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *pcv;
    NSMutableArray *dataSource;
    NSMutableArray *images;
}
@end

@implementation SPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishAction:)];
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0.0f,0.0f, 60.0f, 36.0f)];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    label.backgroundColor=[UIColor redColor];
    
    
    label.text=@"苹果系统45671";
    
    self.navigationItem.titleView = btn;
    
    UICollectionViewFlowLayout *flowLayout=[UICollectionViewFlowLayout new];
    
    flowLayout.itemSize=CGSizeMake(130,130);
    
    pcv=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    
    pcv.dataSource=self;
    pcv.delegate=self;
    pcv.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:pcv];
    
    [pcv registerNib:[UINib nibWithNibName:@"SPCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([SPCollectionViewCell class])];
    
dataSource=[NSMutableArray array];
    images=[NSMutableArray array];
   [self getAllPhotos];
    
    
    
}
-(void)btn:(UIButton *)sender{
    NSLog(@"111");
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SPCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SPCollectionViewCell class]) forIndexPath:indexPath];
    if(indexPath.row==0){
        cell.imageView.image=[UIImage imageNamed:@"photo"];
        cell.selectView.hidden=YES;
        cell.selectButton.hidden=YES;
        return cell;
    }
    PhotoModel*m=dataSource[indexPath.row];
    cell.imageView.image=m.imageV;
    cell.selectView.hidden=NO;
    
    if(m.isSelect){
        cell.selectView.image=[UIImage imageNamed:@"selected"];
    }else{
        cell.selectView.image=[UIImage imageNamed:@"unSelected"];
    }
    cell.selectButton.hidden=NO;
    cell.selectButton.selected=m.isSelect;
cell.selectBtnClickBlock=^(BOOL isSelected) {
        if(images.count>=10&&isSelected){
            NSLog(@"大于10张");
        }else{
            m.isSelect=isSelected;
        
            if(m.isSelect){
                [images addObject:m];
            }else{
                [images removeObject:m];
            }
            [collectionView reloadData];
        }
        };
    return cell;
}

-(void)getAllPhotos{
PHFetchOptions *options=[PHFetchOptions new];
    
    PHFetchResult *allPhotos=[PHAsset fetchAssetsWithOptions:options];
    for(int i=0;i<allPhotos.count;i++){
        PHAsset *asset=allPhotos[i];
        PHImageManager *manager=[PHImageManager new];
        [manager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            PhotoModel *m=[PhotoModel new];
            m.imageV=result;
            m.isSelect=NO;
            [dataSource addObject:m];
            dispatch_async(dispatch_get_main_queue(), ^{
                [pcv reloadData];
            });
        }];
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"count=%ld",dataSource.count);
    return dataSource.count;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
