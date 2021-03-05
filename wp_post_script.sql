 
CREATE TABLE `post_changes` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
  `stamp` char(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activity` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'changed',
  `post_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_edited` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci


###################TRIGGERS#########################

####################DELETE##########################

CREATE TRIGGER `after_wp_posts_delete` AFTER DELETE ON `wp_posts`
 FOR EACH ROW BEGIN
set @current_time=now();
INSERT IGNORE INTO data_changes.post_changes(stamp,post_id,activity,post_type,post_name,post_title,last_edited)
select
	concat( date_format(@current_time,'%Y%m%d%H'),IF(date_format(@current_time,'%i')>30, '30', '00')),
	OLD.id,'changed','post',OLD.post_name,OLD.post_title,meta_value as last_edited
FROM wp_posts join wp_postmeta as pm on OLD.id = pm.post_id 
WHERE meta_key = '_edit_last' and id=OLD.id;
END


####################INSERT##########################

CREATE TRIGGER `after_wp_posts_insert` AFTER INSERT ON `wp_posts`
 FOR EACH ROW BEGIN
set @current_time=now();
INSERT IGNORE INTO data_changes.post_changes(stamp,post_id,activity,post_type,post_name,post_title,last_edited)
select 
concat( date_format(@current_time,'%Y%m%d%H'),IF(date_format(@current_time,'%i')>30, '30', '00')),
NEW.id,'changed', 'post',NEW.post_name,NEW.post_title,meta_value as last_edited
FROM wp_posts join wp_postmeta as pm on NEW.id = pm.post_id AND post_id = NEW.id
WHERE meta_key = '_edit_last' and id=NEW.id;
END


####################UPDATE##########################
CREATE TRIGGER `after_wp_posts_update` AFTER UPDATE ON `wp_posts`
 FOR EACH ROW Begin
set @current_time=now();
INSERT IGNORE INTO data_changes.post_changes(stamp,post_id,activity,post_type,post_name,post_title,last_edited)
select
concat( date_format(@current_time,'%Y%m%d%H'),IF(date_format(@current_time,'%i')>30, '30', '00')),
NEW.id,'changed', 'post',NEW.post_name,NEW.post_title,meta_value as last_edited
FROM wp_posts join wp_postmeta as pm on NEW.id = pm.post_id AND post_id = NEW.id
WHERE meta_key = '_edit_last' and id=NEW.id;

End
