//
//  ELKColorLiteHeader.h
//  ELKHippoLite
//
//  Created by wing on 2020/5/6.
//  Copyright © 2020 wing. All rights reserved.
//

#ifndef ELKColorLiteHeader_h
#define ELKColorLiteHeader_h


#pragma mark - 颜色宏
#ifndef ELK_HexColor
/// 根据十六进制色值和透明度获取颜色 例如：0xffffff 1.f
#define ELK_HexColor(colorH,a) [UIColor colorWithRed:((float)((colorH & 0xff0000) >> 16)) / 255.0 green:((float)((colorH & 0x00ff00) >> 8)) / 255.0 blue:((float)(colorH & 0x0000ff)) / 255.0 alpha:a]
#endif



/// 0xF7F7F7
#define ELKColorLiteF7   ELK_HexColor(0xF7F7F7, 1.f)

/// 0xE6E6E6
#define ELKColorLiteE6   ELK_HexColor(0xE6E6E6, 1.f)

/// 0x333333
#define ELKColorLite333  ELK_HexColor(0x333333, 1.f)

/// 0x666666
#define ELKColorLite666  ELK_HexColor(0x666666, 1.f)

/// 0x888888
#define ELKColorLite888  ELK_HexColor(0x888888, 1.f)

/// 0x999999
#define ELKColorLite999  ELK_HexColor(0x999999, 1.f)










#endif /* ELKColorLiteHeader_h */
