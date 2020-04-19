/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : nio_im

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 19/04/2020 22:30:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `code` varchar(50) DEFAULT NULL COMMENT '字典项',
  `value` int(11) DEFAULT NULL COMMENT '值',
  `name` varchar(50) DEFAULT NULL COMMENT '对应的名称',
  `parent` int(11) DEFAULT NULL COMMENT '父id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据字典表';

-- ----------------------------
-- Records of dictionary
-- ----------------------------
BEGIN;
INSERT INTO `dictionary` VALUES (1, 'constellation', 1, '摩羯座', NULL);
INSERT INTO `dictionary` VALUES (2, 'constellation', 2, '水瓶座', NULL);
INSERT INTO `dictionary` VALUES (3, 'constellation', 3, '双鱼座', NULL);
INSERT INTO `dictionary` VALUES (4, 'constellation', 4, '白羊座', NULL);
INSERT INTO `dictionary` VALUES (5, 'constellation', 5, '金牛座', NULL);
INSERT INTO `dictionary` VALUES (6, 'constellation', 6, '双子座', NULL);
INSERT INTO `dictionary` VALUES (7, 'constellation', 7, '巨蟹座', NULL);
INSERT INTO `dictionary` VALUES (8, 'constellation', 8, '狮子座', NULL);
INSERT INTO `dictionary` VALUES (9, 'constellation', 9, '处女座', NULL);
INSERT INTO `dictionary` VALUES (10, 'constellation', 10, '天秤座', NULL);
INSERT INTO `dictionary` VALUES (11, 'constellation', 11, '天蝎座', NULL);
INSERT INTO `dictionary` VALUES (12, 'constellation', 12, '射手座', NULL);
INSERT INTO `dictionary` VALUES (13, 'zodiac', 1, '鼠', NULL);
INSERT INTO `dictionary` VALUES (14, 'zodiac', 2, '牛', NULL);
INSERT INTO `dictionary` VALUES (15, 'zodiac', 3, '虎', NULL);
INSERT INTO `dictionary` VALUES (16, 'zodiac', 4, '兔', NULL);
INSERT INTO `dictionary` VALUES (17, 'zodiac', 5, '龙', NULL);
INSERT INTO `dictionary` VALUES (18, 'zodiac', 6, '蛇', NULL);
INSERT INTO `dictionary` VALUES (19, 'zodiac', 7, '马', NULL);
INSERT INTO `dictionary` VALUES (20, 'zodiac', 8, '羊', NULL);
INSERT INTO `dictionary` VALUES (21, 'zodiac', 9, '猴', NULL);
INSERT INTO `dictionary` VALUES (22, 'zodiac', 10, '鸡', NULL);
INSERT INTO `dictionary` VALUES (23, 'zodiac', 11, '狗', NULL);
INSERT INTO `dictionary` VALUES (24, 'zodiac', 12, '猪', NULL);
COMMIT;

-- ----------------------------
-- Table structure for group_table
-- ----------------------------
DROP TABLE IF EXISTS `group_table`;
CREATE TABLE `group_table` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `name` varchar(50) DEFAULT NULL COMMENT '群聊名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `notice` text COMMENT '群公告',
  `group_img_reduce` varchar(255) DEFAULT NULL COMMENT '群头像图片地址（压缩图片）',
  `group_img` varchar(255) DEFAULT NULL COMMENT '群头像（原图）',
  `group_owner` bigint(20) DEFAULT NULL COMMENT '群主',
  PRIMARY KEY (`id`),
  KEY `group_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='群信息表';

-- ----------------------------
-- Records of group_table
-- ----------------------------
BEGIN;
INSERT INTO `group_table` VALUES (508745826, 'hello', '5⃣️', '2020-03-01 20:05:51', '！！！！！！！！！！！！！！！！', NULL, NULL, 3520745329);
COMMIT;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '消息属于者，如果为负数，表示该消息属于多用户，具体用户由服务端自己来根据data解析',
  `send_id` bigint(20) DEFAULT NULL COMMENT '发送者id',
  `type` varchar(50) DEFAULT NULL COMMENT '消息类型',
  `data` text COMMENT '消息内容，JSON格式',
  `signed` bit(1) DEFAULT b'0' COMMENT '消息是否签收 1：签收 0：未签收',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`),
  KEY `message_id_index` (`id`),
  KEY `message_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=938 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='消息表';

-- ----------------------------
-- Records of message
-- ----------------------------
BEGIN;
INSERT INTO `message` VALUES (484, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T12:16:24.527\",\"signed\":false}', b'1', '2020-03-15 12:16:25');
INSERT INTO `message` VALUES (496, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T13:38:28.138\",\"signed\":false}', b'1', '2020-03-15 13:38:28');
INSERT INTO `message` VALUES (497, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T13:38:28.322\",\"signed\":false}', b'1', '2020-03-15 13:38:28');
INSERT INTO `message` VALUES (498, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T13:38:28.477\",\"signed\":false}', b'1', '2020-03-15 13:38:28');
INSERT INTO `message` VALUES (499, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T13:38:28.639\",\"signed\":false}', b'1', '2020-03-15 13:38:29');
INSERT INTO `message` VALUES (500, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T13:38:28.809\",\"signed\":false}', b'1', '2020-03-15 13:38:29');
INSERT INTO `message` VALUES (501, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T13:38:28.970\",\"signed\":false}', b'1', '2020-03-15 13:38:29');
INSERT INTO `message` VALUES (502, 3520745329, 3520745329, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T13:38:29.140\",\"signed\":false}', b'1', '2020-03-15 13:38:29');
INSERT INTO `message` VALUES (503, 3520745329, 3520745329, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T13:38:29.327\",\"signed\":false}', b'1', '2020-03-15 13:38:29');
INSERT INTO `message` VALUES (504, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T13:38:29.496\",\"signed\":false}', b'1', '2020-03-15 13:38:29');
INSERT INTO `message` VALUES (505, 35207453291, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":35207453291,\"sendId\":3520745329,\"sendTime\":\"2020-03-15T13:42:00.128\",\"signed\":false}', b'0', '2020-03-15 13:42:00');
INSERT INTO `message` VALUES (506, 35207453291, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":35207453291,\"sendId\":3520745329,\"sendTime\":\"2020-03-15T13:42:00.354\",\"signed\":false}', b'0', '2020-03-15 13:42:00');
INSERT INTO `message` VALUES (507, 35207453291, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":35207453291,\"sendId\":3520745329,\"sendTime\":\"2020-03-15T13:42:00.532\",\"signed\":false}', b'0', '2020-03-15 13:42:01');
INSERT INTO `message` VALUES (508, 35207453291, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":35207453291,\"sendId\":3520745329,\"sendTime\":\"2020-03-15T13:42:00.709\",\"signed\":false}', b'0', '2020-03-15 13:42:01');
INSERT INTO `message` VALUES (509, 35207453291, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":35207453291,\"sendId\":3520745329,\"sendTime\":\"2020-03-15T13:42:00.887\",\"signed\":false}', b'0', '2020-03-15 13:42:01');
INSERT INTO `message` VALUES (510, 35207453291, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":35207453291,\"sendId\":3520745329,\"sendTime\":\"2020-03-15T13:42:01.074\",\"signed\":false}', b'0', '2020-03-15 13:42:01');
INSERT INTO `message` VALUES (511, 35207453291, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":35207453291,\"sendId\":3520745329,\"sendTime\":\"2020-03-15T13:42:01.243\",\"signed\":false}', b'0', '2020-03-15 13:42:01');
INSERT INTO `message` VALUES (512, 35207453291, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":35207453291,\"sendId\":3520745329,\"sendTime\":\"2020-03-15T13:42:01.430\",\"signed\":false}', b'0', '2020-03-15 13:42:01');
INSERT INTO `message` VALUES (513, 35207453291, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":35207453291,\"sendId\":3520745329,\"sendTime\":\"2020-03-15T18:06:12.628\",\"signed\":false}', b'0', '2020-03-15 18:06:13');
INSERT INTO `message` VALUES (514, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:06:51.090\",\"signed\":false}', b'1', '2020-03-15 18:06:51');
INSERT INTO `message` VALUES (515, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:07.890\",\"signed\":false}', b'1', '2020-03-15 18:07:08');
INSERT INTO `message` VALUES (516, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:08.306\",\"signed\":false}', b'1', '2020-03-15 18:07:08');
INSERT INTO `message` VALUES (517, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:16.456\",\"signed\":false}', b'1', '2020-03-15 18:07:16');
INSERT INTO `message` VALUES (518, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:16.649\",\"signed\":false}', b'1', '2020-03-15 18:07:17');
INSERT INTO `message` VALUES (519, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:16.810\",\"signed\":false}', b'1', '2020-03-15 18:07:17');
INSERT INTO `message` VALUES (520, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:16.971\",\"signed\":false}', b'1', '2020-03-15 18:07:17');
INSERT INTO `message` VALUES (521, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:23.442\",\"signed\":false}', b'1', '2020-03-15 18:07:23');
INSERT INTO `message` VALUES (522, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:23.732\",\"signed\":false}', b'1', '2020-03-15 18:07:24');
INSERT INTO `message` VALUES (523, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:23.908\",\"signed\":false}', b'1', '2020-03-15 18:07:24');
INSERT INTO `message` VALUES (524, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:24.073\",\"signed\":false}', b'1', '2020-03-15 18:07:24');
INSERT INTO `message` VALUES (525, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:24.240\",\"signed\":false}', b'1', '2020-03-15 18:07:24');
INSERT INTO `message` VALUES (526, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:24.395\",\"signed\":false}', b'1', '2020-03-15 18:07:24');
INSERT INTO `message` VALUES (527, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:24.554\",\"signed\":false}', b'1', '2020-03-15 18:07:25');
INSERT INTO `message` VALUES (528, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:24.701\",\"signed\":false}', b'1', '2020-03-15 18:07:25');
INSERT INTO `message` VALUES (529, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:24.853\",\"signed\":false}', b'1', '2020-03-15 18:07:25');
INSERT INTO `message` VALUES (530, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:25.007\",\"signed\":false}', b'1', '2020-03-15 18:07:25');
INSERT INTO `message` VALUES (531, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:25.161\",\"signed\":false}', b'1', '2020-03-15 18:07:25');
INSERT INTO `message` VALUES (532, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:25.310\",\"signed\":false}', b'1', '2020-03-15 18:07:25');
INSERT INTO `message` VALUES (533, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:25.517\",\"signed\":false}', b'1', '2020-03-15 18:07:26');
INSERT INTO `message` VALUES (534, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:25.900\",\"signed\":false}', b'1', '2020-03-15 18:07:26');
INSERT INTO `message` VALUES (535, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:26.075\",\"signed\":false}', b'1', '2020-03-15 18:07:26');
INSERT INTO `message` VALUES (536, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:26.252\",\"signed\":false}', b'1', '2020-03-15 18:07:26');
INSERT INTO `message` VALUES (537, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:26.667\",\"signed\":false}', b'1', '2020-03-15 18:07:27');
INSERT INTO `message` VALUES (538, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:26.980\",\"signed\":false}', b'1', '2020-03-15 18:07:27');
INSERT INTO `message` VALUES (539, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:27.379\",\"signed\":false}', b'1', '2020-03-15 18:07:27');
INSERT INTO `message` VALUES (540, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:27.742\",\"signed\":false}', b'1', '2020-03-15 18:07:28');
INSERT INTO `message` VALUES (541, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:28.072\",\"signed\":false}', b'1', '2020-03-15 18:07:28');
INSERT INTO `message` VALUES (542, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:28.486\",\"signed\":false}', b'1', '2020-03-15 18:07:28');
INSERT INTO `message` VALUES (543, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:28.834\",\"signed\":false}', b'1', '2020-03-15 18:07:29');
INSERT INTO `message` VALUES (544, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:29.051\",\"signed\":false}', b'1', '2020-03-15 18:07:29');
INSERT INTO `message` VALUES (545, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:29.213\",\"signed\":false}', b'1', '2020-03-15 18:07:29');
INSERT INTO `message` VALUES (546, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:29.384\",\"signed\":false}', b'1', '2020-03-15 18:07:29');
INSERT INTO `message` VALUES (547, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:29.553\",\"signed\":false}', b'1', '2020-03-15 18:07:30');
INSERT INTO `message` VALUES (548, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:29.714\",\"signed\":false}', b'1', '2020-03-15 18:07:30');
INSERT INTO `message` VALUES (549, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:29.862\",\"signed\":false}', b'1', '2020-03-15 18:07:30');
INSERT INTO `message` VALUES (550, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:30.023\",\"signed\":false}', b'1', '2020-03-15 18:07:30');
INSERT INTO `message` VALUES (551, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:30.185\",\"signed\":false}', b'1', '2020-03-15 18:07:30');
INSERT INTO `message` VALUES (552, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:30.362\",\"signed\":false}', b'1', '2020-03-15 18:07:30');
INSERT INTO `message` VALUES (553, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:30.524\",\"signed\":false}', b'1', '2020-03-15 18:07:31');
INSERT INTO `message` VALUES (554, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T18:07:30.686\",\"signed\":false}', b'1', '2020-03-15 18:07:31');
INSERT INTO `message` VALUES (555, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T19:05:55.758\",\"signed\":false}', b'1', '2020-03-15 19:05:56');
INSERT INTO `message` VALUES (556, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T20:12:52.563\",\"signed\":false}', b'1', '2020-03-15 20:12:53');
INSERT INTO `message` VALUES (557, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T20:12:57.474\",\"signed\":false}', b'1', '2020-03-15 20:12:57');
INSERT INTO `message` VALUES (558, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T21:43:09.200\",\"signed\":false}', b'1', '2020-03-15 21:43:09');
INSERT INTO `message` VALUES (559, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T21:43:22.702\",\"signed\":false}', b'1', '2020-03-15 21:43:23');
INSERT INTO `message` VALUES (560, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T21:43:22.895\",\"signed\":false}', b'1', '2020-03-15 21:43:23');
INSERT INTO `message` VALUES (561, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T21:43:23.081\",\"signed\":false}', b'1', '2020-03-15 21:43:23');
INSERT INTO `message` VALUES (562, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T21:58:57.244\",\"signed\":false}', b'1', '2020-03-15 21:58:57');
INSERT INTO `message` VALUES (563, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T21:59:03.485\",\"signed\":false}', b'1', '2020-03-15 21:59:03');
INSERT INTO `message` VALUES (564, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:00:36.837\",\"signed\":false}', b'1', '2020-03-15 22:00:37');
INSERT INTO `message` VALUES (565, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:04:53.858\",\"signed\":false}', b'1', '2020-03-15 22:04:54');
INSERT INTO `message` VALUES (566, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:04:54.079\",\"signed\":false}', b'1', '2020-03-15 22:04:54');
INSERT INTO `message` VALUES (567, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:04:54.255\",\"signed\":false}', b'1', '2020-03-15 22:04:54');
INSERT INTO `message` VALUES (568, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:05:01.377\",\"signed\":false}', b'1', '2020-03-15 22:05:01');
INSERT INTO `message` VALUES (569, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:05:01.855\",\"signed\":false}', b'1', '2020-03-15 22:05:02');
INSERT INTO `message` VALUES (570, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:05:16.356\",\"signed\":false}', b'1', '2020-03-15 22:05:16');
INSERT INTO `message` VALUES (571, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:05:17.106\",\"signed\":false}', b'1', '2020-03-15 22:05:17');
INSERT INTO `message` VALUES (572, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:06:43.329\",\"signed\":false}', b'1', '2020-03-15 22:06:43');
INSERT INTO `message` VALUES (573, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:06:47.983\",\"signed\":false}', b'1', '2020-03-15 22:06:48');
INSERT INTO `message` VALUES (574, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:06:51.735\",\"signed\":false}', b'1', '2020-03-15 22:06:52');
INSERT INTO `message` VALUES (575, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:06:55.551\",\"signed\":false}', b'1', '2020-03-15 22:06:56');
INSERT INTO `message` VALUES (576, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:07:00.468\",\"signed\":false}', b'1', '2020-03-15 22:07:00');
INSERT INTO `message` VALUES (577, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:07:04.985\",\"signed\":false}', b'1', '2020-03-15 22:07:05');
INSERT INTO `message` VALUES (578, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:08:11.415\",\"signed\":false}', b'1', '2020-03-15 22:08:11');
INSERT INTO `message` VALUES (579, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:08:14.986\",\"signed\":false}', b'1', '2020-03-15 22:08:15');
INSERT INTO `message` VALUES (580, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:08:17.956\",\"signed\":false}', b'1', '2020-03-15 22:08:18');
INSERT INTO `message` VALUES (581, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:08:29.881\",\"signed\":false}', b'1', '2020-03-15 22:08:30');
INSERT INTO `message` VALUES (582, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:08:30.319\",\"signed\":false}', b'1', '2020-03-15 22:08:30');
INSERT INTO `message` VALUES (583, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:09:27.840\",\"signed\":false}', b'1', '2020-03-15 22:09:28');
INSERT INTO `message` VALUES (584, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:09:31.674\",\"signed\":false}', b'1', '2020-03-15 22:09:32');
INSERT INTO `message` VALUES (585, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:10:33.307\",\"signed\":false}', b'1', '2020-03-15 22:10:33');
INSERT INTO `message` VALUES (586, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:10:37.034\",\"signed\":false}', b'1', '2020-03-15 22:10:37');
INSERT INTO `message` VALUES (587, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:10:40.307\",\"signed\":false}', b'1', '2020-03-15 22:10:40');
INSERT INTO `message` VALUES (588, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:10:50.131\",\"signed\":false}', b'1', '2020-03-15 22:10:50');
INSERT INTO `message` VALUES (589, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:08.680\",\"signed\":false}', b'1', '2020-03-15 22:12:09');
INSERT INTO `message` VALUES (590, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:12.550\",\"signed\":false}', b'1', '2020-03-15 22:12:13');
INSERT INTO `message` VALUES (591, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:12.865\",\"signed\":false}', b'1', '2020-03-15 22:12:13');
INSERT INTO `message` VALUES (592, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:13.239\",\"signed\":false}', b'1', '2020-03-15 22:12:13');
INSERT INTO `message` VALUES (593, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:13.617\",\"signed\":false}', b'1', '2020-03-15 22:12:14');
INSERT INTO `message` VALUES (594, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:16.809\",\"signed\":false}', b'1', '2020-03-15 22:12:17');
INSERT INTO `message` VALUES (595, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:17.069\",\"signed\":false}', b'1', '2020-03-15 22:12:17');
INSERT INTO `message` VALUES (596, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:25.778\",\"signed\":false}', b'1', '2020-03-15 22:12:26');
INSERT INTO `message` VALUES (597, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:26.383\",\"signed\":false}', b'1', '2020-03-15 22:12:26');
INSERT INTO `message` VALUES (598, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:26.965\",\"signed\":false}', b'1', '2020-03-15 22:12:27');
INSERT INTO `message` VALUES (599, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:30.222\",\"signed\":false}', b'1', '2020-03-15 22:12:30');
INSERT INTO `message` VALUES (600, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:33.400\",\"signed\":false}', b'1', '2020-03-15 22:12:33');
INSERT INTO `message` VALUES (601, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-15T22:12:33.959\",\"signed\":false}', b'1', '2020-03-15 22:12:34');
INSERT INTO `message` VALUES (602, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T09:45:25.234\",\"signed\":false}', b'1', '2020-03-16 09:45:25');
INSERT INTO `message` VALUES (603, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T09:45:26.823\",\"signed\":false}', b'1', '2020-03-16 09:45:27');
INSERT INTO `message` VALUES (604, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T09:48:18.017\",\"signed\":false}', b'1', '2020-03-16 09:48:18');
INSERT INTO `message` VALUES (605, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:16:57.775\",\"signed\":false}', b'1', '2020-03-16 10:16:58');
INSERT INTO `message` VALUES (606, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:18:44.791\",\"signed\":false}', b'1', '2020-03-16 10:18:45');
INSERT INTO `message` VALUES (607, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:18:54.165\",\"signed\":false}', b'1', '2020-03-16 10:18:54');
INSERT INTO `message` VALUES (608, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:18:54.415\",\"signed\":false}', b'1', '2020-03-16 10:18:54');
INSERT INTO `message` VALUES (609, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:20:06.637\",\"signed\":false}', b'1', '2020-03-16 10:20:07');
INSERT INTO `message` VALUES (610, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:20:07.462\",\"signed\":false}', b'1', '2020-03-16 10:20:07');
INSERT INTO `message` VALUES (611, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:20:53.072\",\"signed\":false}', b'1', '2020-03-16 10:20:53');
INSERT INTO `message` VALUES (612, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:20:53.469\",\"signed\":false}', b'1', '2020-03-16 10:20:53');
INSERT INTO `message` VALUES (613, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:21:58.887\",\"signed\":false}', b'1', '2020-03-16 10:21:59');
INSERT INTO `message` VALUES (614, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:21:59.130\",\"signed\":false}', b'1', '2020-03-16 10:21:59');
INSERT INTO `message` VALUES (615, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:24:55.593\",\"signed\":false}', b'1', '2020-03-16 10:24:56');
INSERT INTO `message` VALUES (616, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:27:24.051\",\"signed\":false}', b'1', '2020-03-16 10:27:24');
INSERT INTO `message` VALUES (617, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:27:24.263\",\"signed\":false}', b'1', '2020-03-16 10:27:24');
INSERT INTO `message` VALUES (618, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:27:24.432\",\"signed\":false}', b'1', '2020-03-16 10:27:24');
INSERT INTO `message` VALUES (619, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:27:33.334\",\"signed\":false}', b'1', '2020-03-16 10:27:33');
INSERT INTO `message` VALUES (620, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:27:33.853\",\"signed\":false}', b'1', '2020-03-16 10:27:34');
INSERT INTO `message` VALUES (621, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:35:55.296\",\"signed\":false}', b'1', '2020-03-16 10:35:55');
INSERT INTO `message` VALUES (622, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:36:03.877\",\"signed\":false}', b'1', '2020-03-16 10:36:04');
INSERT INTO `message` VALUES (623, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:38:09.181\",\"signed\":false}', b'1', '2020-03-16 10:38:09');
INSERT INTO `message` VALUES (624, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:38:14.618\",\"signed\":false}', b'1', '2020-03-16 10:38:15');
INSERT INTO `message` VALUES (625, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:38:15.001\",\"signed\":false}', b'1', '2020-03-16 10:38:15');
INSERT INTO `message` VALUES (626, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:38:15.354\",\"signed\":false}', b'1', '2020-03-16 10:38:15');
INSERT INTO `message` VALUES (627, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:38:20.285\",\"signed\":false}', b'1', '2020-03-16 10:38:20');
INSERT INTO `message` VALUES (628, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:38:20.543\",\"signed\":false}', b'1', '2020-03-16 10:38:21');
INSERT INTO `message` VALUES (629, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:39:27.830\",\"signed\":false}', b'1', '2020-03-16 10:39:28');
INSERT INTO `message` VALUES (630, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:39:28.155\",\"signed\":false}', b'1', '2020-03-16 10:39:28');
INSERT INTO `message` VALUES (631, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:39:28.438\",\"signed\":false}', b'1', '2020-03-16 10:39:28');
INSERT INTO `message` VALUES (632, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:39:32.188\",\"signed\":false}', b'1', '2020-03-16 10:39:32');
INSERT INTO `message` VALUES (633, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:39:32.625\",\"signed\":false}', b'1', '2020-03-16 10:39:33');
INSERT INTO `message` VALUES (634, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:40:05.264\",\"signed\":false}', b'1', '2020-03-16 10:40:05');
INSERT INTO `message` VALUES (635, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:40:05.701\",\"signed\":false}', b'1', '2020-03-16 10:40:06');
INSERT INTO `message` VALUES (636, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:40:06.096\",\"signed\":false}', b'1', '2020-03-16 10:40:06');
INSERT INTO `message` VALUES (637, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:43:17.895\",\"signed\":false}', b'1', '2020-03-16 10:43:18');
INSERT INTO `message` VALUES (638, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:43:18.232\",\"signed\":false}', b'1', '2020-03-16 10:43:18');
INSERT INTO `message` VALUES (639, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T10:43:33.360\",\"signed\":false}', b'1', '2020-03-16 10:43:33');
INSERT INTO `message` VALUES (640, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T11:01:23.460\",\"signed\":false}', b'1', '2020-03-16 11:01:23');
INSERT INTO `message` VALUES (641, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T11:01:34.979\",\"signed\":false}', b'1', '2020-03-16 11:01:35');
INSERT INTO `message` VALUES (642, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T11:01:35.517\",\"signed\":false}', b'1', '2020-03-16 11:01:36');
INSERT INTO `message` VALUES (643, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T11:01:47.769\",\"signed\":false}', b'1', '2020-03-16 11:01:48');
INSERT INTO `message` VALUES (644, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T11:02:12.136\",\"signed\":false}', b'1', '2020-03-16 11:02:12');
INSERT INTO `message` VALUES (645, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T11:02:17.821\",\"signed\":false}', b'1', '2020-03-16 11:02:18');
INSERT INTO `message` VALUES (646, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T11:02:18.254\",\"signed\":false}', b'1', '2020-03-16 11:02:18');
INSERT INTO `message` VALUES (647, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T11:02:27.636\",\"signed\":false}', b'1', '2020-03-16 11:02:28');
INSERT INTO `message` VALUES (648, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T11:02:28.420\",\"signed\":false}', b'1', '2020-03-16 11:02:28');
INSERT INTO `message` VALUES (649, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T11:02:40.385\",\"signed\":false}', b'1', '2020-03-16 11:02:40');
INSERT INTO `message` VALUES (650, 3444614016, 3520745329, 'CHAT', '{\"data\":\"十多个\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-16T11:22:31\",\"signed\":false}', b'1', '2020-03-16 11:22:31');
INSERT INTO `message` VALUES (651, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-16T11:26:40.208\",\"signed\":false}', b'1', '2020-03-16 11:26:40');
INSERT INTO `message` VALUES (652, 3444614016, 3520745329, 'CHAT', '{\"data\":\"是\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-16T11:26:50\",\"signed\":false}', b'1', '2020-03-16 11:26:50');
INSERT INTO `message` VALUES (653, 3520745329, 3520745329, 'CHAT', '{\"data\":\"lk\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T11:46:28\",\"signed\":false}', b'1', '2020-03-17 11:46:28');
INSERT INTO `message` VALUES (654, 3520745329, 3520745329, 'CHAT', '{\"data\":\"ljl\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T11:46:30\",\"signed\":false}', b'1', '2020-03-17 11:46:30');
INSERT INTO `message` VALUES (655, 3520745329, 3520745329, 'CHAT', '{\"data\":\"lkl\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T11:46:35\",\"signed\":false}', b'1', '2020-03-17 11:46:35');
INSERT INTO `message` VALUES (656, 3520745329, 3520745329, 'CHAT', '{\"data\":\"p\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T11:46:39\",\"signed\":false}', b'1', '2020-03-17 11:46:39');
INSERT INTO `message` VALUES (657, 3520745329, 3520745329, 'CHAT', '{\"data\":\"s\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T11:46:41\",\"signed\":false}', b'1', '2020-03-17 11:46:41');
INSERT INTO `message` VALUES (658, 3520745329, 3520745329, 'CHAT', '{\"data\":\"s\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T11:46:45\",\"signed\":false}', b'1', '2020-03-17 11:46:45');
INSERT INTO `message` VALUES (659, 3520745329, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T11:46:52\",\"signed\":false}', b'1', '2020-03-17 11:46:52');
INSERT INTO `message` VALUES (660, 3520745329, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T11:46:58\",\"signed\":false}', b'1', '2020-03-17 11:46:58');
INSERT INTO `message` VALUES (661, 3520745329, 3520745329, 'CHAT', '{\"data\":\".\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T11:47:45\",\"signed\":false}', b'1', '2020-03-17 11:47:45');
INSERT INTO `message` VALUES (662, 3520745329, 3520745329, 'CHAT', '{\"data\":\"d \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T11:49:46\",\"signed\":false}', b'1', '2020-03-17 11:49:46');
INSERT INTO `message` VALUES (663, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sd\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T12:34:54\",\"signed\":false}', b'1', '2020-03-17 12:34:54');
INSERT INTO `message` VALUES (664, 3444614016, 3520745329, 'CHAT', '{\"data\":\"是\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T13:50:44\",\"signed\":false}', b'1', '2020-03-17 13:50:44');
INSERT INTO `message` VALUES (665, 3520745329, 3520745329, 'CHAT', '{\"data\":\"十多个\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T13:51:03\",\"signed\":false}', b'1', '2020-03-17 13:51:03');
INSERT INTO `message` VALUES (666, 3444614016, 3520745329, 'CHAT', '{\"data\":\"十多个\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T13:51:21\",\"signed\":false}', b'1', '2020-03-17 13:51:21');
INSERT INTO `message` VALUES (667, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sdf \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T13:55:39\",\"signed\":false}', b'1', '2020-03-17 13:55:39');
INSERT INTO `message` VALUES (668, 3444614016, 3520745329, 'CHAT', '{\"data\":\"sg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T13:55:47\",\"signed\":false}', b'1', '2020-03-17 13:55:47');
INSERT INTO `message` VALUES (669, 3520745329, 3520745329, 'CHAT', '{\"data\":\"s  \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T13:57:06\",\"signed\":false}', b'1', '2020-03-17 13:57:06');
INSERT INTO `message` VALUES (670, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T13:57:52\",\"signed\":false}', b'1', '2020-03-17 13:57:52');
INSERT INTO `message` VALUES (671, 3444614016, 3520745329, 'CHAT', '{\"data\":\"是\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:01:46\",\"signed\":false}', b'1', '2020-03-17 14:01:46');
INSERT INTO `message` VALUES (672, 3444614016, 3520745329, 'CHAT', '{\"data\":\"隋东风\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:02:02\",\"signed\":false}', b'1', '2020-03-17 14:02:02');
INSERT INTO `message` VALUES (673, 3444614016, 3520745329, 'CHAT', '{\"data\":\"s  \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:03:39\",\"signed\":false}', b'1', '2020-03-17 14:03:39');
INSERT INTO `message` VALUES (674, 3520745329, 3520745329, 'CHAT', '{\"data\":\" \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:04:43\",\"signed\":false}', b'1', '2020-03-17 14:04:43');
INSERT INTO `message` VALUES (675, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sdf \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:04:47\",\"signed\":false}', b'1', '2020-03-17 14:04:47');
INSERT INTO `message` VALUES (676, 3444614016, 3520745329, 'CHAT', '{\"data\":\"sg \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:07:02\",\"signed\":false}', b'1', '2020-03-17 14:07:02');
INSERT INTO `message` VALUES (677, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sdg \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:09:05\",\"signed\":false}', b'1', '2020-03-17 14:09:05');
INSERT INTO `message` VALUES (678, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sd \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:10:10\",\"signed\":false}', b'1', '2020-03-17 14:10:10');
INSERT INTO `message` VALUES (679, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sdf \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:19:11\",\"signed\":false}', b'1', '2020-03-17 14:19:11');
INSERT INTO `message` VALUES (680, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sf \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:19:14\",\"signed\":false}', b'1', '2020-03-17 14:19:14');
INSERT INTO `message` VALUES (681, 3444614016, 3520745329, 'CHAT', '{\"data\":\"000\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:19:25\",\"signed\":false}', b'1', '2020-03-17 14:19:25');
INSERT INTO `message` VALUES (682, 3444614016, 3520745329, 'CHAT', '{\"data\":\"s  \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:22:03\",\"signed\":false}', b'1', '2020-03-17 14:22:03');
INSERT INTO `message` VALUES (683, 3444614016, 3520745329, 'CHAT', '{\"data\":\"iloveyou\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:24:49\",\"signed\":false}', b'1', '2020-03-17 14:24:49');
INSERT INTO `message` VALUES (684, 3520745329, 3520745329, 'CHAT', '{\"data\":\"i love you\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:25:03\",\"signed\":false}', b'1', '2020-03-17 14:25:03');
INSERT INTO `message` VALUES (685, 3520745329, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:25:05\",\"signed\":false}', b'1', '2020-03-17 14:25:05');
INSERT INTO `message` VALUES (686, 3520745329, 3520745329, 'CHAT', '{\"data\":\"你好哇\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:25:10\",\"signed\":false}', b'1', '2020-03-17 14:25:10');
INSERT INTO `message` VALUES (687, 3520745329, 3520745329, 'CHAT', '{\"data\":\"哈哈哈哈哈\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:26:02\",\"signed\":false}', b'1', '2020-03-17 14:26:02');
INSERT INTO `message` VALUES (688, 3520745329, 3520745329, 'CHAT', '{\"data\":\"哈哈哈哈哈哈\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:26:08\",\"signed\":false}', b'1', '2020-03-17 14:26:08');
INSERT INTO `message` VALUES (689, 3520745329, 3520745329, 'CHAT', '{\"data\":\"hh\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:26:09\",\"signed\":false}', b'1', '2020-03-17 14:26:09');
INSERT INTO `message` VALUES (690, 3520745329, 3520745329, 'CHAT', '{\"data\":\" 的\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:26:13\",\"signed\":false}', b'1', '2020-03-17 14:26:13');
INSERT INTO `message` VALUES (691, 3520745329, 3520745329, 'CHAT', '{\"data\":\"45\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:26:16\",\"signed\":false}', b'1', '2020-03-17 14:26:16');
INSERT INTO `message` VALUES (692, 3520745329, 3520745329, 'CHAT', '{\"data\":\"545\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:26:17\",\"signed\":false}', b'1', '2020-03-17 14:26:17');
INSERT INTO `message` VALUES (693, 3520745329, 3520745329, 'CHAT', '{\"data\":\"25\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:26:18\",\"signed\":false}', b'1', '2020-03-17 14:26:18');
INSERT INTO `message` VALUES (694, 3520745329, 3520745329, 'CHAT', '{\"data\":\"高低\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:26:20\",\"signed\":false}', b'1', '2020-03-17 14:26:20');
INSERT INTO `message` VALUES (695, 3520745329, 3520745329, 'CHAT', '{\"data\":\"dsg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:26:21\",\"signed\":false}', b'1', '2020-03-17 14:26:21');
INSERT INTO `message` VALUES (696, 3520745329, 3520745329, 'CHAT', '{\"data\":\"dsg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:26:22\",\"signed\":false}', b'1', '2020-03-17 14:26:22');
INSERT INTO `message` VALUES (697, 3444614016, 3520745329, 'CHAT', '{\"data\":\"helo\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:26:33\",\"signed\":false}', b'1', '2020-03-17 14:26:33');
INSERT INTO `message` VALUES (698, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-17T14:26:48.140\",\"signed\":false}', b'1', '2020-03-17 14:26:48');
INSERT INTO `message` VALUES (699, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-17T14:27:03.894\",\"signed\":false}', b'1', '2020-03-17 14:27:04');
INSERT INTO `message` VALUES (700, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-17T14:27:04.608\",\"signed\":false}', b'1', '2020-03-17 14:27:05');
INSERT INTO `message` VALUES (701, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-17T14:27:04.801\",\"signed\":false}', b'1', '2020-03-17 14:27:05');
INSERT INTO `message` VALUES (702, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-17T14:27:04.979\",\"signed\":false}', b'1', '2020-03-17 14:27:05');
INSERT INTO `message` VALUES (703, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-17T14:27:05.897\",\"signed\":false}', b'1', '2020-03-17 14:27:06');
INSERT INTO `message` VALUES (704, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-17T14:27:06.178\",\"signed\":false}', b'1', '2020-03-17 14:27:06');
INSERT INTO `message` VALUES (705, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-17T14:27:06.394\",\"signed\":false}', b'1', '2020-03-17 14:27:06');
INSERT INTO `message` VALUES (706, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-17T14:27:06.582\",\"signed\":false}', b'1', '2020-03-17 14:27:07');
INSERT INTO `message` VALUES (707, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-17T14:27:06.750\",\"signed\":false}', b'1', '2020-03-17 14:27:07');
INSERT INTO `message` VALUES (708, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-17T14:27:08.771\",\"signed\":false}', b'1', '2020-03-17 14:27:09');
INSERT INTO `message` VALUES (709, 3444614016, 3520745329, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:27:19\",\"signed\":false}', b'1', '2020-03-17 14:27:19');
INSERT INTO `message` VALUES (710, 3520745329, 3520745329, 'CHAT', '{\"data\":\"gdx\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-17T14:27:52\",\"signed\":false}', b'1', '2020-03-17 14:27:52');
INSERT INTO `message` VALUES (711, 3520745329, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-18T17:41:26\",\"signed\":false}', b'1', '2020-03-18 17:41:26');
INSERT INTO `message` VALUES (712, 3520745329, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-18T17:41:32\",\"signed\":false}', b'1', '2020-03-18 17:41:32');
INSERT INTO `message` VALUES (713, 3520745329, 3520745329, 'CHAT', '{\"data\":\"你好啊\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-18T17:41:40\",\"signed\":false}', b'1', '2020-03-18 17:41:40');
INSERT INTO `message` VALUES (714, 3444614016, 3520745329, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-18T17:41:53\",\"signed\":false}', b'1', '2020-03-18 17:41:53');
INSERT INTO `message` VALUES (715, 3520745329, 3520745329, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-18T17:42:07\",\"signed\":false}', b'1', '2020-03-18 17:42:07');
INSERT INTO `message` VALUES (716, 3444614016, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-23T22:23:44\",\"signed\":false}', b'1', '2020-03-23 22:23:44');
INSERT INTO `message` VALUES (717, 3520745329, 3520745329, 'CHAT', '{\"data\":\"gdx\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-23T22:23:53\",\"signed\":false}', b'1', '2020-03-23 22:23:53');
INSERT INTO `message` VALUES (718, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-23T22:23:56\",\"signed\":false}', b'1', '2020-03-23 22:23:56');
INSERT INTO `message` VALUES (719, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-23T22:23:59\",\"signed\":false}', b'1', '2020-03-23 22:23:59');
INSERT INTO `message` VALUES (720, 3520745329, 3444614016, 'CHAT', '{\"data\":\"nihao\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T18:12:53\",\"signed\":false}', b'1', '2020-03-28 18:12:53');
INSERT INTO `message` VALUES (721, 3520745329, 3444614016, 'CHAT', '{\"data\":\"ni\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T18:12:56\",\"signed\":false}', b'1', '2020-03-28 18:12:56');
INSERT INTO `message` VALUES (722, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T18:13:26\",\"signed\":false}', b'1', '2020-03-28 18:13:26');
INSERT INTO `message` VALUES (723, 3444614016, 3520745329, 'CHAT', '{\"data\":\"dsgs\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T18:17:52\",\"signed\":false}', b'1', '2020-03-28 18:17:52');
INSERT INTO `message` VALUES (724, 3444614016, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T18:17:56\",\"signed\":false}', b'1', '2020-03-28 18:17:56');
INSERT INTO `message` VALUES (725, 3444614016, 3520745329, 'CHAT', '{\"data\":\"i love you\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T18:18:01\",\"signed\":false}', b'1', '2020-03-28 18:18:01');
INSERT INTO `message` VALUES (726, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T18:18:08\",\"signed\":false}', b'1', '2020-03-28 18:18:08');
INSERT INTO `message` VALUES (727, 3520745329, 3444614016, 'CHAT', '{\"data\":\"wg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T18:18:31\",\"signed\":false}', b'1', '2020-03-28 18:18:31');
INSERT INTO `message` VALUES (728, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdg \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T18:18:52\",\"signed\":false}', b'1', '2020-03-28 18:18:52');
INSERT INTO `message` VALUES (729, 3444614016, 3520745329, 'CHAT', '{\"data\":\"sg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T18:19:04\",\"signed\":false}', b'1', '2020-03-28 18:19:04');
INSERT INTO `message` VALUES (730, 3444614016, 3520745329, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T18:19:06\",\"signed\":false}', b'1', '2020-03-28 18:19:06');
INSERT INTO `message` VALUES (731, 3520745329, 3444614016, 'CHAT', '{\"data\":\"2325\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T18:19:09\",\"signed\":false}', b'1', '2020-03-28 18:19:09');
INSERT INTO `message` VALUES (732, 3444614016, 3520745329, 'CHAT', '{\"data\":\"111111111\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T18:19:20\",\"signed\":false}', b'1', '2020-03-28 18:19:20');
INSERT INTO `message` VALUES (733, 3444614016, 3520745329, 'CHAT', '{\"data\":\"222222\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T18:19:23\",\"signed\":false}', b'1', '2020-03-28 18:19:23');
INSERT INTO `message` VALUES (734, 3444614016, 3520745329, 'CHAT', '{\"data\":\"33333333\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T18:19:25\",\"signed\":false}', b'1', '2020-03-28 18:19:25');
INSERT INTO `message` VALUES (735, 3444614016, 3520745329, 'CHAT', '{\"data\":\"000\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T18:19:29\",\"signed\":false}', b'1', '2020-03-28 18:19:29');
INSERT INTO `message` VALUES (736, 3444614016, 3520745329, 'CHAT', '{\"data\":\"22\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T18:20:20\",\"signed\":false}', b'1', '2020-03-28 18:20:20');
INSERT INTO `message` VALUES (737, 3520745329, 3444614016, 'CHAT', '{\"data\":\"1\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T18:20:24\",\"signed\":false}', b'1', '2020-03-28 18:20:24');
INSERT INTO `message` VALUES (738, 3520745329, 3444614016, 'CHAT', '{\"data\":\"1111\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T18:20:30\",\"signed\":false}', b'1', '2020-03-28 18:20:30');
INSERT INTO `message` VALUES (739, 3520745329, 3520745329, 'CHAT', '{\"data\":\"12\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T19:55:01\",\"signed\":false}', b'1', '2020-03-28 19:55:01');
INSERT INTO `message` VALUES (740, 3444614016, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T19:55:13\",\"signed\":false}', b'1', '2020-03-28 19:55:13');
INSERT INTO `message` VALUES (741, 3520745329, 3444614016, 'CHAT', '{\"data\":\"wt\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T19:55:37\",\"signed\":false}', b'1', '2020-03-28 19:55:37');
INSERT INTO `message` VALUES (742, 3520745329, 3444614016, 'CHAT', '{\"data\":\"12\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T19:56:05\",\"signed\":false}', b'1', '2020-03-28 19:56:05');
INSERT INTO `message` VALUES (743, 3444614016, 3520745329, 'CHAT', '{\"data\":\"12\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T19:56:13\",\"signed\":false}', b'1', '2020-03-28 19:56:13');
INSERT INTO `message` VALUES (744, 3444614016, 3520745329, 'CHAT', '{\"data\":\"12\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T19:56:29\",\"signed\":false}', b'1', '2020-03-28 19:56:29');
INSERT INTO `message` VALUES (745, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T19:56:33\",\"signed\":false}', b'1', '2020-03-28 19:56:33');
INSERT INTO `message` VALUES (746, 3520745329, 3444614016, 'CHAT', '{\"data\":\"你好\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T19:56:38\",\"signed\":false}', b'1', '2020-03-28 19:56:38');
INSERT INTO `message` VALUES (747, 3444614016, 3520745329, 'CHAT', '{\"data\":\"我好\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-03-28T19:56:43\",\"signed\":false}', b'1', '2020-03-28 19:56:43');
INSERT INTO `message` VALUES (748, 3520745329, 3444614016, 'CHAT', '{\"data\":\"三个\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-03-28T19:58:55\",\"signed\":false}', b'1', '2020-03-28 19:58:55');
INSERT INTO `message` VALUES (749, 3520745329, 3520745329, 'CHAT', '{\"data\":\"s \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-03-29T12:24:26\",\"signed\":false}', b'1', '2020-03-29 12:24:26');
INSERT INTO `message` VALUES (750, 3520745329, 3444614016, 'CHAT', '{\"data\":\"nihao\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:14:51\",\"signed\":false}', b'1', '2020-04-19 14:14:51');
INSERT INTO `message` VALUES (751, 3444614016, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:14:56\",\"signed\":false}', b'1', '2020-04-19 14:14:56');
INSERT INTO `message` VALUES (752, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:15:13\",\"signed\":false}', b'1', '2020-04-19 14:15:13');
INSERT INTO `message` VALUES (753, 3444614016, 3520745329, 'CHAT', '{\"data\":\"nihao \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:15:35\",\"signed\":false}', b'1', '2020-04-19 14:15:35');
INSERT INTO `message` VALUES (754, 3520745329, 3444614016, 'CHAT', '{\"data\":\"nihao \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:17:37\",\"signed\":false}', b'1', '2020-04-19 14:17:37');
INSERT INTO `message` VALUES (755, 3444614016, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:17:42\",\"signed\":false}', b'1', '2020-04-19 14:17:42');
INSERT INTO `message` VALUES (756, 3444614016, 3520745329, 'CHAT', '{\"data\":\"okpok\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:18:10\",\"signed\":false}', b'1', '2020-04-19 14:18:10');
INSERT INTO `message` VALUES (757, 3444614016, 3520745329, 'CHAT', '{\"data\":\"oojo\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:18:11\",\"signed\":false}', b'1', '2020-04-19 14:18:11');
INSERT INTO `message` VALUES (758, 35207453291, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":35207453291,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:19:41.734\",\"signed\":false}', b'0', '2020-04-19 14:19:42');
INSERT INTO `message` VALUES (759, 35207453291, 3520745329, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":35207453291,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:19:44.119\",\"signed\":false}', b'0', '2020-04-19 14:19:44');
INSERT INTO `message` VALUES (760, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:20:58.131\",\"signed\":false}', b'1', '2020-04-19 14:20:58');
INSERT INTO `message` VALUES (761, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:20:59.724\",\"signed\":false}', b'1', '2020-04-19 14:21:00');
INSERT INTO `message` VALUES (762, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:20:59.898\",\"signed\":false}', b'1', '2020-04-19 14:21:00');
INSERT INTO `message` VALUES (763, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:21:10.110\",\"signed\":false}', b'1', '2020-04-19 14:21:10');
INSERT INTO `message` VALUES (764, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:21:18.830\",\"signed\":false}', b'1', '2020-04-19 14:21:19');
INSERT INTO `message` VALUES (765, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:21:19.143\",\"signed\":false}', b'1', '2020-04-19 14:21:19');
INSERT INTO `message` VALUES (766, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:21:19.509\",\"signed\":false}', b'1', '2020-04-19 14:21:20');
INSERT INTO `message` VALUES (767, 3444614016, 3520745329, 'CHAT', '{\"data\":\"ooj\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:21:33\",\"signed\":false}', b'1', '2020-04-19 14:21:33');
INSERT INTO `message` VALUES (768, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:21:36.701\",\"signed\":false}', b'1', '2020-04-19 14:21:37');
INSERT INTO `message` VALUES (769, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:21:40.780\",\"signed\":false}', b'1', '2020-04-19 14:21:41');
INSERT INTO `message` VALUES (770, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:21:44.756\",\"signed\":false}', b'1', '2020-04-19 14:21:45');
INSERT INTO `message` VALUES (771, 3520745329, 3444614016, 'CHAT', '{\"data\":\"I LOVE YOU\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:21:45.168\",\"signed\":false}', b'1', '2020-04-19 14:21:45');
INSERT INTO `message` VALUES (772, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:22:20\",\"signed\":false}', b'1', '2020-04-19 14:22:20');
INSERT INTO `message` VALUES (773, 3520745329, 3444614016, 'CHAT', '{\"data\":\"nihao \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:22:23\",\"signed\":false}', b'1', '2020-04-19 14:22:23');
INSERT INTO `message` VALUES (774, 3520745329, 3444614016, 'CHAT', '{\"data\":\"nihao \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:22:28\",\"signed\":false}', b'1', '2020-04-19 14:22:28');
INSERT INTO `message` VALUES (775, 3520745329, 3444614016, 'CHAT', '{\"data\":\"helelo\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:22:32\",\"signed\":false}', b'1', '2020-04-19 14:22:32');
INSERT INTO `message` VALUES (776, 3520745329, 3444614016, 'CHAT', '{\"data\":\"l\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:22:35\",\"signed\":false}', b'1', '2020-04-19 14:22:35');
INSERT INTO `message` VALUES (777, 3444614016, 3520745329, 'CHAT', '{\"data\":\"sg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:22:39\",\"signed\":false}', b'1', '2020-04-19 14:22:39');
INSERT INTO `message` VALUES (778, 3444614016, 3520745329, 'CHAT', '{\"data\":\"树大根深大哥无关\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:22:44\",\"signed\":false}', b'1', '2020-04-19 14:22:44');
INSERT INTO `message` VALUES (779, 3444614016, 3520745329, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:22:49\",\"signed\":false}', b'1', '2020-04-19 14:22:49');
INSERT INTO `message` VALUES (780, 3444614016, 3520745329, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:22:50\",\"signed\":false}', b'1', '2020-04-19 14:22:50');
INSERT INTO `message` VALUES (781, 3444614016, 3520745329, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:22:51\",\"signed\":false}', b'1', '2020-04-19 14:22:51');
INSERT INTO `message` VALUES (782, 3520745329, 3444614016, 'CHAT', '{\"data\":\"歌舞哦\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:23:24\",\"signed\":false}', b'1', '2020-04-19 14:23:24');
INSERT INTO `message` VALUES (783, 3444614016, 3520745329, 'CHAT', '{\"data\":\"四个\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:23:28\",\"signed\":false}', b'1', '2020-04-19 14:23:28');
INSERT INTO `message` VALUES (784, 3520745329, 3444614016, 'CHAT', '{\"data\":\"十多个\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:23:33\",\"signed\":false}', b'1', '2020-04-19 14:23:33');
INSERT INTO `message` VALUES (785, 3520745329, 3444614016, 'CHAT', '{\"data\":\"树大根深\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:23:35\",\"signed\":false}', b'1', '2020-04-19 14:23:35');
INSERT INTO `message` VALUES (786, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:23:36\",\"signed\":false}', b'1', '2020-04-19 14:23:36');
INSERT INTO `message` VALUES (787, 3444614016, 3520745329, 'CHAT', '{\"data\":\"十多个\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:23:40\",\"signed\":false}', b'1', '2020-04-19 14:23:40');
INSERT INTO `message` VALUES (788, 3444614016, 3520745329, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:23:41\",\"signed\":false}', b'1', '2020-04-19 14:23:41');
INSERT INTO `message` VALUES (789, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:23:45\",\"signed\":false}', b'1', '2020-04-19 14:23:45');
INSERT INTO `message` VALUES (790, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:25:37\",\"signed\":false}', b'1', '2020-04-19 14:25:37');
INSERT INTO `message` VALUES (791, 3520745329, 3444614016, 'CHAT', '{\"data\":\"nihaowa \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:25:45\",\"signed\":false}', b'1', '2020-04-19 14:25:45');
INSERT INTO `message` VALUES (792, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:27:42\",\"signed\":false}', b'1', '2020-04-19 14:27:42');
INSERT INTO `message` VALUES (793, 3520745329, 3444614016, 'CHAT', '{\"data\":\"23t2\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:27:45\",\"signed\":false}', b'1', '2020-04-19 14:27:45');
INSERT INTO `message` VALUES (794, 3520745329, 3444614016, 'CHAT', '{\"data\":\"324234\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:27:48\",\"signed\":false}', b'1', '2020-04-19 14:27:48');
INSERT INTO `message` VALUES (795, 3520745329, 3444614016, 'CHAT', '{\"data\":\"2342\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:27:50\",\"signed\":false}', b'1', '2020-04-19 14:27:50');
INSERT INTO `message` VALUES (796, 3520745329, 3444614016, 'CHAT', '{\"data\":\"2342\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:27:51\",\"signed\":false}', b'1', '2020-04-19 14:27:51');
INSERT INTO `message` VALUES (797, 3444614016, 3520745329, 'CHAT', '{\"data\":\"nihao \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:27:57\",\"signed\":false}', b'1', '2020-04-19 14:27:57');
INSERT INTO `message` VALUES (798, 3520745329, 3444614016, 'CHAT', '{\"data\":\"你好\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:28:05\",\"signed\":false}', b'1', '2020-04-19 14:28:05');
INSERT INTO `message` VALUES (799, 3520745329, 3444614016, 'CHAT', '{\"data\":\"你好\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:28:06\",\"signed\":false}', b'1', '2020-04-19 14:28:06');
INSERT INTO `message` VALUES (800, 3444614016, 3520745329, 'CHAT', '{\"data\":\"你好\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:28:11\",\"signed\":false}', b'1', '2020-04-19 14:28:11');
INSERT INTO `message` VALUES (801, 3520745329, 3444614016, 'CHAT', '{\"data\":\"你好\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:28:24\",\"signed\":false}', b'1', '2020-04-19 14:28:24');
INSERT INTO `message` VALUES (802, 3444614016, 3520745329, 'CHAT', '{\"data\":\"你好\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:28:28\",\"signed\":false}', b'1', '2020-04-19 14:28:28');
INSERT INTO `message` VALUES (803, 3444614016, 3520745329, 'CHAT', '{\"data\":\"helo\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:28:39\",\"signed\":false}', b'1', '2020-04-19 14:28:39');
INSERT INTO `message` VALUES (804, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:28:45\",\"signed\":false}', b'1', '2020-04-19 14:28:45');
INSERT INTO `message` VALUES (805, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:28:57\",\"signed\":false}', b'1', '2020-04-19 14:28:57');
INSERT INTO `message` VALUES (806, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:29:02\",\"signed\":false}', b'1', '2020-04-19 14:29:02');
INSERT INTO `message` VALUES (807, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hell\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:29:04\",\"signed\":false}', b'1', '2020-04-19 14:29:04');
INSERT INTO `message` VALUES (808, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hhe\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:29:05\",\"signed\":false}', b'1', '2020-04-19 14:29:05');
INSERT INTO `message` VALUES (809, 3520745329, 3444614016, 'CHAT', '{\"data\":\"geg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:29:06\",\"signed\":false}', b'1', '2020-04-19 14:29:06');
INSERT INTO `message` VALUES (810, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sgeg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:29:07\",\"signed\":false}', b'1', '2020-04-19 14:29:07');
INSERT INTO `message` VALUES (811, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sges\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:29:08\",\"signed\":false}', b'1', '2020-04-19 14:29:08');
INSERT INTO `message` VALUES (812, 3444614016, 3520745329, 'CHAT', '{\"data\":\"111\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:29:11\",\"signed\":false}', b'1', '2020-04-19 14:29:11');
INSERT INTO `message` VALUES (813, 3520745329, 3444614016, 'CHAT', '{\"data\":\"222\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:29:14\",\"signed\":false}', b'1', '2020-04-19 14:29:14');
INSERT INTO `message` VALUES (814, 3444614016, 3520745329, 'CHAT', '{\"data\":\"111\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:29:19\",\"signed\":false}', b'1', '2020-04-19 14:29:19');
INSERT INTO `message` VALUES (815, 3444614016, 3520745329, 'CHAT', '{\"data\":\"111\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:29:24\",\"signed\":false}', b'1', '2020-04-19 14:29:24');
INSERT INTO `message` VALUES (816, 3444614016, 3520745329, 'CHAT', '{\"data\":\"111\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:29:26\",\"signed\":false}', b'1', '2020-04-19 14:29:26');
INSERT INTO `message` VALUES (817, 3520745329, 3444614016, 'CHAT', '{\"data\":\"222\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:29:33\",\"signed\":false}', b'1', '2020-04-19 14:29:33');
INSERT INTO `message` VALUES (818, 3520745329, 3444614016, 'CHAT', '{\"data\":\"222\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:29:35\",\"signed\":false}', b'1', '2020-04-19 14:29:35');
INSERT INTO `message` VALUES (819, 3520745329, 3444614016, 'CHAT', '{\"data\":\"222\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:29:36\",\"signed\":false}', b'1', '2020-04-19 14:29:36');
INSERT INTO `message` VALUES (820, 3520745329, 3444614016, 'CHAT', '{\"data\":\"000\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:34:30\",\"signed\":false}', b'1', '2020-04-19 14:34:30');
INSERT INTO `message` VALUES (821, 3520745329, 3444614016, 'CHAT', '{\"data\":\"000\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:34:33\",\"signed\":false}', b'1', '2020-04-19 14:34:33');
INSERT INTO `message` VALUES (822, 3444614016, 3520745329, 'CHAT', '{\"data\":\"999\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:34:41\",\"signed\":false}', b'1', '2020-04-19 14:34:41');
INSERT INTO `message` VALUES (823, 3444614016, 3520745329, 'CHAT', '{\"data\":\"999\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:34:43\",\"signed\":false}', b'1', '2020-04-19 14:34:43');
INSERT INTO `message` VALUES (824, 3444614016, 3520745329, 'CHAT', '{\"data\":\"999\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:34:49\",\"signed\":false}', b'1', '2020-04-19 14:34:49');
INSERT INTO `message` VALUES (825, 3520745329, 3444614016, 'CHAT', '{\"data\":\"helllo\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:34:57\",\"signed\":false}', b'1', '2020-04-19 14:34:57');
INSERT INTO `message` VALUES (826, 3444614016, 3520745329, 'CHAT', '{\"data\":\"你好\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:35:01\",\"signed\":false}', b'1', '2020-04-19 14:35:01');
INSERT INTO `message` VALUES (827, 3444614016, 3520745329, 'CHAT', '{\"data\":\"o\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:35:05\",\"signed\":false}', b'1', '2020-04-19 14:35:05');
INSERT INTO `message` VALUES (828, 3520745329, 3444614016, 'CHAT', '{\"data\":\"00000\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:36:29\",\"signed\":false}', b'1', '2020-04-19 14:36:29');
INSERT INTO `message` VALUES (829, 3520745329, 3444614016, 'CHAT', '{\"data\":\"00000\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T14:36:32\",\"signed\":false}', b'1', '2020-04-19 14:36:32');
INSERT INTO `message` VALUES (830, 3444614016, 3520745329, 'CHAT', '{\"data\":\"00000\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:36:37\",\"signed\":false}', b'1', '2020-04-19 14:36:37');
INSERT INTO `message` VALUES (831, 3444614016, 3520745329, 'CHAT', '{\"data\":\"00000\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:36:41\",\"signed\":false}', b'1', '2020-04-19 14:36:41');
INSERT INTO `message` VALUES (832, 3444614016, 3520745329, 'CHAT', '{\"data\":\"0\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T14:36:46\",\"signed\":false}', b'1', '2020-04-19 14:36:46');
INSERT INTO `message` VALUES (833, 3444614016, 3520745329, 'CHAT', '{\"data\":\"kn\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T15:16:10\",\"signed\":false}', b'1', '2020-04-19 15:16:10');
INSERT INTO `message` VALUES (834, 3444614016, 3520745329, 'CHAT', '{\"data\":\"kjnk\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T15:16:13\",\"signed\":false}', b'1', '2020-04-19 15:16:13');
INSERT INTO `message` VALUES (835, 3444614016, 3520745329, 'CHAT', '{\"data\":\"knjjn\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T15:21:15\",\"signed\":false}', b'1', '2020-04-19 15:21:15');
INSERT INTO `message` VALUES (836, 3444614016, 3520745329, 'CHAT', '{\"data\":\"lkkl\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T15:21:19\",\"signed\":false}', b'1', '2020-04-19 15:21:19');
INSERT INTO `message` VALUES (837, 3520745329, 3444614016, 'CHAT', '{\"data\":\"00000\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:34:48\",\"signed\":false}', b'1', '2020-04-19 15:34:48');
INSERT INTO `message` VALUES (838, 3520745329, 3444614016, 'CHAT', '{\"data\":\"000\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:34:49\",\"signed\":false}', b'1', '2020-04-19 15:34:49');
INSERT INTO `message` VALUES (839, 3520745329, 3444614016, 'CHAT', '{\"data\":\"000\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:34:50\",\"signed\":false}', b'1', '2020-04-19 15:34:50');
INSERT INTO `message` VALUES (840, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:35:00\",\"signed\":false}', b'1', '2020-04-19 15:35:00');
INSERT INTO `message` VALUES (841, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:35:04\",\"signed\":false}', b'1', '2020-04-19 15:35:04');
INSERT INTO `message` VALUES (842, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdgsdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:40:41\",\"signed\":false}', b'1', '2020-04-19 15:40:41');
INSERT INTO `message` VALUES (843, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdgsg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:40:42\",\"signed\":false}', b'1', '2020-04-19 15:40:42');
INSERT INTO `message` VALUES (844, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdgsdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:40:43\",\"signed\":false}', b'1', '2020-04-19 15:40:43');
INSERT INTO `message` VALUES (845, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdgsdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:40:44\",\"signed\":false}', b'1', '2020-04-19 15:40:44');
INSERT INTO `message` VALUES (846, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:41:05\",\"signed\":false}', b'1', '2020-04-19 15:41:05');
INSERT INTO `message` VALUES (847, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hello\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:41:14\",\"signed\":false}', b'1', '2020-04-19 15:41:14');
INSERT INTO `message` VALUES (848, 3520745329, 3444614016, 'CHAT', '{\"data\":\"nihoa \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:41:20\",\"signed\":false}', b'1', '2020-04-19 15:41:20');
INSERT INTO `message` VALUES (849, 3520745329, 3444614016, 'CHAT', '{\"data\":\"nihoa \",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:41:26\",\"signed\":false}', b'1', '2020-04-19 15:41:26');
INSERT INTO `message` VALUES (850, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:42:27\",\"signed\":false}', b'1', '2020-04-19 15:42:27');
INSERT INTO `message` VALUES (851, 3520745329, 3444614016, 'CHAT', '{\"data\":\"----------\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:42:39\",\"signed\":false}', b'1', '2020-04-19 15:42:39');
INSERT INTO `message` VALUES (852, 3520745329, 3444614016, 'CHAT', '{\"data\":\"😂\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:42:54\",\"signed\":false}', b'1', '2020-04-19 15:42:54');
INSERT INTO `message` VALUES (853, 3520745329, 3444614016, 'CHAT', '{\"data\":\"😂\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:42:59\",\"signed\":false}', b'1', '2020-04-19 15:42:59');
INSERT INTO `message` VALUES (854, 3520745329, 3444614016, 'CHAT', '{\"data\":\"😂😂\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:43:00\",\"signed\":false}', b'1', '2020-04-19 15:43:00');
INSERT INTO `message` VALUES (855, 3520745329, 3444614016, 'CHAT', '{\"data\":\"🤢🤢\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:43:03\",\"signed\":false}', b'1', '2020-04-19 15:43:03');
INSERT INTO `message` VALUES (856, 3520745329, 3444614016, 'CHAT', '{\"data\":\"😍😍\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:43:05\",\"signed\":false}', b'1', '2020-04-19 15:43:05');
INSERT INTO `message` VALUES (857, 3520745329, 3444614016, 'CHAT', '{\"data\":\"💕\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:43:08\",\"signed\":false}', b'1', '2020-04-19 15:43:08');
INSERT INTO `message` VALUES (858, 3520745329, 3444614016, 'CHAT', '{\"data\":\"😁\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:43:22\",\"signed\":false}', b'1', '2020-04-19 15:43:22');
INSERT INTO `message` VALUES (859, 3520745329, 3444614016, 'CHAT', '{\"data\":\"这是最新数据👨‍💻\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:44:43\",\"signed\":false}', b'1', '2020-04-19 15:44:43');
INSERT INTO `message` VALUES (860, 3520745329, 3444614016, 'CHAT', '{\"data\":\"这是最新数据👨‍💻\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:49:31\",\"signed\":false}', b'1', '2020-04-19 15:49:31');
INSERT INTO `message` VALUES (861, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:50:13\",\"signed\":false}', b'1', '2020-04-19 15:50:13');
INSERT INTO `message` VALUES (862, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sgd\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:50:30\",\"signed\":false}', b'1', '2020-04-19 15:50:30');
INSERT INTO `message` VALUES (863, 3520745329, 3444614016, 'CHAT', '{\"data\":\"这是最新数据👨‍💻\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T15:51:02\",\"signed\":false}', b'1', '2020-04-19 15:51:02');
INSERT INTO `message` VALUES (864, 3520745329, 3444614016, 'CHAT', '{\"data\":\"wet\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:14:47\",\"signed\":false}', b'1', '2020-04-19 16:14:47');
INSERT INTO `message` VALUES (865, 3520745329, 3444614016, 'CHAT', '{\"data\":\"wet\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:14:48\",\"signed\":false}', b'1', '2020-04-19 16:14:48');
INSERT INTO `message` VALUES (866, 3520745329, 3444614016, 'CHAT', '{\"data\":\"wet\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:14:49\",\"signed\":false}', b'1', '2020-04-19 16:14:49');
INSERT INTO `message` VALUES (867, 3520745329, 3444614016, 'CHAT', '{\"data\":\"wet\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:14:50\",\"signed\":false}', b'1', '2020-04-19 16:14:50');
INSERT INTO `message` VALUES (868, 3520745329, 3444614016, 'CHAT', '{\"data\":\"wet\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:14:51\",\"signed\":false}', b'1', '2020-04-19 16:14:51');
INSERT INTO `message` VALUES (869, 3520745329, 3444614016, 'CHAT', '{\"data\":\"wet\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:14:52\",\"signed\":false}', b'1', '2020-04-19 16:14:52');
INSERT INTO `message` VALUES (870, 3520745329, 3444614016, 'CHAT', '{\"data\":\"wet\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:14:53\",\"signed\":false}', b'1', '2020-04-19 16:14:53');
INSERT INTO `message` VALUES (871, 3520745329, 3444614016, 'CHAT', '{\"data\":\"wet\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:14:54\",\"signed\":false}', b'1', '2020-04-19 16:14:54');
INSERT INTO `message` VALUES (872, 3520745329, 3444614016, 'CHAT', '{\"data\":\"wet\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:14:55\",\"signed\":false}', b'1', '2020-04-19 16:14:55');
INSERT INTO `message` VALUES (873, 3520745329, 3444614016, 'CHAT', '{\"data\":\"3222222222\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:14:57\",\"signed\":false}', b'1', '2020-04-19 16:14:57');
INSERT INTO `message` VALUES (874, 3520745329, 3444614016, 'CHAT', '{\"data\":\"2222222222222\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:15:00\",\"signed\":false}', b'1', '2020-04-19 16:15:00');
INSERT INTO `message` VALUES (875, 3520745329, 3444614016, 'CHAT', '{\"data\":\"22222222222222\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:15:01\",\"signed\":false}', b'1', '2020-04-19 16:15:01');
INSERT INTO `message` VALUES (876, 3520745329, 3444614016, 'CHAT', '{\"data\":\"22222222222\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:15:03\",\"signed\":false}', b'1', '2020-04-19 16:15:03');
INSERT INTO `message` VALUES (877, 3520745329, 3444614016, 'CHAT', '{\"data\":\"1\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:15:05\",\"signed\":false}', b'1', '2020-04-19 16:15:05');
INSERT INTO `message` VALUES (878, 3520745329, 3444614016, 'CHAT', '{\"data\":\"2\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:15:07\",\"signed\":false}', b'1', '2020-04-19 16:15:07');
INSERT INTO `message` VALUES (879, 3520745329, 3444614016, 'CHAT', '{\"data\":\"3\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:15:08\",\"signed\":false}', b'1', '2020-04-19 16:15:08');
INSERT INTO `message` VALUES (880, 3520745329, 3444614016, 'CHAT', '{\"data\":\"4\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:15:10\",\"signed\":false}', b'1', '2020-04-19 16:15:10');
INSERT INTO `message` VALUES (881, 3520745329, 3444614016, 'CHAT', '{\"data\":\"5\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:15:11\",\"signed\":false}', b'1', '2020-04-19 16:15:11');
INSERT INTO `message` VALUES (882, 3520745329, 3444614016, 'CHAT', '{\"data\":\"6\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:15:12\",\"signed\":false}', b'1', '2020-04-19 16:15:12');
INSERT INTO `message` VALUES (883, 3520745329, 3444614016, 'CHAT', '{\"data\":\"7\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:15:13\",\"signed\":false}', b'1', '2020-04-19 16:15:13');
INSERT INTO `message` VALUES (884, 3520745329, 3444614016, 'CHAT', '{\"data\":\"12\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:16:06\",\"signed\":false}', b'1', '2020-04-19 16:16:06');
INSERT INTO `message` VALUES (885, 3520745329, 3444614016, 'CHAT', '{\"data\":\"🤢\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:18:45\",\"signed\":false}', b'1', '2020-04-19 16:18:45');
INSERT INTO `message` VALUES (886, 3520745329, 3444614016, 'CHAT', '{\"data\":\"n\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:08\",\"signed\":false}', b'1', '2020-04-19 16:23:08');
INSERT INTO `message` VALUES (887, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sgd\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:12\",\"signed\":false}', b'1', '2020-04-19 16:23:12');
INSERT INTO `message` VALUES (888, 3520745329, 3444614016, 'CHAT', '{\"data\":\"gd\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:14\",\"signed\":false}', b'1', '2020-04-19 16:23:14');
INSERT INTO `message` VALUES (889, 3520745329, 3444614016, 'CHAT', '{\"data\":\"gd\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:15\",\"signed\":false}', b'1', '2020-04-19 16:23:15');
INSERT INTO `message` VALUES (890, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:31\",\"signed\":false}', b'1', '2020-04-19 16:23:31');
INSERT INTO `message` VALUES (891, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:32\",\"signed\":false}', b'1', '2020-04-19 16:23:32');
INSERT INTO `message` VALUES (892, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:33\",\"signed\":false}', b'1', '2020-04-19 16:23:33');
INSERT INTO `message` VALUES (893, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:34\",\"signed\":false}', b'1', '2020-04-19 16:23:34');
INSERT INTO `message` VALUES (894, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sgd\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:35\",\"signed\":false}', b'1', '2020-04-19 16:23:35');
INSERT INTO `message` VALUES (895, 3520745329, 3444614016, 'CHAT', '{\"data\":\"1\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:37\",\"signed\":false}', b'1', '2020-04-19 16:23:37');
INSERT INTO `message` VALUES (896, 3520745329, 3444614016, 'CHAT', '{\"data\":\"2\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:38\",\"signed\":false}', b'1', '2020-04-19 16:23:38');
INSERT INTO `message` VALUES (897, 3520745329, 3444614016, 'CHAT', '{\"data\":\"3\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:39\",\"signed\":false}', b'1', '2020-04-19 16:23:39');
INSERT INTO `message` VALUES (898, 3520745329, 3444614016, 'CHAT', '{\"data\":\"4\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:40\",\"signed\":false}', b'1', '2020-04-19 16:23:40');
INSERT INTO `message` VALUES (899, 3520745329, 3444614016, 'CHAT', '{\"data\":\"5\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:41\",\"signed\":false}', b'1', '2020-04-19 16:23:41');
INSERT INTO `message` VALUES (900, 3520745329, 3444614016, 'CHAT', '{\"data\":\"6\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:42\",\"signed\":false}', b'1', '2020-04-19 16:23:42');
INSERT INTO `message` VALUES (901, 3520745329, 3444614016, 'CHAT', '{\"data\":\"7\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:43\",\"signed\":false}', b'1', '2020-04-19 16:23:43');
INSERT INTO `message` VALUES (902, 3520745329, 3444614016, 'CHAT', '{\"data\":\"8\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:23:46\",\"signed\":false}', b'1', '2020-04-19 16:23:46');
INSERT INTO `message` VALUES (903, 3520745329, 3444614016, 'CHAT', '{\"data\":\"这是最新数据👨‍💻\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:27:10\",\"signed\":false}', b'1', '2020-04-19 16:27:10');
INSERT INTO `message` VALUES (904, 3520745329, 3444614016, 'CHAT', '{\"data\":\"😁\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:27:36\",\"signed\":false}', b'1', '2020-04-19 16:27:36');
INSERT INTO `message` VALUES (905, 3444614016, 3520745329, 'CHAT', '{\"data\":\"👨‍🚒\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T16:28:07\",\"signed\":false}', b'1', '2020-04-19 16:28:07');
INSERT INTO `message` VALUES (906, 3444614016, 3520745329, 'CHAT', '{\"data\":\"0\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T16:28:22\",\"signed\":false}', b'1', '2020-04-19 16:28:22');
INSERT INTO `message` VALUES (907, 3444614016, 3520745329, 'CHAT', '{\"data\":\"1\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T16:28:32\",\"signed\":false}', b'1', '2020-04-19 16:28:32');
INSERT INTO `message` VALUES (908, 3520745329, 3444614016, 'CHAT', '{\"data\":\"111\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:30:20\",\"signed\":false}', b'1', '2020-04-19 16:30:20');
INSERT INTO `message` VALUES (909, 3520745329, 3444614016, 'CHAT', '{\"data\":\"214\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:35:38\",\"signed\":false}', b'1', '2020-04-19 16:35:38');
INSERT INTO `message` VALUES (910, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:36:17\",\"signed\":false}', b'1', '2020-04-19 16:36:17');
INSERT INTO `message` VALUES (911, 3520745329, 3444614016, 'CHAT', '{\"data\":\"这是最新数据👨‍💻\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:36:39\",\"signed\":false}', b'1', '2020-04-19 16:36:39');
INSERT INTO `message` VALUES (912, 3520745329, 3444614016, 'CHAT', '{\"data\":\"这是最新数据👨‍💻\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:36:47\",\"signed\":false}', b'1', '2020-04-19 16:36:47');
INSERT INTO `message` VALUES (913, 3520745329, 3444614016, 'CHAT', '{\"data\":\"这是最新数据👨‍💻\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:36:51\",\"signed\":false}', b'1', '2020-04-19 16:36:51');
INSERT INTO `message` VALUES (914, 3520745329, 3444614016, 'CHAT', '{\"data\":\"这是最新数据👨‍💻\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:36:56\",\"signed\":false}', b'1', '2020-04-19 16:36:56');
INSERT INTO `message` VALUES (915, 3520745329, 3444614016, 'CHAT', '{\"data\":\"这是最新数据👨‍💻\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:39:38\",\"signed\":false}', b'1', '2020-04-19 16:39:38');
INSERT INTO `message` VALUES (916, 3520745329, 3444614016, 'CHAT', '{\"data\":\"123\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:39:42\",\"signed\":false}', b'1', '2020-04-19 16:39:42');
INSERT INTO `message` VALUES (917, 3520745329, 3444614016, 'CHAT', '{\"data\":\"214\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:39:43\",\"signed\":false}', b'1', '2020-04-19 16:39:43');
INSERT INTO `message` VALUES (918, 3520745329, 3444614016, 'CHAT', '{\"data\":\"345\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:39:44\",\"signed\":false}', b'1', '2020-04-19 16:39:44');
INSERT INTO `message` VALUES (919, 3520745329, 3444614016, 'CHAT', '{\"data\":\"546\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:39:45\",\"signed\":false}', b'1', '2020-04-19 16:39:45');
INSERT INTO `message` VALUES (920, 3520745329, 3444614016, 'CHAT', '{\"data\":\"657\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:39:46\",\"signed\":false}', b'1', '2020-04-19 16:39:46');
INSERT INTO `message` VALUES (921, 3520745329, 3444614016, 'CHAT', '{\"data\":\"=====\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:39:49\",\"signed\":false}', b'1', '2020-04-19 16:39:49');
INSERT INTO `message` VALUES (922, 3520745329, 3444614016, 'CHAT', '{\"data\":\"hhh\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:39:51\",\"signed\":false}', b'1', '2020-04-19 16:39:51');
INSERT INTO `message` VALUES (923, 3520745329, 3444614016, 'CHAT', '{\"data\":\"终于正确了\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:39:57\",\"signed\":false}', b'1', '2020-04-19 16:39:57');
INSERT INTO `message` VALUES (924, 3520745329, 3444614016, 'CHAT', '{\"data\":\"👌🏻\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T16:40:06\",\"signed\":false}', b'1', '2020-04-19 16:40:06');
INSERT INTO `message` VALUES (925, 3520745329, 3520745329, 'CHAT', '{\"data\":\"dsg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T17:04:43\",\"signed\":false}', b'1', '2020-04-19 17:04:43');
INSERT INTO `message` VALUES (926, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T17:04:45\",\"signed\":false}', b'1', '2020-04-19 17:04:45');
INSERT INTO `message` VALUES (927, 3520745329, 3520745329, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T17:04:47\",\"signed\":false}', b'1', '2020-04-19 17:04:47');
INSERT INTO `message` VALUES (928, 3520745329, 3444614016, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T17:08:30\",\"signed\":false}', b'1', '2020-04-19 17:08:30');
INSERT INTO `message` VALUES (929, 3520745329, 3444614016, 'CHAT', '{\"data\":\"👨‍🚒\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T17:08:34\",\"signed\":false}', b'1', '2020-04-19 17:08:34');
INSERT INTO `message` VALUES (930, 3520745329, 3444614016, 'CHAT', '{\"data\":\"👌😏\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T17:08:37\",\"signed\":false}', b'1', '2020-04-19 17:08:37');
INSERT INTO `message` VALUES (931, 554587118, 3520745329, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":554587118,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T17:39:28\",\"signed\":false}', b'1', '2020-04-19 17:39:28');
INSERT INTO `message` VALUES (932, 554587118, 3520745329, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":554587118,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T17:39:50\",\"signed\":false}', b'1', '2020-04-19 17:39:50');
INSERT INTO `message` VALUES (933, 3520745329, 554587118, 'CHAT', '{\"data\":\"12\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":554587118,\"sendTime\":\"2020-04-19T17:41:12\",\"signed\":false}', b'1', '2020-04-19 17:41:12');
INSERT INTO `message` VALUES (934, 3520745329, 554587118, 'CHAT', '{\"data\":\"234235\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":554587118,\"sendTime\":\"2020-04-19T17:41:15\",\"signed\":false}', b'1', '2020-04-19 17:41:15');
INSERT INTO `message` VALUES (935, 3520745329, 554587118, 'CHAT', '{\"data\":\"sdg\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":554587118,\"sendTime\":\"2020-04-19T17:41:42\",\"signed\":false}', b'1', '2020-04-19 17:41:42');
INSERT INTO `message` VALUES (936, 3444614016, 3520745329, 'CHAT', '{\"data\":\"po\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3444614016,\"sendId\":3520745329,\"sendTime\":\"2020-04-19T18:31:48\",\"signed\":false}', b'1', '2020-04-19 18:31:48');
INSERT INTO `message` VALUES (937, 3520745329, 3444614016, 'CHAT', '{\"data\":\"😏\",\"header\":{\"msgType\":\"CHAT\",\"priority\":0},\"receiverId\":3520745329,\"sendId\":3444614016,\"sendTime\":\"2020-04-19T18:32:13\",\"signed\":false}', b'1', '2020-04-19 18:32:13');
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role` varchar(50) DEFAULT NULL COMMENT '角色',
  `name` varchar(50) DEFAULT NULL COMMENT '角色名\n',
  `priority` int(11) DEFAULT '0' COMMENT '优先级（0-10）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (1, 'admin', '系统管理员', 10);
INSERT INTO `role` VALUES (2, 'guest', '游客', 0);
INSERT INTO `role` VALUES (3, 'user', '普通用户', 1);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` bigint(64) NOT NULL COMMENT '用户id',
  `username` varchar(50) DEFAULT NULL COMMENT '用户姓名',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `profession` varchar(255) DEFAULT NULL COMMENT '职业',
  `gender` bit(1) DEFAULT NULL COMMENT '性别 1:男性 0:女性',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `identity_id` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `telephone` varchar(50) DEFAULT NULL COMMENT '电话号码',
  `company` varchar(255) DEFAULT NULL COMMENT '公司',
  `address` varchar(255) DEFAULT NULL COMMENT '所在地',
  `hometown` varchar(255) DEFAULT NULL COMMENT '故乡',
  `constellation` tinyint(8) DEFAULT NULL COMMENT '星座1-12分别对应',
  `zodiac` tinyint(8) DEFAULT NULL COMMENT '属相 1-12分别对应',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `signature` varchar(255) DEFAULT NULL COMMENT '个性签名',
  `img_reduce` varchar(255) DEFAULT 'http://localhost:7070/user_default.jpg' COMMENT '用户头像图片（缩略图）',
  `img` varchar(255) DEFAULT 'http://localhost:7070/user_default.jpg' COMMENT '用户头像（原图）',
  `background_img` varchar(255) DEFAULT 'http://localhost:7070/user_default.jpg' COMMENT '背景图',
  PRIMARY KEY (`user_id`),
  KEY `user_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (554587118, NULL, 'taylor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-04-08 20:20:54', NULL, NULL, 'http://localhost:7070/user_default.jpg', 'http://localhost:7070/user_default.jpg', 'http://localhost:7070/user_default.jpg');
INSERT INTO `user` VALUES (3408468037, 'hello', 'world', '会计', b'1', 21, '1998-07-17 05:16:59', 'string', 'string', 'string', 'string', 'string', 7, 3, '2020-03-06 00:05:32', '2020-03-28 19:44:42', 'string', 'http://xxx.com/img/23.jpg', 'http://xxx.com/img/23.jpg', 'http://localhost:7070/user_default.jpg');
INSERT INTO `user` VALUES (3444614016, '包小薇', '小虾米', '计算机', b'0', 23, '1996-07-17 18:16:59', '', '17704443327', '阿里巴巴', '上海', '甘肃天水', 7, 1, '2020-02-18 18:05:42', '2020-04-19 17:48:13', 'hello', 'http://localhost:7070/3444614016_801c0c59133844bfbfd7e3a7eb347dee.jpg', 'http://localhost:7070/3444614016_f6a6211a10104ac1979ea7b050628b8d.jpg', 'http://localhost:7070/3444614016_cb2871c2ad63459898c3a739f56cea8d.jpg');
INSERT INTO `user` VALUES (3520745329, 'taylor', 'Xelastic', '计算机', b'1', 21, '1998-07-17 00:00:00', '62052419980717367X', '15282813960', '中控信息', '浙江省 杭州市 滨江区', '浙江省 杭州市 滨江区', 7, 3, '2020-02-17 18:40:36', '2020-03-13 15:57:58', '没有伞的孩子只能努力奔跑', 'http://localhost:7070/3520745329_a20e4c527a2444c29b3ded9d1840ed9f.jpg', 'http://localhost:7070/3520745329_267c57b088aa497985d92a6bbc173579.jpg', 'http://localhost:7070/3520745329_267c57b088aa497985d92a6bbc173579.jpg');
COMMIT;

-- ----------------------------
-- Table structure for user_login
-- ----------------------------
DROP TABLE IF EXISTS `user_login`;
CREATE TABLE `user_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `password` varchar(255) DEFAULT NULL COMMENT '用户登录密码',
  PRIMARY KEY (`id`),
  KEY `user_login_user_id_index` (`user_id`),
  CONSTRAINT `user_login_user_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户-登录 表';

-- ----------------------------
-- Records of user_login
-- ----------------------------
BEGIN;
INSERT INTO `user_login` VALUES (1, 3520745329, '5b6b23b338dd7ec9becc2a2fc2c6d352');
INSERT INTO `user_login` VALUES (4, 3444614016, '5b6b23b338dd7ec9becc2a2fc2c6d352');
INSERT INTO `user_login` VALUES (10, 3408468037, '7615a6e01d1ed01cf01ee07a42f4455b');
INSERT INTO `user_login` VALUES (18, 554587118, '4073cd25c32a6ff2b150e0d5db477931');
COMMIT;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `role` varchar(255) DEFAULT 'user' COMMENT '用户角色',
  PRIMARY KEY (`id`),
  KEY `user_role_id_index` (`id`),
  KEY `user_role_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户-角色表';

-- ----------------------------
-- Records of user_role
-- ----------------------------
BEGIN;
INSERT INTO `user_role` VALUES (2, 3444614016, 'user');
INSERT INTO `user_role` VALUES (3, 3520745329, 'admin,user,guest');
INSERT INTO `user_role` VALUES (4, 3408468037, 'user');
INSERT INTO `user_role` VALUES (12, 554587118, 'user');
COMMIT;

-- ----------------------------
-- Triggers structure for table group_table
-- ----------------------------
DROP TRIGGER IF EXISTS `group_create_time`;
delimiter ;;
CREATE TRIGGER `group_create_time` BEFORE INSERT ON `group_table` FOR EACH ROW begin
    set new.create_time= CURRENT_TIMESTAMP;    -- NEW用来表示将要(before)或已经(after)插入的新数据。
end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table user
-- ----------------------------
DROP TRIGGER IF EXISTS `create_time`;
delimiter ;;
CREATE TRIGGER `create_time` BEFORE INSERT ON `user` FOR EACH ROW begin
    set new.create_time= CURRENT_TIMESTAMP;    -- NEW用来表示将要(before)或已经(after)插入的新数据。
end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table user
-- ----------------------------
DROP TRIGGER IF EXISTS `modify_time`;
delimiter ;;
CREATE TRIGGER `modify_time` BEFORE UPDATE ON `user` FOR EACH ROW -- 这句话在mysql是固定的，表示任何一条记录上的操作满足触发事件都会触发该触发器。
begin
    set new.modify_time= CURRENT_TIMESTAMP;
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
