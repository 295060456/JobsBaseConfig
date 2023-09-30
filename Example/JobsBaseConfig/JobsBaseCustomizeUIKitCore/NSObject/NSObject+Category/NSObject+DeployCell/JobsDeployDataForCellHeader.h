//
//  JobsDeployDataForCellHeader.h
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/23.
//

#ifndef JobsDeployDataForCellHeader_h
#define JobsDeployDataForCellHeader_h

#pragma mark —— 4 个 cell
#define JobsDeployCellByIndexPathSection4Block if (indexPath.section == 0) {\
if (block1) return block1();\
}else if (indexPath.section == 1){\
if (block2) return block2();\
}else if (indexPath.section == 2){\
if (block3) return block3();\
}else if(indexPath.section == 3){\
if (block4) return block4();\
}else{\
if (block5) return block5();\
}\

#define JobsDeployCellByItem4Block if (indexPath.item == 0) {\
if (block1) return block1();\
}else if (indexPath.item == 1){\
if (block2) return block2();\
}else if (indexPath.item == 2){\
if (block3) return block3();\
}else if(indexPath.item == 3){\
if (block4) return block4();\
}else{\
if (block5) return block5();\
}\

#define JobsDeployCellByRow4Block if (indexPath.row == 0) {\
if (block1) return block1();\
}else if (indexPath.row == 1){\
if (block2) return block2();\
}else if (indexPath.row == 2){\
if (block3) return block3();\
}else if(indexPath.row == 3){\
if (block4) return block4();\
}else{\
if (block5) return block5();\
}\

#define JobsDeployCellBySection4Block if (section == 0) {\
if (block1) return block1();\
}else if (section == 1){\
if (block2) return block2();\
}else if (section == 2){\
if (block3) return block3();\
}else if(section == 3){\
if (block4) return block4();\
}else{\
if (block5) return block5();\
}\

#endif /* JobsDeployDataForCellHeader_h */
