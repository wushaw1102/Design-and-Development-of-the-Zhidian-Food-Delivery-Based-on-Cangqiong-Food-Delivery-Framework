--
-- ZhiDian Takeout - MySQL schema and demo seed data
--
-- Exported from MySQL 8.0 (utf8mb4). Restore with:
--   mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS sky_take_out DEFAULT CHARSET utf8mb4;"
--   mysql -u root -p sky_take_out < database/schema.sql
--
-- All personal data (phone numbers, ID numbers, openids, addresses) in this file
-- has been replaced with placeholder values.
--
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `consignee` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '收货人',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '默认 0 否 1是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '地址簿' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address_book
-- ----------------------------
INSERT INTO `address_book` VALUES (2, 4, '张三', '0', '13800000000', '11', '北京市', '1101', '市辖区', '110102', '西城区', '北京大学', '3', 1);
INSERT INTO `address_book` VALUES (3, 4, '存储', '0', '13800000000', '11', '北京市', '1101', '市辖区', '110102', '西城区', '1', '2', 0);
INSERT INTO `address_book` VALUES (4, 4, '李四', '0', '13800000000', '12', '天津市', '1201', '市辖区', '120101', '和平区', '老街', '2', 0);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int NULL DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT 0 COMMENT '顺序',
  `status` int NULL DEFAULT NULL COMMENT '分类状态 0:禁用，1:启用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_category_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品及套餐分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (11, 1, '酒水饮料', 10, 1, '2022-06-09 22:09:18', '2022-06-09 22:09:18', 1, 1);
INSERT INTO `category` VALUES (12, 1, '传统主食', 9, 1, '2022-06-09 22:09:32', '2022-06-09 22:18:53', 1, 1);
INSERT INTO `category` VALUES (13, 2, '人气套餐', 12, 1, '2022-06-09 22:11:38', '2022-06-10 11:04:40', 1, 1);
INSERT INTO `category` VALUES (15, 2, '商务套餐', 13, 1, '2022-06-09 22:14:10', '2022-06-10 11:04:48', 1, 1);
INSERT INTO `category` VALUES (16, 1, '蜀味烤鱼', 5, 1, '2022-06-09 22:15:37', '2025-01-26 07:53:31', 1, 1);
INSERT INTO `category` VALUES (17, 1, '蜀味牛蛙', 4, 1, '2022-06-09 22:16:14', '2025-03-02 18:03:09', 1, 1);
INSERT INTO `category` VALUES (18, 1, '特色蒸菜', 6, 1, '2022-06-09 22:17:42', '2022-06-09 22:17:42', 1, 1);
INSERT INTO `category` VALUES (19, 1, '新鲜时蔬', 7, 1, '2022-06-09 22:18:12', '2022-06-09 22:18:28', 1, 1);
INSERT INTO `category` VALUES (20, 1, '水煮鱼', 8, 1, '2022-06-09 22:22:29', '2022-06-09 22:23:45', 1, 1);
INSERT INTO `category` VALUES (21, 1, '汤类', 11, 1, '2022-06-10 10:51:47', '2022-06-10 10:51:47', 1, 1);

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '菜品名称',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品价格',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述信息',
  `status` int NULL DEFAULT 1 COMMENT '0 停售 1 起售',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_dish_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES (46, '王老吉', 11, 6.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/0731a52e-a371-46d0-8719-0a8f930823d1.png', '', 1, '2022-06-09 22:40:47', '2025-02-05 17:13:09', 1, 1);
INSERT INTO `dish` VALUES (47, '北冰洋', 11, 4.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/a69df2d1-fdf7-4c03-9441-da1c4bf9acb5.png', '还是小时候的味道', 1, '2022-06-10 09:18:49', '2025-02-05 17:13:19', 1, 1);
INSERT INTO `dish` VALUES (48, '雪花啤酒', 11, 4.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/20b55196-2b67-4c0b-bced-1e1e4bc7b171.png', '', 1, '2022-06-10 09:22:54', '2025-02-05 17:13:29', 1, 1);
INSERT INTO `dish` VALUES (49, '米饭', 12, 2.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/5401217f-5b7c-4651-ba6c-9a957a4a8985.png', '精选五常大米', 1, '2022-06-10 09:30:17', '2025-02-05 17:13:38', 1, 1);
INSERT INTO `dish` VALUES (50, '馒头', 12, 1.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/c30fa662-1f5b-4320-a675-8646cbbb696c.png', '优质面粉', 1, '2022-06-10 09:34:28', '2025-02-05 17:13:54', 1, 1);
INSERT INTO `dish` VALUES (51, '老坛酸菜鱼', 20, 56.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/d08f4cd3-934c-44cb-aec6-2fde4882f0d7.png', '原料：汤，草鱼，酸菜', 1, '2022-06-10 09:40:51', '2025-02-05 17:15:17', 1, 1);
INSERT INTO `dish` VALUES (52, '经典酸菜鮰鱼', 20, 66.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/7c00e715-4457-4d3d-995b-f9459973cf2b.png', '原料：酸菜，江团，鮰鱼', 1, '2022-06-10 09:46:02', '2025-02-05 17:16:29', 1, 1);
INSERT INTO `dish` VALUES (53, '蜀味水煮草鱼', 20, 38.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/8308c17b-5148-4725-a186-0958f8d56618.png', '原料：草鱼，汤', 1, '2022-06-10 09:48:37', '2025-02-05 17:16:40', 1, 1);
INSERT INTO `dish` VALUES (54, '清炒小油菜', 19, 18.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/6600505a-9a61-42ef-bf60-f1a515d25e97.png', '原料：小油菜', 1, '2022-06-10 09:51:46', '2025-02-05 17:16:50', 1, 1);
INSERT INTO `dish` VALUES (55, '蒜蓉娃娃菜', 19, 18.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/ceda4cdc-45db-4e7c-930c-012b7767984c.png', '原料：蒜，娃娃菜', 1, '2022-06-10 09:53:37', '2025-02-05 17:17:05', 1, 1);
INSERT INTO `dish` VALUES (56, '清炒西兰花', 19, 18.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/64fe82e2-78c3-4fca-8bb5-0a109acd9b66.png', '原料：西兰花', 1, '2022-06-10 09:55:44', '2025-02-05 17:15:32', 1, 1);
INSERT INTO `dish` VALUES (57, '炝炒圆白菜', 19, 18.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/016e3a0b-47cb-476d-90b9-a2ec6824220f.png', '原料：圆白菜', 1, '2022-06-10 09:58:35', '2025-02-05 17:17:15', 1, 1);
INSERT INTO `dish` VALUES (58, '清蒸鲈鱼', 18, 98.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/d587e881-b186-4b8d-a4e3-26536108a6e2.png', '原料：鲈鱼', 1, '2022-06-10 10:12:28', '2025-02-05 17:14:29', 1, 1);
INSERT INTO `dish` VALUES (59, '东坡肘子', 18, 138.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/81a29656-60d0-4d98-a72c-13a933f7dbdd.png', '原料：猪肘棒', 1, '2022-06-10 10:24:03', '2025-02-05 17:14:18', 1, 1);
INSERT INTO `dish` VALUES (60, '梅菜扣肉', 18, 58.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/c3ac9e04-f0d0-43ec-a50e-e135abaad0c5.png', '原料：猪肉，梅菜', 1, '2022-06-10 10:26:03', '2025-02-05 17:14:07', 1, 1);
INSERT INTO `dish` VALUES (61, '剁椒鱼头', 18, 66.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/e99a0f01-52f3-4bd6-9d47-16098f40a66b.png', '原料：鲢鱼，剁椒', 1, '2022-06-10 10:28:54', '2025-02-05 17:18:23', 1, 1);
INSERT INTO `dish` VALUES (62, '金汤酸菜牛蛙', 17, 88.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/69891db5-9b76-4aa7-a68b-2ec38df692e8.png', '原料：鲜活牛蛙，酸菜', 1, '2022-06-10 10:33:05', '2025-02-05 17:18:31', 1, 1);
INSERT INTO `dish` VALUES (63, '香锅牛蛙', 17, 88.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/aa86396e-34f0-47c8-a7ad-9cfbfa9da2b1.png', '配料：鲜活牛蛙，莲藕，青笋', 1, '2022-06-10 10:35:40', '2025-02-05 17:18:38', 1, 1);
INSERT INTO `dish` VALUES (64, '馋嘴牛蛙', 17, 88.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/bd99bf9f-a704-44dd-bb32-b5c25fcc58e7.png', '配料：鲜活牛蛙，丝瓜，黄豆芽', 1, '2022-06-10 10:37:52', '2025-02-05 17:18:47', 1, 1);
INSERT INTO `dish` VALUES (65, '草鱼2斤', 16, 68.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/c9276c0b-4118-4568-a3ed-6b6201402984.png', '原料：草鱼，黄豆芽，莲藕', 1, '2022-06-10 10:41:08', '2025-02-05 17:18:55', 1, 1);
INSERT INTO `dish` VALUES (66, '江团鱼2斤', 16, 119.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/a3ecea19-31a4-466c-9ca7-af7048e9d20e.png', '配料：江团鱼，黄豆芽，莲藕', 1, '2022-06-10 10:42:42', '2025-02-05 17:19:03', 1, 1);
INSERT INTO `dish` VALUES (67, '鮰鱼2斤', 16, 72.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/12b15b88-7701-432c-a72b-4afa40086ed4.png', '原料：鮰鱼，黄豆芽，莲藕', 1, '2022-06-10 10:43:56', '2025-02-05 17:19:13', 1, 1);
INSERT INTO `dish` VALUES (68, '鸡蛋汤', 21, 5.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/caaede27-ec3e-4791-bf94-1bcc3f8b5e13.png', '配料：鸡蛋，紫菜', 1, '2022-06-10 10:54:25', '2025-02-05 20:49:10', 1, 1);
INSERT INTO `dish` VALUES (69, '平菇豆腐汤', 21, 6.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/399b6fa7-abba-4992-8f43-26ad34f925de.png', '配料：豆腐，平菇', 1, '2022-06-10 10:55:02', '2025-02-08 21:40:12', 1, 1);
INSERT INTO `dish` VALUES (71, '测试菜品', 18, 25.00, 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/78c7c957-57f6-436b-8ae3-0def3701a842.png', '123', 1, '2025-01-27 20:13:19', '2025-03-20 19:15:19', 1, 1);

-- ----------------------------
-- Table structure for dish_flavor
-- ----------------------------
DROP TABLE IF EXISTS `dish_flavor`;
CREATE TABLE `dish_flavor`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dish_id` bigint NOT NULL COMMENT '菜品',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味名称',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味数据list',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 125 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品口味关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dish_flavor
-- ----------------------------
INSERT INTO `dish_flavor` VALUES (40, 10, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (41, 7, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (42, 7, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]');
INSERT INTO `dish_flavor` VALUES (45, 6, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (46, 6, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (47, 5, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (48, 5, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (49, 2, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (50, 4, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (51, 3, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (52, 3, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (109, 71, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (110, 71, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (111, 60, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (113, 51, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (114, 51, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (115, 56, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (116, 52, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (117, 52, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (118, 53, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (119, 53, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (120, 54, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\"]');
INSERT INTO `dish_flavor` VALUES (121, 57, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (122, 65, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (123, 66, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (124, 67, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '身份证号',
  `status` int NOT NULL DEFAULT 1 COMMENT '状态 0:禁用，1:启用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '员工信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '13800000000', '1', '110101199001010000', 1, '2022-02-15 15:51:20', '2022-02-17 09:16:20', 10, 1);
INSERT INTO `employee` VALUES (2, '汤姆', 'Tom', 'e10adc3949ba59abbe56e057f20f883e', '13800000000', '1', '110101199001010000', 1, '2025-01-24 22:31:59', '2025-01-24 22:31:59', 10, 10);
INSERT INTO `employee` VALUES (3, '李四', 'lisi', 'e10adc3949ba59abbe56e057f20f883e', '13800000000', '1', '110101199001010000', 0, '2025-01-24 22:37:01', '2025-01-25 23:55:12', 10, 1);
INSERT INTO `employee` VALUES (5, '王五', 'wangwu', 'e10adc3949ba59abbe56e057f20f883e', '13800000000', '1', '110101199001010000', 1, '2025-01-24 23:24:51', '2025-01-27 13:16:13', 2, 1);

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '名字',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `dish_id` bigint NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '订单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES (5, '香锅牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/aa86396e-34f0-47c8-a7ad-9cfbfa9da2b1.png', 4, 63, NULL, NULL, 2, 88.00);
INSERT INTO `order_detail` VALUES (6, '鮰鱼2斤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/12b15b88-7701-432c-a72b-4afa40086ed4.png', 4, 67, NULL, '微辣', 1, 72.00);
INSERT INTO `order_detail` VALUES (7, '馋嘴牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/bd99bf9f-a704-44dd-bb32-b5c25fcc58e7.png', 5, 64, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (8, '香锅牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/aa86396e-34f0-47c8-a7ad-9cfbfa9da2b1.png', 5, 63, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (9, '金汤酸菜牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/69891db5-9b76-4aa7-a68b-2ec38df692e8.png', 5, 62, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (10, '蜀味水煮草鱼', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/8308c17b-5148-4725-a186-0958f8d56618.png', 6, 53, NULL, '不要葱,不辣', 1, 38.00);
INSERT INTO `order_detail` VALUES (11, '鸡蛋汤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/caaede27-ec3e-4791-bf94-1bcc3f8b5e13.png', 6, 68, NULL, NULL, 1, 5.00);
INSERT INTO `order_detail` VALUES (12, '金汤酸菜牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/69891db5-9b76-4aa7-a68b-2ec38df692e8.png', 7, 62, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (13, '馋嘴牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/bd99bf9f-a704-44dd-bb32-b5c25fcc58e7.png', 8, 64, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (14, '馋嘴牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/bd99bf9f-a704-44dd-bb32-b5c25fcc58e7.png', 9, 64, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (15, '香锅牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/aa86396e-34f0-47c8-a7ad-9cfbfa9da2b1.png', 9, 63, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (16, '馋嘴牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/bd99bf9f-a704-44dd-bb32-b5c25fcc58e7.png', 10, 64, NULL, NULL, 2, 88.00);
INSERT INTO `order_detail` VALUES (17, '香锅牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/aa86396e-34f0-47c8-a7ad-9cfbfa9da2b1.png', 11, 63, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (18, '金汤酸菜牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/69891db5-9b76-4aa7-a68b-2ec38df692e8.png', 11, 62, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (19, '金汤酸菜牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/69891db5-9b76-4aa7-a68b-2ec38df692e8.png', 12, 62, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (20, '香锅牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/aa86396e-34f0-47c8-a7ad-9cfbfa9da2b1.png', 12, 63, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (21, '馋嘴牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/bd99bf9f-a704-44dd-bb32-b5c25fcc58e7.png', 12, 64, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (22, '剁椒鱼头', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/e99a0f01-52f3-4bd6-9d47-16098f40a66b.png', 13, 61, NULL, NULL, 1, 66.00);
INSERT INTO `order_detail` VALUES (23, '东坡肘子', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/81a29656-60d0-4d98-a72c-13a933f7dbdd.png', 13, 59, NULL, NULL, 1, 138.00);
INSERT INTO `order_detail` VALUES (24, '梅菜扣肉', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/c3ac9e04-f0d0-43ec-a50e-e135abaad0c5.png', 13, 60, NULL, '不要蒜', 1, 58.00);
INSERT INTO `order_detail` VALUES (25, '测试菜品', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/78c7c957-57f6-436b-8ae3-0def3701a842.png', 13, 71, NULL, '不辣,多糖', 1, 25.00);
INSERT INTO `order_detail` VALUES (26, '清蒸鲈鱼', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/d587e881-b186-4b8d-a4e3-26536108a6e2.png', 13, 58, NULL, NULL, 1, 98.00);
INSERT INTO `order_detail` VALUES (27, '王老吉', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/0731a52e-a371-46d0-8719-0a8f930823d1.png', 13, 46, NULL, NULL, 1, 6.00);
INSERT INTO `order_detail` VALUES (28, '北冰洋', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/a69df2d1-fdf7-4c03-9441-da1c4bf9acb5.png', 13, 47, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (29, '雪花啤酒', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/20b55196-2b67-4c0b-bced-1e1e4bc7b171.png', 13, 48, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (30, '套餐二', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/d3c1b3e1-8c0e-40da-bd78-4a69fbc8323b.png', 14, NULL, 39, NULL, 1, 100.00);
INSERT INTO `order_detail` VALUES (31, '草鱼2斤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/c9276c0b-4118-4568-a3ed-6b6201402984.png', 15, 65, NULL, '不辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (32, '江团鱼2斤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/a3ecea19-31a4-466c-9ca7-af7048e9d20e.png', 15, 66, NULL, '微辣', 1, 119.00);
INSERT INTO `order_detail` VALUES (33, '鮰鱼2斤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/12b15b88-7701-432c-a72b-4afa40086ed4.png', 15, 67, NULL, '不辣', 1, 72.00);
INSERT INTO `order_detail` VALUES (34, '剁椒鱼头', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/e99a0f01-52f3-4bd6-9d47-16098f40a66b.png', 16, 61, NULL, NULL, 5, 66.00);
INSERT INTO `order_detail` VALUES (35, '东坡肘子', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/81a29656-60d0-4d98-a72c-13a933f7dbdd.png', 16, 59, NULL, NULL, 1, 138.00);
INSERT INTO `order_detail` VALUES (36, '金汤酸菜牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/69891db5-9b76-4aa7-a68b-2ec38df692e8.png', 17, 62, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (37, '香锅牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/aa86396e-34f0-47c8-a7ad-9cfbfa9da2b1.png', 17, 63, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (38, '金汤酸菜牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/69891db5-9b76-4aa7-a68b-2ec38df692e8.png', 18, 62, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (39, '金汤酸菜牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/69891db5-9b76-4aa7-a68b-2ec38df692e8.png', 19, 62, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (40, '馋嘴牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/bd99bf9f-a704-44dd-bb32-b5c25fcc58e7.png', 20, 64, NULL, NULL, 10, 88.00);
INSERT INTO `order_detail` VALUES (41, '鮰鱼2斤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/12b15b88-7701-432c-a72b-4afa40086ed4.png', 21, 67, NULL, '不辣', 1, 72.00);
INSERT INTO `order_detail` VALUES (42, '江团鱼2斤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/a3ecea19-31a4-466c-9ca7-af7048e9d20e.png', 21, 66, NULL, '重辣', 1, 119.00);
INSERT INTO `order_detail` VALUES (43, '剁椒鱼头', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/e99a0f01-52f3-4bd6-9d47-16098f40a66b.png', 21, 61, NULL, NULL, 16, 66.00);
INSERT INTO `order_detail` VALUES (44, '米饭', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/5401217f-5b7c-4651-ba6c-9a957a4a8985.png', 22, 49, NULL, NULL, 21, 2.00);
INSERT INTO `order_detail` VALUES (45, '雪花啤酒', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/20b55196-2b67-4c0b-bced-1e1e4bc7b171.png', 23, 48, NULL, NULL, 10, 4.00);
INSERT INTO `order_detail` VALUES (46, '馋嘴牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/bd99bf9f-a704-44dd-bb32-b5c25fcc58e7.png', 24, 64, NULL, NULL, 11, 88.00);
INSERT INTO `order_detail` VALUES (47, '平菇豆腐汤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/399b6fa7-abba-4992-8f43-26ad34f925de.png', 25, 69, NULL, NULL, 1, 6.00);
INSERT INTO `order_detail` VALUES (48, '鸡蛋汤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/caaede27-ec3e-4791-bf94-1bcc3f8b5e13.png', 25, 68, NULL, NULL, 2, 5.00);
INSERT INTO `order_detail` VALUES (49, '套餐二', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/d3c1b3e1-8c0e-40da-bd78-4a69fbc8323b.png', 25, NULL, 39, NULL, 1, 100.00);
INSERT INTO `order_detail` VALUES (50, '套餐一', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/79099838-f884-484f-87c2-ec850f0ad1a0.png', 25, NULL, 38, NULL, 1, 99.00);
INSERT INTO `order_detail` VALUES (51, '蒜蓉娃娃菜', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/ceda4cdc-45db-4e7c-930c-012b7767984c.png', 25, 55, NULL, NULL, 1, 18.00);
INSERT INTO `order_detail` VALUES (52, '王老吉', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/0731a52e-a371-46d0-8719-0a8f930823d1.png', 25, 46, NULL, NULL, 1, 6.00);
INSERT INTO `order_detail` VALUES (53, '北冰洋', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/a69df2d1-fdf7-4c03-9441-da1c4bf9acb5.png', 25, 47, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (54, '馒头', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/c30fa662-1f5b-4320-a675-8646cbbb696c.png', 25, 50, NULL, NULL, 2, 1.00);
INSERT INTO `order_detail` VALUES (55, '老坛酸菜鱼', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/d08f4cd3-934c-44cb-aec6-2fde4882f0d7.png', 25, 51, NULL, '不要葱,不辣', 1, 56.00);
INSERT INTO `order_detail` VALUES (56, '平菇豆腐汤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/399b6fa7-abba-4992-8f43-26ad34f925de.png', 26, 69, NULL, NULL, 1, 6.00);
INSERT INTO `order_detail` VALUES (57, '鸡蛋汤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/caaede27-ec3e-4791-bf94-1bcc3f8b5e13.png', 26, 68, NULL, NULL, 1, 5.00);
INSERT INTO `order_detail` VALUES (58, '套餐一', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/79099838-f884-484f-87c2-ec850f0ad1a0.png', 26, NULL, 38, NULL, 1, 99.00);
INSERT INTO `order_detail` VALUES (59, '套餐二', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/d3c1b3e1-8c0e-40da-bd78-4a69fbc8323b.png', 26, NULL, 39, NULL, 1, 100.00);
INSERT INTO `order_detail` VALUES (60, '王老吉', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/0731a52e-a371-46d0-8719-0a8f930823d1.png', 26, 46, NULL, NULL, 1, 6.00);
INSERT INTO `order_detail` VALUES (61, '北冰洋', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/a69df2d1-fdf7-4c03-9441-da1c4bf9acb5.png', 26, 47, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (62, '雪花啤酒', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/20b55196-2b67-4c0b-bced-1e1e4bc7b171.png', 26, 48, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (63, '米饭', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/5401217f-5b7c-4651-ba6c-9a957a4a8985.png', 26, 49, NULL, NULL, 1, 2.00);
INSERT INTO `order_detail` VALUES (64, '馒头', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/c30fa662-1f5b-4320-a675-8646cbbb696c.png', 26, 50, NULL, NULL, 1, 1.00);
INSERT INTO `order_detail` VALUES (65, '老坛酸菜鱼', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/d08f4cd3-934c-44cb-aec6-2fde4882f0d7.png', 26, 51, NULL, '不要葱,不辣', 1, 56.00);
INSERT INTO `order_detail` VALUES (66, '经典酸菜鮰鱼', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/7c00e715-4457-4d3d-995b-f9459973cf2b.png', 26, 52, NULL, '不要葱,不辣', 1, 66.00);
INSERT INTO `order_detail` VALUES (67, '蜀味水煮草鱼', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/8308c17b-5148-4725-a186-0958f8d56618.png', 26, 53, NULL, '不要葱,不辣', 1, 38.00);
INSERT INTO `order_detail` VALUES (68, '蒜蓉娃娃菜', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/ceda4cdc-45db-4e7c-930c-012b7767984c.png', 26, 55, NULL, NULL, 1, 18.00);
INSERT INTO `order_detail` VALUES (69, '炝炒圆白菜', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/016e3a0b-47cb-476d-90b9-a2ec6824220f.png', 26, 57, NULL, '不要葱', 1, 18.00);
INSERT INTO `order_detail` VALUES (70, '清炒西兰花', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/64fe82e2-78c3-4fca-8bb5-0a109acd9b66.png', 26, 56, NULL, '不要葱', 1, 18.00);
INSERT INTO `order_detail` VALUES (71, '清炒小油菜', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/6600505a-9a61-42ef-bf60-f1a515d25e97.png', 26, 54, NULL, '不要葱', 1, 18.00);
INSERT INTO `order_detail` VALUES (72, '测试菜品', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/78c7c957-57f6-436b-8ae3-0def3701a842.png', 26, 71, NULL, '无糖,不辣', 1, 25.00);
INSERT INTO `order_detail` VALUES (73, '剁椒鱼头', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/e99a0f01-52f3-4bd6-9d47-16098f40a66b.png', 26, 61, NULL, NULL, 1, 66.00);
INSERT INTO `order_detail` VALUES (74, '梅菜扣肉', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/c3ac9e04-f0d0-43ec-a50e-e135abaad0c5.png', 26, 60, NULL, '不要葱', 1, 58.00);
INSERT INTO `order_detail` VALUES (75, '东坡肘子', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/81a29656-60d0-4d98-a72c-13a933f7dbdd.png', 26, 59, NULL, NULL, 1, 138.00);
INSERT INTO `order_detail` VALUES (76, '清蒸鲈鱼', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/d587e881-b186-4b8d-a4e3-26536108a6e2.png', 26, 58, NULL, NULL, 1, 98.00);
INSERT INTO `order_detail` VALUES (77, '鮰鱼2斤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/12b15b88-7701-432c-a72b-4afa40086ed4.png', 26, 67, NULL, '不辣', 1, 72.00);
INSERT INTO `order_detail` VALUES (78, '江团鱼2斤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/a3ecea19-31a4-466c-9ca7-af7048e9d20e.png', 26, 66, NULL, '不辣', 1, 119.00);
INSERT INTO `order_detail` VALUES (79, '草鱼2斤', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/c9276c0b-4118-4568-a3ed-6b6201402984.png', 26, 65, NULL, '不辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (80, '馋嘴牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/bd99bf9f-a704-44dd-bb32-b5c25fcc58e7.png', 26, 64, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (81, '香锅牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/aa86396e-34f0-47c8-a7ad-9cfbfa9da2b1.png', 26, 63, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (82, '金汤酸菜牛蛙', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/69891db5-9b76-4aa7-a68b-2ec38df692e8.png', 26, 62, NULL, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (83, '套餐二', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/d3c1b3e1-8c0e-40da-bd78-4a69fbc8323b.png', 27, NULL, 39, NULL, 1, 100.00);
INSERT INTO `order_detail` VALUES (84, '雪花啤酒', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/20b55196-2b67-4c0b-bced-1e1e4bc7b171.png', 27, 48, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (85, '剁椒鱼头', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/e99a0f01-52f3-4bd6-9d47-16098f40a66b.png', 28, 61, NULL, NULL, 1, 66.00);
INSERT INTO `order_detail` VALUES (86, '雪花啤酒', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/20b55196-2b67-4c0b-bced-1e1e4bc7b171.png', 28, 48, NULL, NULL, 4, 4.00);
INSERT INTO `order_detail` VALUES (87, '米饭', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/5401217f-5b7c-4651-ba6c-9a957a4a8985.png', 28, 49, NULL, NULL, 4, 2.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '订单号',
  `status` int NOT NULL DEFAULT 1 COMMENT '订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款',
  `user_id` bigint NOT NULL COMMENT '下单用户',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime NULL DEFAULT NULL COMMENT '结账时间',
  `pay_method` int NOT NULL DEFAULT 1 COMMENT '支付方式 1微信,2支付宝',
  `pay_status` tinyint NOT NULL DEFAULT 0 COMMENT '支付状态 0未支付 1已支付 2退款',
  `amount` decimal(10, 2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '手机号',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '地址',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户名称',
  `consignee` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '收货人',
  `cancel_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '订单取消原因',
  `rejection_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '订单拒绝原因',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '订单取消时间',
  `estimated_delivery_time` datetime NULL DEFAULT NULL COMMENT '预计送达时间',
  `delivery_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '配送状态  1立即送出  0选择具体时间',
  `delivery_time` datetime NULL DEFAULT NULL COMMENT '送达时间',
  `pack_amount` int NULL DEFAULT NULL COMMENT '打包费',
  `tableware_number` int NULL DEFAULT NULL COMMENT '餐具数量',
  `tableware_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '餐具数量状态  1按餐量提供  0选择具体数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (4, '1738917694715', 5, 4, 2, '2025-02-07 16:41:35', NULL, 1, 0, 257.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-02-09 19:15:41', '2025-02-07 17:41:00', 0, '2025-02-12 15:42:44', 3, 0, 0);
INSERT INTO `orders` VALUES (5, '1738917968719', 6, 4, 2, '2025-02-07 16:46:09', NULL, 1, 0, 273.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-02-09 19:15:41', '2025-02-07 17:45:00', 0, NULL, 3, 0, 0);
INSERT INTO `orders` VALUES (6, '1739082962764', 6, 4, 2, '2025-02-09 14:36:03', NULL, 1, 0, 51.00, '', '13800000000', '北京大学', NULL, '张三', '订单量较多，暂时无法接单', NULL, '2025-02-09 18:57:33', '2025-02-09 15:35:00', 0, NULL, 2, 0, 0);
INSERT INTO `orders` VALUES (7, '1739098742607', 6, 4, 2, '2025-02-09 18:59:03', NULL, 1, 0, 95.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-02-09 19:16:51', '2025-02-09 19:58:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (8, '1739098783309', 6, 4, 2, '2025-02-09 18:59:43', NULL, 1, 0, 95.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-02-09 19:15:41', '2025-02-09 19:59:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (9, '1740038991337', 6, 4, 2, '2025-02-20 16:09:51', NULL, 1, 0, 184.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-02-28 23:44:00', '2025-02-20 17:09:00', 0, NULL, 2, 0, 0);
INSERT INTO `orders` VALUES (10, '1741062345021', 6, 4, 2, '2025-03-04 12:25:45', NULL, 1, 0, 184.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-03-04 12:41:00', '2025-03-04 13:25:00', 0, NULL, 2, 0, 0);
INSERT INTO `orders` VALUES (11, '1742740690763', 6, 4, 2, '2025-03-23 22:38:11', NULL, 1, 0, 184.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-03-23 22:54:00', '2025-03-23 23:38:00', 0, NULL, 2, 0, 0);
INSERT INTO `orders` VALUES (12, '1742740699610', 6, 4, 2, '2025-03-23 22:38:20', NULL, 1, 0, 273.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-03-23 22:54:00', '2025-03-23 23:38:00', 0, NULL, 3, 0, 0);
INSERT INTO `orders` VALUES (13, '1742740721217', 6, 4, 2, '2025-03-23 22:38:41', NULL, 1, 0, 413.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-03-23 22:54:00', '2025-03-23 23:38:00', 0, NULL, 8, 0, 0);
INSERT INTO `orders` VALUES (14, '1742740730988', 6, 4, 2, '2025-03-23 22:38:51', NULL, 1, 0, 107.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-03-23 22:54:00', '2025-03-23 23:38:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (15, '1742740742588', 6, 4, 2, '2025-03-23 22:39:03', NULL, 1, 0, 268.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-03-23 22:55:00', '2025-03-23 23:39:00', 0, NULL, 3, 0, 0);
INSERT INTO `orders` VALUES (16, '1742740753411', 6, 4, 2, '2025-03-23 22:39:13', NULL, 1, 0, 480.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-03-23 22:55:00', '2025-03-23 23:39:00', 0, NULL, 6, 0, 0);
INSERT INTO `orders` VALUES (17, '1742740792056', 6, 4, 2, '2025-03-23 22:39:52', NULL, 1, 0, 184.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-03-23 22:55:00', '2025-03-23 23:39:00', 0, NULL, 2, 0, 0);
INSERT INTO `orders` VALUES (18, '1742741039120', 6, 4, 2, '2025-03-23 22:43:59', NULL, 1, 0, 95.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-03-23 22:59:00', '2025-03-23 23:43:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (19, '1742742103471', 5, 4, 2, '2025-03-23 23:01:43', NULL, 1, 0, 95.00, '', '13800000000', '北京大学', NULL, '张三', NULL, NULL, NULL, '2025-03-23 00:01:00', 0, '2025-03-23 23:06:21', 1, 0, 0);
INSERT INTO `orders` VALUES (20, '1742742263924', 5, 4, 2, '2025-03-23 23:04:24', NULL, 1, 0, 896.00, '', '13800000000', '北京大学', NULL, '张三', NULL, NULL, NULL, '2025-03-23 00:04:00', 0, '2025-03-23 23:06:20', 10, 0, 0);
INSERT INTO `orders` VALUES (21, '1742742283815', 5, 4, 2, '2025-03-23 23:04:44', NULL, 1, 0, 1271.00, '', '13800000000', '北京大学', NULL, '张三', NULL, NULL, NULL, '2025-03-23 00:04:00', 0, '2025-03-23 23:06:20', 18, 0, 0);
INSERT INTO `orders` VALUES (22, '1742742297904', 5, 4, 2, '2025-03-23 23:04:58', NULL, 1, 0, 69.00, '', '13800000000', '北京大学', NULL, '张三', NULL, NULL, NULL, '2025-03-23 00:04:00', 0, '2025-03-23 23:06:20', 21, 0, 0);
INSERT INTO `orders` VALUES (23, '1742742318327', 6, 4, 2, '2025-03-23 23:05:18', NULL, 1, 0, 56.00, '', '13800000000', '北京大学', NULL, '张三', '订单超时，自动取消', NULL, '2025-03-23 23:21:00', '2025-03-23 00:05:00', 0, NULL, 10, 0, 0);
INSERT INTO `orders` VALUES (24, '1742742329296', 5, 4, 2, '2025-03-23 23:05:29', NULL, 1, 0, 985.00, '', '13800000000', '北京大学', NULL, '张三', NULL, NULL, NULL, '2025-03-23 00:05:00', 0, '2025-03-23 23:06:19', 11, 0, 0);
INSERT INTO `orders` VALUES (25, '1742742352711', 5, 4, 2, '2025-03-23 23:05:53', NULL, 1, 0, 318.00, '', '13800000000', '北京大学', NULL, '张三', NULL, NULL, NULL, '2025-03-23 00:05:00', 0, '2025-03-23 23:06:18', 11, 0, 0);
INSERT INTO `orders` VALUES (26, '1742743431539', 5, 4, 2, '2025-03-23 23:23:52', NULL, 1, 0, 1400.00, '', '13800000000', '北京大学', NULL, '张三', NULL, NULL, NULL, '2025-03-23 00:23:00', 0, '2025-03-23 23:24:22', 27, 0, 0);
INSERT INTO `orders` VALUES (27, '1742743706384', 2, 4, 2, '2025-03-23 23:28:26', NULL, 1, 0, 112.00, '', '13800000000', '北京大学', NULL, '张三', NULL, NULL, NULL, '2025-03-23 00:28:00', 0, NULL, 2, 0, 0);
INSERT INTO `orders` VALUES (28, '1742743738461', 2, 4, 2, '2025-03-23 23:28:58', NULL, 1, 0, 105.00, '', '13800000000', '北京大学', NULL, '张三', NULL, NULL, NULL, '2025-03-23 00:28:00', 0, NULL, 9, 0, 0);

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '套餐名称',
  `price` decimal(10, 2) NOT NULL COMMENT '套餐价格',
  `status` int NULL DEFAULT 1 COMMENT '售卖状态 0:停售 1:起售',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_setmeal_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '套餐' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of setmeal
-- ----------------------------
INSERT INTO `setmeal` VALUES (38, 13, '套餐一', 99.00, 1, '', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/79099838-f884-484f-87c2-ec850f0ad1a0.png', '2025-02-05 17:35:47', '2025-02-05 17:35:47', 1, 1);
INSERT INTO `setmeal` VALUES (39, 15, '套餐二', 100.00, 1, '', 'https://my-first-bucket-one.oss-cn-beijing.aliyuncs.com/d3c1b3e1-8c0e-40da-bd78-4a69fbc8323b.png', '2025-02-05 17:38:04', '2025-02-05 17:38:04', 1, 1);

-- ----------------------------
-- Table structure for setmeal_dish
-- ----------------------------
DROP TABLE IF EXISTS `setmeal_dish`;
CREATE TABLE `setmeal_dish`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `setmeal_id` bigint NULL DEFAULT NULL COMMENT '套餐id',
  `dish_id` bigint NULL DEFAULT NULL COMMENT '菜品id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '菜品名称 （冗余字段）',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品单价（冗余字段）',
  `copies` int NULL DEFAULT NULL COMMENT '菜品份数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '套餐菜品关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of setmeal_dish
-- ----------------------------
INSERT INTO `setmeal_dish` VALUES (59, 38, 55, '蒜蓉娃娃菜', 18.00, 1);
INSERT INTO `setmeal_dish` VALUES (60, 38, 69, '平菇豆腐汤', 6.00, 1);
INSERT INTO `setmeal_dish` VALUES (61, 38, 48, '雪花啤酒', 4.00, 1);
INSERT INTO `setmeal_dish` VALUES (62, 38, 50, '馒头', 1.00, 1);
INSERT INTO `setmeal_dish` VALUES (63, 38, 49, '米饭', 2.00, 1);
INSERT INTO `setmeal_dish` VALUES (64, 38, 67, '鮰鱼2斤', 72.00, 1);
INSERT INTO `setmeal_dish` VALUES (65, 39, 54, '清炒小油菜', 18.00, 1);
INSERT INTO `setmeal_dish` VALUES (66, 39, 69, '平菇豆腐汤', 6.00, 1);
INSERT INTO `setmeal_dish` VALUES (67, 39, 48, '雪花啤酒', 4.00, 1);
INSERT INTO `setmeal_dish` VALUES (68, 39, 49, '米饭', 2.00, 1);
INSERT INTO `setmeal_dish` VALUES (69, 39, 52, '经典酸菜鮰鱼', 66.00, 1);
INSERT INTO `setmeal_dish` VALUES (70, 39, 57, '炝炒圆白菜', 18.00, 1);

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '商品名称',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `user_id` bigint NOT NULL COMMENT '主键',
  `dish_id` bigint NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '购物车' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '微信用户唯一标识',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '头像',
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (4, 'demo-openid-0000000000000001', NULL, NULL, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
