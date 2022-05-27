/*
 Navicat Premium Data Transfer

 Source Server         : localhost_5432
 Source Server Type    : PostgreSQL
 Source Server Version : 110000
 Source Host           : localhost:5432
 Source Catalog        : n-truong
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 110000
 File Encoding         : 65001

 Date: 15/02/2022 09:29:31
*/


-- ----------------------------
-- Sequence structure for borrow_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."borrow_id_seq";
CREATE SEQUENCE "public"."borrow_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tbl_human_resources_human_rsc_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tbl_human_resources_human_rsc_id_seq";
CREATE SEQUENCE "public"."tbl_human_resources_human_rsc_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tbl_inventory_detail_inventory_detail_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tbl_inventory_detail_inventory_detail_id_seq";
CREATE SEQUENCE "public"."tbl_inventory_detail_inventory_detail_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tbl_inventory_inventory_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tbl_inventory_inventory_id_seq";
CREATE SEQUENCE "public"."tbl_inventory_inventory_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tbl_physical_asset_physical_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tbl_physical_asset_physical_id_seq";
CREATE SEQUENCE "public"."tbl_physical_asset_physical_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tbl_physical_group_physical_grp_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tbl_physical_group_physical_grp_id_seq";
CREATE SEQUENCE "public"."tbl_physical_group_physical_grp_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tbl_roles_role_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tbl_roles_role_id_seq";
CREATE SEQUENCE "public"."tbl_roles_role_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tbl_state_state_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tbl_state_state_id_seq";
CREATE SEQUENCE "public"."tbl_state_state_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tbl_status_status_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tbl_status_status_id_seq";
CREATE SEQUENCE "public"."tbl_status_status_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for tbl_asset
-- ----------------------------
DROP TABLE IF EXISTS "public"."tbl_asset";
CREATE TABLE "public"."tbl_asset" (
  "asset_id" int4 NOT NULL DEFAULT nextval('tbl_physical_asset_physical_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "code" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "configuration" varchar(255) COLLATE "pg_catalog"."default",
  "status" int4 NOT NULL,
  "asset_group_id" int4 NOT NULL,
  "is_disabled" int4 NOT NULL DEFAULT 0,
  "status_percent" int4,
  "state" int4 NOT NULL,
  "deleted_at" varchar(255) COLLATE "pg_catalog"."default",
  "image" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of tbl_asset
-- ----------------------------
INSERT INTO "public"."tbl_asset" VALUES (114, '2131', '3213', '321', 2, 121, 0, NULL, 2, NULL, 'avt1.png');
INSERT INTO "public"."tbl_asset" VALUES (113, 'dưq', 'dưqdwqd123edw1d13', 'dưqdwq', 1, 152, 0, NULL, 1, NULL, '341356_img2501.jpg');
INSERT INTO "public"."tbl_asset" VALUES (112, 'DienThoai', 'dien1e421d1', 'dưqdwq', 2, 151, 0, NULL, 1, NULL, 'laptop_PNG5905.png');
INSERT INTO "public"."tbl_asset" VALUES (98, 'Màn hình LG1', '123', 'LG', 2, 106, 1, NULL, 2, '2022-02-09 14:52:38', 'laptop_PNG5905.png');
INSERT INTO "public"."tbl_asset" VALUES (102, 'e21e11e111e1', 'e21e21e1e231312321', '1e1e1', 1, 106, 1, NULL, 2, '2022-02-10 09:05:37', 'laptop_PNG5905.png');
INSERT INTO "public"."tbl_asset" VALUES (109, 'dưqd', '123213', 'e21d', 1, 107, 1, NULL, 2, '2022-02-10 09:05:37', 'OIP.jpg');
INSERT INTO "public"."tbl_asset" VALUES (111, 'DienThoai', 'dienthoai123', 'dienthoai123cauhinh', 1, 151, 1, NULL, 2, '2022-02-10 09:38:06', 'laptop_PNG5905.png');
INSERT INTO "public"."tbl_asset" VALUES (101, 'dưqddưqdwqdq', 'd21d2', '213214', 1, 90, 1, NULL, 2, '2022-02-10 09:42:08', 'R.jpg');
INSERT INTO "public"."tbl_asset" VALUES (100, 'd21d2', 'd21d21', '', 1, 106, 1, NULL, 2, '2022-02-10 09:42:08', 'laptop_PNG5905.png');
INSERT INTO "public"."tbl_asset" VALUES (99, 'Chai nước', 'cn1', 'máy tính xịn', 2, 90, 1, NULL, 2, '2022-02-10 09:42:08', 'pixel-image-1-15711948680921149315497.jpg');
INSERT INTO "public"."tbl_asset" VALUES (108, 'Ghế xoay', 'ghe-xoay', 'ghế xoay xịn', 2, 151, 1, NULL, 1, '2022-02-10 09:42:08', 'R.jpg');
INSERT INTO "public"."tbl_asset" VALUES (104, 'Chuột rapoo', 'chuot123', 'Chuột rapoo', 2, 90, 1, NULL, 1, '2022-02-10 09:42:08', '341356_img2501.jpg');
INSERT INTO "public"."tbl_asset" VALUES (103, 'dưqd', '2d1d1', '', 1, 106, 1, NULL, 1, '2022-02-10 09:42:08', 'pixel-image-1-15711948680921149315497.jpg');
INSERT INTO "public"."tbl_asset" VALUES (105, 'Chuột rapoo', 'chuotne', '123', 1, 90, 1, NULL, 1, '2022-02-10 09:05:37', '341356_img2501.jpg');

-- ----------------------------
-- Table structure for tbl_asset_group
-- ----------------------------
DROP TABLE IF EXISTS "public"."tbl_asset_group";
CREATE TABLE "public"."tbl_asset_group" (
  "description" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "group_id" int4 NOT NULL DEFAULT nextval('tbl_physical_group_physical_grp_id_seq'::regclass),
  "active" int4 NOT NULL,
  "is_disabled" int4 NOT NULL DEFAULT 0,
  "deleted_at" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of tbl_asset_group
-- ----------------------------
INSERT INTO "public"."tbl_asset_group" VALUES ('đưq', 124, 1, 0, '2022-02-10 08:23:59');
INSERT INTO "public"."tbl_asset_group" VALUES ('124111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111', 149, 1, 1, '2022-02-10 14:19:03');
INSERT INTO "public"."tbl_asset_group" VALUES ('4134', 148, 1, 1, '2022-02-10 14:19:03');
INSERT INTO "public"."tbl_asset_group" VALUES ('521', 147, 1, 1, '2022-02-10 14:19:03');
INSERT INTO "public"."tbl_asset_group" VALUES ('12341', 146, 1, 1, '2022-02-10 14:19:03');
INSERT INTO "public"."tbl_asset_group" VALUES ('123', 145, 1, 1, '2022-02-10 14:19:03');
INSERT INTO "public"."tbl_asset_group" VALUES ('d21d1', 144, 1, 1, '2022-02-10 14:19:03');
INSERT INTO "public"."tbl_asset_group" VALUES ('dưqdwq', 128, 1, 1, '2022-02-10 14:19:03');
INSERT INTO "public"."tbl_asset_group" VALUES ('dqwdwq', 127, 1, 1, '2022-02-10 14:19:03');
INSERT INTO "public"."tbl_asset_group" VALUES ('feqfq', 126, 1, 1, '2022-02-10 14:19:03');
INSERT INTO "public"."tbl_asset_group" VALUES ('dfqfe', 125, 1, 1, '2022-02-10 14:19:03');
INSERT INTO "public"."tbl_asset_group" VALUES ('123421412', 158, 1, 0, NULL);
INSERT INTO "public"."tbl_asset_group" VALUES ('dưqdq1', 123, 1, 1, '2022-02-10 08:23:59');
INSERT INTO "public"."tbl_asset_group" VALUES ('Tủ đồ', 120, 1, 1, '2022-02-10 08:23:59');
INSERT INTO "public"."tbl_asset_group" VALUES ('r32r2', 119, 1, 1, '2022-02-10 08:23:59');
INSERT INTO "public"."tbl_asset_group" VALUES ('412', 118, 1, 1, '2022-02-10 08:23:59');
INSERT INTO "public"."tbl_asset_group" VALUES ('dqdq123141', 117, 1, 1, '2022-02-10 08:23:59');
INSERT INTO "public"."tbl_asset_group" VALUES ('Nhóm tài sản 4', 153, 0, 0, NULL);
INSERT INTO "public"."tbl_asset_group" VALUES ('dqdq3dqfqe', 143, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('dqwdqwd', 142, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('dưqdqw21312dwq', 141, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('d1d1', 140, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('12344', 139, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('412421', 138, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('132321421', 137, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('dqwdqw', 136, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('dưqdq3131312', 135, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('dưqdqw131', 134, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('dưqdqw1', 133, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('dưqdqw', 132, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('e2e213131', 131, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('e2e21', 130, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('dqdq1', 129, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('Bàn phím máy tính', 107, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('Laptop', 90, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('Màn hình máy tính', 89, 1, 1, '2022-02-10 08:54:10');
INSERT INTO "public"."tbl_asset_group" VALUES ('2131d21', 157, 1, 1, '2022-02-10 14:17:31');
INSERT INTO "public"."tbl_asset_group" VALUES ('dưqdq2131d2', 156, 1, 1, '2022-02-10 14:17:37');
INSERT INTO "public"."tbl_asset_group" VALUES ('12321d21', 155, 1, 1, '2022-02-10 14:17:37');
INSERT INTO "public"."tbl_asset_group" VALUES ('fwfq', 154, 1, 1, '2022-02-10 14:17:37');
INSERT INTO "public"."tbl_asset_group" VALUES ('Nhóm tài sản 3', 152, 1, 1, '2022-02-10 14:17:37');
INSERT INTO "public"."tbl_asset_group" VALUES ('Nhóm tài sản 2', 151, 1, 1, '2022-02-10 14:17:37');
INSERT INTO "public"."tbl_asset_group" VALUES ('Nhóm tài sản 1', 150, 1, 1, '2022-02-10 14:17:37');
INSERT INTO "public"."tbl_asset_group" VALUES ('1', 96, 1, 0, '2022-01-26 14:17:33');
INSERT INTO "public"."tbl_asset_group" VALUES ('dqdq', 95, 1, 0, '2022-01-26 14:17:33');
INSERT INTO "public"."tbl_asset_group" VALUES ('dqdq', 94, 1, 0, '2022-01-26 14:17:33');
INSERT INTO "public"."tbl_asset_group" VALUES ('Laptop1', 104, 1, 0, '2022-01-26 15:46:07');
INSERT INTO "public"."tbl_asset_group" VALUES ('Màn hình mát tính', 105, 1, 0, '2022-01-26 15:47:21');
INSERT INTO "public"."tbl_asset_group" VALUES ('213121', 106, 1, 0, '2022-02-07 14:28:50');
INSERT INTO "public"."tbl_asset_group" VALUES ('321321421', 115, 1, 0, '2022-02-07 14:59:00');
INSERT INTO "public"."tbl_asset_group" VALUES ('234', 114, 1, 0, '2022-02-07 14:59:00');
INSERT INTO "public"."tbl_asset_group" VALUES ('32423', 113, 1, 0, '2022-02-07 14:59:00');
INSERT INTO "public"."tbl_asset_group" VALUES ('r32r32f23f', 112, 1, 0, '2022-02-07 14:59:00');
INSERT INTO "public"."tbl_asset_group" VALUES ('f32f2323523', 111, 1, 0, '2022-02-07 14:59:00');
INSERT INTO "public"."tbl_asset_group" VALUES ('f3f3f32', 110, 1, 0, '2022-02-07 14:59:00');
INSERT INTO "public"."tbl_asset_group" VALUES ('32rf32f2', 109, 1, 0, '2022-02-07 14:59:00');
INSERT INTO "public"."tbl_asset_group" VALUES ('dưqdq', 108, 1, 0, '2022-02-07 14:59:00');
INSERT INTO "public"."tbl_asset_group" VALUES ('dqdq1231', 116, 1, 0, '2022-02-09 11:06:07');
INSERT INTO "public"."tbl_asset_group" VALUES ('fefeưeq', 122, 1, 0, '2022-02-10 08:12:17');
INSERT INTO "public"."tbl_asset_group" VALUES ('fefe', 121, 1, 0, '2022-02-10 08:12:17');

-- ----------------------------
-- Table structure for tbl_borrow
-- ----------------------------
DROP TABLE IF EXISTS "public"."tbl_borrow";
CREATE TABLE "public"."tbl_borrow" (
  "borrow_id" int4 NOT NULL DEFAULT nextval('borrow_id_seq'::regclass),
  "asset_id" int4 NOT NULL,
  "user_id" int4 NOT NULL,
  "borrow_date" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "return_date" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of tbl_borrow
-- ----------------------------
INSERT INTO "public"."tbl_borrow" VALUES (2, 103, 44, '2022-02-09', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (3, 103, 44, '09-02-2022', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (4, 103, 44, '09-02-2022', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (5, 98, 44, '09-02-2022', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (6, 98, 44, '09-02-2022', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (7, 98, 44, '09-02-2022', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (8, 103, 45, '09-02-2022', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (9, 103, 11, '', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (10, 103, 45, '2022-02-07', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (15, 103, 11, '2022-02-14', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (16, 103, 11, '2022-03-11', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (17, 101, 44, '2022-02-17', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (20, 105, 4, '2022-03-01', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (19, 98, 45, '2022-06-23', '2022-02-09');
INSERT INTO "public"."tbl_borrow" VALUES (18, 98, 45, '2022-02-16', '2022-02-09');
INSERT INTO "public"."tbl_borrow" VALUES (21, 98, 5, '2022-02-22', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (22, 98, 3, '2022-02-20', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (23, 108, 4, '2022-02-15', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (24, 100, 5, '2022-02-22', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (25, 104, 4, '2022-02-21', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (26, 104, 4, '2022-02-14', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (27, 108, 44, '2022-02-18', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (28, 108, 44, '2022-02-18', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (29, 108, 44, '2022-02-18', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (30, 108, 44, '2022-02-18', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (31, 103, 44, '2022-02-15', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (33, 113, 44, '2022-02-15', '');
INSERT INTO "public"."tbl_borrow" VALUES (34, 113, 44, '2022-02-15', '2022-02-10');
INSERT INTO "public"."tbl_borrow" VALUES (32, 112, 44, '2022-02-07', '2022-02-10');
INSERT INTO "public"."tbl_borrow" VALUES (35, 113, 45, '2022-02-02', '2022-02-10');
INSERT INTO "public"."tbl_borrow" VALUES (36, 112, 5, '2022-02-09', '2022-02-10');
INSERT INTO "public"."tbl_borrow" VALUES (38, 112, 45, '2022-02-16', '2022-02-10');
INSERT INTO "public"."tbl_borrow" VALUES (37, 113, 45, '2022-02-17', '2022-02-10');
INSERT INTO "public"."tbl_borrow" VALUES (39, 113, 5, '2022-02-21', NULL);
INSERT INTO "public"."tbl_borrow" VALUES (40, 112, 50, '2022-02-23', NULL);

-- ----------------------------
-- Table structure for tbl_inventory
-- ----------------------------
DROP TABLE IF EXISTS "public"."tbl_inventory";
CREATE TABLE "public"."tbl_inventory" (
  "inventory_id" int4 NOT NULL DEFAULT nextval('tbl_inventory_inventory_id_seq'::regclass),
  "inventory_person_id" int4 NOT NULL,
  "inventory_date" date NOT NULL,
  "inventory_detail_id" int4 NOT NULL
)
;

-- ----------------------------
-- Records of tbl_inventory
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_inventory_detail
-- ----------------------------
DROP TABLE IF EXISTS "public"."tbl_inventory_detail";
CREATE TABLE "public"."tbl_inventory_detail" (
  "inventory_detail_id" int4 NOT NULL DEFAULT nextval('tbl_inventory_detail_inventory_detail_id_seq'::regclass),
  "asset_id" int4 NOT NULL,
  "before_status" int4,
  "before_percent" int4,
  "inventory_status" int4,
  "inventory_percent" int4
)
;

-- ----------------------------
-- Records of tbl_inventory_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_roles
-- ----------------------------
DROP TABLE IF EXISTS "public"."tbl_roles";
CREATE TABLE "public"."tbl_roles" (
  "role_id" int4 NOT NULL DEFAULT nextval('tbl_roles_role_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "is_disabled" int4 NOT NULL DEFAULT 0,
  "deleted_at" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of tbl_roles
-- ----------------------------
INSERT INTO "public"."tbl_roles" VALUES (2, 'Người quản lý', 0, NULL);
INSERT INTO "public"."tbl_roles" VALUES (3, 'Nhân viên', 0, NULL);

-- ----------------------------
-- Table structure for tbl_state
-- ----------------------------
DROP TABLE IF EXISTS "public"."tbl_state";
CREATE TABLE "public"."tbl_state" (
  "state_id" int4 NOT NULL DEFAULT nextval('tbl_state_state_id_seq'::regclass),
  "state_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "is_delete" int4
)
;

-- ----------------------------
-- Records of tbl_state
-- ----------------------------
INSERT INTO "public"."tbl_state" VALUES (1, 'Đang sử dụng', 0);
INSERT INTO "public"."tbl_state" VALUES (2, 'Rảnh', 0);

-- ----------------------------
-- Table structure for tbl_status
-- ----------------------------
DROP TABLE IF EXISTS "public"."tbl_status";
CREATE TABLE "public"."tbl_status" (
  "status_id" int8 NOT NULL DEFAULT nextval('tbl_status_status_id_seq'::regclass),
  "status_name" varchar(255) COLLATE "pg_catalog"."default",
  "is_delete" int4 DEFAULT 0
)
;

-- ----------------------------
-- Records of tbl_status
-- ----------------------------
INSERT INTO "public"."tbl_status" VALUES (1, 'Nguyên vẹn', 0);
INSERT INTO "public"."tbl_status" VALUES (2, 'Hư hỏng', 0);
INSERT INTO "public"."tbl_status" VALUES (3, 'Mất mát', 0);

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."tbl_user";
CREATE TABLE "public"."tbl_user" (
  "user_id" int4 NOT NULL DEFAULT nextval('tbl_human_resources_human_rsc_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "phone" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "is_disabled" int4 NOT NULL DEFAULT 0,
  "deleted_at" varchar(255) COLLATE "pg_catalog"."default",
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "role_id" int4 NOT NULL,
  "image" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO "public"."tbl_user" VALUES (1, 'trường', '0704804311', 'hoangtruong1808@gmail.com', 0, '2022-02-07 16:55:16', '123', 1, NULL);
INSERT INTO "public"."tbl_user" VALUES (47, 'Nguyễn Hoàng Trường', '0133336781', 'abc123@gmail.com', 0, NULL, '25f9e794323b453885f5181f1b624d0b', 3, '8-1626444967.jpg');
INSERT INTO "public"."tbl_user" VALUES (49, 'admin', '1234567', 'admin@gmail.com', 0, NULL, '21232f297a57a5a743894a0e4a801fc3', 3, 'ghe-xoay.jpg');
INSERT INTO "public"."tbl_user" VALUES (50, '321d1d1d1', '0704311311', '17521184@gm.uit.edu.vn', 0, NULL, '202cb962ac59075b964b07152d234b70', 3, 'avt1.png');
INSERT INTO "public"."tbl_user" VALUES (4, 'Tín', '012345678', 'hoantruongne123', 0, '2022-02-07 16:55:16', '123', 2, NULL);
INSERT INTO "public"."tbl_user" VALUES (3, 'Tuấn', '012345678', 'hoantruongne123', 0, '2022-02-07 16:55:16', '123', 2, NULL);
INSERT INTO "public"."tbl_user" VALUES (2, 'Toàn', '012345678', 'hoantruongne123', 0, '2022-02-07 16:55:16', '123', 2, NULL);
INSERT INTO "public"."tbl_user" VALUES (11, 'Hoàng Trường', '07048041311', 'hoangtruong11808@gmail.com', 1, '2022-02-09 13:27:21', '123456', 2, 'laptop_PNG5905.png');
INSERT INTO "public"."tbl_user" VALUES (9, 'Hoàng Trường', '0704804311', 'hoangtruong1808@gmail.com', 1, '2022-02-09 13:27:33', '123', 3, 'laptop_PNG5905.png');
INSERT INTO "public"."tbl_user" VALUES (44, 'Hoàng T1rường', '07048043131', 'hoangtruon3333g1808@gmail.com', 0, '2022-02-10 09:52:10', '123123', 3, 'avt.png');
INSERT INTO "public"."tbl_user" VALUES (5, 'Tùng', '0123456781', 'hoantruongne123@uit.edu.vn', 0, '2022-02-07 16:55:16', '123', 2, 'R.jpg');
INSERT INTO "public"."tbl_user" VALUES (45, 'Tuấn', '01231231211', 'tuan1234531@gmail.com', 0, NULL, '900150983CD24FB0D6963F7D28E17F72', 3, 'avt1.png');
INSERT INTO "public"."tbl_user" VALUES (46, 'Nguyễn Hoàng Trường', '0704311111', '17521185@gm.uit.edu.vn', 0, NULL, '81dc9bdb52d04dc20036dbd8313ed055', 2, 'OIP.jpg');
INSERT INTO "public"."tbl_user" VALUES (48, 'Cái ly', '32142152151', 'abcd@gmail.com', 0, NULL, '202cb962ac59075b964b07152d234b70', 3, 'R.jpg');

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."borrow_id_seq"
OWNED BY "public"."tbl_borrow"."borrow_id";
SELECT setval('"public"."borrow_id_seq"', 40, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."tbl_human_resources_human_rsc_id_seq"
OWNED BY "public"."tbl_user"."user_id";
SELECT setval('"public"."tbl_human_resources_human_rsc_id_seq"', 50, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."tbl_inventory_detail_inventory_detail_id_seq"
OWNED BY "public"."tbl_inventory_detail"."inventory_detail_id";
SELECT setval('"public"."tbl_inventory_detail_inventory_detail_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."tbl_inventory_inventory_id_seq"
OWNED BY "public"."tbl_inventory"."inventory_id";
SELECT setval('"public"."tbl_inventory_inventory_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."tbl_physical_asset_physical_id_seq"
OWNED BY "public"."tbl_asset"."asset_id";
SELECT setval('"public"."tbl_physical_asset_physical_id_seq"', 114, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."tbl_physical_group_physical_grp_id_seq"
OWNED BY "public"."tbl_asset_group"."group_id";
SELECT setval('"public"."tbl_physical_group_physical_grp_id_seq"', 158, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."tbl_roles_role_id_seq"
OWNED BY "public"."tbl_roles"."role_id";
SELECT setval('"public"."tbl_roles_role_id_seq"', 9, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."tbl_state_state_id_seq"
OWNED BY "public"."tbl_state"."state_id";
SELECT setval('"public"."tbl_state_state_id_seq"', 4, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."tbl_status_status_id_seq"
OWNED BY "public"."tbl_status"."status_id";
SELECT setval('"public"."tbl_status_status_id_seq"', 3, true);

-- ----------------------------
-- Primary Key structure for table tbl_asset
-- ----------------------------
ALTER TABLE "public"."tbl_asset" ADD CONSTRAINT "tbl_physical_asset_pkey" PRIMARY KEY ("asset_id");

-- ----------------------------
-- Primary Key structure for table tbl_asset_group
-- ----------------------------
ALTER TABLE "public"."tbl_asset_group" ADD CONSTRAINT "tbl_physical_group_pkey" PRIMARY KEY ("group_id");

-- ----------------------------
-- Primary Key structure for table tbl_borrow
-- ----------------------------
ALTER TABLE "public"."tbl_borrow" ADD CONSTRAINT "tbl_borrow_physical_pkey" PRIMARY KEY ("borrow_id");

-- ----------------------------
-- Primary Key structure for table tbl_inventory
-- ----------------------------
ALTER TABLE "public"."tbl_inventory" ADD CONSTRAINT "tbl_inventory_pkey" PRIMARY KEY ("inventory_id");

-- ----------------------------
-- Primary Key structure for table tbl_inventory_detail
-- ----------------------------
ALTER TABLE "public"."tbl_inventory_detail" ADD CONSTRAINT "tbl_inventory_detail_pkey" PRIMARY KEY ("inventory_detail_id");

-- ----------------------------
-- Primary Key structure for table tbl_roles
-- ----------------------------
ALTER TABLE "public"."tbl_roles" ADD CONSTRAINT "tbl_roles_pkey" PRIMARY KEY ("role_id");

-- ----------------------------
-- Primary Key structure for table tbl_state
-- ----------------------------
ALTER TABLE "public"."tbl_state" ADD CONSTRAINT "tbl_state_pkey" PRIMARY KEY ("state_id");

-- ----------------------------
-- Primary Key structure for table tbl_status
-- ----------------------------
ALTER TABLE "public"."tbl_status" ADD CONSTRAINT "tbl_status_pkey" PRIMARY KEY ("status_id");

-- ----------------------------
-- Primary Key structure for table tbl_user
-- ----------------------------
ALTER TABLE "public"."tbl_user" ADD CONSTRAINT "tbl_human_resources_pkey" PRIMARY KEY ("user_id");

-- ----------------------------
-- Foreign Keys structure for table tbl_asset
-- ----------------------------
ALTER TABLE "public"."tbl_asset" ADD CONSTRAINT "tbl_asset_asset_group_id_fkey" FOREIGN KEY ("asset_group_id") REFERENCES "public"."tbl_asset_group" ("group_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."tbl_asset" ADD CONSTRAINT "tbl_asset_state_fkey" FOREIGN KEY ("state") REFERENCES "public"."tbl_state" ("state_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."tbl_asset" ADD CONSTRAINT "tbl_asset_status_fkey" FOREIGN KEY ("status") REFERENCES "public"."tbl_status" ("status_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table tbl_borrow
-- ----------------------------
ALTER TABLE "public"."tbl_borrow" ADD CONSTRAINT "tbl_borrow_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."tbl_asset" ("asset_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."tbl_borrow" ADD CONSTRAINT "tbl_borrow_person_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."tbl_user" ("user_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table tbl_inventory
-- ----------------------------
ALTER TABLE "public"."tbl_inventory" ADD CONSTRAINT "tbl_inventory_inventory_detail_id_fkey" FOREIGN KEY ("inventory_detail_id") REFERENCES "public"."tbl_inventory_detail" ("inventory_detail_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."tbl_inventory" ADD CONSTRAINT "tbl_inventory_inventory_person_id_fkey" FOREIGN KEY ("inventory_person_id") REFERENCES "public"."tbl_user" ("user_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table tbl_inventory_detail
-- ----------------------------
ALTER TABLE "public"."tbl_inventory_detail" ADD CONSTRAINT "tbl_inventory_detail_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."tbl_asset" ("asset_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
