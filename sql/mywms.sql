/*
Navicat MySQL Data Transfer

Source Server         : 12345
Source Server Version : 50561
Source Host           : localhost:3306
Source Database       : mywms

Target Server Type    : MYSQL
Target Server Version : 50561
File Encoding         : 65001

Date: 2020-03-16 17:12:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(100) NOT NULL COMMENT '订单编号',
  `totalAmount` int(11) NOT NULL COMMENT '总的金额',
  `totalCount` int(11) NOT NULL,
  `createDate` datetime NOT NULL,
  `makeUserId` int(11) NOT NULL COMMENT '下单人',
  `supplierId` int(11) NOT NULL COMMENT '供应商',
  `finishDate` datetime DEFAULT NULL,
  `status` tinyint(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `makeUserId` (`makeUserId`),
  KEY `supplierId` (`supplierId`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`makeUserId`) REFERENCES `user` (`id`),
  CONSTRAINT `book_ibfk_2` FOREIGN KEY (`supplierId`) REFERENCES `supplier` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('4', '2020-03-05 16:40:16', '491730', '555', '2020-03-05 16:40:16', '2', '4', null, '1');
INSERT INTO `book` VALUES ('5', '2020-03-12 00:35:28', '4430', '5', '2020-03-12 00:35:28', '10', '4', null, '1');

-- ----------------------------
-- Table structure for bookitem
-- ----------------------------
DROP TABLE IF EXISTS `bookitem`;
CREATE TABLE `bookitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `costPrice` int(11) NOT NULL COMMENT '成本价',
  `input` int(11) DEFAULT '0',
  `number` int(11) NOT NULL COMMENT '数量',
  `amount` int(11) NOT NULL COMMENT '总价',
  `productId` int(11) NOT NULL,
  `productName` varchar(40) NOT NULL,
  `bookId` int(11) NOT NULL,
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `bookId` (`bookId`),
  CONSTRAINT `bookitem_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`id`),
  CONSTRAINT `bookitem_ibfk_2` FOREIGN KEY (`bookId`) REFERENCES `book` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bookitem
-- ----------------------------
INSERT INTO `bookitem` VALUES ('8', '2000', '1110', '111', '222000', '11', 'iPhone 11 Pro Max', '4', null);
INSERT INTO `bookitem` VALUES ('9', '80', '106', '111', '8880', '12', 'oppo Find X2', '4', null);
INSERT INTO `bookitem` VALUES ('10', '500', '7', '111', '55500', '13', 'oppo Find X2', '4', null);
INSERT INTO `bookitem` VALUES ('11', '350', '16', '111', '38850', '14', '荣耀V30', '4', null);
INSERT INTO `bookitem` VALUES ('12', '1500', '106', '111', '166500', '15', '小米(MI) 小米5手机', '4', null);
INSERT INTO `bookitem` VALUES ('13', '2000', '61', '1', '2000', '11', '华为 P9手机', '5', null);
INSERT INTO `bookitem` VALUES ('14', '80', '22', '1', '80', '12', '荣耀V30', '5', null);
INSERT INTO `bookitem` VALUES ('15', '500', '107', '1', '500', '13', '华为 Mate30pro', '5', null);
INSERT INTO `bookitem` VALUES ('16', '350', '15', '1', '350', '14', 'NOKIA 9 Pure', '5', null);
INSERT INTO `bookitem` VALUES ('17', '1500', '22', '1', '1500', '15', '小米(MI) 小米5手机', '5', null);

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of brand
-- ----------------------------
INSERT INTO `brand` VALUES ('1', '苹果');
INSERT INTO `brand` VALUES ('2', '华为');
INSERT INTO `brand` VALUES ('3', '小米xx');
INSERT INTO `brand` VALUES ('4', '锤子');
INSERT INTO `brand` VALUES ('5', '360');
INSERT INTO `brand` VALUES ('6', '菲尔可');
INSERT INTO `brand` VALUES ('7', '西部数据');
INSERT INTO `brand` VALUES ('8', '闪迪');
INSERT INTO `brand` VALUES ('9', '斯伯丁');
INSERT INTO `brand` VALUES ('11', 'xx');

-- ----------------------------
-- Table structure for client
-- ----------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `sn` varchar(40) NOT NULL COMMENT '客户编号',
  `phone` char(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of client
-- ----------------------------
INSERT INTO `client` VALUES ('1', 'test', 'test', '111');

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentId`),
  CONSTRAINT `dept_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `dept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES ('1', '总裁办', null);
INSERT INTO `dept` VALUES ('3', '董事会', null);
INSERT INTO `dept` VALUES ('4', '市场部', '1');
INSERT INTO `dept` VALUES ('5', '销售部', '4');

-- ----------------------------
-- Table structure for income
-- ----------------------------
DROP TABLE IF EXISTS `income`;
CREATE TABLE `income` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(40) NOT NULL COMMENT '送货单编号',
  `totalAmount` decimal(10,0) NOT NULL COMMENT '总金额',
  `totalNumber` decimal(10,0) NOT NULL COMMENT '总数量',
  `makeUserId` int(11) NOT NULL COMMENT '签单员',
  `bookId` int(11) DEFAULT NULL,
  `storeId` int(20) NOT NULL,
  `createDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bookId` (`bookId`),
  KEY `storeId` (`storeId`),
  KEY `makeUserId` (`makeUserId`),
  CONSTRAINT `income_ibfk_1` FOREIGN KEY (`bookId`) REFERENCES `book` (`id`),
  CONSTRAINT `income_ibfk_2` FOREIGN KEY (`storeId`) REFERENCES `store` (`id`),
  CONSTRAINT `income_ibfk_3` FOREIGN KEY (`makeUserId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of income
-- ----------------------------
INSERT INTO `income` VALUES ('18', '1212', '4430', '5', '2', '4', '1', '2020-03-10 10:53:14');
INSERT INTO `income` VALUES ('19', '5645', '4430', '5', '2', '4', '1', '2020-03-10 10:54:42');
INSERT INTO `income` VALUES ('24', '30', '1850', '2', '2', '4', '3', '2020-03-10 21:32:03');
INSERT INTO `income` VALUES ('25', '1212', '4430', '5', '10', '4', '1', '2020-03-10 22:23:57');
INSERT INTO `income` VALUES ('26', '1212', '500', '1', '2', null, '2', '2020-03-10 23:01:29');
INSERT INTO `income` VALUES ('27', '1212', '500', '1', '10', null, '2', '2020-03-11 13:16:46');
INSERT INTO `income` VALUES ('28', '5', '80', '1', '2', null, '1', '2020-03-11 22:36:52');
INSERT INTO `income` VALUES ('39', '5', '500', '1', '10', null, '1', '2020-03-16 14:34:28');
INSERT INTO `income` VALUES ('40', '5', '50000', '100', '10', null, '2', '2020-03-16 14:38:33');
INSERT INTO `income` VALUES ('41', '5', '33000', '22', '10', null, '2', '2020-03-16 14:51:12');
INSERT INTO `income` VALUES ('42', '5', '500', '1', '10', null, '2', '2020-03-16 14:55:37');
INSERT INTO `income` VALUES ('43', '1', '3500', '10', '10', null, '2', '2020-03-16 15:24:19');
INSERT INTO `income` VALUES ('44', '30', '80', '1', '10', null, '1', '2020-03-16 15:35:05');
INSERT INTO `income` VALUES ('45', '5', '800', '10', '10', null, '1', '2020-03-16 16:35:36');
INSERT INTO `income` VALUES ('46', '5', '850', '2', '10', null, '3', '2020-03-16 16:37:51');
INSERT INTO `income` VALUES ('48', '30', '850', '2', '10', null, '2', '2020-03-16 16:42:44');
INSERT INTO `income` VALUES ('49', '30', '20800', '20', '10', null, '1', '2020-03-16 16:45:56');
INSERT INTO `income` VALUES ('50', '111', '20000', '10', '10', null, '2', '2020-03-16 16:48:28');
INSERT INTO `income` VALUES ('51', '30', '24000', '12', '10', null, '1', '2020-03-16 16:50:06');
INSERT INTO `income` VALUES ('52', '30', '4000', '2', '10', null, '1', '2020-03-16 16:57:04');
INSERT INTO `income` VALUES ('53', '30', '8000', '4', '10', null, '1', '2020-03-16 17:04:19');
INSERT INTO `income` VALUES ('54', '30', '44000', '22', '10', null, '2', '2020-03-16 17:06:58');

-- ----------------------------
-- Table structure for incomeitem
-- ----------------------------
DROP TABLE IF EXISTS `incomeitem`;
CREATE TABLE `incomeitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `costPrice` decimal(10,0) NOT NULL COMMENT '成本价',
  `number` decimal(10,0) NOT NULL,
  `amount` decimal(10,0) NOT NULL COMMENT '总金额',
  `productName` varchar(40) NOT NULL,
  `productId` int(11) NOT NULL,
  `bookItemId` int(11) NOT NULL,
  `incomeId` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `bookItemId` (`bookItemId`),
  KEY `incomeId` (`incomeId`),
  CONSTRAINT `incomeitem_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`id`),
  CONSTRAINT `incomeitem_ibfk_2` FOREIGN KEY (`bookItemId`) REFERENCES `bookitem` (`id`),
  CONSTRAINT `incomeitem_ibfk_3` FOREIGN KEY (`incomeId`) REFERENCES `income` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of incomeitem
-- ----------------------------
INSERT INTO `incomeitem` VALUES ('62', '500', '1', '500', 'oppo Find X2', '13', '10', '25', null);
INSERT INTO `incomeitem` VALUES ('63', '350', '1', '350', 'iPhone 11 Pro Max', '14', '11', '25', null);
INSERT INTO `incomeitem` VALUES ('64', '1500', '1', '1500', 'nova 5 Pro', '15', '12', '25', null);
INSERT INTO `incomeitem` VALUES ('65', '500', '1', '500', 'vivo S1Pro', '13', '10', '26', null);
INSERT INTO `incomeitem` VALUES ('66', '500', '1', '500', 'vivo S1Pro', '13', '10', '27', null);
INSERT INTO `incomeitem` VALUES ('67', '80', '1', '80', '荣耀V30', '12', '9', '28', null);
INSERT INTO `incomeitem` VALUES ('84', '500', '1', '500', 'iPhone 11 Pro Max', '13', '15', '39', null);
INSERT INTO `incomeitem` VALUES ('85', '500', '100', '50000', 'iPhone 11 Pro Max', '13', '15', '40', null);
INSERT INTO `incomeitem` VALUES ('86', '1500', '22', '33000', 'nova 5 Pro', '15', '17', '41', null);
INSERT INTO `incomeitem` VALUES ('87', '500', '1', '500', 'iPhone 11 Pro Max', '13', '15', '42', null);
INSERT INTO `incomeitem` VALUES ('88', '350', '10', '3500', '华为 Mate30pro', '14', '16', '43', null);
INSERT INTO `incomeitem` VALUES ('89', '80', '1', '80', 'iPhone 11', '12', '14', '44', null);
INSERT INTO `incomeitem` VALUES ('90', '80', '10', '800', 'iPhone 11', '12', '14', '45', null);
INSERT INTO `incomeitem` VALUES ('91', '500', '1', '500', 'iPhone 11 Pro Max', '13', '15', '46', null);
INSERT INTO `incomeitem` VALUES ('92', '350', '1', '350', '华为 Mate30pro', '14', '16', '46', null);
INSERT INTO `incomeitem` VALUES ('95', '500', '1', '500', 'iPhone 11 Pro Max', '13', '15', '48', null);
INSERT INTO `incomeitem` VALUES ('96', '350', '1', '350', '华为 Mate30pro', '14', '16', '48', null);
INSERT INTO `incomeitem` VALUES ('97', '2000', '10', '20000', '华为 P9手机', '11', '13', '49', null);
INSERT INTO `incomeitem` VALUES ('98', '80', '10', '800', 'iPhone 11', '12', '14', '49', null);
INSERT INTO `incomeitem` VALUES ('99', '2000', '10', '20000', '华为 P9手机', '11', '13', '50', null);
INSERT INTO `incomeitem` VALUES ('100', '2000', '12', '24000', '华为 P9手机', '11', '13', '51', null);
INSERT INTO `incomeitem` VALUES ('101', '2000', '2', '4000', '华为 P9手机', '11', '13', '52', null);
INSERT INTO `incomeitem` VALUES ('102', '2000', '4', '8000', '华为 P9手机', '11', '13', '53', null);
INSERT INTO `incomeitem` VALUES ('103', '2000', '22', '44000', '华为 P9手机', '11', '13', '54', null);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `auth` varchar(255) NOT NULL COMMENT '调用控制器的哪个方法来处理',
  `level` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_36p7vtyw1vxng18fhtbd6m505` (`parentId`) USING BTREE,
  KEY `accessToken` (`auth`) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '系统管理', '', 'fa fa-adjust', '', '0', null);
INSERT INTO `menu` VALUES ('2', '用户管理', '/users', 'fa fa-adjust', 'users!list', '0', '1');
INSERT INTO `menu` VALUES ('3', '添加', 'users/add', null, 'users!add', '1', '2');
INSERT INTO `menu` VALUES ('4', '菜单管理', '/menus', 'fa fa-camera-retro', 'menus!list', '0', '1');
INSERT INTO `menu` VALUES ('5', '角色管理', '/roles', 'fa fa-adjust', 'roles!list', '0', '1');
INSERT INTO `menu` VALUES ('6', '编辑', 'users/edit', 'fa fa-adjust', 'users!edit', '1', '2');
INSERT INTO `menu` VALUES ('7', '删除', 'users/delete', 'fa fa-adjust', 'users!delete', '1', '2');
INSERT INTO `menu` VALUES ('37', '添加', 'roles/add', 'fa fa-etsy', 'roles!add', '1', '5');
INSERT INTO `menu` VALUES ('38', '更新', 'roles/edit', 'fa fa-etsy', 'roles!edit', '1', '5');
INSERT INTO `menu` VALUES ('40', '添加', 'menus/add', 'fa fa-etsy', 'menus!add', '1', '4');
INSERT INTO `menu` VALUES ('41', '更新', 'menus/edit', 'fa fa-etsy', 'menus!edit', '1', '4');
INSERT INTO `menu` VALUES ('42', '删除', 'menus/delete', 'fa fa-etsy', 'menus!delete', '1', '4');

-- ----------------------------
-- Table structure for middle_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `middle_role_menu`;
CREATE TABLE `middle_role_menu` (
  `menuId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`roleId`,`menuId`),
  KEY `FK_f7xuyb3bvlxjss5yg0uv4ppvx` (`menuId`) USING BTREE,
  CONSTRAINT `middle_role_menu_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`),
  CONSTRAINT `middle_role_menu_ibfk_2` FOREIGN KEY (`menuId`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of middle_role_menu
-- ----------------------------
INSERT INTO `middle_role_menu` VALUES ('1', '6');
INSERT INTO `middle_role_menu` VALUES ('1', '8');
INSERT INTO `middle_role_menu` VALUES ('2', '6');
INSERT INTO `middle_role_menu` VALUES ('2', '8');
INSERT INTO `middle_role_menu` VALUES ('3', '6');
INSERT INTO `middle_role_menu` VALUES ('3', '8');
INSERT INTO `middle_role_menu` VALUES ('4', '6');
INSERT INTO `middle_role_menu` VALUES ('5', '6');
INSERT INTO `middle_role_menu` VALUES ('5', '8');
INSERT INTO `middle_role_menu` VALUES ('6', '6');
INSERT INTO `middle_role_menu` VALUES ('6', '8');
INSERT INTO `middle_role_menu` VALUES ('7', '6');
INSERT INTO `middle_role_menu` VALUES ('7', '8');
INSERT INTO `middle_role_menu` VALUES ('37', '6');
INSERT INTO `middle_role_menu` VALUES ('38', '6');
INSERT INTO `middle_role_menu` VALUES ('40', '6');
INSERT INTO `middle_role_menu` VALUES ('41', '6');
INSERT INTO `middle_role_menu` VALUES ('42', '6');

-- ----------------------------
-- Table structure for middle_user_role
-- ----------------------------
DROP TABLE IF EXISTS `middle_user_role`;
CREATE TABLE `middle_user_role` (
  `userId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`roleId`),
  KEY `FK_kjp9c6hki8a1p70x44bwqex2v` (`roleId`) USING BTREE,
  CONSTRAINT `middle_user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `middle_user_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of middle_user_role
-- ----------------------------
INSERT INTO `middle_user_role` VALUES ('6', '6');
INSERT INTO `middle_user_role` VALUES ('8', '6');
INSERT INTO `middle_user_role` VALUES ('6', '8');
INSERT INTO `middle_user_role` VALUES ('8', '8');

-- ----------------------------
-- Table structure for outcome
-- ----------------------------
DROP TABLE IF EXISTS `outcome`;
CREATE TABLE `outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(40) NOT NULL COMMENT '出库编号',
  `totalAmount` int(11) NOT NULL COMMENT '总价',
  `totalNumber` int(11) NOT NULL COMMENT '出库的数量',
  `createTime` datetime NOT NULL COMMENT '出库时间',
  `userId` int(11) NOT NULL COMMENT '出库人',
  `storeId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sn` (`sn`),
  KEY `userId` (`userId`),
  KEY `clientId` (`clientId`),
  KEY `storeId` (`storeId`),
  CONSTRAINT `outcome_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `outcome_ibfk_2` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `outcome_ibfk_3` FOREIGN KEY (`storeId`) REFERENCES `store` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of outcome
-- ----------------------------
INSERT INTO `outcome` VALUES ('8', '20200316132247', '1200', '1', '2020-03-16 13:22:47', '10', '1', '1', '1');
INSERT INTO `outcome` VALUES ('9', '20200316142534', '5000', '1', '2020-03-16 14:25:34', '10', '1', '1', '1');

-- ----------------------------
-- Table structure for outcomeitem
-- ----------------------------
DROP TABLE IF EXISTS `outcomeitem`;
CREATE TABLE `outcomeitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `salePrice` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `outSn` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `outSn` (`outSn`) USING BTREE,
  CONSTRAINT `outcomeitem_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`id`),
  CONSTRAINT `outcomeitem_ibfk_2` FOREIGN KEY (`outSn`) REFERENCES `outcome` (`sn`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of outcomeitem
-- ----------------------------
INSERT INTO `outcomeitem` VALUES ('7', '1200', '1', '1200', '12', '20200316132247');
INSERT INTO `outcomeitem` VALUES ('8', '5000', '1', '5000', '12', '20200316142534');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `sn` varchar(40) NOT NULL COMMENT '商品编号',
  `costPrice` int(11) NOT NULL COMMENT '成本价',
  `salePrice` int(11) NOT NULL,
  `img` varchar(100) NOT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `brandId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `brandId` (`brandId`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`brandId`) REFERENCES `brand` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('11', '华为 P9手机', '011', '2000', '3500', 'upload/qq.bmp', '华为 P9 全网通 3GB+32GB版 流光金 移动联通电信4G手机 双卡双待', '2');
INSERT INTO `product` VALUES ('12', 'iPhone 11', '012', '80', '150', 'upload/qq.bmp', '闪迪（SanDisk）至尊高速（CZ48） 256GB USB3.0 U盘 读100MBs 写40MBs', '8');
INSERT INTO `product` VALUES ('13', 'iPhone 11 Pro Max', '013', '500', '800', 'upload/qq.bmp', '斯伯丁 NBA金色经典系列 耐磨防滑 室内外兼用 篮球', '9');
INSERT INTO `product` VALUES ('14', '华为 Mate30pro', '014', '350', '500', 'upload/qq.bmp', '西部数据（WD）My Passport Ultra 升级版 1TB 2.5英寸 野莓红 移动硬盘', '7');
INSERT INTO `product` VALUES ('15', 'nova 5 Pro', '015', '1500', '2000', 'upload/qq.bmp', '小米(MI) 小米5 全网通4G手机 双卡双待 黑色 尊享版(4G RAM+128G ROM) 标配', '3');
INSERT INTO `product` VALUES ('16', 'HUAWEI nova6 SE', '016', '200', '250', 'upload/qq.bmp', '小米（MI）蓝牙音箱 音响 无线迷你便携音箱 车载音箱 支持SD卡 免提通话（蓝色）', '3');
INSERT INTO `product` VALUES ('17', 'oppo Find X2', '017', '6000', '8000', 'upload/qq.bmp', '小米（MI）L70M4-AA 70英寸 智能4K分体电视', '3');
INSERT INTO `product` VALUES ('18', 'OPPO Reno3 Pro(', '018', '8000', '11000', 'upload/qq.bmp', 'Apple iMac 21.5英寸一体机(四核 Core i5 处理器8GB内存1TB存储Retina 4K屏).jpg', '1');
INSERT INTO `product` VALUES ('19', 'vivo S1Pro', '019', '2500', '3500', 'upload/qq.bmp', 'Apple iPad Air 2 平板电脑 9.7英寸（64G WLAN版A8X 芯片Retina显示屏Touch ID技术 MH182CH）金色', '1');
INSERT INTO `product` VALUES ('20', 'vivo  iQOO', '020', '7000', '10000', 'upload/qq.bmp', 'Apple MacBook 12英寸笔记本电脑 玫瑰金色 256GB闪存', '1');
INSERT INTO `product` VALUES ('22', '小米CC9 Pro', '12', '12', '11', 'upload/qq.bmp', '12', '1');
INSERT INTO `product` VALUES ('23', '魅族', 'yy', '12', '12', 'upload/qq.bmp', '12', '1');
INSERT INTO `product` VALUES ('24', '荣耀V30', 'aa', '12', '12', 'upload/qq.bmp', '12', '1');
INSERT INTO `product` VALUES ('25', 'Redmi K30', 'test', '12', '12', 'upload/36cfb9abe9a44ea5a8c5fea8501b92b6qq.bmp', '12', '2');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('6', '收银员xx');
INSERT INTO `role` VALUES ('8', '项目总经理');

-- ----------------------------
-- Table structure for stock
-- ----------------------------
DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock` (
  `storeCount` int(11) NOT NULL COMMENT '库存数量',
  `incomeDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '入库时间',
  `outcomeDate` datetime DEFAULT NULL COMMENT '出库时间',
  `productName` varchar(40) NOT NULL,
  `productId` int(11) NOT NULL COMMENT '商品Id',
  `storeId` int(11) NOT NULL COMMENT '仓库',
  `storeName` varchar(255) NOT NULL,
  PRIMARY KEY (`productId`,`storeId`,`storeName`),
  KEY `storeId` (`storeId`),
  KEY `storeName` (`storeName`) USING BTREE,
  KEY `incomeDate` (`incomeDate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stock
-- ----------------------------
INSERT INTO `stock` VALUES ('28', '2020-03-16 17:04:19', null, '华为 P9手机', '11', '1', '柳州南区');
INSERT INTO `stock` VALUES ('32', '2020-03-16 17:06:58', null, '华为 P9手机', '11', '2', '柳州北区');
INSERT INTO `stock` VALUES ('10', '2020-03-16 16:45:56', null, 'iPhone 11', '12', '1', '柳州南区');

-- ----------------------------
-- Table structure for store
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `address` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of store
-- ----------------------------
INSERT INTO `store` VALUES ('1', '柳州南区', '广西南区');
INSERT INTO `store` VALUES ('2', '柳州北区', '广西北区');
INSERT INTO `store` VALUES ('3', '柳州东区', '广西东区');
INSERT INTO `store` VALUES ('5', '广州东软一号仓库', '广西东区');

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `phone` char(11) NOT NULL,
  `address` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES ('4', '11', '11', '11');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `loginName` varchar(255) NOT NULL COMMENT '登录名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `status` tinyint(255) NOT NULL COMMENT '状态0:禁用1:激活',
  `header` varchar(255) NOT NULL COMMENT '邮箱',
  `deptId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_bmngciqbcrw3yqdcfdwh8ysu7` (`loginName`) USING BTREE,
  KEY `deptId` (`deptId`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`deptId`) REFERENCES `dept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('2', 'test', 'ls', 'ls', '1', 'ww@qq.com', '1');
INSERT INTO `user` VALUES ('6', 'lldd', 'll', 'E10ADC3949BA59ABBE56E057F20F883E', '0', 'll@qq.com', '1');
INSERT INTO `user` VALUES ('8', 'admin', 'admin', 'E10ADC3949BA59ABBE56E057F20F883E', '0', 'yuyu@qq.com', '1');
INSERT INTO `user` VALUES ('9', '1', '1111111111111', 'e10adc3949ba59abbe56e057f20f883e', '0', '111', '1');
INSERT INTO `user` VALUES ('10', 'test', 'test', '123456', '1', 'test', '3');
INSERT INTO `user` VALUES ('11', 'wwuu', 'wwuu', '123456', '1', 'wwuu', '3');
INSERT INTO `user` VALUES ('12', 'xxxxxxxx', 'xxxx', '123456', '1', 'xxx', '5');
