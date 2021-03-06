

create table user(

	id bigint(20) unsigned not null primary key auto_increment,
	email varchar(100) not null unique comment '邮箱',
	password varchar(50) not null comment '密码',
	status int(1) default 0 comment '用户状态',
	register_time date not null comment '注册时间'
	

);

create table user_detail(
	id bigint(20) unsigned not null primary key auto_increment,
	user_id bigint(20) unsigned not null comment '用户id',
	username varchar(100) not null comment '用户展示名',
	gender int(1) default 0 comment '用户性别',
	url varchar(100)  comment '用户头像url',
	motto varchar(200) not null comment '用户格言，显示的一句话',
	stone_count int(11) default 0 comment '用户拥有的能量石数量',
	get_count int(1) default 0 comment '每天抽取卡片的数量',
	get_time date  comment '最后一次抽取卡片的时间'
);




create table card(
	id bigint(20) unsigned not null primary key auto_increment,
	user_id bigint(20) unsigned not null comment '用户id，这里存主要是为了让card直接能知道user,不再通过卡包去找',
	url varchar(100)  comment '卡片内容的图片url',
	title varchar(100) not null comment '卡片标题',
	content text not null comment '卡片正文',
	isprivate int(1) not null default 0 comment '公开或私密',
	city varchar(20) comment '发布时的定位城市',
	status int(1) default 0 comment '卡包状态',
	create_time date not null comment '创建时间'
);



create table package(
	id bigint(20) unsigned not null primary key auto_increment,
	user_id bigint(20) unsigned not null comment '用户id',
	url varchar(100)  comment '卡包封面URL',
	packagename varchar(100) not null comment '卡包名称',
	isprivate int(1) not null default 0 comment '是否为私密卡包',
	status int(1) default 0 comment '卡包状态',
	create_time date not null comment '创建时间'
);


create table package_card(
	id bigint(20) unsigned not null primary key auto_increment,
	card_id bigint(20) unsigned not null comment '卡片id',
	package_id bigint(20) unsigned not null comment '卡包id',
	category int(1) default 0 comment '收藏的还是自己建的'
);





create table theme(
	id bigint(20) unsigned not null primary key auto_increment,
	url varchar(100)  comment '卡包封面URL',
	bgurl varchar(100)  comment '卡包背景URL',
	packagename varchar(100) not null comment '卡包名称',
	status int(1) default 0 comment '卡包状态',
	create_time date not null comment '创建时间'
);



create table theme_card(
	id bigint(20) unsigned not null primary key auto_increment,
	card_id bigint(20) unsigned not null comment '卡片id',
	theme_id bigint(20) unsigned not null comment '主题卡包id'
);


create table follow(
	id bigint(20) unsigned not null primary key auto_increment,
	follower_id bigint(20) unsigned not null comment '关注人ID',
	followeder_id bigint(20) unsigned not null comment '被关注人ID',
	isfollowed int(1) default 0 comment '是否也被它关注，这个字段只要是用于查询好友列表时，不需要再次查找是否被关注，提高查询效率，有待商榷',
	follow_time date not null comment '关注时间'
);


create table message(
	id bigint(20) unsigned not null primary key auto_increment,
	sender_id bigint(20) unsigned not null comment '发送者id',
	receiver_id bigint(20) unsigned not null comment '接收者id',
	card_id bigint(20) unsigned not null default 0 comment '卡片id,如果是送能量石自动产生的推送信息，保存id，默认为0',
	content text not null comment '消息内容', 
	send_time date not null comment '发送时间',
	status int(1) default 0 comment '消息状态，是否删除'
);



create table stone_log(
	id bigint(20) unsigned not null primary key auto_increment,
	user_id bigint(20) unsigned not null comment '用户id',
	log varchar(100) not null comment '日志信息，例如：送给  xxx 2颗能量石，xxx需要标记高亮' ,
	log_time date not null comment '记录时间',
	stone_count int(11) default 0 comment '变动的能量石数',
	status int(1) default 0 comment '状态'
);



alter table user_detail add constraint FK_user_detail_user_id foreign key(user_id) REFERENCES user(id);

alter table card add constraint FK_card_user_id foreign key(user_id) REFERENCES user(id);

alter table package add constraint FK_package_user_id foreign key(user_id) REFERENCES user(id);

alter table package_card add constraint FK_package_card_user_id foreign key(card_id) REFERENCES card(id);
alter table package_card add constraint FK_package_card_package_id foreign key(package_id) REFERENCES package(id);


alter table theme_card add constraint FK_theme_card_card_id foreign key(card_id) REFERENCES card(id);
alter table theme_card add constraint FK_theme_card_theme_id foreign key(theme_id) REFERENCES theme(id);

alter table follow add constraint FK_follow_follower_id foreign key(follower_id) REFERENCES user(id);
alter table follow add constraint FK_follow_followeder_id foreign key(followeder_id) REFERENCES user(id);

alter table message add constraint FK_message_sender_id foreign key(sender_id) REFERENCES user(id);
alter table message add constraint FK_message_receiver_id foreign key(receiver_id) REFERENCES user(id);
alter table message add constraint FK_message_card_id foreign key(card_id) REFERENCES card(id);

alter table stone_log add constraint FK_stone_log_user_id foreign key(user_id) REFERENCES user(id);






