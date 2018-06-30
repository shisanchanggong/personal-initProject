/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : manage

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2018-06-23 18:09:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_department
-- ----------------------------
DROP TABLE IF EXISTS `sys_department`;
CREATE TABLE `sys_department` (
  `DEPARTMENT_ID` varchar(50) NOT NULL COMMENT '部门id',
  `DEPARTMENT_NAME` varchar(100) NOT NULL COMMENT '部门名称',
  `PARENT_ID` varchar(50) DEFAULT NULL COMMENT '上级部门id',
  `PARENT_NAME` varchar(100) DEFAULT NULL COMMENT '上级部门名称',
  `REMARK` varchar(5000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`DEPARTMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_department
-- ----------------------------
INSERT INTO `sys_department` VALUES ('2b1389f6-a422-476b-aad7-5a5cb9665166', '部门3-3', '79f3c3eb-c40c-4cbf-a6b0-1fdedeeac0e8', '部门3', null);
INSERT INTO `sys_department` VALUES ('2cef2f75-3972-4b0d-8dd4-2159c1b3ebeb', '部门1-1', '88049f99-e0cb-4d26-bdda-fc42cf62254b', '部门1', '备注：1-1');
INSERT INTO `sys_department` VALUES ('3acac695-ea28-48ae-9ceb-30ac0d867777', '部门3-1', '79f3c3eb-c40c-4cbf-a6b0-1fdedeeac0e8', '部门3', null);
INSERT INTO `sys_department` VALUES ('4bef0b16-4d54-4a99-8bab-7902def47d26', '部门2-2', 'dae89795-9857-4593-ae20-69a6c8528de0', '部门2', null);
INSERT INTO `sys_department` VALUES ('5532bd37-b622-4cac-a400-d90038ba00e9', '部门3-2-2', 'c7594d18-aa31-40f4-8869-b36336b40e57', '部门3-2', null);
INSERT INTO `sys_department` VALUES ('68b3cf47-b72f-4b7e-97dc-e35056066a1d', '部门1-2', '88049f99-e0cb-4d26-bdda-fc42cf62254b', '部门1', null);
INSERT INTO `sys_department` VALUES ('79f3c3eb-c40c-4cbf-a6b0-1fdedeeac0e8', '部门3', '0', '', null);
INSERT INTO `sys_department` VALUES ('8571539f-7fa7-43b8-baba-96a8749dc1c9', '部门2-1', 'dae89795-9857-4593-ae20-69a6c8528de0', '部门2', null);
INSERT INTO `sys_department` VALUES ('88049f99-e0cb-4d26-bdda-fc42cf62254b', '部门1', '0', '', '备注');
INSERT INTO `sys_department` VALUES ('c3942dac-2a5a-4bc9-a5e3-065d2c019652', '部门3-2-1', 'c7594d18-aa31-40f4-8869-b36336b40e57', '部门3-2', null);
INSERT INTO `sys_department` VALUES ('c7594d18-aa31-40f4-8869-b36336b40e57', '部门3-2', '79f3c3eb-c40c-4cbf-a6b0-1fdedeeac0e8', '部门3', null);
INSERT INTO `sys_department` VALUES ('dae89795-9857-4593-ae20-69a6c8528de0', '部门2', '0', '', null);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `MENU_ID` varchar(36) NOT NULL,
  `PARENT_ID` varchar(36) DEFAULT '0',
  `MENU_NAME` varchar(255) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  `ICON` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `PARENT_NAME` varchar(255) DEFAULT NULL COMMENT '上级菜单名称，方便查询',
  `SORT` int(10) DEFAULT '30',
  PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('11', '0', '系统管理', '', 'fa fa-cog', '', '10');
INSERT INTO `sys_menu` VALUES ('12', '11', '菜单管理', '/menu/menuListPage', 'fa fa-folder-open', '系统管理', '11');
INSERT INTO `sys_menu` VALUES ('14', '11', '用户管理', '/user/userListPage', 'fa fa-users', '系统管理', '12');
INSERT INTO `sys_menu` VALUES ('15', '11', '部门管理', '/department/departmentListPage', 'fa fa-database', '系统管理', '13');
INSERT INTO `sys_menu` VALUES ('16', '11', '角色管理', '/role/roleListPage', 'fa fa-exchange', '系统管理', '14');
INSERT INTO `sys_menu` VALUES ('e89c1e00-3b53-46a2-84bd-e77916ad0bde', '0', '操作日志', '/sysOperateLog/sysOperateLogListPage', 'fa fa-edit', '', '30');

-- ----------------------------
-- Table structure for sys_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_operate_log`;
CREATE TABLE `sys_operate_log` (
  `LOG_ID` varchar(50) NOT NULL,
  `OPERATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  `OPERATE_USER_ID` varchar(50) DEFAULT NULL COMMENT '操作人ID',
  `OPERATE_USER_NAME` varchar(50) DEFAULT NULL COMMENT '操作人名称',
  `OPERATE_TYPE` varchar(10) DEFAULT NULL COMMENT '操作类型',
  `OPERATE_NAME` varchar(50) DEFAULT NULL COMMENT '操作名称',
  `UPDATE_PARAMS` varchar(1000) DEFAULT NULL COMMENT '修改参数',
  `REQUEST_URL` varchar(100) DEFAULT NULL COMMENT '请求路径',
  `TABLE_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_operate_log
-- ----------------------------
INSERT INTO `sys_operate_log` VALUES ('03ccd868-a658-4ac8-a14c-2d52a57087c3', '2018-06-23 15:00:45', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('04f3381d-856a-430e-ae7b-3af4f1e91905', '2018-06-23 12:52:01', '1', 'admin', '1', '角色列表', null, '/role/roleList', null);
INSERT INTO `sys_operate_log` VALUES ('05e6d6e1-ba93-4463-9f9b-94a4b336b514', '2018-06-23 11:23:30', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('05eda885-3a58-4971-a4b7-50b9f00e953f', '2018-06-23 14:37:36', '1', 'admin', '1', '模糊查询列表', '', '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('098c9f2f-2d68-489c-9d4d-602b53d1e707', '2018-06-23 12:18:41', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('0a26ac4e-24be-4d72-9e2e-9f94e7360302', '2018-06-23 11:42:13', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('0a560a67-3713-40e5-9855-cb67198d38d4', '2018-06-23 11:44:59', '1', 'admin', '4', '批量删除', '{\"ids\":\"44e26df2-769c-41eb-904e-7f8d7cda4e3d\"}', '/department/batchDelete', null);
INSERT INTO `sys_operate_log` VALUES ('0a564926-14da-48a6-ba84-19d72335ed25', '2018-06-23 16:44:31', '1', 'admin', '1', '模糊查询列表', null, '/menu/list', 'SYS_MENU');
INSERT INTO `sys_operate_log` VALUES ('0a6659b3-84c8-4a21-87a2-b59706a077b7', '2018-06-23 11:23:10', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('0cd7251b-f1a3-4bbf-9a69-a1766398e897', '2018-06-23 11:28:51', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('0e5a6aad-870d-47c0-9000-9a8aac875c7d', '2018-06-23 14:54:45', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('12ad7bda-02b9-4037-bc59-0d7a90aad16a', '2018-06-23 11:16:49', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('14da1b74-71f5-4fc9-bb63-8ee1fcd2ae1c', '2018-06-23 16:46:13', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('175450ea-3e95-4f76-bd75-bea11f29c4d9', '2018-06-23 11:44:59', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('18c35181-7198-4862-937d-453e91563478', '2018-06-23 14:44:53', '1', 'admin', '1', '模糊查询列表', null, '/menu/list', null);
INSERT INTO `sys_operate_log` VALUES ('1923caa0-b391-40a3-87d9-da52029b4102', '2018-06-23 14:57:49', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('1a805036-e333-4eec-84ca-073fe876a48b', '2018-06-23 14:54:58', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('1bd6f30c-89a6-44cc-9437-a27f274c2175', '2018-06-23 14:52:55', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('1c969e28-58a1-4433-9a69-0300eea428f5', '2018-06-23 16:48:52', '1', 'admin', '-1', '退出系统', null, '/exit', null);
INSERT INTO `sys_operate_log` VALUES ('1eda0ee3-a36b-4957-a903-289b92c1079e', '2018-06-23 16:04:43', '1', 'admin', '1', '模糊查询列表', null, '/user/list', 'SYS_USER');
INSERT INTO `sys_operate_log` VALUES ('1f851751-3fbf-4154-a846-39aaa00733bf', '2018-06-23 14:57:22', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('2047d0b5-0ab6-4b1d-ae37-660752027c19', '2018-06-23 11:31:33', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('208195bd-d6d1-4e88-9f56-d49e0bc27367', '2018-06-23 14:57:41', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('20d36335-648a-4ea6-8949-0e3fda86a641', '2018-06-23 14:55:41', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('21c35b31-cba5-4633-ae03-71f38cb8377a', '2018-06-23 14:55:36', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('21d878e7-68e4-4b10-9fea-f8edb8105c23', '2018-06-23 11:44:56', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('2410fbad-4eed-42bb-aefc-6136bd4a1e7a', '2018-06-23 16:13:36', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('242c9bfd-3fbb-434b-83db-72f740763927', '2018-06-23 14:54:33', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('25dff3b3-0b63-464b-8a48-686941fdfec3', '2018-06-23 14:47:04', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('262f0cdd-699e-4d15-8315-5009166f3ad3', '2018-06-23 16:50:54', '1', 'admin', '1', '模糊查询列表', null, '/user/list', 'SYS_USER');
INSERT INTO `sys_operate_log` VALUES ('2a8a91da-7257-407f-adc2-de8bcc4b7cc8', '2018-06-23 14:37:40', '1', 'admin', '0', '进入系统', '', '/', null);
INSERT INTO `sys_operate_log` VALUES ('2b953426-d8f8-4df2-823a-14adf00a2913', '2018-06-23 14:52:48', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('2c86f67e-129f-4d6f-b316-36248921b405', '2018-06-23 11:26:46', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('305a2e3d-2e5a-4dbc-b2a7-a251e8f22d46', '2018-06-23 16:49:18', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('338effcb-1fc5-4074-ab1f-47d33ae7b7ef', '2018-06-23 14:46:46', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('33da997b-8245-4f9b-b467-39ceefa29530', '2018-06-23 11:45:49', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('343ceb32-3a55-44bf-87f6-94b0cada1651', '2018-06-23 14:54:51', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('365fc9ad-fdbb-475f-9014-f18bb6da2ffc', '2018-06-23 16:05:17', '1', 'admin', '5', '保存（新增或更新）', '{\"departmentName\":\"部门1\",\"userSex\":\"F\",\"createUserId\":\"1\",\"updateUserId\":\"1\",\"departmentId\":\"88049f99-e0cb-4d26-bdda-fc42cf62254b\",\"updateUserName\":\"admin\",\"remark\":null,\"createUserName\":\"admin\",\"updateTime\":\"2018-06-23 16:05:17\",\"userName\":\"test3\",\"userId\":null,\"createTime\":\"2018-06-23 16:05:17\",\"loginName\":\"test3\",\"loginPassword\":null,\"locked\":1}', '/user/save', 'SYS_USER');
INSERT INTO `sys_operate_log` VALUES ('37b962ec-d7be-4a10-86a4-7afaf8616612', '2018-06-23 14:55:05', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('3878a6fa-69dc-4543-a4a0-2bbbd257ca43', '2018-06-23 14:44:56', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('39c159c4-aa72-4fcf-9447-071f10c647c0', '2018-06-23 16:04:27', '1', 'admin', '1', '模糊查询列表', null, '/user/list', 'SYS_USER');
INSERT INTO `sys_operate_log` VALUES ('3a06bdbf-995a-4b34-8ffa-49078daa7ef4', '2018-06-23 15:01:12', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('3d62abcd-b3ee-4671-870d-a52d9e25eefa', '2018-06-23 14:59:28', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('3d8899db-63f6-40cc-b4ca-cc574f49948d', '2018-06-23 14:57:51', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('3e8fcad4-00ff-47b2-94da-3bd7a14413d8', '2018-06-23 14:54:42', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('402e5c0b-8873-435e-b9dd-9c05df70bd52', '2018-06-23 14:54:49', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('419d3de9-b0c4-4f6d-9510-2dd12278197d', '2018-06-23 14:52:53', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('4241e2f7-5918-4de7-ad11-ceb85999f3a0', '2018-06-23 14:54:28', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('44bfda93-1c4d-48d6-a36a-ca7f9d488ac4', '2018-06-23 14:54:52', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('461b7263-bd77-4045-ba00-dd76eaccea08', '2018-06-23 11:20:42', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/menu/list', null);
INSERT INTO `sys_operate_log` VALUES ('463d40f3-300e-4e7f-b704-41bd131251a0', '2018-06-23 14:46:48', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('4711f1e5-f1e2-43f8-8d1a-899571e56136', '2018-06-23 11:41:15', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('4a94afce-f37a-4876-8004-195056ca5623', '2018-06-23 14:55:39', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('4ae8e0ca-beee-476d-9590-13cab0f7274d', '2018-06-23 14:53:16', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('4b16fb22-e176-4ea8-a97e-b98f85ccdbb0', '2018-06-23 14:54:30', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('4b3d89f2-856e-430b-a211-afc2329c7398', '2018-06-23 16:35:27', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('4cf6ed9a-6ebf-4049-ae6e-5182d14e5b9a', '2018-06-23 13:57:33', '1', 'admin', '1', '模糊查询列表', null, '/menu/list', null);
INSERT INTO `sys_operate_log` VALUES ('4d7eb9ef-f4a2-4ecb-969e-305723750cc1', '2018-06-23 15:00:22', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('4e32ff59-71a7-4027-a914-2b53b8b34dab', '2018-06-23 11:10:26', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('4e6cef90-c3fb-4752-8482-8a7e90f40009', '2018-06-23 15:01:09', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('4f7ba654-b900-4a21-b753-7063bf0cf237', '2018-06-23 14:54:27', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('4f8fe33e-2bfa-419c-92c8-d6d417f52b56', '2018-06-23 14:01:22', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('506d95bd-36e2-4f1d-8221-5b2b65571906', '2018-06-23 16:14:26', '1', 'admin', '1', '模糊查询列表', null, '/sysOperateLog/list', null);
INSERT INTO `sys_operate_log` VALUES ('5186b56c-7e7c-44a8-bfe1-c3afd8bc114f', '2018-06-23 14:37:41', '1', 'admin', '1', '模糊查询列表', '', '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('519eb63b-930a-4f5c-8516-7db4e234773d', '2018-06-23 11:10:18', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('5213df0f-8fd1-4e57-83d7-22578dd60145', '2018-06-23 11:27:52', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('597d01b1-7d9d-4c8b-98df-fa4d0c03f640', '2018-06-23 14:54:48', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('59a348c5-6ca1-4068-b106-9ce9a79b0539', '2018-06-23 14:45:03', '1', 'admin', '1', '角色列表', null, '/role/roleList', null);
INSERT INTO `sys_operate_log` VALUES ('5b238315-a059-4e4f-acc8-223497fb0a52', '2018-06-23 11:45:46', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('5c3aac77-bf72-4324-b3cb-9b6ccc177f26', '2018-06-23 14:53:19', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('5e8bffa3-5f79-416d-84cf-56a7b62cfa59', '2018-06-23 14:54:02', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('6059aa4a-a48b-4034-989a-1d519319b7bc', '2018-06-23 16:20:55', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('6231a965-5b71-4e7d-b606-321d6e5730bc', '2018-06-23 14:55:38', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('62c5ae6d-38ed-4b59-af21-9b4d3d05a847', '2018-06-23 14:52:51', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('635ff4cf-4b9a-4aa9-a080-6e1ac45cb255', '2018-06-23 16:45:38', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('63a0e716-48f1-45ac-af46-10547eadbbb0', '2018-06-23 14:52:45', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('63ffbff6-3a8f-45b3-a201-f9353a30ca0d', '2018-06-23 11:10:03', '1', 'admin', '1', '模糊查询列表', null, '/menu/list', null);
INSERT INTO `sys_operate_log` VALUES ('65527e1f-b887-4cb1-8bd0-dcbd79c85b26', '2018-06-23 14:54:44', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('65a78afa-3d10-4712-8c87-f637205919dc', '2018-06-23 13:58:11', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('65b2d3ee-7398-41c0-85cd-9f574b52d7cd', '2018-06-23 14:45:27', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('666b44d5-ea56-4c0a-a1ce-ac5583177f26', '2018-06-23 15:01:28', '1', 'admin', '1', '角色列表', null, '/role/roleList', null);
INSERT INTO `sys_operate_log` VALUES ('672f29b0-60fe-48fe-84af-d1c0b76684fa', '2018-06-23 15:00:43', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('6795303d-eaad-4dba-a642-b83fda20fa2c', '2018-06-23 16:41:12', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('67b2d6db-63ea-4353-9f16-9f9293f72175', '2018-06-23 14:46:30', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('67cdf04f-6f04-4922-8d26-0bf69632a34e', '2018-06-23 16:50:56', '1', 'admin', '1', '模糊查询列表', null, '/role/list', 'SYS_ROLE');
INSERT INTO `sys_operate_log` VALUES ('69647bb2-e44a-4cad-a947-c0d5e002d11a', '2018-06-23 14:46:01', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('6a0bf86e-cc1b-4b66-a638-ec303e73ccc5', '2018-06-23 12:52:03', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('6a7a4af4-638d-43eb-bada-5899f3fdc393', '2018-06-23 14:57:40', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('6c830cf1-2169-4485-b588-d418147520ca', '2018-06-23 14:45:05', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('6fff13b6-b57f-47d9-a098-a70f9c27736d', '2018-06-23 16:14:18', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('70dec1d8-d09e-494c-992c-2768728210f5', '2018-06-23 11:13:42', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('72b9ba52-f62b-45a3-9b20-b96af3bf41dc', '2018-06-23 12:46:39', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('736dba6b-7fec-4fa6-9bd4-7757265e2650', '2018-06-23 15:00:26', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('74985918-f200-429c-b6c9-064a326c2547', '2018-06-23 15:00:25', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('75d255b1-5c48-4165-bdd5-29d2a657c1dd', '2018-06-23 16:05:37', '1', 'admin', '4', '批量删除', '[{\"departmentName\":\"部门1\",\"userSex\":\"F\",\"createUserId\":\"1\",\"updateUserId\":\"1\",\"departmentId\":\"88049f99-e0cb-4d26-bdda-fc42cf62254b\",\"updateUserName\":\"admin\",\"updateTime\":\"2018-06-23 16:05:17\",\"createUserName\":\"admin\",\"userName\":\"test3\",\"userId\":\"2b59503a-f7f4-4b70-8213-13f1a01f105f\",\"createTime\":\"2018-06-23 16:05:17\",\"loginName\":\"test3\",\"loginPassword\":\"917d97071255f1e77c059347a1df7b91\",\"locked\":1},{\"departmentName\":\"部门1-2\",\"userSex\":\"M\",\"createUserId\":\"1\",\"updateUserId\":\"1\",\"departmentId\":\"68b3cf47-b72f-4b7e-97dc-e35056066a1d\",\"updateUserName\":\"admin\",\"updateTime\":\"2018-06-23 16:04:42\",\"createUserName\":\"admin\",\"userName\":\"test4\",\"userId\":\"36a84c39-42c6-4e92-8ea6-a24933323b73\",\"createTime\":\"2018-06-23 16:04:42\",\"loginName\":\"test4\",\"loginPassword\":\"d0d89fe835e2a61226334254f4e724e0\",\"locked\":0}]', '/user/batchDelete', 'SYS_USER');
INSERT INTO `sys_operate_log` VALUES ('7659015d-1384-4347-aede-eef3745b459c', '2018-06-23 11:27:55', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('77446856-720a-4f47-acd1-18d89b705a59', '2018-06-23 12:46:19', '1', 'admin', '5', '保存（新增或更新）', '{\"departmentName\":\"部门3-2\",\"userSex\":\"M\",\"createUserId\":\"1\",\"updateUserId\":\"1\",\"departmentId\":\"c7594d18-aa31-40f4-8869-b36336b40e57\",\"updateUserName\":\"admin\",\"remark\":\"备注：\",\"createUserName\":\"admin\",\"updateTime\":\"2018-06-23 12:46:19\",\"userName\":\"test3\",\"userId\":null,\"createTime\":\"2018-06-23 12:46:19\",\"loginName\":\"test3\",\"loginPassword\":null,\"locked\":0}', '/user/save', null);
INSERT INTO `sys_operate_log` VALUES ('7af2b643-b16f-4622-aec7-9deca4039f56', '2018-06-23 14:55:35', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('7bd4f719-3271-4675-888e-628e51a69a10', '2018-06-23 12:17:23', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('7e4ea24b-ffd2-4ed8-9147-476ea33b7489', '2018-06-23 14:55:02', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('7e5faf84-19b9-4abc-823d-305ed45be5cf', '2018-06-23 13:58:04', '1', 'admin', '1', '模糊查询列表', null, '/menu/list', null);
INSERT INTO `sys_operate_log` VALUES ('7eb3422d-b462-4c89-a687-4deab83876bf', '2018-06-23 14:55:07', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('7f834df1-441b-44db-83e4-ad62298bbf18', '2018-06-23 15:00:52', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('7ffeb2ac-2cc9-4327-bda5-e6f3b335989f', '2018-06-23 14:45:17', '1', 'admin', '1', '角色列表', null, '/role/roleList', null);
INSERT INTO `sys_operate_log` VALUES ('81144717-cd31-40af-98f3-9118da738eae', '2018-06-23 14:46:28', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('84dd5493-c38c-4063-a893-ad561ca2c7c7', '2018-06-23 16:43:39', '1', 'admin', '-1', '退出系统', null, '/exit', null);
INSERT INTO `sys_operate_log` VALUES ('85e45fe2-4241-4a2c-83bd-30d49123dd4e', '2018-06-23 11:44:39', '1', 'admin', '-1', '退出系统', null, '/exit', null);
INSERT INTO `sys_operate_log` VALUES ('8747d91b-c179-43c0-96bf-eb03632285f9', '2018-06-23 14:57:29', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('87970214-4a13-40d5-bc84-488a48d59e1b', '2018-06-23 14:46:26', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('8853546d-9cde-4776-9f55-aa58c996f800', '2018-06-23 14:55:01', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('8a72edee-838a-4ebb-a896-4c0cdf46489b', '2018-06-23 14:57:53', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('8c0fcb54-f5aa-44c0-b1ef-3b6654639c9a', '2018-06-23 14:01:24', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('8ede750f-1cb8-497c-b0c9-1918dc282131', '2018-06-23 16:50:43', '1', 'admin', '1', '模糊查询列表', null, '/user/list', 'SYS_USER');
INSERT INTO `sys_operate_log` VALUES ('911b0a26-2c1f-4c23-b2aa-18905b45032b', '2018-06-23 14:37:44', '1', 'admin', '1', '模糊查询列表', '', '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('918fa537-15e8-4c03-9b80-5d57527edc1c', '2018-06-23 11:31:08', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('9326b266-7fcd-4019-a7ac-0c31e73fe6da', '2018-06-23 14:46:13', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('9500e9e7-e987-4af3-a573-41d81d58cb2f', '2018-06-23 16:44:25', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('96f931d9-596e-48b0-8c0d-2d6fbabd1536', '2018-06-23 16:46:23', '1', 'admin', '1', '模糊查询列表', null, '/department/list', 'SYS_DEPARTMENT');
INSERT INTO `sys_operate_log` VALUES ('98adf685-d47e-49ee-a79c-f1364f12356c', '2018-06-23 16:05:17', '1', 'admin', '1', '模糊查询列表', null, '/user/list', 'SYS_USER');
INSERT INTO `sys_operate_log` VALUES ('9a4ab6f7-3f63-4ac2-89c3-96b08cc3f720', '2018-06-23 14:54:31', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('9b5df6bb-123f-45e8-b4a5-95fccc6dc5ef', '2018-06-23 16:45:11', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('9b99e271-a806-4db6-81fa-ef5b08fe4547', '2018-06-23 14:46:00', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('a30838b7-aaf4-411b-bb76-8a67957d2b85', '2018-06-23 16:04:42', '1', 'admin', '5', '保存（新增或更新）', '{\"departmentName\":\"部门1-2\",\"userSex\":\"M\",\"createUserId\":\"1\",\"updateUserId\":\"1\",\"departmentId\":\"68b3cf47-b72f-4b7e-97dc-e35056066a1d\",\"updateUserName\":\"admin\",\"remark\":null,\"createUserName\":\"admin\",\"updateTime\":\"2018-06-23 16:04:42\",\"userName\":\"test4\",\"userId\":null,\"createTime\":\"2018-06-23 16:04:42\",\"loginName\":\"test4\",\"loginPassword\":null,\"locked\":0}', '/user/save', 'SYS_USER');
INSERT INTO `sys_operate_log` VALUES ('a51357be-755b-4648-9e9f-b342a33fdba9', '2018-06-23 14:54:41', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('a55a19ad-e515-431a-b75f-89ce529766ac', '2018-06-23 16:45:14', '1', 'admin', '1', '模糊查询列表', null, '/menu/list', 'SYS_MENU');
INSERT INTO `sys_operate_log` VALUES ('a5fafe64-07fa-466e-b5fc-3fcbc0c1458e', '2018-06-23 15:00:42', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('a6b8778e-7223-4881-b936-e3677ee5545b', '2018-06-23 14:46:23', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('a777b542-14c5-4190-b960-28bdc3145753', '2018-06-23 16:33:17', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('a789be54-d5cf-44b0-9579-3742cbf6356d', '2018-06-23 16:13:56', '1', 'admin', '-1', '退出系统', null, '/exit', null);
INSERT INTO `sys_operate_log` VALUES ('a79063b7-0a91-42bc-8a06-b3a83a833e75', '2018-06-23 14:52:50', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('aa0dadca-ec48-4673-b07f-97903096bd46', '2018-06-23 15:01:24', '1', 'admin', '1', '角色列表', null, '/role/roleList', null);
INSERT INTO `sys_operate_log` VALUES ('aa3438db-5bb2-46c2-9735-c8948e70880d', '2018-06-23 14:54:39', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('abe13773-6343-43de-9fe6-fe7a800b23b7', '2018-06-23 14:01:26', '1', 'admin', '1', '角色列表', null, '/role/roleList', null);
INSERT INTO `sys_operate_log` VALUES ('ae4dc1a6-e992-4c0a-8e91-2f26f8f0b31f', '2018-06-23 11:38:56', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('aebae844-c690-4aaa-aa47-bad4951bdf21', '2018-06-23 14:52:52', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('af430659-cb69-42b4-8bc8-534901d534f2', '2018-06-23 14:57:20', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('b0b4ced0-36bd-4388-931b-f0e23ca369da', '2018-06-23 16:31:47', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('b26c7b26-4a90-4410-a12e-8712c6b94c26', '2018-06-23 15:01:21', '1', 'admin', '1', '角色列表', null, '/role/roleList', null);
INSERT INTO `sys_operate_log` VALUES ('b4e8876d-8d58-4bf0-a7b7-eebe6046f5c5', '2018-06-23 15:00:19', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('b5daecd8-7bad-49e1-9f58-2f07f5c6d113', '2018-06-23 13:57:25', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('b601c82f-bc66-40e2-8c66-54c90496cc42', '2018-06-23 11:29:05', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('b6aae8dd-f441-4745-bbf6-1a3a3c33adee', '2018-06-23 14:55:09', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('b6ef7667-05e8-47d0-9354-4337083a8e29', '2018-06-23 15:01:00', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('b7ea6d2d-5fec-42e6-ae8f-4793be34364f', '2018-06-23 15:01:08', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('b8b18f64-34d1-4e88-af22-244cd8f207d2', '2018-06-23 11:21:11', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('b9c7f457-8547-43ab-aa93-00448c69750c', '2018-06-23 14:55:03', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('ba3233e3-2aaa-4a48-9f0f-89b38f4ec2be', '2018-06-23 11:44:33', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('ba51861f-c1e9-48fe-a47e-b03001c58596', '2018-06-23 12:46:33', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('bb4b5d2f-3946-4acf-a82b-ca1b77eb467c', '2018-06-23 14:55:40', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('bc7586b4-4b1f-49f2-93f8-2b0b76b3c52b', '2018-06-23 15:00:27', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('bf9b7b64-ce82-4197-a318-14ed4939b46b', '2018-06-23 14:59:30', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('c1995826-eefc-4fef-82f0-5536993edffd', '2018-06-23 15:01:05', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('c1e6e10e-c28a-41fc-8405-271e760a30f4', '2018-06-23 11:14:03', '1', 'admin', '5', '保存（新增或更新）', '{\"departmentName\":\"test1-1\",\"parentName\":\"test1\",\"departmentId\":null,\"remark\":\"备注：\",\"parentId\":\"44e26df2-769c-41eb-904e-7f8d7cda4e3d\"}', '/department/save', null);
INSERT INTO `sys_operate_log` VALUES ('c30c4860-c3c3-4399-83b9-fa5a14500509', '2018-06-23 12:18:16', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('c44caf18-dbe5-43a6-ae06-ea605d995206', '2018-06-23 11:11:23', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('c634eff8-79af-48e8-83f8-f8be7d9cd2bb', '2018-06-23 15:00:51', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('c7c79053-6844-4c16-95d4-269ddcdc1ede', '2018-06-23 14:59:24', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('cac854ca-820f-4dd2-8d75-2e2c5945b641', '2018-06-23 16:14:24', '1', 'admin', '1', '模糊查询列表', null, '/user/list', 'SYS_USER');
INSERT INTO `sys_operate_log` VALUES ('cc2d68a2-e645-454d-9e80-c5a9e6b3a4e9', '2018-06-23 15:00:24', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('cc5854ce-b858-4768-bd64-b117b14b48e7', '2018-06-23 15:01:07', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('ccc93f67-b331-461e-8fa5-7ce163b3948f', '2018-06-23 11:38:13', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '5', '保存（新增或更新）', '{\"departmentName\":\"部门3-2-2\",\"userSex\":\"F\",\"createUserId\":\"da7f709d-3c54-4313-8618-52c9c12f180d\",\"updateUserId\":\"da7f709d-3c54-4313-8618-52c9c12f180d\",\"departmentId\":\"5532bd37-b622-4cac-a400-d90038ba00e9\",\"updateUserName\":\"test1\",\"remark\":null,\"createUserName\":\"test1\",\"updateTime\":\"2018-06-23 11:38:13\",\"userName\":\"test3\",\"userId\":null,\"createTime\":\"2018-06-23 11:38:13\",\"loginName\":\"test3\",\"loginPassword\":null,\"locked\":0}', '/user/save', null);
INSERT INTO `sys_operate_log` VALUES ('d0ebef54-728a-4dd4-8a5a-1f9f9f823955', '2018-06-23 14:57:25', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('d10316e7-c074-4b70-9a11-d4d4d0a747ad', '2018-06-23 14:48:04', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('d186de46-b3e4-4a47-8d07-f0d3bdaedd4a', '2018-06-23 14:57:46', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('d33c2f4e-303f-4069-a1a5-09367fed118b', '2018-06-23 14:55:43', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('d380ef58-4943-46d1-b12b-61c68c5ae148', '2018-06-23 14:57:44', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('d411cbca-7059-40c4-ae2f-ee0907236bac', '2018-06-23 14:57:43', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('d483f27f-9540-4e93-a393-48e03e69639d', '2018-06-23 14:57:24', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('d4b4ad68-dfcf-4015-aa53-525f698115ff', '2018-06-23 14:55:11', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('d527b034-48d5-4fd8-9f2c-d4423d6c099b', '2018-06-23 11:29:36', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('d6131006-2a71-47b3-8839-f8572c68a966', '2018-06-23 15:00:30', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('d73bdecb-c2ea-4282-937f-ac94c7e94ca2', '2018-06-23 16:05:37', '1', 'admin', '1', '模糊查询列表', null, '/user/list', 'SYS_USER');
INSERT INTO `sys_operate_log` VALUES ('d847361a-fdea-490b-9f1b-8fc9709d901a', '2018-06-23 11:45:49', '1', 'admin', '4', '批量删除', '{\"ids\":\"44fb4cef-bac7-4bd5-b9e0-a0c46749f227\"}', '/department/batchDelete', null);
INSERT INTO `sys_operate_log` VALUES ('d98cc83d-c041-4b1a-bd13-55e34f116969', '2018-06-23 11:38:56', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '5', '保存（新增或更新）', '{\"departmentName\":\"test1\",\"userSex\":\"M\",\"createUserId\":\"da7f709d-3c54-4313-8618-52c9c12f180d\",\"updateUserId\":\"da7f709d-3c54-4313-8618-52c9c12f180d\",\"departmentId\":\"44e26df2-769c-41eb-904e-7f8d7cda4e3d\",\"updateUserName\":\"test1\",\"remark\":null,\"createUserName\":\"test1\",\"updateTime\":\"2018-06-23 11:38:55\",\"userName\":\"test4\",\"userId\":null,\"createTime\":\"2018-06-23 11:38:55\",\"loginName\":\"test4\",\"loginPassword\":null,\"locked\":1}', '/user/save', null);
INSERT INTO `sys_operate_log` VALUES ('d9f458a4-1a3b-47b0-a2d5-d256162a25b2', '2018-06-23 11:39:04', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '4', '批量删除', '{\"ids\":\"162010d2-551d-413b-ba0a-e832bc33595f,366c4465-c2c3-48e6-9215-7f7a9470962e\"}', '/user/batchDelete', null);
INSERT INTO `sys_operate_log` VALUES ('dd706a7f-5986-4232-bf08-23e35e6f743c', '2018-06-23 11:11:05', '1', 'admin', '4', '单条删除', '{\"id\":\"68ed9456-94ae-4a3f-a8c8-acbb69b345ee\"}', '/department/delete/68ed9456-94ae-4a3f-a8c8-acbb69b345ee', null);
INSERT INTO `sys_operate_log` VALUES ('ddc583af-b01f-4795-a4d5-7de95a7ec670', '2018-06-23 14:55:12', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('df001a09-ff22-4ffb-a6e9-c2af5da91742', '2018-06-23 13:58:02', '1', 'admin', '5', '保存（新增或更新）', '{\"parentName\":\"\",\"icon\":\"fa fa-edit\",\"menuId\":\"e89c1e00-3b53-46a2-84bd-e77916ad0bde\",\"menuName\":\"操作日志\",\"sort\":30,\"parentId\":\"0\",\"url\":\"/sysOperateLog/sysOperateLogListPage\"}', '/menu/save', null);
INSERT INTO `sys_operate_log` VALUES ('dfde17a7-780c-4acd-9911-add2adc98ea7', '2018-06-23 11:13:40', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('e18c18fb-019c-4b8f-bfa0-9caef1f6ec78', '2018-06-23 16:51:03', '1', 'admin', '1', '模糊查询列表', null, '/user/list', 'SYS_USER');
INSERT INTO `sys_operate_log` VALUES ('e2b42fe6-9ee2-47e0-9594-bf1199cb19ea', '2018-06-23 14:57:52', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('e5ebf958-ac29-43b9-b0de-70300b690382', '2018-06-23 16:14:20', '1', 'admin', '1', '模糊查询列表', null, '/menu/list', 'SYS_MENU');
INSERT INTO `sys_operate_log` VALUES ('e5eca38e-7898-48c0-90e2-f2b0e96106e2', '2018-06-23 12:52:06', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('e6a2da48-8c00-43a8-b120-7f7aa1c7e189', '2018-06-23 11:38:14', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('e77a6c32-690e-4a14-bc13-857abb413107', '2018-06-23 11:31:16', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '4', '批量删除', '{\"id\":\"[Ljava.lang.String;@43e49577\"}', '/user/batchDelete', null);
INSERT INTO `sys_operate_log` VALUES ('e7995728-042b-4c85-a514-b906908bd9d1', '2018-06-23 14:46:33', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('eb54ef7a-4bb4-4227-85cb-b18acc7e5b1c', '2018-06-23 12:46:39', '1', 'admin', '4', '批量删除', '[{\"departmentName\":\"部门3-2\",\"userSex\":\"M\",\"createUserId\":\"1\",\"updateUserId\":\"1\",\"departmentId\":\"c7594d18-aa31-40f4-8869-b36336b40e57\",\"updateUserName\":\"admin\",\"updateTime\":\"2018-06-23 12:46:19\",\"createUserName\":\"admin\",\"remark\":\"备注：\",\"userName\":\"test3\",\"userId\":\"d8309392-96be-4535-aa69-e4532f0cf604\",\"createTime\":\"2018-06-23 12:46:19\",\"loginName\":\"test3\",\"loginPassword\":\"917d97071255f1e77c059347a1df7b91\",\"locked\":0}]', '/user/batchDelete', null);
INSERT INTO `sys_operate_log` VALUES ('ed18eed3-2026-48a7-af87-1ae5687d22b8', '2018-06-23 14:59:26', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('ed29a684-7d5a-4d4c-8659-29f55eb5feb0', '2018-06-23 14:54:32', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('ee74008b-24a2-4299-8a9c-58930d039469', '2018-06-23 14:01:23', '1', 'admin', '1', '模糊查询列表', null, '/menu/list', null);
INSERT INTO `sys_operate_log` VALUES ('efc53273-4ff7-428e-a5fb-b37e4bc41e38', '2018-06-23 11:28:58', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '5', '保存（新增或更新）', '{\"departmentName\":\"test1\",\"userSex\":\"M\",\"createUserId\":\"da7f709d-3c54-4313-8618-52c9c12f180d\",\"updateUserId\":\"da7f709d-3c54-4313-8618-52c9c12f180d\",\"departmentId\":\"44e26df2-769c-41eb-904e-7f8d7cda4e3d\",\"updateUserName\":\"test1\",\"remark\":\"备注：\",\"createUserName\":\"test1\",\"updateTime\":\"2018-06-23 11:28:58\",\"userName\":\"test3\",\"userId\":\"24a11c31-4533-4c50-a0f3-d69a0aeffdb9\",\"createTime\":\"2018-06-23 11:21:31\",\"loginName\":\"test3\",\"loginPassword\":\"917d97071255f1e77c059347a1df7b91\",\"locked\":0}', '/user/save', null);
INSERT INTO `sys_operate_log` VALUES ('f1900032-a119-48fd-b2d4-32a4456a5974', '2018-06-23 15:01:16', '1', 'admin', '1', '角色列表', null, '/role/roleList', null);
INSERT INTO `sys_operate_log` VALUES ('f1a3b4d1-74a1-457e-8fed-5a0436bdc4cd', '2018-06-23 16:13:54', '1', 'admin', '1', '模糊查询列表', null, '/department/list', 'SYS_DEPARTMENT');
INSERT INTO `sys_operate_log` VALUES ('f2a192ba-a56c-424d-8526-a566256eb610', '2018-06-23 16:46:18', '1', 'admin', '1', '模糊查询列表', null, '/menu/list', 'SYS_MENU');
INSERT INTO `sys_operate_log` VALUES ('f4c2e380-3468-42a3-96e8-5709f46e805f', '2018-06-23 11:39:04', 'da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('f507986b-9c89-4d3b-9053-85500259fa32', '2018-06-23 14:41:28', '1', 'admin', '1', '模糊查询列表', null, '/menu/list', null);
INSERT INTO `sys_operate_log` VALUES ('f570ac74-d06d-4e69-b12a-2c619986910c', '2018-06-23 14:46:24', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('f80ea2c1-d4ee-45a9-aac7-c3388c179956', '2018-06-23 16:43:36', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('f879b708-8eba-4b2f-8779-8eb646bb3e71', '2018-06-23 14:54:36', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('faa7fd89-dfe9-4a04-92cc-0fcf7cb2ad94', '2018-06-23 16:45:45', '1', 'admin', '-1', '退出系统', null, '/exit', null);
INSERT INTO `sys_operate_log` VALUES ('fb88cce4-c52b-492d-b80c-5d6dbb20af8a', '2018-06-23 11:44:52', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('fbb33a31-9077-440b-8a6f-5ec54aa5b735', '2018-06-23 11:16:48', '1', 'admin', '1', '模糊查询列表', null, '/department/list', null);
INSERT INTO `sys_operate_log` VALUES ('fbd6bf76-0db4-4755-9a94-3a49a674f729', '2018-06-23 14:46:19', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('fc101ad4-8bcd-419b-a83e-a53137282a0a', '2018-06-23 15:00:29', '1', 'admin', '1', '模糊查询列表', null, '/user/list', null);
INSERT INTO `sys_operate_log` VALUES ('fcfb67df-fcf6-4d79-977a-0024bfaaaa23', '2018-06-23 11:41:15', '1', 'admin', '0', '进入系统', null, '/', null);
INSERT INTO `sys_operate_log` VALUES ('fd2fd24a-a5fb-4b8e-8f90-c36b5e324f4f', '2018-06-23 14:57:38', '1', 'admin', '1', '模糊查询列表', null, '/role/list', null);
INSERT INTO `sys_operate_log` VALUES ('fd5aa37a-e1f5-4b10-93f0-2005d0f4588b', '2018-06-23 12:52:09', '1', 'admin', '1', '模糊查询列表', null, '/menu/list', null);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `ROLE_ID` varchar(36) NOT NULL,
  `ROLE_NAME` varchar(255) NOT NULL,
  `ROLE_SIGN` varchar(255) DEFAULT NULL,
  `REMARK` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('49fa5763-b0f3-46cc-b7a3-d61e388d44eb', '系统超级管理员', 'admin', '系统超级管理员');
INSERT INTO `sys_role` VALUES ('6f17c930-807f-4dbf-a030-aafb6a0caccc', '角色1', 'test', null);
INSERT INTO `sys_role` VALUES ('dca43f07-f3e0-48e4-bc41-80be955e7b7f', '角色2', 'test', null);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `ROLE_MENU_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) DEFAULT NULL,
  `MENU_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ROLE_MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('01e8bbcc-ee68-4647-9dff-6b52f7256695', '48b4b05f-0b1e-442a-8878-1fb36307d7e2', '14');
INSERT INTO `sys_role_menu` VALUES ('18cbf3d1-d248-4d12-8f1b-d39457e7ff7e', '48b4b05f-0b1e-442a-8878-1fb36307d7e2', '12');
INSERT INTO `sys_role_menu` VALUES ('22f868aa-ca7f-4e1b-b93c-57889ea9e9b2', '49fa5763-b0f3-46cc-b7a3-d61e388d44eb', '12');
INSERT INTO `sys_role_menu` VALUES ('26256192-ec50-4b3e-8ff6-8cb731b972dc', '49fa5763-b0f3-46cc-b7a3-d61e388d44eb', '15');
INSERT INTO `sys_role_menu` VALUES ('2f18e6b2-09a4-4d7d-a589-45ec9fe99fd4', '6f17c930-807f-4dbf-a030-aafb6a0caccc', '15');
INSERT INTO `sys_role_menu` VALUES ('376ea0c1-ffd0-42a6-98eb-f35cb4734626', '6f17c930-807f-4dbf-a030-aafb6a0caccc', '14');
INSERT INTO `sys_role_menu` VALUES ('38db4e67-b133-4688-948a-a8c603c9287c', '48b4b05f-0b1e-442a-8878-1fb36307d7e2', '16');
INSERT INTO `sys_role_menu` VALUES ('3acb2664-2b66-4fc4-b8ff-5ff6e0f21f4d', '49fa5763-b0f3-46cc-b7a3-d61e388d44eb', '16');
INSERT INTO `sys_role_menu` VALUES ('5077c175-cb6c-4db2-ad07-127f6a3638ce', '49fa5763-b0f3-46cc-b7a3-d61e388d44eb', '14');
INSERT INTO `sys_role_menu` VALUES ('515e2cca-d924-4d5f-8ad4-2e5a35be0387', 'd23d5a1d-2904-44be-bc7f-91d6a408c082', '11');
INSERT INTO `sys_role_menu` VALUES ('55316414-1148-443d-a4ca-4aed705425c1', 'dca43f07-f3e0-48e4-bc41-80be955e7b7f', '16');
INSERT INTO `sys_role_menu` VALUES ('61415df6-6c15-48d4-ad8b-d33ca7ff2b8e', '6f17c930-807f-4dbf-a030-aafb6a0caccc', '12');
INSERT INTO `sys_role_menu` VALUES ('9d4143e6-6106-4bd6-bd7a-8409de91bb65', '48b4b05f-0b1e-442a-8878-1fb36307d7e2', '15');
INSERT INTO `sys_role_menu` VALUES ('bf3dca47-484b-42f3-bdc7-5ecac5d89182', '6f17c930-807f-4dbf-a030-aafb6a0caccc', '11');
INSERT INTO `sys_role_menu` VALUES ('c40d666f-f4a7-40fe-9d27-22fcceaa3177', '49fa5763-b0f3-46cc-b7a3-d61e388d44eb', '11');
INSERT INTO `sys_role_menu` VALUES ('c7de95dc-261d-4e24-af5c-0fe55490e465', '48b4b05f-0b1e-442a-8878-1fb36307d7e2', '11');
INSERT INTO `sys_role_menu` VALUES ('d5357479-a284-4091-833a-d5223d00fc43', '49fa5763-b0f3-46cc-b7a3-d61e388d44eb', 'e89c1e00-3b53-46a2-84bd-e77916ad0bde');
INSERT INTO `sys_role_menu` VALUES ('d7564fcb-b07a-4c85-bb42-d2f9aada8077', 'd23d5a1d-2904-44be-bc7f-91d6a408c082', '12');
INSERT INTO `sys_role_menu` VALUES ('db89a624-da47-48c3-9a57-1fe89dbca2ef', 'dca43f07-f3e0-48e4-bc41-80be955e7b7f', '11');
INSERT INTO `sys_role_menu` VALUES ('df8c0943-d8da-4ae1-9fda-b7f8f0597fb6', 'd23d5a1d-2904-44be-bc7f-91d6a408c082', '14');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `USER_ID` varchar(36) NOT NULL DEFAULT '',
  `USER_NAME` varchar(50) DEFAULT NULL COMMENT '用户名',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER_ID` varchar(36) DEFAULT NULL,
  `CREATE_USER_NAME` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `UPDATE_TIME` timestamp NULL DEFAULT NULL COMMENT '修改人',
  `UPDATE_USER_ID` varchar(36) DEFAULT NULL,
  `UPDATE_USER_NAME` varchar(50) DEFAULT NULL COMMENT '修改人名称',
  `LOGIN_NAME` varchar(100) DEFAULT NULL COMMENT '登录名',
  `LOGIN_PASSWORD` varchar(100) DEFAULT NULL COMMENT '登录密码',
  `USER_SEX` char(1) DEFAULT NULL COMMENT '性别（M：男；F：女）',
  `LOCKED` int(1) DEFAULT '0',
  `DEPARTMENT_ID` varchar(50) DEFAULT NULL,
  `DEPARTMENT_NAME` varchar(500) DEFAULT NULL,
  `REMARK` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  KEY `USER_ID_INDEX` (`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '2018-06-05 13:39:11', null, null, '2018-06-18 19:48:05', '1', 'admin', 'admin', '83976aece2b2d3ec1eb0caa78bbc43d7', 'M', '1', '88049f99-e0cb-4d26-bdda-fc42cf62254b', '部门1', 'qwe11');
INSERT INTO `sys_user` VALUES ('da7f709d-3c54-4313-8618-52c9c12f180d', 'test1', '2018-06-21 18:43:20', '1', 'admin', '2018-06-21 18:43:20', '1', 'admin', 'test1', '2a30c6dc1bb9f8fb74fb01e6f71fa945', 'F', '1', '2cef2f75-3972-4b0d-8dd4-2159c1b3ebeb', '部门1-1', '备注');
INSERT INTO `sys_user` VALUES ('ec54f852-dff7-4442-a3eb-e6ed2b731d8d', 'test2', '2018-06-21 19:40:09', '1', 'admin', '2018-06-21 19:40:09', '1', 'admin', 'test2', '5655a48199799eee4d3b6b949cb7d913', 'F', '1', '79f3c3eb-c40c-4cbf-a6b0-1fdedeeac0e8', '部门3', null);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `USER_ROLE_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(36) DEFAULT NULL,
  `ROLE_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`USER_ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('0214a245-9a83-4a14-ae1b-ed50b37f4ead', 'da7f709d-3c54-4313-8618-52c9c12f180d', '6f17c930-807f-4dbf-a030-aafb6a0caccc');
INSERT INTO `sys_user_role` VALUES ('256ef847-ac49-4ea7-98d5-777b0f2e1fe1', '11671d65-cc5b-48c2-adc5-29e0945a02c2', 'd23d5a1d-2904-44be-bc7f-91d6a408c082');
INSERT INTO `sys_user_role` VALUES ('29248bbd-d7b2-4193-b769-dadcaec41e12', '1', '49fa5763-b0f3-46cc-b7a3-d61e388d44eb');
INSERT INTO `sys_user_role` VALUES ('3585b244-e96e-4c40-af5e-aeac45025b24', 'ec54f852-dff7-4442-a3eb-e6ed2b731d8d', 'dca43f07-f3e0-48e4-bc41-80be955e7b7f');
INSERT INTO `sys_user_role` VALUES ('5622c7f0-1032-4c89-a738-f36bd4d02ab3', '1', '6f17c930-807f-4dbf-a030-aafb6a0caccc');
