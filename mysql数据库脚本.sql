-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `userPhoto` varchar(60)  NOT NULL COMMENT '用户照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(50)  NOT NULL COMMENT '邮箱',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_incomeType` (
  `typeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `typeName` varchar(20)  NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_income` (
  `incomeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '收入id',
  `incomeTypeObj` int(11) NOT NULL COMMENT '收入类型',
  `incomeFrom` varchar(50)  NOT NULL COMMENT '收入来源',
  `payWayObj` int(11) NOT NULL COMMENT '支付方式',
  `payAccount` varchar(20)  NOT NULL COMMENT '支付账号',
  `incomeMoney` float NOT NULL COMMENT '收入金额',
  `incomeDate` varchar(20)  NULL COMMENT '收入日期',
  `userObj` varchar(30)  NOT NULL COMMENT '收入用户',
  `incomeMemo` varchar(800)  NULL COMMENT '收入备注',
  PRIMARY KEY (`incomeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_expendType` (
  `expendTypeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '支出类型id',
  `expendTypeName` varchar(20)  NOT NULL COMMENT '支出类型名称',
  PRIMARY KEY (`expendTypeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_expend` (
  `expendId` int(11) NOT NULL AUTO_INCREMENT COMMENT '支出id',
  `exprendTypeObj` int(11) NOT NULL COMMENT '支出类型',
  `expendPurpose` varchar(60)  NOT NULL COMMENT '支出用途',
  `payWayObj` int(11) NOT NULL COMMENT '支付方式',
  `payAccount` varchar(20)  NOT NULL COMMENT '支付账号',
  `expendMoney` float NOT NULL COMMENT '支付金额',
  `expendDate` varchar(20)  NULL COMMENT '支付日期',
  `userObj` varchar(30)  NOT NULL COMMENT '支出用户',
  `expendMemo` varchar(20)  NULL COMMENT '支出备注',
  PRIMARY KEY (`expendId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_payWay` (
  `payWayId` int(11) NOT NULL AUTO_INCREMENT COMMENT '支付方式id',
  `payWayName` varchar(20)  NOT NULL COMMENT '支付方式名称',
  PRIMARY KEY (`payWayId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80)  NOT NULL COMMENT '标题',
  `content` varchar(5000)  NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_income ADD CONSTRAINT FOREIGN KEY (incomeTypeObj) REFERENCES t_incomeType(typeId);
ALTER TABLE t_income ADD CONSTRAINT FOREIGN KEY (payWayObj) REFERENCES t_payWay(payWayId);
ALTER TABLE t_income ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_expend ADD CONSTRAINT FOREIGN KEY (exprendTypeObj) REFERENCES t_expendType(expendTypeId);
ALTER TABLE t_expend ADD CONSTRAINT FOREIGN KEY (payWayObj) REFERENCES t_payWay(payWayId);
ALTER TABLE t_expend ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


