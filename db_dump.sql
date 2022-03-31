/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `admin_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `conditions` json DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_permissions_created_by_id_fk` (`created_by_id`),
  KEY `admin_permissions_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `admin_permissions_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `admin_permissions_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `admin_permissions_role_links` (
  `permission_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  KEY `admin_permissions_role_links_fk` (`permission_id`),
  KEY `admin_permissions_role_links_inv_fk` (`role_id`),
  CONSTRAINT `admin_permissions_role_links_fk` FOREIGN KEY (`permission_id`) REFERENCES `admin_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `admin_permissions_role_links_inv_fk` FOREIGN KEY (`role_id`) REFERENCES `admin_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `admin_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_roles_created_by_id_fk` (`created_by_id`),
  KEY `admin_roles_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `admin_roles_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `admin_roles_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `admin_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `registration_token` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  `prefered_language` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_users_created_by_id_fk` (`created_by_id`),
  KEY `admin_users_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `admin_users_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `admin_users_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `admin_users_roles_links` (
  `user_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  KEY `admin_users_roles_links_fk` (`user_id`),
  KEY `admin_users_roles_links_inv_fk` (`role_id`),
  CONSTRAINT `admin_users_roles_links_fk` FOREIGN KEY (`user_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `admin_users_roles_links_inv_fk` FOREIGN KEY (`role_id`) REFERENCES `admin_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `articles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `excerpt` longtext,
  `content` longtext,
  `featured` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `articles_slug_unique` (`slug`),
  KEY `articles_created_by_id_fk` (`created_by_id`),
  KEY `articles_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `articles_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `articles_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `blog_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `description` longtext,
  `slug` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_categories_slug_unique` (`slug`),
  KEY `blog_categories_created_by_id_fk` (`created_by_id`),
  KEY `blog_categories_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `blog_categories_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `blog_categories_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `blog_categories_articles_links` (
  `blog_category_id` int(10) unsigned DEFAULT NULL,
  `article_id` int(10) unsigned DEFAULT NULL,
  KEY `blog_categories_articles_links_fk` (`blog_category_id`),
  KEY `blog_categories_articles_links_inv_fk` (`article_id`),
  CONSTRAINT `blog_categories_articles_links_fk` FOREIGN KEY (`blog_category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_categories_articles_links_inv_fk` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `blog_categories_parent_category_links` (
  `blog_category_id` int(10) unsigned DEFAULT NULL,
  `inv_blog_category_id` int(10) unsigned DEFAULT NULL,
  KEY `blog_categories_parent_category_links_fk` (`blog_category_id`),
  KEY `blog_categories_parent_category_links_inv_fk` (`inv_blog_category_id`),
  CONSTRAINT `blog_categories_parent_category_links_fk` FOREIGN KEY (`blog_category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_categories_parent_category_links_inv_fk` FOREIGN KEY (`inv_blog_category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clients_created_by_id_fk` (`created_by_id`),
  KEY `clients_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `clients_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `clients_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `components_crud_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` longtext,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `components_crud_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `name` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `components_elements_contact_infos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `components_elements_contact_infos_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `components_elements_contact_infos_field_index` (`field`),
  KEY `components_elements_contact_infos_component_type_index` (`component_type`),
  KEY `components_elements_contact_infos_entity_fk` (`entity_id`),
  CONSTRAINT `components_elements_contact_infos_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `components_elements_contact_infos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `components_elements_menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `custom_link` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

CREATE TABLE `components_elements_menu_items_page_links` (
  `menu_item_id` int(10) unsigned DEFAULT NULL,
  `page_id` int(10) unsigned DEFAULT NULL,
  KEY `components_elements_menu_items_page_links_fk` (`menu_item_id`),
  KEY `components_elements_menu_items_page_links_inv_fk` (`page_id`),
  CONSTRAINT `components_elements_menu_items_page_links_fk` FOREIGN KEY (`menu_item_id`) REFERENCES `components_elements_menu_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `components_elements_menu_items_page_links_inv_fk` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `components_elements_menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `components_elements_menus_footer_menu_left_links` (
  `menus_id` int(10) unsigned DEFAULT NULL,
  `menu_id` int(10) unsigned DEFAULT NULL,
  KEY `components_elements_menus_footer_menu_left_links_fk` (`menus_id`),
  KEY `components_elements_menus_footer_menu_left_links_inv_fk` (`menu_id`),
  CONSTRAINT `components_elements_menus_footer_menu_left_links_fk` FOREIGN KEY (`menus_id`) REFERENCES `components_elements_menus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `components_elements_menus_footer_menu_left_links_inv_fk` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `components_elements_menus_footer_menu_right_links` (
  `menus_id` int(10) unsigned DEFAULT NULL,
  `menu_id` int(10) unsigned DEFAULT NULL,
  KEY `components_elements_menus_footer_menu_right_links_fk` (`menus_id`),
  KEY `components_elements_menus_footer_menu_right_links_inv_fk` (`menu_id`),
  CONSTRAINT `components_elements_menus_footer_menu_right_links_fk` FOREIGN KEY (`menus_id`) REFERENCES `components_elements_menus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `components_elements_menus_footer_menu_right_links_inv_fk` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `components_elements_menus_primary_menu_links` (
  `menus_id` int(10) unsigned DEFAULT NULL,
  `menu_id` int(10) unsigned DEFAULT NULL,
  KEY `components_elements_menus_primary_menu_links_fk` (`menus_id`),
  KEY `components_elements_menus_primary_menu_links_inv_fk` (`menu_id`),
  CONSTRAINT `components_elements_menus_primary_menu_links_fk` FOREIGN KEY (`menus_id`) REFERENCES `components_elements_menus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `components_elements_menus_primary_menu_links_inv_fk` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `components_elements_reviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rating` decimal(10,2) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `review` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `components_elements_sliders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `btn_text` varchar(255) DEFAULT NULL,
  `btn_link` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `components_elements_social_infos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `components_media_galleries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `components_media_logos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `components_mixed_seos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE `components_mixed_seos_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `components_mixed_seos_field_index` (`field`),
  KEY `components_mixed_seos_component_type_index` (`component_type`),
  KEY `components_mixed_seos_entity_fk` (`entity_id`),
  CONSTRAINT `components_mixed_seos_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `components_mixed_seos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

CREATE TABLE `components_models_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `components_models_portfolios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `components_models_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `components_models_testimonials` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `components_text_keywords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `contact_form_submits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `message` longtext,
  PRIMARY KEY (`id`),
  KEY `contact_form_submits_created_by_id_fk` (`created_by_id`),
  KEY `contact_form_submits_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `contact_form_submits_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `contact_form_submits_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

CREATE TABLE `files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `alternative_text` varchar(255) DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `formats` json DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `ext` varchar(255) DEFAULT NULL,
  `mime` varchar(255) DEFAULT NULL,
  `size` decimal(10,2) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `preview_url` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `provider_metadata` json DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `files_created_by_id_fk` (`created_by_id`),
  KEY `files_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `files_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `files_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `files_related_morphs` (
  `file_id` int(10) unsigned DEFAULT NULL,
  `related_id` int(10) unsigned DEFAULT NULL,
  `related_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT NULL,
  KEY `files_related_morphs_fk` (`file_id`),
  CONSTRAINT `files_related_morphs_fk` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `homepage_sliders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `homepage_sliders_created_by_id_fk` (`created_by_id`),
  KEY `homepage_sliders_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `homepage_sliders_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `homepage_sliders_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `homepage_sliders_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `homepage_sliders_field_index` (`field`),
  KEY `homepage_sliders_component_type_index` (`component_type`),
  KEY `homepage_sliders_entity_fk` (`entity_id`),
  CONSTRAINT `homepage_sliders_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `homepage_sliders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `i18n_locale` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i18n_locale_created_by_id_fk` (`created_by_id`),
  KEY `i18n_locale_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `i18n_locale_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `i18n_locale_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menus_created_by_id_fk` (`created_by_id`),
  KEY `menus_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `menus_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `menus_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `menus_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `menus_field_index` (`field`),
  KEY `menus_component_type_index` (`component_type`),
  KEY `menus_entity_fk` (`entity_id`),
  CONSTRAINT `menus_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `sub_title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `leaf_content` longtext,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `header_size` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`),
  KEY `pages_created_by_id_fk` (`created_by_id`),
  KEY `pages_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `pages_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `pages_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE `pages_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `pages_field_index` (`field`),
  KEY `pages_component_type_index` (`component_type`),
  KEY `pages_entity_fk` (`entity_id`),
  CONSTRAINT `pages_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

CREATE TABLE `portfolio_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` longtext,
  `slug` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `portfolio_categories_slug_unique` (`slug`),
  KEY `portfolio_categories_created_by_id_fk` (`created_by_id`),
  KEY `portfolio_categories_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `portfolio_categories_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `portfolio_categories_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `portfolios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `client` varchar(255) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `content` longtext,
  `description` longtext,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `embed_code` longtext,
  PRIMARY KEY (`id`),
  KEY `portfolios_created_by_id_fk` (`created_by_id`),
  KEY `portfolios_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `portfolios_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `portfolios_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `portfolios_category_links` (
  `portfolio_id` int(10) unsigned DEFAULT NULL,
  `portfolio_category_id` int(10) unsigned DEFAULT NULL,
  KEY `portfolios_category_links_fk` (`portfolio_id`),
  KEY `portfolios_category_links_inv_fk` (`portfolio_category_id`),
  CONSTRAINT `portfolios_category_links_fk` FOREIGN KEY (`portfolio_id`) REFERENCES `portfolios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `portfolios_category_links_inv_fk` FOREIGN KEY (`portfolio_category_id`) REFERENCES `portfolio_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `portfolios_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `portfolios_field_index` (`field`),
  KEY `portfolios_component_type_index` (`component_type`),
  KEY `portfolios_entity_fk` (`entity_id`),
  CONSTRAINT `portfolios_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `portfolios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `sub_title` varchar(255) DEFAULT NULL,
  `description` longtext,
  `featured` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `services_created_by_id_fk` (`created_by_id`),
  KEY `services_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `services_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `services_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE `services_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `services_field_index` (`field`),
  KEY `services_component_type_index` (`component_type`),
  KEY `services_entity_fk` (`entity_id`),
  CONSTRAINT `services_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

CREATE TABLE `site_infos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_name` varchar(255) DEFAULT NULL,
  `site_title` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site_infos_created_by_id_fk` (`created_by_id`),
  KEY `site_infos_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `site_infos_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `site_infos_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `site_infos_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `site_infos_field_index` (`field`),
  KEY `site_infos_component_type_index` (`component_type`),
  KEY `site_infos_entity_fk` (`entity_id`),
  CONSTRAINT `site_infos_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `site_infos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `strapi_api_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `access_key` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `strapi_api_tokens_created_by_id_fk` (`created_by_id`),
  KEY `strapi_api_tokens_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `strapi_api_tokens_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `strapi_api_tokens_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `strapi_core_store_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` longtext,
  `type` varchar(255) DEFAULT NULL,
  `environment` varchar(255) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `strapi_database_schema` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `schema` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `time` datetime DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `strapi_migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `strapi_webhooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` longtext,
  `headers` json DEFAULT NULL,
  `events` json DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `team_members` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `bio` longtext,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `team_members_created_by_id_fk` (`created_by_id`),
  KEY `team_members_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `team_members_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `team_members_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `team_members_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `team_members_field_index` (`field`),
  KEY `team_members_component_type_index` (`component_type`),
  KEY `team_members_entity_fk` (`entity_id`),
  CONSTRAINT `team_members_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `team_members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

CREATE TABLE `testimonials` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `testimonials_created_by_id_fk` (`created_by_id`),
  KEY `testimonials_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `testimonials_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `testimonials_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `testimonials_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `testimonials_field_index` (`field`),
  KEY `testimonials_component_type_index` (`component_type`),
  KEY `testimonials_entity_fk` (`entity_id`),
  CONSTRAINT `testimonials_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `testimonials` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `up_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `up_permissions_created_by_id_fk` (`created_by_id`),
  KEY `up_permissions_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `up_permissions_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `up_permissions_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `up_permissions_role_links` (
  `permission_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  KEY `up_permissions_role_links_fk` (`permission_id`),
  KEY `up_permissions_role_links_inv_fk` (`role_id`),
  CONSTRAINT `up_permissions_role_links_fk` FOREIGN KEY (`permission_id`) REFERENCES `up_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `up_permissions_role_links_inv_fk` FOREIGN KEY (`role_id`) REFERENCES `up_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `up_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `up_roles_created_by_id_fk` (`created_by_id`),
  KEY `up_roles_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `up_roles_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `up_roles_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `up_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed` tinyint(1) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `up_users_created_by_id_fk` (`created_by_id`),
  KEY `up_users_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `up_users_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `up_users_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `up_users_role_links` (
  `user_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  KEY `up_users_role_links_fk` (`user_id`),
  KEY `up_users_role_links_inv_fk` (`role_id`),
  CONSTRAINT `up_users_role_links_fk` FOREIGN KEY (`user_id`) REFERENCES `up_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `up_users_role_links_inv_fk` FOREIGN KEY (`role_id`) REFERENCES `up_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `admin_permissions` (`id`, `action`, `subject`, `properties`, `conditions`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 'plugin::upload.read', NULL, '{}', '[]', '2022-01-02 21:36:53.918000', '2022-01-02 21:36:53.918000', NULL, NULL);
INSERT INTO `admin_permissions` (`id`, `action`, `subject`, `properties`, `conditions`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(2, 'plugin::upload.assets.create', NULL, '{}', '[]', '2022-01-02 21:36:53.927000', '2022-01-02 21:36:53.927000', NULL, NULL);
INSERT INTO `admin_permissions` (`id`, `action`, `subject`, `properties`, `conditions`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(3, 'plugin::upload.assets.update', NULL, '{}', '[]', '2022-01-02 21:36:53.935000', '2022-01-02 21:36:53.935000', NULL, NULL);
INSERT INTO `admin_permissions` (`id`, `action`, `subject`, `properties`, `conditions`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(4, 'plugin::upload.assets.download', NULL, '{}', '[]', '2022-01-02 21:36:53.941000', '2022-01-02 21:36:53.941000', NULL, NULL),
(5, 'plugin::upload.assets.copy-link', NULL, '{}', '[]', '2022-01-02 21:36:53.950000', '2022-01-02 21:36:53.950000', NULL, NULL),
(6, 'plugin::upload.read', NULL, '{}', '[\"admin::is-creator\"]', '2022-01-02 21:36:53.959000', '2022-01-02 21:36:53.959000', NULL, NULL),
(7, 'plugin::upload.assets.create', NULL, '{}', '[]', '2022-01-02 21:36:53.966000', '2022-01-02 21:36:53.966000', NULL, NULL),
(8, 'plugin::upload.assets.update', NULL, '{}', '[\"admin::is-creator\"]', '2022-01-02 21:36:53.973000', '2022-01-02 21:36:53.973000', NULL, NULL),
(9, 'plugin::upload.assets.download', NULL, '{}', '[]', '2022-01-02 21:36:53.980000', '2022-01-02 21:36:53.980000', NULL, NULL),
(10, 'plugin::upload.assets.copy-link', NULL, '{}', '[]', '2022-01-02 21:36:53.987000', '2022-01-02 21:36:53.987000', NULL, NULL),
(11, 'plugin::content-manager.explorer.create', 'plugin::users-permissions.user', '{\"fields\": [\"username\", \"email\", \"provider\", \"password\", \"resetPasswordToken\", \"confirmationToken\", \"confirmed\", \"blocked\", \"role\"]}', '[]', '2022-01-02 21:36:54.041000', '2022-01-02 21:36:54.041000', NULL, NULL),
(12, 'plugin::content-manager.explorer.read', 'plugin::users-permissions.user', '{\"fields\": [\"username\", \"email\", \"provider\", \"password\", \"resetPasswordToken\", \"confirmationToken\", \"confirmed\", \"blocked\", \"role\"]}', '[]', '2022-01-02 21:36:54.048000', '2022-01-02 21:36:54.048000', NULL, NULL),
(13, 'plugin::content-manager.explorer.update', 'plugin::users-permissions.user', '{\"fields\": [\"username\", \"email\", \"provider\", \"password\", \"resetPasswordToken\", \"confirmationToken\", \"confirmed\", \"blocked\", \"role\"]}', '[]', '2022-01-02 21:36:54.053000', '2022-01-02 21:36:54.053000', NULL, NULL),
(14, 'plugin::content-manager.explorer.delete', 'plugin::users-permissions.user', '{}', '[]', '2022-01-02 21:36:54.060000', '2022-01-02 21:36:54.060000', NULL, NULL),
(15, 'plugin::content-manager.single-types.configure-view', NULL, '{}', '[]', '2022-01-02 21:36:54.068000', '2022-01-02 21:36:54.068000', NULL, NULL),
(16, 'plugin::content-manager.collection-types.configure-view', NULL, '{}', '[]', '2022-01-02 21:36:54.076000', '2022-01-02 21:36:54.076000', NULL, NULL),
(17, 'plugin::content-manager.components.configure-layout', NULL, '{}', '[]', '2022-01-02 21:36:54.084000', '2022-01-02 21:36:54.084000', NULL, NULL),
(18, 'plugin::content-type-builder.read', NULL, '{}', '[]', '2022-01-02 21:36:54.092000', '2022-01-02 21:36:54.092000', NULL, NULL),
(19, 'plugin::email.settings.read', NULL, '{}', '[]', '2022-01-02 21:36:54.100000', '2022-01-02 21:36:54.100000', NULL, NULL),
(20, 'plugin::upload.read', NULL, '{}', '[]', '2022-01-02 21:36:54.107000', '2022-01-02 21:36:54.107000', NULL, NULL),
(21, 'plugin::upload.assets.create', NULL, '{}', '[]', '2022-01-02 21:36:54.114000', '2022-01-02 21:36:54.114000', NULL, NULL),
(22, 'plugin::upload.assets.update', NULL, '{}', '[]', '2022-01-02 21:36:54.123000', '2022-01-02 21:36:54.123000', NULL, NULL),
(23, 'plugin::upload.assets.download', NULL, '{}', '[]', '2022-01-02 21:36:54.130000', '2022-01-02 21:36:54.130000', NULL, NULL),
(24, 'plugin::upload.assets.copy-link', NULL, '{}', '[]', '2022-01-02 21:36:54.139000', '2022-01-02 21:36:54.139000', NULL, NULL),
(25, 'plugin::upload.settings.read', NULL, '{}', '[]', '2022-01-02 21:36:54.145000', '2022-01-02 21:36:54.145000', NULL, NULL),
(26, 'plugin::users-permissions.roles.create', NULL, '{}', '[]', '2022-01-02 21:36:54.152000', '2022-01-02 21:36:54.152000', NULL, NULL),
(27, 'plugin::users-permissions.roles.read', NULL, '{}', '[]', '2022-01-02 21:36:54.156000', '2022-01-02 21:36:54.156000', NULL, NULL),
(28, 'plugin::users-permissions.roles.update', NULL, '{}', '[]', '2022-01-02 21:36:54.164000', '2022-01-02 21:36:54.164000', NULL, NULL),
(29, 'plugin::users-permissions.roles.delete', NULL, '{}', '[]', '2022-01-02 21:36:54.170000', '2022-01-02 21:36:54.170000', NULL, NULL),
(30, 'plugin::users-permissions.providers.read', NULL, '{}', '[]', '2022-01-02 21:36:54.176000', '2022-01-02 21:36:54.176000', NULL, NULL),
(31, 'plugin::users-permissions.providers.update', NULL, '{}', '[]', '2022-01-02 21:36:54.182000', '2022-01-02 21:36:54.182000', NULL, NULL),
(32, 'plugin::users-permissions.email-templates.read', NULL, '{}', '[]', '2022-01-02 21:36:54.188000', '2022-01-02 21:36:54.188000', NULL, NULL),
(33, 'plugin::users-permissions.email-templates.update', NULL, '{}', '[]', '2022-01-02 21:36:54.209000', '2022-01-02 21:36:54.209000', NULL, NULL),
(34, 'plugin::users-permissions.advanced-settings.read', NULL, '{}', '[]', '2022-01-02 21:36:54.225000', '2022-01-02 21:36:54.225000', NULL, NULL),
(35, 'plugin::users-permissions.advanced-settings.update', NULL, '{}', '[]', '2022-01-02 21:36:54.233000', '2022-01-02 21:36:54.233000', NULL, NULL),
(36, 'plugin::i18n.locale.create', NULL, '{}', '[]', '2022-01-02 21:36:54.239000', '2022-01-02 21:36:54.239000', NULL, NULL),
(37, 'plugin::i18n.locale.read', NULL, '{}', '[]', '2022-01-02 21:36:54.246000', '2022-01-02 21:36:54.246000', NULL, NULL),
(38, 'plugin::i18n.locale.update', NULL, '{}', '[]', '2022-01-02 21:36:54.251000', '2022-01-02 21:36:54.251000', NULL, NULL),
(39, 'plugin::i18n.locale.delete', NULL, '{}', '[]', '2022-01-02 21:36:54.257000', '2022-01-02 21:36:54.257000', NULL, NULL),
(40, 'admin::marketplace.read', NULL, '{}', '[]', '2022-01-02 21:36:54.262000', '2022-01-02 21:36:54.262000', NULL, NULL),
(41, 'admin::marketplace.plugins.install', NULL, '{}', '[]', '2022-01-02 21:36:54.269000', '2022-01-02 21:36:54.269000', NULL, NULL),
(42, 'admin::marketplace.plugins.uninstall', NULL, '{}', '[]', '2022-01-02 21:36:54.274000', '2022-01-02 21:36:54.274000', NULL, NULL),
(43, 'admin::webhooks.create', NULL, '{}', '[]', '2022-01-02 21:36:54.281000', '2022-01-02 21:36:54.281000', NULL, NULL),
(44, 'admin::webhooks.read', NULL, '{}', '[]', '2022-01-02 21:36:54.287000', '2022-01-02 21:36:54.287000', NULL, NULL),
(45, 'admin::webhooks.update', NULL, '{}', '[]', '2022-01-02 21:36:54.293000', '2022-01-02 21:36:54.293000', NULL, NULL),
(46, 'admin::webhooks.delete', NULL, '{}', '[]', '2022-01-02 21:36:54.300000', '2022-01-02 21:36:54.300000', NULL, NULL),
(47, 'admin::users.create', NULL, '{}', '[]', '2022-01-02 21:36:54.305000', '2022-01-02 21:36:54.305000', NULL, NULL),
(48, 'admin::users.read', NULL, '{}', '[]', '2022-01-02 21:36:54.312000', '2022-01-02 21:36:54.312000', NULL, NULL),
(49, 'admin::users.update', NULL, '{}', '[]', '2022-01-02 21:36:54.319000', '2022-01-02 21:36:54.319000', NULL, NULL),
(50, 'admin::users.delete', NULL, '{}', '[]', '2022-01-02 21:36:54.327000', '2022-01-02 21:36:54.327000', NULL, NULL),
(51, 'admin::roles.create', NULL, '{}', '[]', '2022-01-02 21:36:54.334000', '2022-01-02 21:36:54.334000', NULL, NULL),
(52, 'admin::roles.read', NULL, '{}', '[]', '2022-01-02 21:36:54.342000', '2022-01-02 21:36:54.342000', NULL, NULL),
(53, 'admin::roles.update', NULL, '{}', '[]', '2022-01-02 21:36:54.348000', '2022-01-02 21:36:54.348000', NULL, NULL),
(54, 'admin::roles.delete', NULL, '{}', '[]', '2022-01-02 21:36:54.355000', '2022-01-02 21:36:54.355000', NULL, NULL),
(55, 'admin::api-tokens.create', NULL, '{}', '[]', '2022-01-02 21:36:54.376000', '2022-01-02 21:36:54.376000', NULL, NULL),
(56, 'admin::api-tokens.read', NULL, '{}', '[]', '2022-01-02 21:36:54.384000', '2022-01-02 21:36:54.384000', NULL, NULL),
(57, 'admin::api-tokens.update', NULL, '{}', '[]', '2022-01-02 21:36:54.397000', '2022-01-02 21:36:54.397000', NULL, NULL),
(58, 'admin::api-tokens.delete', NULL, '{}', '[]', '2022-01-02 21:36:54.406000', '2022-01-02 21:36:54.406000', NULL, NULL),
(62, 'plugin::content-manager.explorer.delete', 'api::client.client', '{}', '[]', '2022-01-03 01:21:26.189000', '2022-01-03 01:21:26.189000', NULL, NULL),
(70, 'plugin::content-manager.explorer.delete', 'api::client.client', '{}', '[]', '2022-01-03 02:14:42.455000', '2022-01-03 02:14:42.455000', NULL, NULL),
(76, 'plugin::documentation.read', NULL, '{}', '[]', '2022-01-04 02:15:47.019000', '2022-01-04 02:15:47.019000', NULL, NULL),
(77, 'plugin::documentation.settings.update', NULL, '{}', '[]', '2022-01-04 02:15:47.061000', '2022-01-04 02:15:47.061000', NULL, NULL),
(78, 'plugin::documentation.settings.regenerate', NULL, '{}', '[]', '2022-01-04 02:15:47.069000', '2022-01-04 02:15:47.069000', NULL, NULL),
(79, 'plugin::documentation.settings.read', NULL, '{}', '[]', '2022-01-04 02:15:47.077000', '2022-01-04 02:15:47.077000', NULL, NULL),
(111, 'plugin::content-manager.explorer.delete', 'api::blog-category.blog-category', '{}', '[]', '2022-01-04 18:25:36.812000', '2022-01-04 18:25:36.812000', NULL, NULL),
(116, 'plugin::content-manager.explorer.delete', 'api::portfolio-category.portfolio-category', '{}', '[]', '2022-01-04 18:30:25.288000', '2022-01-04 18:30:25.288000', NULL, NULL),
(121, 'plugin::content-manager.explorer.delete', 'api::portfolio.portfolio', '{}', '[]', '2022-01-04 18:46:02.372000', '2022-01-04 18:46:02.372000', NULL, NULL),
(122, 'plugin::content-manager.explorer.publish', 'api::portfolio.portfolio', '{}', '[]', '2022-01-04 18:46:02.379000', '2022-01-04 18:46:02.379000', NULL, NULL),
(138, 'plugin::content-manager.explorer.create', 'api::portfolio.portfolio', '{\"fields\": [\"title\", \"image\", \"featured\", \"category\", \"client\", \"year\", \"content\", \"description\", \"gallery.images\", \"keywords.keyword\", \"embedCode\"]}', '[]', '2022-01-04 19:16:23.948000', '2022-01-04 19:16:23.948000', NULL, NULL),
(139, 'plugin::content-manager.explorer.read', 'api::portfolio.portfolio', '{\"fields\": [\"title\", \"image\", \"featured\", \"category\", \"client\", \"year\", \"content\", \"description\", \"gallery.images\", \"keywords.keyword\", \"embedCode\"]}', '[]', '2022-01-04 19:16:23.956000', '2022-01-04 19:16:23.956000', NULL, NULL),
(140, 'plugin::content-manager.explorer.update', 'api::portfolio.portfolio', '{\"fields\": [\"title\", \"image\", \"featured\", \"category\", \"client\", \"year\", \"content\", \"description\", \"gallery.images\", \"keywords.keyword\", \"embedCode\"]}', '[]', '2022-01-04 19:16:23.964000', '2022-01-04 19:16:23.964000', NULL, NULL),
(146, 'plugin::content-manager.explorer.create', 'api::homepage-slider.homepage-slider', '{\"fields\": [\"slides.image\", \"slides.title\", \"slides.subtitle\", \"slides.btnText\", \"slides.btnLink\", \"slides.status\", \"status\"]}', '[]', '2022-01-05 02:19:43.734000', '2022-01-05 02:19:43.734000', NULL, NULL),
(147, 'plugin::content-manager.explorer.read', 'api::homepage-slider.homepage-slider', '{\"fields\": [\"slides.image\", \"slides.title\", \"slides.subtitle\", \"slides.btnText\", \"slides.btnLink\", \"slides.status\", \"status\"]}', '[]', '2022-01-05 02:19:43.745000', '2022-01-05 02:19:43.745000', NULL, NULL),
(148, 'plugin::content-manager.explorer.update', 'api::homepage-slider.homepage-slider', '{\"fields\": [\"slides.image\", \"slides.title\", \"slides.subtitle\", \"slides.btnText\", \"slides.btnLink\", \"slides.status\", \"status\"]}', '[]', '2022-01-05 02:19:43.752000', '2022-01-05 02:19:43.752000', NULL, NULL),
(149, 'plugin::content-manager.explorer.delete', 'api::homepage-slider.homepage-slider', '{}', '[]', '2022-01-05 02:19:43.758000', '2022-01-05 02:19:43.758000', NULL, NULL),
(150, 'plugin::content-manager.explorer.publish', 'api::homepage-slider.homepage-slider', '{}', '[]', '2022-01-05 02:19:43.765000', '2022-01-05 02:19:43.765000', NULL, NULL),
(154, 'plugin::content-manager.explorer.delete', 'api::testimonial.testimonial', '{}', '[]', '2022-01-05 02:39:04.772000', '2022-01-05 02:39:04.772000', NULL, NULL),
(155, 'plugin::content-manager.explorer.create', 'api::testimonial.testimonial', '{\"fields\": [\"name\", \"designation\", \"avatar\", \"Review.rating\", \"Review.Type\", \"Review.review\", \"status\"]}', '[]', '2022-01-05 02:45:22.057000', '2022-01-05 02:45:22.057000', NULL, NULL),
(156, 'plugin::content-manager.explorer.read', 'api::testimonial.testimonial', '{\"fields\": [\"name\", \"designation\", \"avatar\", \"Review.rating\", \"Review.Type\", \"Review.review\", \"status\"]}', '[]', '2022-01-05 02:45:22.064000', '2022-01-05 02:45:22.064000', NULL, NULL),
(157, 'plugin::content-manager.explorer.update', 'api::testimonial.testimonial', '{\"fields\": [\"name\", \"designation\", \"avatar\", \"Review.rating\", \"Review.Type\", \"Review.review\", \"status\"]}', '[]', '2022-01-05 02:45:22.071000', '2022-01-05 02:45:22.071000', NULL, NULL),
(170, 'plugin::content-manager.explorer.delete', 'api::article.article', '{}', '[]', '2022-01-05 04:10:47.608000', '2022-01-05 04:10:47.608000', NULL, NULL),
(171, 'plugin::content-manager.explorer.publish', 'api::article.article', '{}', '[]', '2022-01-05 04:10:47.627000', '2022-01-05 04:10:47.627000', NULL, NULL),
(181, 'plugin::content-manager.explorer.delete', 'api::site-info.site-info', '{}', '[]', '2022-01-05 04:49:40.863000', '2022-01-05 04:49:40.863000', NULL, NULL),
(182, 'plugin::content-manager.explorer.publish', 'api::site-info.site-info', '{}', '[]', '2022-01-05 04:49:40.869000', '2022-01-05 04:49:40.869000', NULL, NULL),
(189, 'plugin::content-manager.explorer.delete', 'api::team-member.team-member', '{}', '[]', '2022-01-11 13:55:07.121000', '2022-01-11 13:55:07.121000', NULL, NULL),
(190, 'plugin::content-manager.explorer.publish', 'api::team-member.team-member', '{}', '[]', '2022-01-11 13:55:07.297000', '2022-01-11 13:55:07.297000', NULL, NULL),
(194, 'plugin::content-manager.explorer.delete', 'api::service.service', '{}', '[]', '2022-01-11 14:06:00.537000', '2022-01-11 14:06:00.537000', NULL, NULL),
(199, 'plugin::content-manager.explorer.publish', 'api::service.service', '{}', '[]', '2022-01-11 14:16:23.620000', '2022-01-11 14:16:23.620000', NULL, NULL),
(214, 'plugin::content-manager.explorer.delete', 'api::page.page', '{}', '[]', '2022-01-11 15:28:44.930000', '2022-01-11 15:28:44.930000', NULL, NULL),
(215, 'plugin::content-manager.explorer.publish', 'api::page.page', '{}', '[]', '2022-01-11 15:28:45.303000', '2022-01-11 15:28:45.303000', NULL, NULL),
(272, 'plugin::content-manager.explorer.create', 'api::menu.menu', '{\"fields\": [\"name\", \"items.title\", \"items.type\", \"items.page\", \"items.custom_link\", \"items.hover_image\", \"items.status\"]}', '[]', '2022-01-13 16:41:13.655000', '2022-01-13 16:41:13.655000', NULL, NULL),
(273, 'plugin::content-manager.explorer.read', 'api::menu.menu', '{\"fields\": [\"name\", \"items.title\", \"items.type\", \"items.page\", \"items.custom_link\", \"items.hover_image\", \"items.status\"]}', '[]', '2022-01-13 16:41:14.087000', '2022-01-13 16:41:14.087000', NULL, NULL),
(274, 'plugin::content-manager.explorer.update', 'api::menu.menu', '{\"fields\": [\"name\", \"items.title\", \"items.type\", \"items.page\", \"items.custom_link\", \"items.hover_image\", \"items.status\"]}', '[]', '2022-01-13 16:41:15.411000', '2022-01-13 16:41:15.411000', NULL, NULL),
(275, 'plugin::content-manager.explorer.delete', 'api::menu.menu', '{}', '[]', '2022-01-13 16:41:16.035000', '2022-01-13 16:41:16.035000', NULL, NULL),
(276, 'plugin::content-manager.explorer.publish', 'api::menu.menu', '{}', '[]', '2022-01-13 16:41:16.210000', '2022-01-13 16:41:16.210000', NULL, NULL),
(283, 'plugin::content-manager.explorer.create', 'api::article.article', '{\"fields\": [\"categories\", \"content\", \"excerpt\", \"featured\", \"featured_image\", \"slug\", \"status\", \"thumbnail\", \"title\"]}', '[\"admin::is-creator\"]', '2022-01-13 17:06:55.061000', '2022-01-13 17:06:55.061000', NULL, NULL),
(284, 'plugin::content-manager.explorer.read', 'api::article.article', '{\"fields\": [\"categories\", \"content\", \"excerpt\", \"featured\", \"featured_image\", \"slug\", \"status\", \"thumbnail\", \"title\"]}', '[\"admin::is-creator\"]', '2022-01-13 17:06:55.257000', '2022-01-13 17:06:55.257000', NULL, NULL),
(285, 'plugin::content-manager.explorer.update', 'api::article.article', '{\"fields\": [\"categories\", \"content\", \"excerpt\", \"featured\", \"featured_image\", \"slug\", \"status\", \"thumbnail\", \"title\"]}', '[\"admin::is-creator\"]', '2022-01-13 17:06:55.754000', '2022-01-13 17:06:55.754000', NULL, NULL),
(286, 'plugin::content-manager.explorer.delete', 'api::article.article', '{}', '[\"admin::is-creator\"]', '2022-01-13 17:06:55.929000', '2022-01-13 17:06:55.929000', NULL, NULL),
(290, 'plugin::content-manager.explorer.delete', 'api::blog-category.blog-category', '{}', '[\"admin::is-creator\"]', '2022-01-13 17:06:56.628000', '2022-01-13 17:06:56.628000', NULL, NULL),
(331, 'plugin::content-manager.explorer.create', 'api::article.article', '{\"fields\": [\"categories\", \"content\", \"excerpt\", \"featured\", \"featured_image\", \"slug\", \"status\", \"thumbnail\", \"title\"]}', '[]', '2022-01-13 11:19:36.951000', '2022-01-13 11:19:36.951000', NULL, NULL),
(332, 'plugin::content-manager.explorer.read', 'api::article.article', '{\"fields\": [\"categories\", \"content\", \"excerpt\", \"featured\", \"featured_image\", \"slug\", \"status\", \"thumbnail\", \"title\"]}', '[]', '2022-01-13 11:19:36.960000', '2022-01-13 11:19:36.960000', NULL, NULL),
(333, 'plugin::content-manager.explorer.update', 'api::article.article', '{\"fields\": [\"categories\", \"content\", \"excerpt\", \"featured\", \"featured_image\", \"slug\", \"status\", \"thumbnail\", \"title\"]}', '[]', '2022-01-13 11:19:36.969000', '2022-01-13 11:19:36.969000', NULL, NULL),
(334, 'plugin::content-manager.explorer.delete', 'api::article.article', '{}', '[]', '2022-01-13 11:19:36.978000', '2022-01-13 11:19:36.978000', NULL, NULL),
(335, 'plugin::content-manager.explorer.publish', 'api::article.article', '{}', '[]', '2022-01-13 11:19:36.987000', '2022-01-13 11:19:36.987000', NULL, NULL),
(339, 'plugin::content-manager.explorer.delete', 'api::blog-category.blog-category', '{}', '[]', '2022-01-13 11:19:37.023000', '2022-01-13 11:19:37.023000', NULL, NULL),
(340, 'plugin::content-manager.explorer.create', 'api::menu.menu', '{\"fields\": [\"items.custom_link\", \"items.hover_image\", \"items.page\", \"items.status\", \"items.title\", \"items.type\", \"name\"]}', '[]', '2022-01-13 11:19:37.032000', '2022-01-13 11:19:37.032000', NULL, NULL),
(341, 'plugin::content-manager.explorer.read', 'api::menu.menu', '{\"fields\": [\"items.custom_link\", \"items.hover_image\", \"items.page\", \"items.status\", \"items.title\", \"items.type\", \"name\"]}', '[]', '2022-01-13 11:19:37.042000', '2022-01-13 11:19:37.042000', NULL, NULL),
(342, 'plugin::content-manager.explorer.update', 'api::menu.menu', '{\"fields\": [\"items.custom_link\", \"items.hover_image\", \"items.page\", \"items.status\", \"items.title\", \"items.type\", \"name\"]}', '[]', '2022-01-13 11:19:37.051000', '2022-01-13 11:19:37.051000', NULL, NULL),
(343, 'plugin::content-manager.explorer.delete', 'api::menu.menu', '{}', '[]', '2022-01-13 11:19:37.061000', '2022-01-13 11:19:37.061000', NULL, NULL),
(344, 'plugin::content-manager.explorer.publish', 'api::menu.menu', '{}', '[]', '2022-01-13 11:19:37.070000', '2022-01-13 11:19:37.070000', NULL, NULL),
(345, 'plugin::content-manager.explorer.create', 'api::page.page', '{\"fields\": [\"SEO.meta_description\", \"SEO.meta_tags.keyword\", \"SEO.meta_title\", \"SEO.share_thumbnail\", \"blocks\", \"header_image\", \"header_size\", \"leaf_content\", \"slug\", \"status\", \"sub_title\", \"title\", \"type\"]}', '[]', '2022-01-13 11:19:37.080000', '2022-01-13 11:19:37.080000', NULL, NULL),
(346, 'plugin::content-manager.explorer.read', 'api::page.page', '{\"fields\": [\"SEO.meta_description\", \"SEO.meta_tags.keyword\", \"SEO.meta_title\", \"SEO.share_thumbnail\", \"blocks\", \"header_image\", \"header_size\", \"leaf_content\", \"slug\", \"status\", \"sub_title\", \"title\", \"type\"]}', '[]', '2022-01-13 11:19:37.092000', '2022-01-13 11:19:37.092000', NULL, NULL),
(347, 'plugin::content-manager.explorer.update', 'api::page.page', '{\"fields\": [\"SEO.meta_description\", \"SEO.meta_tags.keyword\", \"SEO.meta_title\", \"SEO.share_thumbnail\", \"blocks\", \"header_image\", \"header_size\", \"leaf_content\", \"slug\", \"status\", \"sub_title\", \"title\", \"type\"]}', '[]', '2022-01-13 11:19:37.102000', '2022-01-13 11:19:37.102000', NULL, NULL),
(348, 'plugin::content-manager.explorer.delete', 'api::page.page', '{}', '[]', '2022-01-13 11:19:37.121000', '2022-01-13 11:19:37.121000', NULL, NULL),
(349, 'plugin::content-manager.explorer.publish', 'api::page.page', '{}', '[]', '2022-01-13 11:19:37.131000', '2022-01-13 11:19:37.131000', NULL, NULL),
(350, 'plugin::content-manager.explorer.create', 'api::portfolio.portfolio', '{\"fields\": [\"category\", \"client\", \"content\", \"description\", \"embedCode\", \"featured\", \"gallery.images\", \"image\", \"keywords.keyword\", \"title\", \"year\"]}', '[]', '2022-01-13 11:19:37.140000', '2022-01-13 11:19:37.140000', NULL, NULL),
(351, 'plugin::content-manager.explorer.read', 'api::portfolio.portfolio', '{\"fields\": [\"category\", \"client\", \"content\", \"description\", \"embedCode\", \"featured\", \"gallery.images\", \"image\", \"keywords.keyword\", \"title\", \"year\"]}', '[]', '2022-01-13 11:19:37.148000', '2022-01-13 11:19:37.148000', NULL, NULL),
(352, 'plugin::content-manager.explorer.update', 'api::portfolio.portfolio', '{\"fields\": [\"category\", \"client\", \"content\", \"description\", \"embedCode\", \"featured\", \"gallery.images\", \"image\", \"keywords.keyword\", \"title\", \"year\"]}', '[]', '2022-01-13 11:19:37.157000', '2022-01-13 11:19:37.157000', NULL, NULL),
(353, 'plugin::content-manager.explorer.delete', 'api::portfolio.portfolio', '{}', '[]', '2022-01-13 11:19:37.166000', '2022-01-13 11:19:37.166000', NULL, NULL),
(354, 'plugin::content-manager.explorer.publish', 'api::portfolio.portfolio', '{}', '[]', '2022-01-13 11:19:37.175000', '2022-01-13 11:19:37.175000', NULL, NULL),
(355, 'plugin::content-manager.explorer.create', 'api::portfolio-category.portfolio-category', '{\"fields\": [\"description\", \"name\", \"slug\", \"status\"]}', '[]', '2022-01-13 11:19:37.183000', '2022-01-13 11:19:37.183000', NULL, NULL),
(356, 'plugin::content-manager.explorer.read', 'api::portfolio-category.portfolio-category', '{\"fields\": [\"description\", \"name\", \"slug\", \"status\"]}', '[]', '2022-01-13 11:19:37.192000', '2022-01-13 11:19:37.192000', NULL, NULL),
(357, 'plugin::content-manager.explorer.update', 'api::portfolio-category.portfolio-category', '{\"fields\": [\"description\", \"name\", \"slug\", \"status\"]}', '[]', '2022-01-13 11:19:37.201000', '2022-01-13 11:19:37.201000', NULL, NULL),
(358, 'plugin::content-manager.explorer.delete', 'api::portfolio-category.portfolio-category', '{}', '[]', '2022-01-13 11:19:37.210000', '2022-01-13 11:19:37.210000', NULL, NULL),
(363, 'plugin::content-manager.explorer.delete', 'api::service.service', '{}', '[]', '2022-01-13 11:19:37.255000', '2022-01-13 11:19:37.255000', NULL, NULL),
(364, 'plugin::content-manager.explorer.publish', 'api::service.service', '{}', '[]', '2022-01-13 11:19:37.264000', '2022-01-13 11:19:37.264000', NULL, NULL),
(368, 'plugin::content-manager.explorer.delete', 'api::team-member.team-member', '{}', '[]', '2022-01-13 11:19:37.298000', '2022-01-13 11:19:37.298000', NULL, NULL),
(369, 'plugin::content-manager.explorer.publish', 'api::team-member.team-member', '{}', '[]', '2022-01-13 11:19:37.308000', '2022-01-13 11:19:37.308000', NULL, NULL),
(370, 'plugin::content-manager.explorer.create', 'api::testimonial.testimonial', '{\"fields\": [\"Review.Type\", \"Review.rating\", \"Review.review\", \"avatar\", \"designation\", \"name\", \"status\"]}', '[]', '2022-01-13 11:19:37.316000', '2022-01-13 11:19:37.316000', NULL, NULL),
(371, 'plugin::content-manager.explorer.read', 'api::testimonial.testimonial', '{\"fields\": [\"Review.Type\", \"Review.rating\", \"Review.review\", \"avatar\", \"designation\", \"name\", \"status\"]}', '[]', '2022-01-13 11:19:37.324000', '2022-01-13 11:19:37.324000', NULL, NULL),
(372, 'plugin::content-manager.explorer.update', 'api::testimonial.testimonial', '{\"fields\": [\"Review.Type\", \"Review.rating\", \"Review.review\", \"avatar\", \"designation\", \"name\", \"status\"]}', '[]', '2022-01-13 11:19:37.333000', '2022-01-13 11:19:37.333000', NULL, NULL),
(373, 'plugin::content-manager.explorer.delete', 'api::testimonial.testimonial', '{}', '[]', '2022-01-13 11:19:37.343000', '2022-01-13 11:19:37.343000', NULL, NULL),
(386, 'plugin::content-manager.explorer.create', 'api::site-info.site-info', '{\"fields\": [\"site_name\", \"site_title\", \"meta_keywords.keyword\", \"site_logo.normal\", \"site_logo.light\", \"site_logo.dark\", \"site_logo.loader\", \"contact_info.email\", \"contact_info.phone\", \"contact_info.Address\", \"contact_info.socials.name\", \"contact_info.socials.link\", \"contact_info.socials.icon\", \"contact_info.socials.status\", \"menus.primary_menu\", \"menus.footer_menu_left\", \"menus.footer_menu_right\"]}', '[]', '2022-01-17 15:33:28.229000', '2022-01-17 15:33:28.229000', NULL, NULL),
(387, 'plugin::content-manager.explorer.read', 'api::site-info.site-info', '{\"fields\": [\"site_name\", \"site_title\", \"meta_keywords.keyword\", \"site_logo.normal\", \"site_logo.light\", \"site_logo.dark\", \"site_logo.loader\", \"contact_info.email\", \"contact_info.phone\", \"contact_info.Address\", \"contact_info.socials.name\", \"contact_info.socials.link\", \"contact_info.socials.icon\", \"contact_info.socials.status\", \"menus.primary_menu\", \"menus.footer_menu_left\", \"menus.footer_menu_right\"]}', '[]', '2022-01-17 15:33:28.402000', '2022-01-17 15:33:28.402000', NULL, NULL),
(388, 'plugin::content-manager.explorer.update', 'api::site-info.site-info', '{\"fields\": [\"site_name\", \"site_title\", \"meta_keywords.keyword\", \"site_logo.normal\", \"site_logo.light\", \"site_logo.dark\", \"site_logo.loader\", \"contact_info.email\", \"contact_info.phone\", \"contact_info.Address\", \"contact_info.socials.name\", \"contact_info.socials.link\", \"contact_info.socials.icon\", \"contact_info.socials.status\", \"menus.primary_menu\", \"menus.footer_menu_left\", \"menus.footer_menu_right\"]}', '[]', '2022-01-17 15:33:28.592000', '2022-01-17 15:33:28.592000', NULL, NULL),
(389, 'plugin::content-manager.explorer.create', 'api::client.client', '{\"fields\": [\"name\", \"logo\", \"website\", \"featured\", \"order\"]}', '[]', '2022-01-18 14:03:43.489000', '2022-01-18 14:03:43.489000', NULL, NULL),
(390, 'plugin::content-manager.explorer.read', 'api::client.client', '{\"fields\": [\"name\", \"logo\", \"website\", \"featured\", \"order\"]}', '[]', '2022-01-18 14:03:43.659000', '2022-01-18 14:03:43.659000', NULL, NULL),
(391, 'plugin::content-manager.explorer.update', 'api::client.client', '{\"fields\": [\"name\", \"logo\", \"website\", \"featured\", \"order\"]}', '[]', '2022-01-18 14:03:43.831000', '2022-01-18 14:03:43.831000', NULL, NULL),
(392, 'plugin::content-manager.explorer.create', 'api::team-member.team-member', '{\"fields\": [\"name\", \"designation\", \"photo\", \"bio\", \"links.name\", \"links.link\", \"links.icon\", \"links.status\", \"status\", \"order\"]}', '[]', '2022-01-19 01:12:44.896000', '2022-01-19 01:12:44.896000', NULL, NULL),
(393, 'plugin::content-manager.explorer.read', 'api::team-member.team-member', '{\"fields\": [\"name\", \"designation\", \"photo\", \"bio\", \"links.name\", \"links.link\", \"links.icon\", \"links.status\", \"status\", \"order\"]}', '[]', '2022-01-19 01:12:45.076000', '2022-01-19 01:12:45.076000', NULL, NULL),
(394, 'plugin::content-manager.explorer.update', 'api::team-member.team-member', '{\"fields\": [\"name\", \"designation\", \"photo\", \"bio\", \"links.name\", \"links.link\", \"links.icon\", \"links.status\", \"status\", \"order\"]}', '[]', '2022-01-19 01:12:45.278000', '2022-01-19 01:12:45.278000', NULL, NULL),
(395, 'plugin::content-manager.explorer.create', 'api::service.service', '{\"fields\": [\"title\", \"sub_title\", \"image\", \"keywords.keyword\", \"description\", \"featured\"]}', '[]', '2022-01-19 02:10:02.375000', '2022-01-19 02:10:02.375000', NULL, NULL),
(396, 'plugin::content-manager.explorer.read', 'api::service.service', '{\"fields\": [\"title\", \"sub_title\", \"image\", \"keywords.keyword\", \"description\", \"featured\"]}', '[]', '2022-01-19 02:10:02.538000', '2022-01-19 02:10:02.538000', NULL, NULL),
(397, 'plugin::content-manager.explorer.update', 'api::service.service', '{\"fields\": [\"title\", \"sub_title\", \"image\", \"keywords.keyword\", \"description\", \"featured\"]}', '[]', '2022-01-19 02:10:02.706000', '2022-01-19 02:10:02.706000', NULL, NULL),
(401, 'plugin::content-manager.explorer.create', 'api::article.article', '{\"fields\": [\"title\", \"slug\", \"excerpt\", \"featured_image\", \"thumbnail\", \"content\", \"categories\", \"featured\", \"status\"]}', '[]', '2022-01-19 04:11:23.185000', '2022-01-19 04:11:23.185000', NULL, NULL),
(402, 'plugin::content-manager.explorer.read', 'api::article.article', '{\"fields\": [\"title\", \"slug\", \"excerpt\", \"featured_image\", \"thumbnail\", \"content\", \"categories\", \"featured\", \"status\"]}', '[]', '2022-01-19 04:11:23.350000', '2022-01-19 04:11:23.350000', NULL, NULL),
(403, 'plugin::content-manager.explorer.update', 'api::article.article', '{\"fields\": [\"title\", \"slug\", \"excerpt\", \"featured_image\", \"thumbnail\", \"content\", \"categories\", \"featured\", \"status\"]}', '[]', '2022-01-19 04:11:23.511000', '2022-01-19 04:11:23.511000', NULL, NULL),
(419, 'plugin::content-manager.explorer.create', 'api::blog-category.blog-category', '{\"fields\": [\"articles\", \"description\", \"name\", \"parent_category\", \"slug\", \"status\"]}', '[]', '2022-01-22 09:38:30.314000', '2022-01-22 09:38:30.314000', NULL, NULL),
(420, 'plugin::content-manager.explorer.read', 'api::blog-category.blog-category', '{\"fields\": [\"articles\", \"description\", \"name\", \"parent_category\", \"slug\", \"status\"]}', '[]', '2022-01-22 09:38:30.322000', '2022-01-22 09:38:30.322000', NULL, NULL),
(421, 'plugin::content-manager.explorer.update', 'api::blog-category.blog-category', '{\"fields\": [\"articles\", \"description\", \"name\", \"parent_category\", \"slug\", \"status\"]}', '[]', '2022-01-22 09:38:30.335000', '2022-01-22 09:38:30.335000', NULL, NULL),
(422, 'plugin::content-manager.explorer.create', 'api::client.client', '{\"fields\": [\"featured\", \"logo\", \"name\", \"order\", \"website\"]}', '[]', '2022-01-22 09:38:30.345000', '2022-01-22 09:38:30.345000', NULL, NULL),
(423, 'plugin::content-manager.explorer.read', 'api::client.client', '{\"fields\": [\"featured\", \"logo\", \"name\", \"order\", \"website\"]}', '[]', '2022-01-22 09:38:30.352000', '2022-01-22 09:38:30.352000', NULL, NULL),
(424, 'plugin::content-manager.explorer.update', 'api::client.client', '{\"fields\": [\"featured\", \"logo\", \"name\", \"order\", \"website\"]}', '[]', '2022-01-22 09:38:30.362000', '2022-01-22 09:38:30.362000', NULL, NULL),
(425, 'plugin::content-manager.explorer.create', 'api::service.service', '{\"fields\": [\"description\", \"featured\", \"image\", \"keywords.keyword\", \"sub_title\", \"title\"]}', '[]', '2022-01-22 09:38:30.372000', '2022-01-22 09:38:30.372000', NULL, NULL),
(426, 'plugin::content-manager.explorer.read', 'api::service.service', '{\"fields\": [\"description\", \"featured\", \"image\", \"keywords.keyword\", \"sub_title\", \"title\"]}', '[]', '2022-01-22 09:38:30.382000', '2022-01-22 09:38:30.382000', NULL, NULL),
(427, 'plugin::content-manager.explorer.update', 'api::service.service', '{\"fields\": [\"description\", \"featured\", \"image\", \"keywords.keyword\", \"sub_title\", \"title\"]}', '[]', '2022-01-22 09:38:30.391000', '2022-01-22 09:38:30.391000', NULL, NULL),
(428, 'plugin::content-manager.explorer.create', 'api::team-member.team-member', '{\"fields\": [\"bio\", \"designation\", \"links.icon\", \"links.link\", \"links.name\", \"links.status\", \"name\", \"order\", \"photo\", \"status\"]}', '[]', '2022-01-22 09:38:30.399000', '2022-01-22 09:38:30.399000', NULL, NULL),
(429, 'plugin::content-manager.explorer.read', 'api::team-member.team-member', '{\"fields\": [\"bio\", \"designation\", \"links.icon\", \"links.link\", \"links.name\", \"links.status\", \"name\", \"order\", \"photo\", \"status\"]}', '[]', '2022-01-22 09:38:30.414000', '2022-01-22 09:38:30.414000', NULL, NULL),
(430, 'plugin::content-manager.explorer.update', 'api::team-member.team-member', '{\"fields\": [\"bio\", \"designation\", \"links.icon\", \"links.link\", \"links.name\", \"links.status\", \"name\", \"order\", \"photo\", \"status\"]}', '[]', '2022-01-22 09:38:30.424000', '2022-01-22 09:38:30.424000', NULL, NULL),
(431, 'plugin::content-manager.explorer.create', 'api::homepage-slider.homepage-slider', '{\"fields\": [\"slides.btnLink\", \"slides.btnText\", \"slides.image\", \"slides.status\", \"slides.subtitle\", \"slides.title\", \"status\"]}', '[]', '2022-01-22 09:38:35.969000', '2022-01-22 09:38:35.969000', NULL, NULL),
(432, 'plugin::content-manager.explorer.read', 'api::homepage-slider.homepage-slider', '{\"fields\": [\"slides.btnLink\", \"slides.btnText\", \"slides.image\", \"slides.status\", \"slides.subtitle\", \"slides.title\", \"status\"]}', '[]', '2022-01-22 09:38:35.980000', '2022-01-22 09:38:35.980000', NULL, NULL),
(433, 'plugin::content-manager.explorer.update', 'api::homepage-slider.homepage-slider', '{\"fields\": [\"slides.btnLink\", \"slides.btnText\", \"slides.image\", \"slides.status\", \"slides.subtitle\", \"slides.title\", \"status\"]}', '[]', '2022-01-22 09:38:35.989000', '2022-01-22 09:38:35.989000', NULL, NULL),
(434, 'plugin::content-manager.explorer.delete', 'api::homepage-slider.homepage-slider', '{}', '[]', '2022-01-22 09:38:35.999000', '2022-01-22 09:38:35.999000', NULL, NULL),
(435, 'plugin::content-manager.explorer.publish', 'api::homepage-slider.homepage-slider', '{}', '[]', '2022-01-22 09:38:36.008000', '2022-01-22 09:38:36.008000', NULL, NULL),
(436, 'plugin::content-manager.explorer.create', 'api::site-info.site-info', '{\"fields\": [\"contact_info.Address\", \"contact_info.email\", \"contact_info.phone\", \"contact_info.socials.icon\", \"contact_info.socials.link\", \"contact_info.socials.name\", \"contact_info.socials.status\", \"menus.footer_menu_left\", \"menus.footer_menu_right\", \"menus.primary_menu\", \"meta_keywords.keyword\", \"site_logo.dark\", \"site_logo.light\", \"site_logo.loader\", \"site_logo.normal\", \"site_name\", \"site_title\"]}', '[]', '2022-01-22 09:38:36.017000', '2022-01-22 09:38:36.017000', NULL, NULL),
(437, 'plugin::content-manager.explorer.read', 'api::site-info.site-info', '{\"fields\": [\"contact_info.Address\", \"contact_info.email\", \"contact_info.phone\", \"contact_info.socials.icon\", \"contact_info.socials.link\", \"contact_info.socials.name\", \"contact_info.socials.status\", \"menus.footer_menu_left\", \"menus.footer_menu_right\", \"menus.primary_menu\", \"meta_keywords.keyword\", \"site_logo.dark\", \"site_logo.light\", \"site_logo.loader\", \"site_logo.normal\", \"site_name\", \"site_title\"]}', '[]', '2022-01-22 09:38:36.026000', '2022-01-22 09:38:36.026000', NULL, NULL),
(438, 'plugin::content-manager.explorer.update', 'api::site-info.site-info', '{\"fields\": [\"contact_info.Address\", \"contact_info.email\", \"contact_info.phone\", \"contact_info.socials.icon\", \"contact_info.socials.link\", \"contact_info.socials.name\", \"contact_info.socials.status\", \"menus.footer_menu_left\", \"menus.footer_menu_right\", \"menus.primary_menu\", \"meta_keywords.keyword\", \"site_logo.dark\", \"site_logo.light\", \"site_logo.loader\", \"site_logo.normal\", \"site_name\", \"site_title\"]}', '[]', '2022-01-22 09:38:36.035000', '2022-01-22 09:38:36.035000', NULL, NULL),
(439, 'plugin::content-manager.explorer.delete', 'api::site-info.site-info', '{}', '[]', '2022-01-22 09:38:36.045000', '2022-01-22 09:38:36.045000', NULL, NULL),
(440, 'plugin::content-manager.explorer.publish', 'api::site-info.site-info', '{}', '[]', '2022-01-22 09:38:36.054000', '2022-01-22 09:38:36.054000', NULL, NULL),
(441, 'plugin::content-manager.explorer.create', 'api::blog-category.blog-category', '{\"fields\": [\"articles\", \"description\", \"name\", \"parent_category\", \"slug\", \"status\"]}', '[\"admin::is-creator\"]', '2022-01-22 09:38:45.412000', '2022-01-22 09:38:45.412000', NULL, NULL),
(442, 'plugin::content-manager.explorer.read', 'api::blog-category.blog-category', '{\"fields\": [\"articles\", \"description\", \"name\", \"parent_category\", \"slug\", \"status\"]}', '[\"admin::is-creator\"]', '2022-01-22 09:38:45.431000', '2022-01-22 09:38:45.431000', NULL, NULL),
(443, 'plugin::content-manager.explorer.update', 'api::blog-category.blog-category', '{\"fields\": [\"articles\", \"description\", \"name\", \"parent_category\", \"slug\", \"status\"]}', '[\"admin::is-creator\"]', '2022-01-22 09:38:45.446000', '2022-01-22 09:38:45.446000', NULL, NULL),
(447, 'plugin::content-manager.explorer.create', 'api::portfolio-category.portfolio-category', '{\"fields\": [\"name\", \"description\", \"slug\", \"status\"]}', '[]', '2022-01-23 17:51:02.315000', '2022-01-23 17:51:02.315000', NULL, NULL),
(448, 'plugin::content-manager.explorer.read', 'api::portfolio-category.portfolio-category', '{\"fields\": [\"name\", \"description\", \"slug\", \"status\"]}', '[]', '2022-01-23 17:51:02.581000', '2022-01-23 17:51:02.581000', NULL, NULL),
(449, 'plugin::content-manager.explorer.update', 'api::portfolio-category.portfolio-category', '{\"fields\": [\"name\", \"description\", \"slug\", \"status\"]}', '[]', '2022-01-23 17:51:02.785000', '2022-01-23 17:51:02.785000', NULL, NULL),
(450, 'plugin::content-manager.explorer.create', 'api::blog-category.blog-category', '{\"fields\": [\"name\", \"status\", \"description\", \"slug\", \"parent_category\", \"articles\", \"image\"]}', '[]', '2022-01-23 17:52:13.799000', '2022-01-23 17:52:13.799000', NULL, NULL),
(451, 'plugin::content-manager.explorer.read', 'api::blog-category.blog-category', '{\"fields\": [\"name\", \"status\", \"description\", \"slug\", \"parent_category\", \"articles\", \"image\"]}', '[]', '2022-01-23 17:52:13.997000', '2022-01-23 17:52:13.997000', NULL, NULL),
(452, 'plugin::content-manager.explorer.update', 'api::blog-category.blog-category', '{\"fields\": [\"name\", \"status\", \"description\", \"slug\", \"parent_category\", \"articles\", \"image\"]}', '[]', '2022-01-23 17:52:14.241000', '2022-01-23 17:52:14.241000', NULL, NULL),
(456, 'plugin::content-manager.explorer.delete', 'api::contact-form-submit.contact-form-submit', '{}', '[]', '2022-01-24 12:52:26.942000', '2022-01-24 12:52:26.942000', NULL, NULL),
(460, 'plugin::content-manager.explorer.create', 'api::contact-form-submit.contact-form-submit', '{\"fields\": [\"name\", \"phone\", \"email\", \"message\"]}', '[]', '2022-01-24 13:11:00.772000', '2022-01-24 13:11:00.772000', NULL, NULL),
(461, 'plugin::content-manager.explorer.read', 'api::contact-form-submit.contact-form-submit', '{\"fields\": [\"name\", \"phone\", \"email\", \"message\"]}', '[]', '2022-01-24 13:11:00.949000', '2022-01-24 13:11:00.949000', NULL, NULL),
(462, 'plugin::content-manager.explorer.update', 'api::contact-form-submit.contact-form-submit', '{\"fields\": [\"name\", \"phone\", \"email\", \"message\"]}', '[]', '2022-01-24 13:11:01.128000', '2022-01-24 13:11:01.128000', NULL, NULL),
(478, 'plugin::content-manager.explorer.create', 'api::page.page', '{\"fields\": [\"title\", \"sub_title\", \"header_image\", \"type\", \"blocks\", \"leaf_content\", \"status\", \"SEO.meta_title\", \"SEO.meta_description\", \"SEO.meta_tags.keyword\", \"SEO.share_thumbnail\", \"slug\", \"header_size\", \"Fields.name\", \"Fields.Value\", \"Fields.Type\", \"Sections.name\", \"Sections.content\", \"Sections.status\", \"Pagedata\"]}', '[]', '2022-02-24 11:00:57.253000', '2022-02-24 11:00:57.253000', NULL, NULL),
(479, 'plugin::content-manager.explorer.read', 'api::page.page', '{\"fields\": [\"title\", \"sub_title\", \"header_image\", \"type\", \"blocks\", \"leaf_content\", \"status\", \"SEO.meta_title\", \"SEO.meta_description\", \"SEO.meta_tags.keyword\", \"SEO.share_thumbnail\", \"slug\", \"header_size\", \"Fields.name\", \"Fields.Value\", \"Fields.Type\", \"Sections.name\", \"Sections.content\", \"Sections.status\", \"Pagedata\"]}', '[]', '2022-02-24 11:00:57.269000', '2022-02-24 11:00:57.269000', NULL, NULL),
(480, 'plugin::content-manager.explorer.update', 'api::page.page', '{\"fields\": [\"title\", \"sub_title\", \"header_image\", \"type\", \"blocks\", \"leaf_content\", \"status\", \"SEO.meta_title\", \"SEO.meta_description\", \"SEO.meta_tags.keyword\", \"SEO.share_thumbnail\", \"slug\", \"header_size\", \"Fields.name\", \"Fields.Value\", \"Fields.Type\", \"Sections.name\", \"Sections.content\", \"Sections.status\", \"Pagedata\"]}', '[]', '2022-02-24 11:00:57.281000', '2022-02-24 11:00:57.281000', NULL, NULL);

INSERT INTO `admin_permissions_role_links` (`permission_id`, `role_id`) VALUES
(1, 2);
INSERT INTO `admin_permissions_role_links` (`permission_id`, `role_id`) VALUES
(2, 2);
INSERT INTO `admin_permissions_role_links` (`permission_id`, `role_id`) VALUES
(3, 2);
INSERT INTO `admin_permissions_role_links` (`permission_id`, `role_id`) VALUES
(4, 2),
(5, 2),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(10, 3),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(62, 1),
(70, 2),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(111, 1),
(116, 1),
(121, 1),
(122, 1),
(138, 1),
(139, 1),
(140, 1),
(146, 1),
(147, 1),
(148, 1),
(149, 1),
(150, 1),
(154, 1),
(155, 1),
(156, 1),
(157, 1),
(170, 1),
(171, 1),
(181, 1),
(182, 1),
(189, 1),
(190, 1),
(194, 1),
(199, 1),
(214, 1),
(215, 1),
(272, 1),
(273, 1),
(274, 1),
(275, 1),
(276, 1),
(283, 3),
(284, 3),
(285, 3),
(286, 3),
(290, 3),
(331, 2),
(332, 2),
(333, 2),
(334, 2),
(335, 2),
(339, 2),
(340, 2),
(341, 2),
(342, 2),
(343, 2),
(344, 2),
(345, 2),
(346, 2),
(347, 2),
(348, 2),
(349, 2),
(350, 2),
(351, 2),
(352, 2),
(353, 2),
(354, 2),
(355, 2),
(356, 2),
(357, 2),
(358, 2),
(363, 2),
(364, 2),
(368, 2),
(369, 2),
(370, 2),
(371, 2),
(372, 2),
(373, 2),
(386, 1),
(387, 1),
(388, 1),
(389, 1),
(390, 1),
(391, 1),
(392, 1),
(393, 1),
(394, 1),
(395, 1),
(396, 1),
(397, 1),
(401, 1),
(402, 1),
(403, 1),
(419, 2),
(420, 2),
(421, 2),
(422, 2),
(423, 2),
(424, 2),
(425, 2),
(426, 2),
(427, 2),
(428, 2),
(429, 2),
(430, 2),
(431, 2),
(432, 2),
(433, 2),
(434, 2),
(435, 2),
(436, 2),
(437, 2);
INSERT INTO `admin_permissions_role_links` (`permission_id`, `role_id`) VALUES
(438, 2),
(439, 2),
(440, 2),
(441, 3),
(442, 3),
(443, 3),
(447, 1),
(448, 1),
(449, 1),
(450, 1),
(451, 1),
(452, 1),
(456, 1),
(460, 1),
(461, 1),
(462, 1),
(478, 1),
(479, 1),
(480, 1);

INSERT INTO `admin_roles` (`id`, `name`, `code`, `description`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 'Super Admin', 'strapi-super-admin', 'Super Admins can access and manage all features and settings.', '2022-01-02 21:36:53.889000', '2022-01-02 21:36:53.889000', NULL, NULL);
INSERT INTO `admin_roles` (`id`, `name`, `code`, `description`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(2, 'Editor', 'strapi-editor', 'Editors can manage and publish contents including those of other users.', '2022-01-02 21:36:53.902000', '2022-01-22 09:38:35.685000', NULL, NULL);
INSERT INTO `admin_roles` (`id`, `name`, `code`, `description`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(3, 'Author', 'strapi-author', 'Authors can manage the content they have created.', '2022-01-02 21:36:53.909000', '2022-01-22 09:42:53.033000', NULL, NULL);

INSERT INTO `admin_users` (`id`, `firstname`, `lastname`, `username`, `email`, `password`, `reset_password_token`, `registration_token`, `is_active`, `blocked`, `prefered_language`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 'Sheikh', 'Salman', NULL, 'sksalmanmiah@gmail.com', '$2a$10$6MdHkwSmxNy8BNL6QIyDx.ICGI327U6IPjs764P.DH6OuUqjuedrC', NULL, NULL, 1, 0, 'en', '2022-01-02 21:37:17.932000', '2022-01-03 20:43:42.185000', NULL, NULL);
INSERT INTO `admin_users` (`id`, `firstname`, `lastname`, `username`, `email`, `password`, `reset_password_token`, `registration_token`, `is_active`, `blocked`, `prefered_language`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(4, 'Mr', 'Ginger', 'Mr. Ginger', 'tester@gmail.com', '$2a$10$7KpJZPZOXssv1aSzGxNM6.zYfBfVoVTDDiJZ.TfHe6yBggZC2QUti', NULL, NULL, 1, 0, 'en', '2022-01-13 11:37:08.144000', '2022-01-26 07:28:08.130000', NULL, NULL);
INSERT INTO `admin_users` (`id`, `firstname`, `lastname`, `username`, `email`, `password`, `reset_password_token`, `registration_token`, `is_active`, `blocked`, `prefered_language`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(5, 'Mr. ', 'Author', NULL, 'author@ai.com', '$2a$10$q9Bgwb5buIT47HhDV/T2eOIP10vaD5ZeXE2RVVO2IT1tsQy6lV/TC', NULL, NULL, 1, 0, NULL, '2022-01-22 09:43:33.941000', '2022-01-22 09:43:56.864000', NULL, NULL);

INSERT INTO `admin_users_roles_links` (`user_id`, `role_id`) VALUES
(1, 1);
INSERT INTO `admin_users_roles_links` (`user_id`, `role_id`) VALUES
(1, 2);
INSERT INTO `admin_users_roles_links` (`user_id`, `role_id`) VALUES
(1, 3);
INSERT INTO `admin_users_roles_links` (`user_id`, `role_id`) VALUES
(5, 3),
(4, 2),
(4, 3),
(4, 1);

INSERT INTO `articles` (`id`, `title`, `slug`, `excerpt`, `content`, `featured`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`) VALUES
(2, 'CORNHOLE SLOW FRANZEN WOKE MASTER CLEANSE', 'cornhole-slow-franzen-woke-master-cleanse', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fash.', '---\n__Advertisement :)__\n\n- __[pica](https://nodeca.github.io/pica/demo/)__ - high quality and fast image\n  resize in browser.\n- __[babelfish](https://github.com/nodeca/babelfish/)__ - developer friendly\n  i18n with plurals support and easy syntax.\n\nYou will like those projects!\n\n---\n\n# h1 Heading 8-)\n## h2 Heading\n### h3 Heading\n#### h4 Heading\n##### h5 Heading\n###### h6 Heading\n\n\n## Horizontal Rules\n\n___\n\n---\n\n***\n\n\n## Typographic replacements\n\nEnable typographer option to see result.\n\n(c) (C) (r) (R) (tm) (TM) (p) (P) +-\n\ntest.. test... test..... test?..... test!....\n\n!!!!!! ???? ,,  -- ---\n\n\"Smartypants, double quotes\" and \'single quotes\'\n\n\n## Emphasis\n\n**This is bold text**\n\n__This is bold text__\n\n*This is italic text*\n\n_This is italic text_\n\n~~Strikethrough~~\n\n\n## Blockquotes\n\n\n> Blockquotes can also be nested...\n>> ...by using additional greater-than signs right next to each other...\n> > > ...or with spaces between arrows.\n\n\n## Lists\n\nUnordered\n\n+ Create a list by starting a line with `+`, `-`, or `*`\n+ Sub-lists are made by indenting 2 spaces:\n  - Marker character change forces new list start:\n    * Ac tristique libero volutpat at\n    + Facilisis in pretium nisl aliquet\n    - Nulla volutpat aliquam velit\n+ Very easy!\n\nOrdered\n\n1. Lorem ipsum dolor sit amet\n2. Consectetur adipiscing elit\n3. Integer molestie lorem at massa\n\n\n1. You can use sequential numbers...\n1. ...or keep all the numbers as `1.`\n\nStart numbering with offset:\n\n57. foo\n1. bar\n\n\n## Code\n\nInline `code`\n\nIndented code\n\n    // Some comments\n    line 1 of code\n    line 2 of code\n    line 3 of code\n\n\nBlock code \"fences\"\n\n```\nSample text here...\n```\n\nSyntax highlighting\n\n``` js\nvar foo = function (bar) {\n  return bar++;\n};\n\nconsole.log(foo(5));\n```\n\n## Tables\n\n| Option | Description |\n| ------ | ----------- |\n| data   | path to data files to supply the data that will be passed into templates. |\n| engine | engine to be used for processing templates. Handlebars is the default. |\n| ext    | extension to be used for dest files. |\n\nRight aligned columns\n\n| Option | Description |\n| ------:| -----------:|\n| data   | path to data files to supply the data that will be passed into templates. |\n| engine | engine to be used for processing templates. Handlebars is the default. |\n| ext    | extension to be used for dest files. |\n\n\n## Links\n\n[link text](http://dev.nodeca.com)\n\n[link with title](http://nodeca.github.io/pica/demo/ \"title text!\")\n\nAutoconverted link https://github.com/nodeca/pica (enable linkify to see)\n\n\n## Images\n\n![Minion](https://octodex.github.com/images/minion.png)\n![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg \"The Stormtroopocat\")\n\nLike links, Images also have a footnote style syntax\n\n![Alt text][id]\n\nWith a reference later in the document defining the URL location:\n\n[id]: https://octodex.github.com/images/dojocat.jpg  \"The Dojocat\"\n\n\n## Plugins\n\nThe killer feature of `markdown-it` is very effective support of\n[syntax plugins](https://www.npmjs.org/browse/keyword/markdown-it-plugin).\n\n\n### [Emojies](https://github.com/markdown-it/markdown-it-emoji)\n\n> Classic markup: :wink: :crush: :cry: :tear: :laughing: :yum:\n>\n> Shortcuts (emoticons): :-) :-( 8-) ;)\n\nsee [how to change output](https://github.com/markdown-it/markdown-it-emoji#change-output) with twemoji.\n\n\n### [Subscript](https://github.com/markdown-it/markdown-it-sub) / [Superscript](https://github.com/markdown-it/markdown-it-sup)\n\n- 19^th^\n- H~2~O\n\n\n### [\\<ins>](https://github.com/markdown-it/markdown-it-ins)\n\n++Inserted text++\n\n\n### [\\<mark>](https://github.com/markdown-it/markdown-it-mark)\n\n==Marked text==\n\n\n### [Footnotes](https://github.com/markdown-it/markdown-it-footnote)\n\nFootnote 1 link[^first].\n\nFootnote 2 link[^second].\n\nInline footnote^[Text of inline footnote] definition.\n\nDuplicated footnote reference[^second].\n\n[^first]: Footnote **can have markup**\n\n    and multiple paragraphs.\n\n[^second]: Footnote text.\n\n\n### [Definition lists](https://github.com/markdown-it/markdown-it-deflist)\n\nTerm 1\n\n:   Definition 1\nwith lazy continuation.\n\nTerm 2 with *inline markup*\n\n:   Definition 2\n\n        { some code, part of Definition 2 }\n\n    Third paragraph of definition 2.\n\n_Compact style:_\n\nTerm 1\n  ~ Definition 1\n\nTerm 2\n  ~ Definition 2a\n  ~ Definition 2b\n\n\n### [Abbreviations](https://github.com/markdown-it/markdown-it-abbr)\n\nThis is HTML abbreviation example.\n\nIt converts \"HTML\", but keep intact partial entries like \"xxxHTMLyyy\" and so on.\n\n*[HTML]: Hyper Text Markup Language\n\n### [Custom containers](https://github.com/markdown-it/markdown-it-container)\n\n::: warning\n*here be dragons*\n:::\n', 1, 1, '2022-01-05 04:18:06.503000', '2022-01-19 18:53:45.931000', '2022-01-19 03:23:36.515000', 1, 1);
INSERT INTO `articles` (`id`, `title`, `slug`, `excerpt`, `content`, `featured`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`) VALUES
(3, ' SLOW FRANZEN WOKE MASTER CLEANSE', 'slow-franzen-woke-master-cleanse-1', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fash.', 'An h1 header\n============\n\nParagraphs are separated by a blank line.\n\n2nd paragraph. *Italic*, **bold**, and `monospace`. Itemized lists\nlook like:\n\n  * this one\n  * that one\n  * the other one\n\nNote that --- not considering the asterisk --- the actual text\ncontent starts at 4-columns in.\n\n> Block quotes are\n> written like so.\n>\n> They can span multiple paragraphs,\n> if you like.\n\nUse 3 dashes for an em-dash. Use 2 dashes for ranges (ex., \"it\'s all\nin chapters 12--14\"). Three dots ... will be converted to an ellipsis.\nUnicode is supported. ☺\n\n\n\nAn h2 header\n------------\n\nHere\'s a numbered list:\n\n 1. first item\n 2. second item\n 3. third item\n\nNote again how the actual text starts at 4 columns in (4 characters\nfrom the left side). Here\'s a code sample:\n\n    # Let me re-iterate ...\n    for i in 1 .. 10 { do-something(i) }\n\nAs you probably guessed, indented 4 spaces. By the way, instead of\nindenting the block, you can use delimited blocks, if you like:\n\n~~~\ndefine foobar() {\n    print \"Welcome to flavor country!\";\n}\n~~~\n\n(which makes copying & pasting easier). You can optionally mark the\ndelimited block for Pandoc to syntax highlight it:\n\n~~~python\nimport time\n# Quick, count to ten!\nfor i in range(10):\n    # (but not *too* quick)\n    time.sleep(0.5)\n    print i\n~~~\n\n\n\n### An h3 header ###\n\nNow a nested list:\n\n 1. First, get these ingredients:\n\n      * carrots\n      * celery\n      * lentils\n\n 2. Boil some water.\n\n 3. Dump everything in the pot and follow\n    this algorithm:\n\n        find wooden spoon\n        uncover pot\n        stir\n        cover pot\n        balance wooden spoon precariously on pot handle\n        wait 10 minutes\n        goto first step (or shut off burner when done)\n\n    Do not bump wooden spoon or it will fall.\n\nNotice again how text always lines up on 4-space indents (including\nthat last line which continues item 3 above).\n\nHere\'s a link to [a website](http://foo.bar), to a [local\ndoc](local-doc.html), and to a [section heading in the current\ndoc](#an-h2-header). Here\'s a footnote [^1].\n\n[^1]: Footnote text goes here.\n\nTables can look like this:\n\nsize  material      color\n----  ------------  ------------\n9     leather       brown\n10    hemp canvas   natural\n11    glass         transparent\n\nTable: Shoes, their sizes, and what they\'re made of\n\n(The above is the caption for the table.) Pandoc also supports\nmulti-line tables:\n\n--------  -----------------------\nkeyword   text\n--------  -----------------------\nred       Sunsets, apples, and\n          other red or reddish\n          things.\n\ngreen     Leaves, grass, frogs\n          and other things it\'s\n          not easy being.\n--------  -----------------------\n\nA horizontal rule follows.\n\n***\n\nHere\'s a definition list:\n\napples\n  : Good for making applesauce.\noranges\n  : Citrus!\ntomatoes\n  : There\'s no \"e\" in tomatoe.\n\nAgain, text is indented 4 spaces. (Put a blank line between each\nterm/definition pair to spread things out more.)\n\nHere\'s a \"line block\":\n\n| Line one\n|   Line too\n| Line tree\n\nand images can be specified like so:\n\n![example image](example-image.jpg \"An exemplary image\")\n\nInline math equations go in like so: $\\omega = d\\phi / dt$. Display\nmath should get its own line and be put in in double-dollarsigns:\n\n$$I = \\int \\rho R^{2} dV$$\n\nAnd note that you can backslash-escape any punctuation characters\nwhich you wish to be displayed literally, ex.: \\`foo\\`, \\*bar\\*, etc.', 1, 1, '2022-01-19 03:24:13.285000', '2022-01-19 18:45:41.660000', '2022-01-19 03:24:18.345000', 1, 1);
INSERT INTO `articles` (`id`, `title`, `slug`, `excerpt`, `content`, `featured`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`) VALUES
(4, 'FRANZEN WOKE MASTER CLEANSE', 'franzen-woke-master-cleanse-1', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fash.', '## ddddddddddddddddasd![Eventos-virtuales-1080x675.jpg](/uploads/Eventos_virtuales_1080x675_72f022291d.jpg)\ndkashkdjasdasdsdsdas', 0, 1, '2022-01-19 03:25:06.934000', '2022-01-19 13:33:17.310000', '2022-01-19 03:25:45.628000', 1, 1);
INSERT INTO `articles` (`id`, `title`, `slug`, `excerpt`, `content`, `featured`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`) VALUES
(5, ' WOKE MASTER CLEANSE', 'woke-master-cleanse-1', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fash.', '## ddddddddddddddddasd![Eventos-virtuales-1080x675.jpg](/uploads/Eventos_virtuales_1080x675_72f022291d.jpg)\ndkashkdjasdasdsdsdas', 0, 1, '2022-01-19 03:26:32.036000', '2022-01-19 15:18:59.621000', '2022-01-19 03:26:36.530000', 1, 1),
(6, 'Te amo me ', 'te-amo-me', 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups', '# Heading 1\n\n\n\n- list element 1\n- list element 2\n- list element 3\n\n![alienide_sample_page_head_half.jpg](http://localhost:1337/uploads/alienide_sample_page_head_half_ae30f1cb0a.jpg)\n\nPlain old paragraph text. What would be the main body of the article.\n\n', 1, 1, '2022-01-19 03:59:35.448000', '2022-01-19 18:48:38.885000', '2022-01-19 03:59:48.675000', 1, 1),
(8, 'hey', 'hey', 'you', 'yreah', 0, 1, '2022-01-22 10:16:26.608000', '2022-01-23 15:12:14.440000', '2022-01-22 10:55:29.793000', 5, 1);

INSERT INTO `blog_categories` (`id`, `name`, `status`, `description`, `slug`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 'Tools and Tech', 1, 'We write about tools and tech in this category', 'tools-and-tech', '2022-01-05 03:42:45.441000', '2022-01-05 03:56:46.413000', 1, 1);
INSERT INTO `blog_categories` (`id`, `name`, `status`, `description`, `slug`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(2, 'Project experiences', 1, 'we write about our experiences of past projects', 'project-experiences', '2022-01-05 03:45:47.348000', '2022-01-22 09:30:10.844000', 1, 4);
INSERT INTO `blog_categories` (`id`, `name`, `status`, `description`, `slug`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(4, 'Life in SWT', 1, 'How its like to work in SWT? the umbrellas of alienide interactive.', 'life-in-swt', '2022-01-05 03:59:25.446000', '2022-01-23 17:54:21.523000', 1, 1);
INSERT INTO `blog_categories` (`id`, `name`, `status`, `description`, `slug`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(5, 'HowTos', 1, NULL, 'how-tos', '2022-01-19 15:43:35.981000', '2022-01-19 15:43:35.981000', 1, 1),
(6, 'sales', 1, NULL, 'sales', '2022-01-22 09:45:41.467000', '2022-01-22 09:45:41.467000', 5, 5),
(7, 'marketing', 1, NULL, 'marketing', '2022-01-22 09:55:44.752000', '2022-01-22 09:56:14.621000', 5, 5);

INSERT INTO `blog_categories_articles_links` (`blog_category_id`, `article_id`) VALUES
(2, 5);
INSERT INTO `blog_categories_articles_links` (`blog_category_id`, `article_id`) VALUES
(1, 3);
INSERT INTO `blog_categories_articles_links` (`blog_category_id`, `article_id`) VALUES
(2, 3);
INSERT INTO `blog_categories_articles_links` (`blog_category_id`, `article_id`) VALUES
(2, 8),
(4, 6),
(4, 2);

INSERT INTO `blog_categories_parent_category_links` (`blog_category_id`, `inv_blog_category_id`) VALUES
(2, 4);
INSERT INTO `blog_categories_parent_category_links` (`blog_category_id`, `inv_blog_category_id`) VALUES
(7, 2);


INSERT INTO `clients` (`id`, `name`, `website`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `featured`, `order`) VALUES
(2, 'Alienide Inc', 'https://alienide.com/', '2022-01-03 02:13:35.860000', '2022-01-18 14:04:57.968000', 1, 1, 0, 0);
INSERT INTO `clients` (`id`, `name`, `website`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `featured`, `order`) VALUES
(3, 'Test 2', 'http://test.com', '2022-01-04 19:40:06.601000', '2022-01-18 14:05:44.783000', 1, 1, 0, 4);
INSERT INTO `clients` (`id`, `name`, `website`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `featured`, `order`) VALUES
(5, 'Alienide Inc', 'https://alienide.com/', '2022-01-18 13:11:55.580000', '2022-01-18 14:06:24.567000', 1, 1, 1, 3);
INSERT INTO `clients` (`id`, `name`, `website`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `featured`, `order`) VALUES
(6, 'Test', 'http://test.com', '2022-01-18 13:54:50.710000', '2022-01-18 14:05:56.043000', 1, 1, 1, 1),
(7, 'Alienide Inc', 'https://alienide.com/', '2022-01-18 13:57:52.400000', '2022-01-18 14:07:03.408000', 1, 1, 1, 6),
(8, 'Test', 'http://test.com', '2022-01-18 13:57:58.433000', '2022-01-18 14:06:05.142000', 1, 1, 1, 2),
(9, 'Test 2', 'http://test.com', '2022-01-18 13:58:09.205000', '2022-01-18 14:07:18.432000', 1, 1, 1, 7),
(10, 'Alienide Inc', 'https://alienide.com/', '2022-01-18 13:58:23.848000', '2022-01-18 14:06:53.633000', 1, 1, 1, 5);

INSERT INTO `components_crud_fields` (`id`, `value`, `name`, `type`) VALUES
(1, 'TestValue', 'TestField', 'text');


INSERT INTO `components_crud_sections` (`id`, `content`, `name`, `status`) VALUES
(1, '### Hello\n\ni**ts  a section**\n![adult-blur-brick-walls-846741.jpg](https://alienide.sksalman.codes/uploads/adult_blur_brick_walls_846741_e3a68f5081.jpg)', 'TestSection', 1);


INSERT INTO `components_elements_contact_infos` (`id`, `email`, `phone`, `address`) VALUES
(1, 'alienide@mail.co', '+8801303560093', 'Dhaka,Bangladesh');


INSERT INTO `components_elements_contact_infos_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(21, 1, 1, 'elements.social-info', 'socials', 1);
INSERT INTO `components_elements_contact_infos_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(22, 1, 2, 'elements.social-info', 'socials', 2);


INSERT INTO `components_elements_menu_items` (`id`, `type`, `title`, `custom_link`, `status`) VALUES
(2, 'page', 'Portfolio', 'port', 1);
INSERT INTO `components_elements_menu_items` (`id`, `type`, `title`, `custom_link`, `status`) VALUES
(6, 'page', 'Home', NULL, 1);
INSERT INTO `components_elements_menu_items` (`id`, `type`, `title`, `custom_link`, `status`) VALUES
(7, 'page', 'About us', NULL, 1);
INSERT INTO `components_elements_menu_items` (`id`, `type`, `title`, `custom_link`, `status`) VALUES
(8, 'page', 'Services', NULL, 1),
(9, 'page', 'Portfolio', NULL, 1),
(10, 'page', 'Blog', NULL, 1),
(11, 'page', 'Contact', NULL, 1),
(13, 'page', 'News & events', NULL, 1),
(14, 'page', 'Terms & conditions', NULL, 1),
(15, 'page', 'Privacy policy', NULL, 1),
(16, 'custom_link', 'Softwind tech', 'http://softwindtech.com/', 1),
(17, 'page', 'Home', NULL, 1),
(18, 'page', 'About', NULL, 1),
(19, 'page', 'Services', NULL, 1),
(20, 'page', 'Portfolio', NULL, 1),
(21, 'page', 'Blog', NULL, 1),
(22, 'page', 'Contact', NULL, 1),
(23, 'page', 'Home', NULL, 1),
(24, 'page', 'Contact', NULL, 1),
(25, 'page', 'Services', NULL, 1),
(26, 'page', 'Blog', NULL, 1),
(27, 'page', 'Portfolio', NULL, 1),
(28, 'page', 'About', NULL, 1),
(29, 'page', 'Terms of services', NULL, 1),
(30, 'page', 'Privacy policy', NULL, 1),
(31, 'custom_link', 'Umbrella', 'https://www.softwindtech.com/', 1);

INSERT INTO `components_elements_menu_items_page_links` (`menu_item_id`, `page_id`) VALUES
(14, 9);
INSERT INTO `components_elements_menu_items_page_links` (`menu_item_id`, `page_id`) VALUES
(15, 8);
INSERT INTO `components_elements_menu_items_page_links` (`menu_item_id`, `page_id`) VALUES
(13, 10);
INSERT INTO `components_elements_menu_items_page_links` (`menu_item_id`, `page_id`) VALUES
(7, 3),
(6, 2),
(8, 4),
(9, 5),
(10, 6),
(11, 7),
(23, 2),
(24, 7),
(26, 6),
(27, 5),
(25, 4),
(28, 3),
(29, 9),
(30, 8),
(18, 3),
(17, 2),
(19, 4),
(20, 5),
(21, 6),
(22, 7);

INSERT INTO `components_elements_menus` (`id`) VALUES
(1);


INSERT INTO `components_elements_menus_footer_menu_left_links` (`menus_id`, `menu_id`) VALUES
(1, 2);


INSERT INTO `components_elements_menus_footer_menu_right_links` (`menus_id`, `menu_id`) VALUES
(1, 3);


INSERT INTO `components_elements_menus_primary_menu_links` (`menus_id`, `menu_id`) VALUES
(1, 1);


INSERT INTO `components_elements_reviews` (`id`, `rating`, `type`, `review`) VALUES
(1, 4.55, 'customer', 'Copper mug vexillologist +1 prism iPhone fashion axe portland.\n    Hella quinoa woke blog af umami tacos freegan vinyl snackwave\n    microdosing. Fanny pack direct trade XOXO drinking vinegar.\n    Live-edge kinfolk master cleanse brooklyn meh organic man braid.\n    Actually humblebrag sriracha authentic chia. IPhone glossier\n    schlitz fam, la croix keytar retro offal. Artisan selfies mlkshk\n    pinterest gastropub knausgaard live-edge.');
INSERT INTO `components_elements_reviews` (`id`, `rating`, `type`, `review`) VALUES
(2, 5.00, 'customer', 'Copper mug vexillologist +1 prism iPhone fashion axe portland.direct trade XOXO drinking vinegar.\n    Live-edge kinfolk master cleanse brooklyn meh organic man braid.\n    Actually humblebrag sriracha authentic chia. IPhone glossier\n    schlitz fam, la croix keytar retro offal. Artisan selfies mlkshk\n    pinterest gastropub knausgaard live-edge.');
INSERT INTO `components_elements_reviews` (`id`, `rating`, `type`, `review`) VALUES
(3, 4.55, 'inhouse', 'Copper mug vexillologist +1 prism iPhone fashion axe portland.\n    Hella quinoa woke blog af umami tacos freegan vinyl snackwave\n    microdosing. Fanny pack direct trade XOXO drinking vinegar.\n    Live-edge kinfolk master cleanse brooklyn meh organic man braid.\n    Actually humblebrag sriracha authentic chia. IPhone glossier\n    schlitz fam, la croix keytar retro offal. Artisan selfies mlkshk\n    pinterest gastropub knausgaard live-edge.');
INSERT INTO `components_elements_reviews` (`id`, `rating`, `type`, `review`) VALUES
(4, 4.55, 'customer', 'Copper mug vexillologist +1 prism iPhone fashion axe portland.\n    Hella quinoa woke blog af umami tacos freegan vinyl snackwave\n    microdosing. Fanny pack direct trade XOXO drinking vinegar.\n    Live-edge kinfolk master cleanse brooklyn meh organic man braid.\n    Actually humblebrag sriracha authentic chia. IPhone glossier\n    schlitz fam, la croix keytar retro offal. Artisan selfies mlkshk\n    pinterest gastropub knausgaard live-edge.'),
(5, 4.55, 'inhouse', 'Copper mug vexillologist +1 prism iPhone fashion axe portland.\n    Hella quinoa woke blog af umami tacos freegan vinyl snackwave\n    microdosing. Fanny pack direct trade XOXO drinking vinegar.\n    Live-edge kinfolk master cleanse brooklyn meh organic man braid.\n    Actually humblebrag sriracha authentic chia. IPhone glossier\n    schlitz fam, la croix keytar retro offal. Artisan selfies mlkshk\n    pinterest gastropub knausgaard live-edge.');

INSERT INTO `components_elements_sliders` (`id`, `title`, `subtitle`, `btn_text`, `btn_link`, `status`) VALUES
(1, 'We generate creative & novation ideas', 'XOXO fam brunch retro intelligentsia live-edge vegan', 'About us', '/about', 1);
INSERT INTO `components_elements_sliders` (`id`, `title`, `subtitle`, `btn_text`, `btn_link`, `status`) VALUES
(2, 'We gamify experiences', 'Grow your brand through experience', 'About us', '/about', 1);
INSERT INTO `components_elements_sliders` (`id`, `title`, `subtitle`, `btn_text`, `btn_link`, `status`) VALUES
(3, 'Door to metaverse', 'Arrange virtual events, fairs and enter into the metaverse.', 'About us', '/about', 1);
INSERT INTO `components_elements_sliders` (`id`, `title`, `subtitle`, `btn_text`, `btn_link`, `status`) VALUES
(4, 'test slider', 'hey', 'About us', '/about', 1),
(5, 'Hyper casual games', 'Unawareness of gameplay.', 'Check out', '/portfolio/5', 1);

INSERT INTO `components_elements_social_infos` (`id`, `name`, `link`, `status`) VALUES
(1, 'fb', 'https://fb.com/alienide', 1);
INSERT INTO `components_elements_social_infos` (`id`, `name`, `link`, `status`) VALUES
(2, 'instagram', 'https://instagram.com/', 1);
INSERT INTO `components_elements_social_infos` (`id`, `name`, `link`, `status`) VALUES
(3, 'FB', 'https://fb.com/', 1);
INSERT INTO `components_elements_social_infos` (`id`, `name`, `link`, `status`) VALUES
(4, 'Insta', 'https://instagram.com/', 1),
(5, 'FB', 'https://fb.com/', 1),
(6, 'Insta', 'https://instagram.com/', 1),
(7, 'FB', 'https://fb.com/', 1),
(8, 'Insta', 'https://instagram.com/', 1),
(9, 'Insta', 'https://instagram.com/', 1),
(10, 'FB', 'https://fb.com/', 1),
(11, 'Insta', 'https://instagram.com/', 1),
(12, 'FB', 'https://fb.com/', 1);

INSERT INTO `components_media_galleries` (`id`) VALUES
(2);
INSERT INTO `components_media_galleries` (`id`) VALUES
(4);
INSERT INTO `components_media_galleries` (`id`) VALUES
(6);
INSERT INTO `components_media_galleries` (`id`) VALUES
(7),
(8),
(9),
(10),
(11),
(12),
(13);

INSERT INTO `components_media_logos` (`id`) VALUES
(1);


INSERT INTO `components_mixed_seos` (`id`, `meta_title`, `meta_description`) VALUES
(2, 'Alienide Interactive home page', NULL);
INSERT INTO `components_mixed_seos` (`id`, `meta_title`, `meta_description`) VALUES
(3, 'Alienide Interactive home page', NULL);
INSERT INTO `components_mixed_seos` (`id`, `meta_title`, `meta_description`) VALUES
(4, 'Alienide Interactive home page', NULL);
INSERT INTO `components_mixed_seos` (`id`, `meta_title`, `meta_description`) VALUES
(5, 'Alienide Interactive home page', NULL),
(6, 'Alienide Interactive home page', NULL),
(7, NULL, NULL);

INSERT INTO `components_mixed_seos_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(24, 5, 21, 'text.keyword', 'meta_tags', 1);
INSERT INTO `components_mixed_seos_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(25, 5, 22, 'text.keyword', 'meta_tags', 2);
INSERT INTO `components_mixed_seos_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(31, 4, 19, 'text.keyword', 'meta_tags', 1);
INSERT INTO `components_mixed_seos_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(32, 4, 20, 'text.keyword', 'meta_tags', 2),
(33, 6, 23, 'text.keyword', 'meta_tags', 1),
(34, 6, 24, 'text.keyword', 'meta_tags', 2),
(35, 6, 25, 'text.keyword', 'meta_tags', 3),
(36, 7, 75, 'text.keyword', 'meta_tags', 1),
(37, 3, 17, 'text.keyword', 'meta_tags', 1),
(38, 3, 18, 'text.keyword', 'meta_tags', 2),
(41, 2, 16, 'text.keyword', 'meta_tags', 1),
(42, 2, 15, 'text.keyword', 'meta_tags', 2);

INSERT INTO `components_models_clients` (`id`, `name`) VALUES
(1, 'clients');


INSERT INTO `components_models_portfolios` (`id`, `name`) VALUES
(1, 'portfolios');


INSERT INTO `components_models_services` (`id`, `name`) VALUES
(1, 'services');


INSERT INTO `components_models_testimonials` (`id`, `name`) VALUES
(1, 'testimonials');


INSERT INTO `components_text_keywords` (`id`, `keyword`) VALUES
(6, 'tests');
INSERT INTO `components_text_keywords` (`id`, `keyword`) VALUES
(7, 'ui/ux');
INSERT INTO `components_text_keywords` (`id`, `keyword`) VALUES
(8, 'web dev');
INSERT INTO `components_text_keywords` (`id`, `keyword`) VALUES
(10, 'game dev'),
(11, 'v exp'),
(12, 'hello there kw'),
(15, 'virtual events'),
(16, 'game development'),
(17, 'game development'),
(18, 'virtual events'),
(19, 'game development'),
(20, 'virtual events'),
(21, 'game development'),
(22, 'virtual events'),
(23, 'game development'),
(24, 'virtual events'),
(25, 'tech articles'),
(26, 'tests'),
(27, 'ui/ux'),
(28, 'web dev'),
(29, 'ui/ux'),
(30, 'tests'),
(31, 'web dev'),
(32, 'ui/ux'),
(33, 'tests'),
(34, 'web dev'),
(35, 'ui/ux'),
(36, 'tests'),
(37, 'web dev'),
(38, 'tests'),
(39, 'ui/ux'),
(40, 'web dev'),
(41, 'MEDIA PROMOTION'),
(42, 'USER INTERFACE'),
(43, 'SEO & MARKETING'),
(44, 'USER EXPERIENCE'),
(45, 'CREATIVE DESIGN'),
(46, 'MEDIA PROMOTION'),
(47, 'USER INTERFACE'),
(48, 'SEO & MARKETING'),
(49, 'USER EXPERIENCE'),
(50, 'CREATIVE DESIGN'),
(51, 'USER INTERFACE'),
(52, 'MEDIA PROMOTION'),
(53, 'USER EXPERIENCE'),
(54, 'SEO & MARKETING'),
(55, 'CREATIVE DESIGN'),
(56, 'USER INTERFACE'),
(57, 'MEDIA PROMOTION'),
(58, 'SEO & MARKETING'),
(59, 'USER EXPERIENCE'),
(60, 'CREATIVE DESIGN'),
(61, 'MEDIA PROMOTION'),
(62, 'USER INTERFACE'),
(63, 'SEO & MARKETING'),
(64, 'USER EXPERIENCE'),
(65, 'CREATIVE DESIGN'),
(66, 'USER INTERFACE'),
(67, 'MEDIA PROMOTION'),
(68, 'SEO & MARKETING'),
(69, 'USER EXPERIENCE'),
(70, 'CREATIVE DESIGN'),
(71, 'tests'),
(72, 'ui/ux'),
(73, 'web dev'),
(74, 'tesat'),
(75, 'KM');

INSERT INTO `contact_form_submits` (`id`, `name`, `phone`, `email`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `message`) VALUES
(31, 'Sheikh Salman Ahmed Sabbir', '+8801705548264', 'salman15-9398@diu.edu.bd', '2022-01-24 12:51:08.419000', '2022-01-24 12:51:08.419000', NULL, NULL, 'hey there');
INSERT INTO `contact_form_submits` (`id`, `name`, `phone`, `email`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `message`) VALUES
(32, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-01-24 12:55:07.885000', '2022-01-24 12:55:07.885000', NULL, NULL, 'dasdasd');
INSERT INTO `contact_form_submits` (`id`, `name`, `phone`, `email`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `message`) VALUES
(33, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-01-24 13:14:29.282000', '2022-01-24 13:14:29.282000', NULL, NULL, 'dasdasd');
INSERT INTO `contact_form_submits` (`id`, `name`, `phone`, `email`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `message`) VALUES
(34, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-01-24 13:21:04.783000', '2022-01-24 13:21:04.783000', NULL, NULL, 'dasdasd'),
(35, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-01-24 13:22:59.906000', '2022-01-24 13:22:59.906000', NULL, NULL, 'dasdad'),
(36, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-01-24 13:23:16.070000', '2022-01-24 13:23:16.070000', NULL, NULL, 'dasd'),
(37, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-01-24 13:24:20.142000', '2022-01-24 13:24:20.142000', NULL, NULL, 'dasd'),
(38, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-01-24 13:28:36.504000', '2022-01-24 13:28:36.504000', NULL, NULL, 'zxfafd'),
(39, 'Shffg', '55555', 'bsbsbsb@gmail.com', '2022-01-24 19:51:17.165000', '2022-01-24 19:51:17.165000', NULL, NULL, 'Hey there'),
(40, 'Ggf', '555555', 'hgf@ghg.com', '2022-01-24 19:51:49.951000', '2022-01-24 19:51:49.951000', NULL, NULL, 'Hhffg'),
(41, 'Hry', '56327', 'hgff@jjf.bn', '2022-01-24 19:52:19.673000', '2022-01-24 19:52:19.673000', NULL, NULL, 'Gjgdy'),
(42, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-01-25 15:34:00.420000', '2022-01-25 15:34:00.420000', NULL, NULL, 'hey there again'),
(43, 'Sheikh Salman', '+8801303560093', 'sheikhsalman2013@gmail.com', '2022-01-25 15:48:23.368000', '2022-01-25 15:48:23.368000', NULL, NULL, 'hey you.'),
(44, 'Sheikh Salman', '+8801303560093', 'sheikhsalman2013@gmail.com', '2022-01-25 15:54:57.381000', '2022-01-25 15:54:57.381000', NULL, NULL, 'hey you'),
(45, 'Sheikh Salman', '+8801303560093', 'salman15-9398@diu.edu.bd', '2022-01-25 10:02:22.753000', '2022-01-25 10:02:22.753000', NULL, NULL, 'Can you develop sudoku metaverse'),
(46, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-01-25 10:12:10.132000', '2022-01-25 10:12:10.132000', NULL, NULL, 'again'),
(47, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-01-25 10:20:58.481000', '2022-01-25 10:20:58.481000', NULL, NULL, 'wsfsfsdf'),
(48, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-01-26 21:28:38.555000', '2022-01-26 21:28:38.555000', NULL, NULL, 'Test'),
(49, 'Sheikh Salman', '+8801303560093', 'Sksalmanmiah@gmail.com', '2022-02-11 17:20:31.063000', '2022-02-11 17:20:31.063000', NULL, NULL, 'test');

INSERT INTO `files` (`id`, `name`, `alternative_text`, `caption`, `width`, `height`, `formats`, `hash`, `ext`, `mime`, `size`, `url`, `preview_url`, `provider`, `provider_metadata`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 'logo-loader.png', 'logo-loader.png', 'logo-loader.png', 256, 256, '{\"thumbnail\": {\"ext\": \".png\", \"url\": \"/uploads/thumbnail_logo_loader_53122ca46c.png\", \"hash\": \"thumbnail_logo_loader_53122ca46c\", \"mime\": \"image/png\", \"name\": \"thumbnail_logo-loader.png\", \"path\": null, \"size\": 6.39, \"width\": 156, \"height\": 156}}', 'logo_loader_53122ca46c', '.png', 'image/png', 9.40, '/uploads/logo_loader_53122ca46c.png', NULL, 'local', NULL, '2022-01-03 00:56:28.771000', '2022-01-03 00:56:28.771000', 1, 1);
INSERT INTO `files` (`id`, `name`, `alternative_text`, `caption`, `width`, `height`, `formats`, `hash`, `ext`, `mime`, `size`, `url`, `preview_url`, `provider`, `provider_metadata`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(4, 'icon_logo.png', 'icon_logo.png', 'icon_logo.png', 169, 156, '{}', 'icon_logo_e1ac67568e', '.png', 'image/png', 7.28, '/uploads/icon_logo_e1ac67568e.png', NULL, 'local', NULL, '2022-01-03 01:08:06.835000', '2022-01-07 19:56:46.044000', 1, 1);
INSERT INTO `files` (`id`, `name`, `alternative_text`, `caption`, `width`, `height`, `formats`, `hash`, `ext`, `mime`, `size`, `url`, `preview_url`, `provider`, `provider_metadata`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(5, 'Untitled.png', 'Untitled.png', 'Untitled.png', 3300, 1346, '{\"large\": {\"ext\": \".png\", \"url\": \"/uploads/large_Untitled_84f4053732.png\", \"hash\": \"large_Untitled_84f4053732\", \"mime\": \"image/png\", \"name\": \"large_Untitled.png\", \"path\": null, \"size\": 1125.61, \"width\": 1000, \"height\": 408}, \"small\": {\"ext\": \".png\", \"url\": \"/uploads/small_Untitled_84f4053732.png\", \"hash\": \"small_Untitled_84f4053732\", \"mime\": \"image/png\", \"name\": \"small_Untitled.png\", \"path\": null, \"size\": 303.8, \"width\": 500, \"height\": 204}, \"medium\": {\"ext\": \".png\", \"url\": \"/uploads/medium_Untitled_84f4053732.png\", \"hash\": \"medium_Untitled_84f4053732\", \"mime\": \"image/png\", \"name\": \"medium_Untitled.png\", \"path\": null, \"size\": 652.66, \"width\": 750, \"height\": 306}, \"thumbnail\": {\"ext\": \".png\", \"url\": \"/uploads/thumbnail_Untitled_84f4053732.png\", \"hash\": \"thumbnail_Untitled_84f4053732\", \"mime\": \"image/png\", \"name\": \"thumbnail_Untitled.png\", \"path\": null, \"size\": 78.49, \"width\": 245, \"height\": 100}}', 'Untitled_84f4053732', '.png', 'image/png', 10334.79, '/uploads/Untitled_84f4053732.png', NULL, 'local', NULL, '2022-01-03 02:35:13.366000', '2022-01-03 02:35:13.366000', NULL, NULL);
INSERT INTO `files` (`id`, `name`, `alternative_text`, `caption`, `width`, `height`, `formats`, `hash`, `ext`, `mime`, `size`, `url`, `preview_url`, `provider`, `provider_metadata`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(6, '4.jpg', '4.jpg', '4.jpg', 3000, 3000, '{\"large\": {\"ext\": \".jpg\", \"url\": \"/uploads/large_4_1dea7f717b.jpg\", \"hash\": \"large_4_1dea7f717b\", \"mime\": \"image/jpeg\", \"name\": \"large_4.jpg\", \"path\": null, \"size\": 140.79, \"width\": 1000, \"height\": 1000}, \"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_4_1dea7f717b.jpg\", \"hash\": \"small_4_1dea7f717b\", \"mime\": \"image/jpeg\", \"name\": \"small_4.jpg\", \"path\": null, \"size\": 49.55, \"width\": 500, \"height\": 500}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_4_1dea7f717b.jpg\", \"hash\": \"medium_4_1dea7f717b\", \"mime\": \"image/jpeg\", \"name\": \"medium_4.jpg\", \"path\": null, \"size\": 92.78, \"width\": 750, \"height\": 750}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_4_1dea7f717b.jpg\", \"hash\": \"thumbnail_4_1dea7f717b\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_4.jpg\", \"path\": null, \"size\": 7.16, \"width\": 156, \"height\": 156}}', '4_1dea7f717b', '.jpg', 'image/jpeg', 624.91, '/uploads/4_1dea7f717b.jpg', NULL, 'local', NULL, '2022-01-04 19:33:18.937000', '2022-01-04 19:33:18.937000', 1, 1),
(7, '7.jpg', '7.jpg', '7.jpg', 3000, 3000, '{\"large\": {\"ext\": \".jpg\", \"url\": \"/uploads/large_7_b07f47d126.jpg\", \"hash\": \"large_7_b07f47d126\", \"mime\": \"image/jpeg\", \"name\": \"large_7.jpg\", \"path\": null, \"size\": 145.08, \"width\": 1000, \"height\": 1000}, \"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_7_b07f47d126.jpg\", \"hash\": \"small_7_b07f47d126\", \"mime\": \"image/jpeg\", \"name\": \"small_7.jpg\", \"path\": null, \"size\": 51.77, \"width\": 500, \"height\": 500}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_7_b07f47d126.jpg\", \"hash\": \"medium_7_b07f47d126\", \"mime\": \"image/jpeg\", \"name\": \"medium_7.jpg\", \"path\": null, \"size\": 95.65, \"width\": 750, \"height\": 750}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_7_b07f47d126.jpg\", \"hash\": \"thumbnail_7_b07f47d126\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_7.jpg\", \"path\": null, \"size\": 7.5, \"width\": 156, \"height\": 156}}', '7_b07f47d126', '.jpg', 'image/jpeg', 627.08, '/uploads/7_b07f47d126.jpg', NULL, 'local', NULL, '2022-01-04 19:33:18.943000', '2022-01-04 19:33:18.943000', 1, 1),
(8, '7_option3.jpg', '7_option3.jpg', '7_option3.jpg', 2887, 3955, '{\"large\": {\"ext\": \".jpg\", \"url\": \"/uploads/large_7_option3_a27e9b000c.jpg\", \"hash\": \"large_7_option3_a27e9b000c\", \"mime\": \"image/jpeg\", \"name\": \"large_7_option3.jpg\", \"path\": null, \"size\": 69.55, \"width\": 730, \"height\": 1000}, \"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_7_option3_a27e9b000c.jpg\", \"hash\": \"small_7_option3_a27e9b000c\", \"mime\": \"image/jpeg\", \"name\": \"small_7_option3.jpg\", \"path\": null, \"size\": 25.8, \"width\": 365, \"height\": 500}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_7_option3_a27e9b000c.jpg\", \"hash\": \"medium_7_option3_a27e9b000c\", \"mime\": \"image/jpeg\", \"name\": \"medium_7_option3.jpg\", \"path\": null, \"size\": 46.06, \"width\": 547, \"height\": 750}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_7_option3_a27e9b000c.jpg\", \"hash\": \"thumbnail_7_option3_a27e9b000c\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_7_option3.jpg\", \"path\": null, \"size\": 4.69, \"width\": 114, \"height\": 156}}', '7_option3_a27e9b000c', '.jpg', 'image/jpeg', 498.42, '/uploads/7_option3_a27e9b000c.jpg', NULL, 'local', NULL, '2022-01-04 19:33:18.984000', '2022-01-04 19:45:34.811000', 1, 1),
(9, 'double-exposure-2390185_1920.jpg', 'double-exposure-2390185_1920.jpg', 'double-exposure-2390185_1920.jpg', 1920, 1279, '{\"large\": {\"ext\": \".jpg\", \"url\": \"/uploads/large_double_exposure_2390185_1920_a07d941034.jpg\", \"hash\": \"large_double_exposure_2390185_1920_a07d941034\", \"mime\": \"image/jpeg\", \"name\": \"large_double-exposure-2390185_1920.jpg\", \"path\": null, \"size\": 13.6, \"width\": 1000, \"height\": 666}, \"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_double_exposure_2390185_1920_a07d941034.jpg\", \"hash\": \"small_double_exposure_2390185_1920_a07d941034\", \"mime\": \"image/jpeg\", \"name\": \"small_double-exposure-2390185_1920.jpg\", \"path\": null, \"size\": 5.29, \"width\": 500, \"height\": 333}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_double_exposure_2390185_1920_a07d941034.jpg\", \"hash\": \"medium_double_exposure_2390185_1920_a07d941034\", \"mime\": \"image/jpeg\", \"name\": \"medium_double-exposure-2390185_1920.jpg\", \"path\": null, \"size\": 9.01, \"width\": 750, \"height\": 500}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_double_exposure_2390185_1920_a07d941034.jpg\", \"hash\": \"thumbnail_double_exposure_2390185_1920_a07d941034\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_double-exposure-2390185_1920.jpg\", \"path\": null, \"size\": 2.19, \"width\": 234, \"height\": 156}}', 'double_exposure_2390185_1920_a07d941034', '.jpg', 'image/jpeg', 33.71, '/uploads/double_exposure_2390185_1920_a07d941034.jpg', NULL, 'local', NULL, '2022-01-05 02:26:52.936000', '2022-01-05 02:26:52.936000', 1, 1),
(10, 'Eventos-virtuales-1080x675.jpg', 'Eventos-virtuales-1080x675.jpg', 'Eventos-virtuales-1080x675.jpg', 1080, 675, '{\"large\": {\"ext\": \".jpg\", \"url\": \"/uploads/large_Eventos_virtuales_1080x675_72f022291d.jpg\", \"hash\": \"large_Eventos_virtuales_1080x675_72f022291d\", \"mime\": \"image/jpeg\", \"name\": \"large_Eventos-virtuales-1080x675.jpg\", \"path\": null, \"size\": 115.83, \"width\": 1000, \"height\": 625}, \"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_Eventos_virtuales_1080x675_72f022291d.jpg\", \"hash\": \"small_Eventos_virtuales_1080x675_72f022291d\", \"mime\": \"image/jpeg\", \"name\": \"small_Eventos-virtuales-1080x675.jpg\", \"path\": null, \"size\": 36.08, \"width\": 500, \"height\": 313}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_Eventos_virtuales_1080x675_72f022291d.jpg\", \"hash\": \"medium_Eventos_virtuales_1080x675_72f022291d\", \"mime\": \"image/jpeg\", \"name\": \"medium_Eventos-virtuales-1080x675.jpg\", \"path\": null, \"size\": 72.58, \"width\": 750, \"height\": 469}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_Eventos_virtuales_1080x675_72f022291d.jpg\", \"hash\": \"thumbnail_Eventos_virtuales_1080x675_72f022291d\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_Eventos-virtuales-1080x675.jpg\", \"path\": null, \"size\": 10.98, \"width\": 245, \"height\": 153}}', 'Eventos_virtuales_1080x675_72f022291d', '.jpg', 'image/jpeg', 135.10, '/uploads/Eventos_virtuales_1080x675_72f022291d.jpg', NULL, 'local', NULL, '2022-01-05 02:29:46.204000', '2022-01-05 02:29:46.204000', 1, 1);
INSERT INTO `files` (`id`, `name`, `alternative_text`, `caption`, `width`, `height`, `formats`, `hash`, `ext`, `mime`, `size`, `url`, `preview_url`, `provider`, `provider_metadata`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(12, 'linkin.png', 'linkin.png r', 'linkin.png', 21, 14, '{}', 'linkin_215ea35ddb', '.png', 'image/png', 0.31, '/uploads/linkin_215ea35ddb.png', NULL, 'local', NULL, '2022-01-07 17:45:06.552000', '2022-01-07 19:55:52.870000', 1, 1),
(13, 'double_exposure_2390185_1920_a07d941034.jpg', 'double_exposure_2390185_1920_a07d941034.jpg', 'double_exposure_2390185_1920_a07d941034.jpg', 1920, 1279, '{\"large\": {\"ext\": \".jpg\", \"url\": \"/uploads/large_double_exposure_2390185_1920_a07d941034_705f840eda.jpg\", \"hash\": \"large_double_exposure_2390185_1920_a07d941034_705f840eda\", \"mime\": \"image/jpeg\", \"name\": \"large_double_exposure_2390185_1920_a07d941034.jpg\", \"path\": null, \"size\": 13.6, \"width\": 1000, \"height\": 666}, \"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_double_exposure_2390185_1920_a07d941034_705f840eda.jpg\", \"hash\": \"small_double_exposure_2390185_1920_a07d941034_705f840eda\", \"mime\": \"image/jpeg\", \"name\": \"small_double_exposure_2390185_1920_a07d941034.jpg\", \"path\": null, \"size\": 5.29, \"width\": 500, \"height\": 333}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_double_exposure_2390185_1920_a07d941034_705f840eda.jpg\", \"hash\": \"medium_double_exposure_2390185_1920_a07d941034_705f840eda\", \"mime\": \"image/jpeg\", \"name\": \"medium_double_exposure_2390185_1920_a07d941034.jpg\", \"path\": null, \"size\": 9.01, \"width\": 750, \"height\": 500}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_double_exposure_2390185_1920_a07d941034_705f840eda.jpg\", \"hash\": \"thumbnail_double_exposure_2390185_1920_a07d941034_705f840eda\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_double_exposure_2390185_1920_a07d941034.jpg\", \"path\": null, \"size\": 2.19, \"width\": 234, \"height\": 156}}', 'double_exposure_2390185_1920_a07d941034_705f840eda', '.jpg', 'image/jpeg', 33.71, '/uploads/double_exposure_2390185_1920_a07d941034_705f840eda.jpg', NULL, 'local', NULL, '2022-01-07 19:50:41.978000', '2022-01-07 19:50:41.978000', 1, 1),
(14, 'alienide_sample_page_head_full.jpg', 'alienide_sample_page_head_full.jpg', 'alienide_sample_page_head_full.jpg', 1920, 1808, '{\"large\": {\"ext\": \".jpg\", \"url\": \"/uploads/large_alienide_sample_page_head_full_706af1aba0.jpg\", \"hash\": \"large_alienide_sample_page_head_full_706af1aba0\", \"mime\": \"image/jpeg\", \"name\": \"large_alienide_sample_page_head_full.jpg\", \"path\": null, \"size\": 259.44, \"width\": 1000, \"height\": 942}, \"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_alienide_sample_page_head_full_706af1aba0.jpg\", \"hash\": \"small_alienide_sample_page_head_full_706af1aba0\", \"mime\": \"image/jpeg\", \"name\": \"small_alienide_sample_page_head_full.jpg\", \"path\": null, \"size\": 78.71, \"width\": 500, \"height\": 471}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_alienide_sample_page_head_full_706af1aba0.jpg\", \"hash\": \"medium_alienide_sample_page_head_full_706af1aba0\", \"mime\": \"image/jpeg\", \"name\": \"medium_alienide_sample_page_head_full.jpg\", \"path\": null, \"size\": 156.43, \"width\": 750, \"height\": 706}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_alienide_sample_page_head_full_706af1aba0.jpg\", \"hash\": \"thumbnail_alienide_sample_page_head_full_706af1aba0\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_alienide_sample_page_head_full.jpg\", \"path\": null, \"size\": 11.54, \"width\": 166, \"height\": 156}}', 'alienide_sample_page_head_full_706af1aba0', '.jpg', 'image/jpeg', 688.61, '/uploads/alienide_sample_page_head_full_706af1aba0.jpg', NULL, 'local', NULL, '2022-01-12 16:24:29.042000', '2022-01-12 16:24:29.042000', 1, 1),
(15, 'alienide_sample_page_head_half.jpg', 'alienide_sample_page_head_half.jpg', 'alienide_sample_page_head_half.jpg', 1920, 368, '{\"large\": {\"ext\": \".jpg\", \"url\": \"/uploads/large_alienide_sample_page_head_half_ae30f1cb0a.jpg\", \"hash\": \"large_alienide_sample_page_head_half_ae30f1cb0a\", \"mime\": \"image/jpeg\", \"name\": \"large_alienide_sample_page_head_half.jpg\", \"path\": null, \"size\": 65.45, \"width\": 1000, \"height\": 192}, \"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_alienide_sample_page_head_half_ae30f1cb0a.jpg\", \"hash\": \"small_alienide_sample_page_head_half_ae30f1cb0a\", \"mime\": \"image/jpeg\", \"name\": \"small_alienide_sample_page_head_half.jpg\", \"path\": null, \"size\": 18.82, \"width\": 500, \"height\": 96}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_alienide_sample_page_head_half_ae30f1cb0a.jpg\", \"hash\": \"medium_alienide_sample_page_head_half_ae30f1cb0a\", \"mime\": \"image/jpeg\", \"name\": \"medium_alienide_sample_page_head_half.jpg\", \"path\": null, \"size\": 38.16, \"width\": 750, \"height\": 144}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_alienide_sample_page_head_half_ae30f1cb0a.jpg\", \"hash\": \"thumbnail_alienide_sample_page_head_half_ae30f1cb0a\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_alienide_sample_page_head_half.jpg\", \"path\": null, \"size\": 5.52, \"width\": 245, \"height\": 47}}', 'alienide_sample_page_head_half_ae30f1cb0a', '.jpg', 'image/jpeg', 198.91, '/uploads/alienide_sample_page_head_half_ae30f1cb0a.jpg', NULL, 'local', NULL, '2022-01-12 16:48:36.724000', '2022-01-12 16:48:36.724000', 1, 1),
(16, 'keyboard_blog.jpg', 'keyboard_blog.jpg', 'keyboard_blog.jpg', 880, 586, '{\"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_keyboard_blog_8aab9743d4.jpg\", \"hash\": \"small_keyboard_blog_8aab9743d4\", \"mime\": \"image/jpeg\", \"name\": \"small_keyboard_blog.jpg\", \"path\": null, \"size\": 27.25, \"width\": 500, \"height\": 333}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_keyboard_blog_8aab9743d4.jpg\", \"hash\": \"medium_keyboard_blog_8aab9743d4\", \"mime\": \"image/jpeg\", \"name\": \"medium_keyboard_blog.jpg\", \"path\": null, \"size\": 48.74, \"width\": 750, \"height\": 499}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_keyboard_blog_8aab9743d4.jpg\", \"hash\": \"thumbnail_keyboard_blog_8aab9743d4\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_keyboard_blog.jpg\", \"path\": null, \"size\": 9.03, \"width\": 234, \"height\": 156}}', 'keyboard_blog_8aab9743d4', '.jpg', 'image/jpeg', 44.03, '/uploads/keyboard_blog_8aab9743d4.jpg', NULL, 'local', NULL, '2022-01-12 17:21:51.903000', '2022-01-12 17:21:51.903000', 1, 1),
(17, 'mail_abstract.jpg', 'mail_abstract.jpg', 'mail_abstract.jpg', 852, 480, '{\"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_mail_abstract_38500ab5aa.jpg\", \"hash\": \"small_mail_abstract_38500ab5aa\", \"mime\": \"image/jpeg\", \"name\": \"small_mail_abstract.jpg\", \"path\": null, \"size\": 26.5, \"width\": 500, \"height\": 282}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_mail_abstract_38500ab5aa.jpg\", \"hash\": \"medium_mail_abstract_38500ab5aa\", \"mime\": \"image/jpeg\", \"name\": \"medium_mail_abstract.jpg\", \"path\": null, \"size\": 51.26, \"width\": 750, \"height\": 423}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_mail_abstract_38500ab5aa.jpg\", \"hash\": \"thumbnail_mail_abstract_38500ab5aa\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_mail_abstract.jpg\", \"path\": null, \"size\": 7.74, \"width\": 245, \"height\": 138}}', 'mail_abstract_38500ab5aa', '.jpg', 'image/jpeg', 57.34, '/uploads/mail_abstract_38500ab5aa.jpg', NULL, 'local', NULL, '2022-01-12 17:23:11.873000', '2022-01-12 17:23:11.873000', 1, 1),
(18, 'logo-white.png', 'logo-white.png', 'logo-white.png', 601, 130, '{\"small\": {\"ext\": \".png\", \"url\": \"/uploads/small_logo_white_4d6f448ddb.png\", \"hash\": \"small_logo_white_4d6f448ddb\", \"mime\": \"image/png\", \"name\": \"small_logo-white.png\", \"path\": null, \"size\": 14.26, \"width\": 500, \"height\": 108}, \"thumbnail\": {\"ext\": \".png\", \"url\": \"/uploads/thumbnail_logo_white_4d6f448ddb.png\", \"hash\": \"thumbnail_logo_white_4d6f448ddb\", \"mime\": \"image/png\", \"name\": \"thumbnail_logo-white.png\", \"path\": null, \"size\": 5.93, \"width\": 245, \"height\": 53}}', 'logo_white_4d6f448ddb', '.png', 'image/png', 10.73, '/uploads/logo_white_4d6f448ddb.png', NULL, 'local', NULL, '2022-01-17 13:26:10.158000', '2022-01-17 13:26:10.158000', 1, 1),
(19, 'China-Brefing-Chinas-New-Gaming-Regulations-What-it-Means-for-Investors.jpg', 'China-Brefing-Chinas-New-Gaming-Regulations-What-it-Means-for-Investors.jpg', 'China-Brefing-Chinas-New-Gaming-Regulations-What-it-Means-for-Investors.jpg', 900, 506, '{\"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_China_Brefing_Chinas_New_Gaming_Regulations_What_it_Means_for_Investors_3cbc786326.jpg\", \"hash\": \"small_China_Brefing_Chinas_New_Gaming_Regulations_What_it_Means_for_Investors_3cbc786326\", \"mime\": \"image/jpeg\", \"name\": \"small_China-Brefing-Chinas-New-Gaming-Regulations-What-it-Means-for-Investors.jpg\", \"path\": null, \"size\": 21.92, \"width\": 500, \"height\": 281}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_China_Brefing_Chinas_New_Gaming_Regulations_What_it_Means_for_Investors_3cbc786326.jpg\", \"hash\": \"medium_China_Brefing_Chinas_New_Gaming_Regulations_What_it_Means_for_Investors_3cbc786326\", \"mime\": \"image/jpeg\", \"name\": \"medium_China-Brefing-Chinas-New-Gaming-Regulations-What-it-Means-for-Investors.jpg\", \"path\": null, \"size\": 38.68, \"width\": 750, \"height\": 422}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_China_Brefing_Chinas_New_Gaming_Regulations_What_it_Means_for_Investors_3cbc786326.jpg\", \"hash\": \"thumbnail_China_Brefing_Chinas_New_Gaming_Regulations_What_it_Means_for_Investors_3cbc786326\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_China-Brefing-Chinas-New-Gaming-Regulations-What-it-Means-for-Investors.jpg\", \"path\": null, \"size\": 8.24, \"width\": 245, \"height\": 138}}', 'China_Brefing_Chinas_New_Gaming_Regulations_What_it_Means_for_Investors_3cbc786326', '.jpg', 'image/jpeg', 51.15, '/uploads/China_Brefing_Chinas_New_Gaming_Regulations_What_it_Means_for_Investors_3cbc786326.jpg', NULL, 'local', NULL, '2022-01-18 02:59:11.200000', '2022-01-18 02:59:11.200000', 1, 1),
(20, 'lg_w_sq.png', 'lg_w_sq.png', 'lg_w_sq.png', 200, 200, '{\"thumbnail\": {\"ext\": \".png\", \"url\": \"/uploads/thumbnail_lg_w_sq_a8b4979d73.png\", \"hash\": \"thumbnail_lg_w_sq_a8b4979d73\", \"mime\": \"image/png\", \"name\": \"thumbnail_lg_w_sq.png\", \"path\": null, \"size\": 3.72, \"width\": 156, \"height\": 156}}', 'lg_w_sq_a8b4979d73', '.png', 'image/png', 3.96, '/uploads/lg_w_sq_a8b4979d73.png', NULL, 'local', NULL, '2022-01-18 13:34:10.857000', '2022-01-18 13:34:10.857000', 1, 1),
(21, 'logo-black.png', 'logo-black.png', 'logo-black.png', 601, 130, '{\"small\": {\"ext\": \".png\", \"url\": \"/uploads/small_logo_black_22f74e824e.png\", \"hash\": \"small_logo_black_22f74e824e\", \"mime\": \"image/png\", \"name\": \"small_logo-black.png\", \"path\": null, \"size\": 12.68, \"width\": 500, \"height\": 108}, \"thumbnail\": {\"ext\": \".png\", \"url\": \"/uploads/thumbnail_logo_black_22f74e824e.png\", \"hash\": \"thumbnail_logo_black_22f74e824e\", \"mime\": \"image/png\", \"name\": \"thumbnail_logo-black.png\", \"path\": null, \"size\": 5.52, \"width\": 245, \"height\": 53}}', 'logo_black_22f74e824e', '.png', 'image/png', 12.72, '/uploads/logo_black_22f74e824e.png', NULL, 'local', NULL, '2022-01-18 13:39:55.861000', '2022-01-18 13:39:55.861000', 1, 1),
(23, 'avtr.png', 'avtr.png', 'avtr.png', 222, 227, '{\"thumbnail\": {\"ext\": \".png\", \"url\": \"/uploads/thumbnail_avtr_1affde0fa2.png\", \"hash\": \"thumbnail_avtr_1affde0fa2\", \"mime\": \"image/png\", \"name\": \"thumbnail_avtr.png\", \"path\": null, \"size\": 11.61, \"width\": 153, \"height\": 156}}', 'avtr_1affde0fa2', '.png', 'image/png', 4.29, '/uploads/avtr_1affde0fa2.png', NULL, 'local', NULL, '2022-01-18 15:09:12.728000', '2022-01-18 15:09:12.728000', 1, 1),
(24, 'cartoon-avatar-of-smiling-beard-man-profile-icon-vector.jpg', 'cartoon-avatar-of-smiling-beard-man-profile-icon-vector.jpg', 'cartoon-avatar-of-smiling-beard-man-profile-icon-vector.jpg', 1920, 1920, '{\"large\": {\"ext\": \".jpg\", \"url\": \"/uploads/large_cartoon_avatar_of_smiling_beard_man_profile_icon_vector_0b58c5e33d.jpg\", \"hash\": \"large_cartoon_avatar_of_smiling_beard_man_profile_icon_vector_0b58c5e33d\", \"mime\": \"image/jpeg\", \"name\": \"large_cartoon-avatar-of-smiling-beard-man-profile-icon-vector.jpg\", \"path\": null, \"size\": 24.63, \"width\": 1000, \"height\": 1000}, \"small\": {\"ext\": \".jpg\", \"url\": \"/uploads/small_cartoon_avatar_of_smiling_beard_man_profile_icon_vector_0b58c5e33d.jpg\", \"hash\": \"small_cartoon_avatar_of_smiling_beard_man_profile_icon_vector_0b58c5e33d\", \"mime\": \"image/jpeg\", \"name\": \"small_cartoon-avatar-of-smiling-beard-man-profile-icon-vector.jpg\", \"path\": null, \"size\": 11.26, \"width\": 500, \"height\": 500}, \"medium\": {\"ext\": \".jpg\", \"url\": \"/uploads/medium_cartoon_avatar_of_smiling_beard_man_profile_icon_vector_0b58c5e33d.jpg\", \"hash\": \"medium_cartoon_avatar_of_smiling_beard_man_profile_icon_vector_0b58c5e33d\", \"mime\": \"image/jpeg\", \"name\": \"medium_cartoon-avatar-of-smiling-beard-man-profile-icon-vector.jpg\", \"path\": null, \"size\": 17.63, \"width\": 750, \"height\": 750}, \"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_cartoon_avatar_of_smiling_beard_man_profile_icon_vector_0b58c5e33d.jpg\", \"hash\": \"thumbnail_cartoon_avatar_of_smiling_beard_man_profile_icon_vector_0b58c5e33d\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_cartoon-avatar-of-smiling-beard-man-profile-icon-vector.jpg\", \"path\": null, \"size\": 3.22, \"width\": 156, \"height\": 156}}', 'cartoon_avatar_of_smiling_beard_man_profile_icon_vector_0b58c5e33d', '.jpg', 'image/jpeg', 59.94, '/uploads/cartoon_avatar_of_smiling_beard_man_profile_icon_vector_0b58c5e33d.jpg', NULL, 'local', NULL, '2022-01-19 00:46:38.209000', '2022-01-19 00:46:38.209000', 1, 1);
INSERT INTO `files` (`id`, `name`, `alternative_text`, `caption`, `width`, `height`, `formats`, `hash`, `ext`, `mime`, `size`, `url`, `preview_url`, `provider`, `provider_metadata`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(25, 'download (1).jpg', 'download (1).jpg', 'download (1).jpg', 273, 184, '{\"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_download_1_d61500044a.jpg\", \"hash\": \"thumbnail_download_1_d61500044a\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_download (1).jpg\", \"path\": null, \"size\": 8.92, \"width\": 231, \"height\": 156}}', 'download_1_d61500044a', '.jpg', 'image/jpeg', 7.15, '/uploads/download_1_d61500044a.jpg', NULL, 'local', NULL, '2022-01-19 00:56:32.080000', '2022-01-19 00:56:32.080000', 1, 1),
(26, 'casual-close-up-eyeglasses-1516680.jpg', 'casual-close-up-eyeglasses-1516680.jpg', 'casual-close-up-eyeglasses-1516680.jpg', 200, 200, '{\"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_casual_close_up_eyeglasses_1516680_a11934afa5.jpg\", \"hash\": \"thumbnail_casual_close_up_eyeglasses_1516680_a11934afa5\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_casual-close-up-eyeglasses-1516680.jpg\", \"path\": null, \"size\": 2.06, \"width\": 156, \"height\": 156}}', 'casual_close_up_eyeglasses_1516680_a11934afa5', '.jpg', 'image/jpeg', 2.47, '/uploads/casual_close_up_eyeglasses_1516680_a11934afa5.jpg', NULL, 'local', NULL, '2022-01-19 01:18:44.725000', '2022-01-19 01:18:44.725000', 1, 1),
(27, 'adult-blur-brick-walls-846741.jpg', 'adult-blur-brick-walls-846741.jpg', 'adult-blur-brick-walls-846741.jpg', 200, 200, '{\"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_adult_blur_brick_walls_846741_e3a68f5081.jpg\", \"hash\": \"thumbnail_adult_blur_brick_walls_846741_e3a68f5081\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_adult-blur-brick-walls-846741.jpg\", \"path\": null, \"size\": 2.14, \"width\": 156, \"height\": 156}}', 'adult_blur_brick_walls_846741_e3a68f5081', '.jpg', 'image/jpeg', 2.53, '/uploads/adult_blur_brick_walls_846741_e3a68f5081.jpg', NULL, 'local', NULL, '2022-01-19 01:20:54.811000', '2022-01-19 01:20:54.811000', 1, 1),
(28, 'blue-boy-daylight-1205033.jpg', 'blue-boy-daylight-1205033.jpg', 'blue-boy-daylight-1205033.jpg', 200, 200, '{\"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_blue_boy_daylight_1205033_2b1783b183.jpg\", \"hash\": \"thumbnail_blue_boy_daylight_1205033_2b1783b183\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_blue-boy-daylight-1205033.jpg\", \"path\": null, \"size\": 2.63, \"width\": 156, \"height\": 156}}', 'blue_boy_daylight_1205033_2b1783b183', '.jpg', 'image/jpeg', 3.23, '/uploads/blue_boy_daylight_1205033_2b1783b183.jpg', NULL, 'local', NULL, '2022-01-19 01:21:43.355000', '2022-01-19 01:21:43.355000', 1, 1),
(29, 'adolescent-beautiful-beauty-247878.jpg', 'adolescent-beautiful-beauty-247878.jpg', 'adolescent-beautiful-beauty-247878.jpg', 200, 200, '{\"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_adolescent_beautiful_beauty_247878_2459fecbc1.jpg\", \"hash\": \"thumbnail_adolescent_beautiful_beauty_247878_2459fecbc1\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_adolescent-beautiful-beauty-247878.jpg\", \"path\": null, \"size\": 1.99, \"width\": 156, \"height\": 156}}', 'adolescent_beautiful_beauty_247878_2459fecbc1', '.jpg', 'image/jpeg', 2.31, '/uploads/adolescent_beautiful_beauty_247878_2459fecbc1.jpg', NULL, 'local', NULL, '2022-01-19 01:24:14.870000', '2022-01-19 01:24:14.870000', 1, 1),
(30, 'attractive-background-beautiful-756453.jpg', 'attractive-background-beautiful-756453.jpg', 'attractive-background-beautiful-756453.jpg', 200, 200, '{\"thumbnail\": {\"ext\": \".jpg\", \"url\": \"/uploads/thumbnail_attractive_background_beautiful_756453_2bf72a5790.jpg\", \"hash\": \"thumbnail_attractive_background_beautiful_756453_2bf72a5790\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_attractive-background-beautiful-756453.jpg\", \"path\": null, \"size\": 2.04, \"width\": 156, \"height\": 156}}', 'attractive_background_beautiful_756453_2bf72a5790', '.jpg', 'image/jpeg', 2.45, '/uploads/attractive_background_beautiful_756453_2bf72a5790.jpg', NULL, 'local', NULL, '2022-01-19 01:48:02.740000', '2022-01-19 01:48:02.740000', 1, 1),
(31, 'pexels-photo-688988.jpeg', 'pexels-photo-688988.jpeg', 'pexels-photo-688988.jpeg', 1920, 1280, '{\"large\": {\"ext\": \".jpeg\", \"url\": \"/uploads/large_pexels_photo_688988_8f30a0e963.jpeg\", \"hash\": \"large_pexels_photo_688988_8f30a0e963\", \"mime\": \"image/jpeg\", \"name\": \"large_pexels-photo-688988.jpeg\", \"path\": null, \"size\": 21.21, \"width\": 1000, \"height\": 667}, \"small\": {\"ext\": \".jpeg\", \"url\": \"/uploads/small_pexels_photo_688988_8f30a0e963.jpeg\", \"hash\": \"small_pexels_photo_688988_8f30a0e963\", \"mime\": \"image/jpeg\", \"name\": \"small_pexels-photo-688988.jpeg\", \"path\": null, \"size\": 7.9, \"width\": 500, \"height\": 333}, \"medium\": {\"ext\": \".jpeg\", \"url\": \"/uploads/medium_pexels_photo_688988_8f30a0e963.jpeg\", \"hash\": \"medium_pexels_photo_688988_8f30a0e963\", \"mime\": \"image/jpeg\", \"name\": \"medium_pexels-photo-688988.jpeg\", \"path\": null, \"size\": 14.09, \"width\": 750, \"height\": 500}, \"thumbnail\": {\"ext\": \".jpeg\", \"url\": \"/uploads/thumbnail_pexels_photo_688988_8f30a0e963.jpeg\", \"hash\": \"thumbnail_pexels_photo_688988_8f30a0e963\", \"mime\": \"image/jpeg\", \"name\": \"thumbnail_pexels-photo-688988.jpeg\", \"path\": null, \"size\": 3.09, \"width\": 234, \"height\": 156}}', 'pexels_photo_688988_8f30a0e963', '.jpeg', 'image/jpeg', 51.47, '/uploads/pexels_photo_688988_8f30a0e963.jpeg', NULL, 'local', NULL, '2022-01-22 09:47:46.230000', '2022-01-22 09:47:46.230000', 5, 5);

INSERT INTO `files_related_morphs` (`file_id`, `related_id`, `related_type`, `field`, `order`) VALUES
(5, 1, 'api::home-page-slider.home-page-slider', 'image', 1);
INSERT INTO `files_related_morphs` (`file_id`, `related_id`, `related_type`, `field`, `order`) VALUES
(12, 4, 'api::client.client', 'logo', 1);
INSERT INTO `files_related_morphs` (`file_id`, `related_id`, `related_type`, `field`, `order`) VALUES
(10, 4, 'media.gallery', 'images', 1);
INSERT INTO `files_related_morphs` (`file_id`, `related_id`, `related_type`, `field`, `order`) VALUES
(10, 4, 'elements.slider', 'image', 1),
(9, 1, 'mixed.seo', 'share_thumbnail', 1),
(10, 1, 'elements.menu-item', 'hover_image', 1),
(10, 2, 'elements.menu-item', 'hover_image', 1),
(5, 5, 'elements.menu-item', 'hover_image', 1),
(9, 4, 'elements.menu-item', 'hover_image', 1),
(10, 3, 'elements.menu-item', 'hover_image', 1),
(15, 12, 'elements.menu-item', 'hover_image', 1),
(10, 13, 'elements.menu-item', 'hover_image', 1),
(14, 7, 'elements.menu-item', 'hover_image', 1),
(9, 6, 'elements.menu-item', 'hover_image', 1),
(10, 8, 'elements.menu-item', 'hover_image', 1),
(14, 9, 'elements.menu-item', 'hover_image', 1),
(17, 11, 'elements.menu-item', 'hover_image', 1),
(16, 10, 'elements.menu-item', 'hover_image', 1),
(17, 24, 'elements.menu-item', 'hover_image', 1),
(9, 23, 'elements.menu-item', 'hover_image', 1),
(16, 26, 'elements.menu-item', 'hover_image', 1),
(15, 27, 'elements.menu-item', 'hover_image', 1),
(10, 25, 'elements.menu-item', 'hover_image', 1),
(10, 28, 'elements.menu-item', 'hover_image', 1),
(10, 31, 'elements.menu-item', 'hover_image', 1),
(10, 18, 'elements.menu-item', 'hover_image', 1),
(9, 17, 'elements.menu-item', 'hover_image', 1),
(15, 20, 'elements.menu-item', 'hover_image', 1),
(10, 19, 'elements.menu-item', 'hover_image', 1),
(16, 21, 'elements.menu-item', 'hover_image', 1),
(17, 22, 'elements.menu-item', 'hover_image', 1),
(8, 2, 'media.gallery', 'images', 1),
(7, 2, 'media.gallery', 'images', 2),
(6, 2, 'media.gallery', 'images', 3),
(10, 1, 'api::portfolio.portfolio', 'image', 1),
(8, 8, 'media.gallery', 'images', 1),
(7, 8, 'media.gallery', 'images', 2),
(6, 8, 'media.gallery', 'images', 3),
(19, 4, 'api::portfolio.portfolio', 'image', 1),
(20, 2, 'api::client.client', 'logo', 1),
(1, 3, 'api::client.client', 'logo', 1),
(4, 6, 'api::client.client', 'logo', 1),
(4, 8, 'api::client.client', 'logo', 1),
(20, 5, 'api::client.client', 'logo', 1),
(20, 10, 'api::client.client', 'logo', 1),
(20, 7, 'api::client.client', 'logo', 1),
(1, 9, 'api::client.client', 'logo', 1),
(8, 9, 'media.gallery', 'images', 1),
(7, 9, 'media.gallery', 'images', 2),
(6, 9, 'media.gallery', 'images', 3),
(10, 5, 'api::portfolio.portfolio', 'image', 1),
(8, 10, 'media.gallery', 'images', 1),
(7, 10, 'media.gallery', 'images', 2),
(6, 10, 'media.gallery', 'images', 3),
(17, 6, 'api::portfolio.portfolio', 'image', 1),
(8, 11, 'media.gallery', 'images', 1),
(7, 11, 'media.gallery', 'images', 2),
(6, 11, 'media.gallery', 'images', 3),
(14, 7, 'api::portfolio.portfolio', 'image', 1),
(8, 7, 'media.gallery', 'images', 1),
(7, 7, 'media.gallery', 'images', 2),
(6, 7, 'media.gallery', 'images', 3),
(14, 3, 'api::portfolio.portfolio', 'image', 1),
(23, 1, 'api::testimonial.testimonial', 'avatar', 1),
(21, 1, 'media.logos', 'normal', 1),
(21, 1, 'media.logos', 'light', 1),
(18, 1, 'media.logos', 'dark', 1),
(1, 1, 'media.logos', 'loader', 1),
(4, 1, 'elements.social-info', 'icon', 1),
(24, 4, 'api::testimonial.testimonial', 'avatar', 1),
(25, 5, 'api::testimonial.testimonial', 'avatar', 1),
(23, 3, 'api::testimonial.testimonial', 'avatar', 1),
(28, 3, 'api::team-member.team-member', 'photo', 1),
(26, 1, 'api::team-member.team-member', 'photo', 1),
(10, 4, 'api::service.service', 'image', 1),
(17, 3, 'api::service.service', 'image', 1),
(5, 5, 'api::service.service', 'image', 1),
(19, 6, 'api::service.service', 'image', 1),
(17, 7, 'api::service.service', 'image', 1),
(8, 12, 'media.gallery', 'images', 1),
(7, 12, 'media.gallery', 'images', 2),
(6, 12, 'media.gallery', 'images', 3),
(10, 8, 'api::portfolio.portfolio', 'image', 1),
(10, 4, 'api::article.article', 'featured_image', 1),
(14, 4, 'api::article.article', 'thumbnail', 1),
(9, 5, 'api::article.article', 'featured_image', 1);
INSERT INTO `files_related_morphs` (`file_id`, `related_id`, `related_type`, `field`, `order`) VALUES
(29, 5, 'api::team-member.team-member', 'photo', 1),
(27, 2, 'api::team-member.team-member', 'photo', 1),
(29, 4, 'api::team-member.team-member', 'photo', 1),
(16, 3, 'api::article.article', 'featured_image', 1),
(29, 6, 'api::article.article', 'featured_image', 1),
(16, 2, 'api::article.article', 'featured_image', 1),
(17, 2, 'api::article.article', 'thumbnail', 1),
(19, 2, 'api::service.service', 'image', 1),
(5, 1, 'elements.slider', 'image', 1),
(10, 3, 'elements.slider', 'image', 1),
(19, 5, 'elements.slider', 'image', 1),
(9, 2, 'elements.slider', 'image', 1),
(14, 8, 'api::article.article', 'featured_image', 1),
(28, 8, 'api::article.article', 'thumbnail', 1),
(4, 5, 'mixed.seo', 'share_thumbnail', 1),
(14, 5, 'api::page.page', 'header_image', 1),
(10, 7, 'api::page.page', 'header_image', 1),
(15, 8, 'api::page.page', 'header_image', 1),
(15, 9, 'api::page.page', 'header_image', 1),
(4, 4, 'mixed.seo', 'share_thumbnail', 1),
(10, 4, 'api::page.page', 'header_image', 1),
(4, 6, 'mixed.seo', 'share_thumbnail', 1),
(16, 6, 'api::page.page', 'header_image', 1),
(10, 4, 'api::blog-category.blog-category', 'image', 1),
(7, 6, 'media.gallery', 'images', 1),
(8, 6, 'media.gallery', 'images', 2),
(14, 10, 'api::page.page', 'header_image', 1),
(4, 3, 'mixed.seo', 'share_thumbnail', 1),
(14, 3, 'api::page.page', 'header_image', 1),
(30, 13, 'media.gallery', 'images', 1),
(29, 13, 'media.gallery', 'images', 2),
(28, 13, 'media.gallery', 'images', 3),
(4, 2, 'mixed.seo', 'share_thumbnail', 1),
(14, 2, 'api::page.page', 'header_image', 1);

INSERT INTO `homepage_sliders` (`id`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 1, '2022-01-05 02:30:03.079000', '2022-01-23 14:12:44.045000', '2022-01-05 02:30:06.238000', 1, 1);


INSERT INTO `homepage_sliders_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(12, 1, 3, 'elements.slider', 'slides', 1);
INSERT INTO `homepage_sliders_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(13, 1, 1, 'elements.slider', 'slides', 2);
INSERT INTO `homepage_sliders_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(14, 1, 2, 'elements.slider', 'slides', 3);
INSERT INTO `homepage_sliders_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(15, 1, 5, 'elements.slider', 'slides', 4);

INSERT INTO `i18n_locale` (`id`, `name`, `code`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 'English (en)', 'en', '2022-01-02 21:36:53.739000', '2022-01-02 21:36:53.739000', NULL, NULL);


INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 'Primary menu', '2022-01-13 16:43:10.815000', '2022-01-17 19:25:19.583000', '2022-01-13 17:00:13.010000', 1, 1);
INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`) VALUES
(2, 'Footer menu left', '2022-01-13 16:56:48.488000', '2022-01-13 16:57:18.980000', '2022-01-13 16:57:18.824000', 1, 1);
INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`) VALUES
(3, 'Footer menu right', '2022-01-13 16:58:13.961000', '2022-01-17 14:54:59.168000', '2022-01-13 16:58:26.504000', 1, 1);

INSERT INTO `menus_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(8, 2, 23, 'elements.menu-item', 'items', 1);
INSERT INTO `menus_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(9, 2, 28, 'elements.menu-item', 'items', 2);
INSERT INTO `menus_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(10, 2, 25, 'elements.menu-item', 'items', 3);
INSERT INTO `menus_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(11, 2, 27, 'elements.menu-item', 'items', 4),
(12, 2, 26, 'elements.menu-item', 'items', 5),
(13, 2, 24, 'elements.menu-item', 'items', 6),
(16, 3, 29, 'elements.menu-item', 'items', 1),
(17, 3, 30, 'elements.menu-item', 'items', 2),
(18, 3, 31, 'elements.menu-item', 'items', 3),
(26, 1, 17, 'elements.menu-item', 'items', 1),
(27, 1, 18, 'elements.menu-item', 'items', 2),
(28, 1, 19, 'elements.menu-item', 'items', 3),
(29, 1, 20, 'elements.menu-item', 'items', 4),
(30, 1, 21, 'elements.menu-item', 'items', 5),
(31, 1, 22, 'elements.menu-item', 'items', 6);

INSERT INTO `pages` (`id`, `title`, `sub_title`, `type`, `leaf_content`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `slug`, `header_size`) VALUES
(2, 'Home', NULL, 'prebuilt', NULL, 1, '2022-01-12 16:27:31.290000', '2022-02-24 11:18:07.826000', '2022-01-12 16:27:36.342000', 1, 4, 'home', 'full');
INSERT INTO `pages` (`id`, `title`, `sub_title`, `type`, `leaf_content`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `slug`, `header_size`) VALUES
(3, 'About', 'We gamify everything.', 'prebuilt', 'ALIENIDE INTERACTIVE IS THE PLAYGROUND OF TECHNOLOGIES THAT WORKS TO CREATE DIGITAL ILLUSIONS THROUGH VIDEO GAMES AND SIMULATIONS\n\nALIENIDE Interactive is a Dhaka based full-fledged game studio which works with different sectors of gaming and engineering. Over the year, we have grown our expertise on high-end game engines such as Unity and Unreal. We have worked with cutting edge gaming devices and controllers such as Microsoft XBOX KINECT, PS3 Move and PS3 Eye, Nintendo Wii Mote, LEAP Motion, Myo Armband, Emotiv EPOC, Oculus VR and Google Cardboard etc.With team members from diverse background such as Computer Science, Fine Arts, 2D and 3D Graphics and Animation, Electronics and Electrical engineering and Robotics and having previous experience of designing military simulators and participation in robotics project contest by NASA, we aim to take video games to the next level where we combine electronics with video games and virtual reality to create complex simulation system.\n\nWe have a culture of kindness, transparency, and play. There is a lot of heart and passion at this studio – we get to work on projects we’re proud of and we work hard to be the best at what we do. We are curious, we strive for excellence, we build on each other’s ideas, and we celebrate each other’s great work. We organize movie nights, game tournaments, life drawing, community and charity events, and more. Basically, we believe that good work starts with a community you’re excited to spend your day with, both in and out of the studio.\n\nWe love creating and playing games. We value ideas and innovation so every title we deliver is a reflection of our entire teams’ talents and passions. We have the best of two worlds: the autonomous, entrepreneurial spirit and talent of an indie developer combined with the extensive reach of a large publisher. The story of Alienide is ours to create.\n\nFrom the outset, Alienate sought to balance the priorities of people and products while creating the best entertainment software available, a philosophy that still drives us today. We have delivered rich, thoughtful strategy games throughout our history and our vision is to continue making games that people love to play.\n', 1, '2022-01-12 16:38:45.590000', '2022-02-09 07:34:34.920000', '2022-01-12 16:39:54.903000', 1, 4, 'about', 'full');
INSERT INTO `pages` (`id`, `title`, `sub_title`, `type`, `leaf_content`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `slug`, `header_size`) VALUES
(4, 'Services', 'We game', 'prebuilt', NULL, 1, '2022-01-12 16:39:33.204000', '2022-01-23 16:02:46.215000', '2022-01-12 16:39:39.037000', 1, 1, 'services', 'full');
INSERT INTO `pages` (`id`, `title`, `sub_title`, `type`, `leaf_content`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `slug`, `header_size`) VALUES
(5, 'Portfolio', 'past projects collection', 'prebuilt', NULL, 1, '2022-01-12 16:44:13.912000', '2022-01-23 15:39:25.874000', '2022-01-12 16:44:49.082000', 1, 1, 'portfolio', 'full'),
(6, 'Blog', 'We write tech!', 'prebuilt', NULL, 1, '2022-01-12 16:45:29.037000', '2022-01-23 16:05:50.779000', '2022-01-12 16:45:34.596000', 1, 1, 'blog', 'full'),
(7, 'Contact', 'contact alienide internals', 'prebuilt', NULL, 1, '2022-01-12 16:46:32.733000', '2022-01-23 15:39:55.875000', '2022-01-12 16:46:36.972000', 1, 1, 'contact', 'full'),
(8, 'Privacy policy', 'alienide\'s privacy policy', 'leaf', 'Privacy Policy\n==============\n\nLast revised on February, 2022\n\n### The Gist\n\n[COMPANY] will collect certain non-personally identify information about you as you use our sites. We may use this data to better understand our users. We can also publish this data, but the data will be about a large group of users, not individuals.\n\nWe will also ask you to provide personal information, but you\'ll always be able to opt out. If you give us personal information, we won\'t do anything evil with it.\n\nWe can also use cookies, but you can choose not to store these.\n\nThat\'s the basic idea, but you must read through the entire Privacy Policy below and agree with all the details before you use any of our sites.\n\n### Reuse\n\nThis document is based upon the [Automattic Privacy Policy](http://automattic.com/privacy/) and is licensed under [Creative Commons Attribution Share-Alike License 2.5](http://creativecommons.org/licenses/by-sa/2.5/). Basically, this means you can use it verbatim or edited, but you must release new versions under the same license and you have to credit Automattic somewhere (like this!). Automattic is not connected with and does not sponsor or endorse [COMPANY] or its use of the work.\n\n[COMPANY], Inc. (\"[COMPANY]\") makes available services include our web sites ([URL] and [URL]), our blog, our API, and any other software, sites, and services offered by [COMPANY] in connection to any of those (taken together, the \"Service\"). It is [COMPANY]\'s policy to respect your privacy regarding any information we may collect while operating our websites.\n\n### Questions\n\nIf you have question about this Privacy Policy, please contact us at [CONTACT EMAIL]\n\n### Visitors\n\nLike most website operators, [COMPANY] collects non-personally-identifying information of the sort that web browsers and servers typically make available, such as the browser type, language preference, referring site, and the date and time of each visitor request. [COMPANY]\'s purpose in collecting non-personally identifying information is to better understand how [COMPANY]\'s visitors use its website. From time to time, [COMPANY] may release non-personally-identifying information in the aggregate, e.g., by publishing a report on trends in the usage of its website.\n\n[COMPANY] also collects potentially personally-identifying information like Internet Protocol (IP) addresses. [COMPANY] does not use such information to identify its visitors, however, and does not disclose such information, other than under the same circumstances that it uses and discloses personally-identifying information, as described below. We may also collect and use IP addresses to block users who violated our Terms of Service.\n\n### Gathering of Personally-Identifying Information\n\nCertain visitors to [COMPANY]\'s websites choose to interact with [COMPANY] in ways that require [COMPANY] to gather personally-identifying information. The amount and type of information that [COMPANY] gathers depends on the nature of the interaction. [COMPANY] collects such information only insofar as is necessary or appropriate to fulfill the purpose of the visitor\'s interaction with [COMPANY]. [COMPANY] does not disclose personally-identifying information other than as described below. And visitors can always refuse to supply personally-identifying information, with the caveat that it may prevent them from engaging in certain Service-related activities.\n\nAdditionally, some interactions, such as posting a comment, may ask for optional personal information. For instance, when posting a comment, may provide a website that will be displayed along with a user\'s name when the comment is displayed. Supplying such personal information is completely optional and is only displayed for the benefit and the convenience of the user.\n\n### Aggregated Statistics\n\n[COMPANY] may collect statistics about the behavior of visitors to the Service. For instance, [COMPANY] may monitor the most popular parts of the [URL]. [COMPANY] may display this information publicly or provide it to others. However, [COMPANY] does not disclose personally-identifying information other than as described below.\n\n### Protection of Certain Personally-Identifying Information\n\n[COMPANY] discloses potentially personally-identifying and personally-identifying information only to those of its employees, contractors and affiliated organizations that (i) need to know that information in order to process it on [COMPANY]\'s behalf or to provide services available at [COMPANY]\'s websites, and (ii) that have agreed not to disclose it to others. Some of those employees, contractors and affiliated organizations may be located outside of your home country; by using the Service, you consent to the transfer of such information to them. [COMPANY] will not rent or sell potentially personally-identifying and personally-identifying information to anyone. Other than to its employees, contractors and affiliated organizations, as described above, [COMPANY] discloses potentially personally-identifying and personally-identifying information only when required to do so by law, or when [COMPANY] believes in good faith that disclosure is reasonably necessary to protect the property or rights of [COMPANY], third parties or the public at large. If you are a registered user of the Service and have supplied your email address, [COMPANY] may occasionally send you an email to tell you about new features, solicit your feedback, or just keep you up to date with what\'s going on with [COMPANY] and our products. We primarily use our website and blog to communicate this type of information, so we expect to keep this type of email to a minimum. If you send us a request (for example via a support email or via one of our feedback mechanisms), we reserve the right to publish it in order to help us clarify or respond to your request or to help us support other users. [COMPANY] takes all measures reasonably necessary to protect against the unauthorized access, use, alteration or destruction of potentially personally-identifying and personally-identifying information.\n\n### Cookies\nA cookie is a string of information that a website stores on a visitor\'s computer, and that the visitor\'s browser provides to the Service each time the visitor returns. [COMPANY] uses cookies to help [COMPANY] identify and track visitors, their usage of [COMPANY] Service, and their Service access preferences. [COMPANY] visitors who do not wish to have cookies placed on their computers should set their browsers to refuse cookies before using [COMPANY]\'s websites, with the drawback that certain features of [COMPANY]\'s websites may not function properly without the aid of cookies.\n\n### Data Storage\n[COMPANY] uses third party vendors and hosting partners to provide the necessary hardware, software, networking, storage, and related technology required to run the Service. You understand that although you retain full rights to your data, it may be stored on third party storage and transmitted through third party networks.\n\n### Privacy Policy Changes\nAlthough most changes are likely to be minor, [COMPANY] may change its Privacy Policy from time to time, and in [COMPANY]\'s sole discretion. [COMPANY] encourages visitors to frequently check this page for any changes to its Privacy Policy. Your continued use of this site after any change in this Privacy Policy will constitute your acceptance of such change. ', 1, '2022-01-12 16:50:20.268000', '2022-01-23 15:40:24.505000', '2022-01-12 16:50:26.948000', 1, 1, 'privacy-policy', 'half');
INSERT INTO `pages` (`id`, `title`, `sub_title`, `type`, `leaf_content`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `slug`, `header_size`) VALUES
(9, 'Terms & conditions', 'alienide\'s TOS', 'leaf', 'Terms of Service\n================\n\nLast revised on [DATE]\n\n### The Gist\n\n[COMPANY] operates the [SERVICE] service, which we hope you use. If you use it, please use it responsibly. If you don\'t, we\'ll have to terminate your account.\n\nFor paid accounts, you\'ll be charged on a monthly basis. You can cancel anytime, but there are no refunds.\n\nYou own the source code that you provide to [SERVICE] and you\'re responsible for keeping it safe.\n\nThe Terms of Service, [SERVICE] itself, and our prices can change at any time. We\'ll warn you 30 days in advance of any price changes. We\'ll try to warn you about major changes to the Terms of Service or [SERVICE], but we make no guarantees.\n\nThat\'s the basic idea, but You must read through the entire Terms of Service below and agree with all the details before You use any of our sites (whether or not you have created an account).\n\n### Reuse\n\nThis document is an adaptation of the [Heroku Terms of Service](http://legal.heroku.com/tos), which is turn an adaptation of the [Google App Engine Terms of Service](http://code.google.com/appengine/terms.html). The original work has been modified with permission under the [Creative Commons Attribution 3.0 License](http://creativecommons.org/licenses/by/3.0/). Neither Heroku, Inc. nor Google, Inc. is not connected with and does not sponsor or endorse [COMPANY] or its use of the work.\n\nYou\'re welcome to adapt and use this document for your own needs. If you make an improvement, we\'d appreciate it if you would let us know so we can consider improving our own document.\n\n### Your Agreement with [COMPANY]\n\nYour use of the [COMPANY] service is governed by this agreement (the \"Terms\"). \"[COMPANY]\" means [COMPANY] Inc. The \"Service\" means the services [COMPANY] makes available include our web sites ([URL] and [URL]), our blog, our API, and any other software, sites, and services offered by [COMPANY] in connection to any of those. \"Customer Source Code\" means any source code you submit to [COMPANY] for the purpose of using the Service. \"Content\" means all content generated by [COMPANY] on your behalf (including metric data) and does not include Customer Source Code.\n\nIn order to use the Service, You (the \"Customer\", \"You\", or \"Your\") must first agree to the Terms. You understand and agree that [COMPANY] will treat Your use of the Service as acceptance of the Terms from that point onwards.\n\n[COMPANY] may make changes to the Terms from time to time. You may reject the changes by terminating Your account. You understand and agree that if You use the Service after the date on which the Terms have changed, [COMPANY] will treat Your use as acceptance of the updated Terms.\n\nIf you have any question about the Terms, please contact us at [CONTACT EMAIL].\n\n### Your Account\n\n* You may not use the Service if You are a person barred from receiving the Service under the laws of the United States or other countries, including the country in which You are resident or from which You use the Service.\n* You may not use the service unless you are over the age of 13.\n* You must be a human. Account created by automated methods are not permitted.\n\n### Use of the Service\n\n* You must provide accurate and complete registration information any time You register to use the Service.\n* You are responsible for the security of Your passwords and for any use of Your account.\n* Your use of the Service must comply with all applicable laws, regulations and ordinances.\n* You agree to not engage in any activity that interferes with or disrupts the Service.\n* [COMPANY] reserves the right to enforce quotas and usage limits (to any resources, including the API) at its sole discretion, with or without notice, which may result in [COMPANY] disabling or throttling your usage of the Service for any amount of time.\n* You may not allow multiple people to use the same account or otherwise access the Service in a manner intended to avoid incurring fees.\n\n### Service Policies and Privacy\n\nThe Service shall be subject to the privacy policy for the Service available at privacy policy. You agree to the use of Your data in accordance with [COMPANY]\'s privacy policies.\n\n### Fees for Use of the Service\n\n* The Service may be provided to You without charge up with certain limits or for a certain \"trial\" period of time.\n* Usage over this limit (or after the \"trial\" period) requires Your purchase of additional resources or services.\n* For all purchased resources and services, we will charge Your credit card on a monthly basis.\n* Payments are non-refundable. There will be no refunds or credits for partial months of service, upgrade/downgrade refunds, or refunds for months unused with an open account.\n* Charges are solely based on [COMPANY]\'s measurements of Your use of the Service, unless otherwise agreed to in writing.\n* All fees are exclusive of all taxes, levies, or duties imposed by taxing authorities, and You shall be responsible for payment of all such taxes, levies, or duties.\n* You acknowledge and agree that any credit card and related billing and payment information that You provide to [COMPANY] may be shared by [COMPANY] with companies who work on [COMPANY]\'s behalf, such as payment processors and/or credit agencies, solely for the purposes of checking credit, effecting payment to [COMPANY] and servicing Your account.\n* [COMPANY] may change its fees and payment policies for the Service by notifying You at least thirty (30) days before the beginning of the billing cycle in which such change will take effect.\n\n### Cancellation and Termination\n\n* You must cancel Your account via [URL]. An email or phone request to cancel Your account is not considered cancellation.\n* You will not receive any refunds if You cancel Your account.\n* If You cancel the Service before the end of Your current paid up month, Your cancellation will take effect immediately and You will not be charged again.\n* All of Customer Source Code and Content will, within a reasonable amount of time to be determined solely by [COMPANY], be deleted from the Service upon cancellation.\n* You agree that [COMPANY], in its sole discretion and for any or no reason, may terminate or suspend Your account. You agree that any termination of Your access to the Service may be without prior notice, and You agree that [COMPANY] will not be liable to You or any third party for such termination.\n\n### Customer Source Code\n\n* [COMPANY] claims no ownership or control over any Customer Source Code. You retain copyright and any other rights You already hold in the Customer Source Code and You are responsible for protecting those rights, as appropriate.\n* You agree to assume full responsibility for configuring the Service to allow appropriate access to any Customer Source code provided to the Service.\n* You understand that public projects display Customer Source Code to any party on the Internet, including search engines and web spiders.\n* You understand that private projects will display Customer Source Code to You and any collaborators that you designate for that project.\n* You retain sole responsibility for any collaborators or third-party services that you allow to view Customer Source Code and entrust them at your own risk.\n* [COMPANY] is not responsible if you fail to configure, or misconfigure, your project and inadvertently allow unauthorized parties view any Customer Source Code.\n\n### Ideas and Feedback\n\nYou may choose to or we may invite You to submit comments or ideas about the Service, including but not limited to ideas about improving the Service or our products (\"Ideas\"). By submitting any Idea, You agree that Your disclosure is unsolicited and without restriction and will not place [COMPANY] under any fiduciary or other obligation, and that we are free to use the Idea without any additional compensation to You, and/or to disclose the Idea on a non-confidential basis or otherwise to anyone.\n\n### Modification of the Service\n\n* You acknowledge and agree that the Service may change from time to time without prior notice to You.\n* Changes include, without limitation, changes to fee and payment policies, security patches, added or removed functionality, and other enhancements or restrictions.\n* [COMPANY] shall not be liable to you or to any third party for any modification, price change, suspension or discontinuance of the Service.\n\n### External Resources\n\nThe Services may include hyperlinks to other web sites or content or resources or email content. You acknowledge and agree that [COMPANY] is not responsible for the availability of any such external sites or resources, and does not endorse any advertising, products or other materials on or available from such web sites or resources.\n\n### License from [COMPANY] and Restrictions\n\n[COMPANY] gives You a personal, worldwide, royalty-free, non-assignable and non-exclusive license to use the software provided to You by [COMPANY] as part of the Service as provided to You by [COMPANY]. This license is for the sole purpose of enabling You to use and enjoy the benefit of the Service as provided by [COMPANY], in the manner permitted by the Terms.\n\nYou may not (and You may not permit anyone else to): (a) copy, modify, create a derivative work of, reverse engineer, decompile or otherwise attempt to extract the source code of the Service or any part thereof, unless this is expressly permitted or required by law, or unless You have been specifically told that You may do so by [COMPANY], in writing (e.g., through an open source software license); or (b) attempt to disable or circumvent any security mechanisms used by the Service.\n\nOpen source software licenses for components of the Service released under an open source license constitute separate written agreements. To the limited extent that the open source software licenses expressly supersede these Terms, the open source licenses govern Your agreement with [COMPANY] for the use of the components of the Service released under an open source license.\n\n### Exclusion of warranties\n\n* You expressly understand and agree that your use of the service is at your sole risk and that the service is provided \"as is\" and \"as available.\".\n* You agree that [COMPANY] has no responsibility or liability for the deletion or failure to store any Content and other communications maintained or transmitted through use of the Service. You further acknowledge that You are solely responsible for securing and backing up Customer Source Code.\n* [COMPANY] does not warrant to you that: (a) your use of the service will meet your requirements, (b) your use of the service will be uninterrupted, timely, secure or free from error, (c) the results or data provided by the Service will be accurate, (d) the quality of the service will meet your expectations and (e) any errors in the Service will be fixed.\n\n### Limitation of liability\n\nYou expressly understand and agree that [COMPANY], its subsidiaries and affiliates, and its licensors shall not be liable to you for any direct, indirect, incidental, special consequential or exemplary damages which may be incurred by you, however caused and under any theory of liability. This shall include, but not be limited to, any loss of profit (whether incurred directly or indirectly), any loss of goodwill or business reputation, any loss of data suffered, cost of procurement of substitute goods or services, or other intangible loss (whether or not [COMPANY] has been advised of or should have been aware of the possibility of any such losses arising).\n\n### Indemnification\n\nYou agree to hold harmless and indemnify [COMPANY], and its subsidiaries, affiliates, officers, agents, employees, advertisers, licensors, suppliers or partners (collectively \"[COMPANY] and Partners\") from and against any third party claim arising from or in any way related to (a) Your breach of the Terms, (b) Your use of the Service, (c) Your violation of applicable laws, rules or regulations in connection with the Service, or (d) Your Customer Source Code, including any liability or expense arising from all claims, losses, damages (actual and consequential), suits, judgments, litigation costs and attorneys\' fees, of every kind and nature. In such a case, [COMPANY] will provide You with written notice of such claim, suit or action.\n\n### General Legal Terms\n\nThe Terms constitute the whole legal agreement between You and [COMPANY] and govern Your use of the Service and completely replace any prior agreements between You and [COMPANY] in relation to the Service.\n\nYou agree that if [COMPANY] does not exercise or enforce any legal right or remedy which is contained in the Terms (or which [COMPANY] has the benefit of under any applicable law), this will not be taken to be a formal waiver of [COMPANY]\'s rights and that those rights or remedies will still be available to [COMPANY].\n\n[COMPANY] shall not be liable for failing or delaying performance of its obligations resulting from any condition beyond its reasonable control, including but not limited to, governmental action, acts of terrorism, earthquake, fire, flood or other acts of God, labor conditions, power failures, and Internet disturbances.\n', 1, '2022-01-12 16:51:50.771000', '2022-01-23 15:40:37.358000', '2022-01-12 16:52:10.830000', 1, 1, 'terms-and-conditions', 'half'),
(10, 'Upcoming events', 'latest news and events ', 'custom', NULL, 1, '2022-01-12 16:59:08.650000', '2022-01-26 07:30:34.726000', '2022-01-12 17:02:56.715000', 1, 4, 'upcoming-events', 'full');

INSERT INTO `pages_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(18, 5, 5, 'mixed.seo', 'SEO', 1);
INSERT INTO `pages_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(21, 4, 4, 'mixed.seo', 'SEO', 1);
INSERT INTO `pages_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(22, 6, 6, 'mixed.seo', 'SEO', 1);
INSERT INTO `pages_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(23, 10, 6, 'media.gallery', 'blocks', 1),
(24, 10, 7, 'mixed.seo', 'SEO', 1),
(25, 3, 3, 'mixed.seo', 'SEO', 1),
(31, 2, 13, 'media.gallery', 'blocks', 1),
(32, 2, 74, 'text.keyword', 'blocks', 2),
(33, 2, 2, 'mixed.seo', 'SEO', 1),
(34, 2, 1, 'crud.field', 'Fields', 1),
(35, 2, 1, 'crud.section', 'Sections', 1),
(36, 2, 1, 'models.clients', 'Pagedata', 1),
(37, 2, 1, 'models.portfolio', 'Pagedata', 2),
(38, 2, 1, 'models.services', 'Pagedata', 3),
(39, 2, 1, 'models.testimonials', 'Pagedata', 4);

INSERT INTO `portfolio_categories` (`id`, `name`, `description`, `slug`, `status`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 'Gamified experience', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread', 'gamified-experience', 1, '2022-01-04 19:36:21.108000', '2022-01-04 19:36:22.470000', 1, 1);
INSERT INTO `portfolio_categories` (`id`, `name`, `description`, `slug`, `status`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(4, 'Virtual event', NULL, 'virtual-event', 1, '2022-01-18 02:54:05.065000', '2022-01-18 02:54:05.065000', 1, 1);
INSERT INTO `portfolio_categories` (`id`, `name`, `description`, `slug`, `status`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(5, 'Hyper casual', NULL, 'hyper-casual', 1, '2022-01-18 02:57:39.288000', '2022-01-18 02:57:39.288000', 1, 1);
INSERT INTO `portfolio_categories` (`id`, `name`, `description`, `slug`, `status`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(6, 'Ad campaign', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread', 'ad-campaign', 1, '2022-01-18 14:23:56.921000', '2022-01-18 14:23:56.921000', 1, 1);

INSERT INTO `portfolios` (`id`, `title`, `featured`, `client`, `year`, `content`, `description`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `embed_code`) VALUES
(1, 'This is a sample portfolio of our previous works to showcase', 1, 'Softwind', 2020, '## Here goes the rich text content of the portfolio\n\nNarwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. **Glossier drinking** vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party _XOXO_, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health <u>goth farm-to-table pork belly</u> slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe su', '2022-01-04 19:35:49.346000', '2022-01-18 02:47:29.762000', '2022-01-18 02:47:29.699000', 1, 1, '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/gkMOXsY1nDo\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>');
INSERT INTO `portfolios` (`id`, `title`, `featured`, `client`, `year`, `content`, `description`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `embed_code`) VALUES
(3, 'This is another sample portfolio of our previous works to showcase', 1, 'Softwind', 2020, 'An h1 header\n============\n\nParagraphs are separated by a blank line.\n\n2nd paragraph. *Italic*, **bold**, and `monospace`. Itemized lists\nlook like:\n\n  * this one\n  * that one\n  * the other one\n\nNote that --- not considering the asterisk --- the actual text\ncontent starts at 4-columns in.\n\n> Block quotes are\n> written like so.\n>\n> They can span multiple paragraphs,\n> if you like.\n\nUse 3 dashes for an em-dash. Use 2 dashes for ranges (ex., \"it\'s all\nin chapters 12--14\"). Three dots ... will be converted to an ellipsis.\nUnicode is supported. ☺\n\n\n\nAn h2 header\n------------\n\nHere\'s a numbered list:\n\n 1. first item\n 2. second item\n 3. third item\n\nNote again how the actual text starts at 4 columns in (4 characters\nfrom the left side). Here\'s a code sample:\n\n    # Let me re-iterate ...\n    for i in 1 .. 10 { do-something(i) }\n\nAs you probably guessed, indented 4 spaces. By the way, instead of\nindenting the block, you can use delimited blocks, if you like:\n\n~~~\ndefine foobar() {\n    print \"Welcome to flavor country!\";\n}\n~~~\n\n(which makes copying & pasting easier). You can optionally mark the\ndelimited block for Pandoc to syntax highlight it:\n\n~~~python\nimport time\n# Quick, count to ten!\nfor i in range(10):\n    # (but not *too* quick)\n    time.sleep(0.5)\n    print(i)\n~~~\n\n\n\n### An h3 header ###\n\nNow a nested list:\n\n 1. First, get these ingredients:\n\n      * carrots\n      * celery\n      * lentils\n\n 2. Boil some water.\n\n 3. Dump everything in the pot and follow\n    this algorithm:\n\n        find wooden spoon\n        uncover pot\n        stir\n        cover pot\n        balance wooden spoon precariously on pot handle\n        wait 10 minutes\n        goto first step (or shut off burner when done)\n\n    Do not bump wooden spoon or it will fall.\n\nNotice again how text always lines up on 4-space indents (including\nthat last line which continues item 3 above).\n\nHere\'s a link to [a website](http://foo.bar), to a [local\ndoc](local-doc.html), and to a [section heading in the current\ndoc](#an-h2-header). Here\'s a footnote [^1].\n\n[^1]: Some footnote text.\n\nTables can look like this:\n\nName           Size  Material      Color\n------------- -----  ------------  ------------\nAll Business      9  leather       brown\nRoundabout       10  hemp canvas   natural\nCinderella       11  glass         transparent\n\nTable: Shoes sizes, materials, and colors.\n\n(The above is the caption for the table.) Pandoc also supports\nmulti-line tables:\n\n--------  -----------------------\nKeyword   Text\n--------  -----------------------\nred       Sunsets, apples, and\n          other red or reddish\n          things.\n\ngreen     Leaves, grass, frogs\n          and other things it\'s\n          not easy being.\n--------  -----------------------\n\nA horizontal rule follows.\n\n***\n\nHere\'s a definition list:\n\napples\n  : Good for making applesauce.\n\noranges\n  : Citrus!\n\ntomatoes\n  : There\'s no \"e\" in tomatoe.\n\nAgain, text is indented 4 spaces. (Put a blank line between each\nterm and  its definition to spread things out more.)\n\nHere\'s a \"line block\" (note how whitespace is honored):\n\n| Line one\n|   Line too\n| Line tree\n\n\n\nand images can be specified like so:\n\n![logo-black.png](http://localhost:1337/uploads/logo_black_e0b5b2049e.png)\n![Untitled.png](http://localhost:1337/uploads/Untitled_84f4053732.png)\n![linkin.png r](http://localhost:1337/uploads/linkin_215ea35ddb.png)\n\nInline math equation: $\\omega = d\\phi / dt$. Display\nmath should get its own line like so:\n\n\n\n1. item one\n2. item two\n3. item three\n\nAnd note that you can backslash-escape any punctuation characters\nwhich you wish to be displayed literally, ex.: \\`foo\\`, \\*bar\\*, etc.', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe su', '2022-01-18 02:38:43.118000', '2022-01-18 14:59:39.277000', '2022-01-18 02:51:03.798000', 1, 1, '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/gkMOXsY1nDo\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>');
INSERT INTO `portfolios` (`id`, `title`, `featured`, `client`, `year`, `content`, `description`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `embed_code`) VALUES
(4, 'Gaming is what we dream and do.', 1, 'Softwind', 2020, '## Here goes the rich text content of the portfolio\n\nNarwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. **Glossier drinking** vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party _XOXO_, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health <u>goth farm-to-table pork belly</u> slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 'Game Development is the art of creating games and describes the design, development and release of a game. It may involve concept generation, design, build, test and release', '2022-01-18 02:59:20.126000', '2022-01-18 03:00:58.681000', '2022-01-18 02:59:42.059000', 1, 1, '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/gkMOXsY1nDo\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>');
INSERT INTO `portfolios` (`id`, `title`, `featured`, `client`, `year`, `content`, `description`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `embed_code`) VALUES
(5, 'Hyper casual at its best.', 1, 'Softwind', 2020, '## Here goes the rich text content of the portfolio\n\nNarwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. **Glossier drinking** vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party _XOXO_, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health <u>goth farm-to-table pork belly</u> slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe su', '2022-01-18 14:22:00.099000', '2022-01-18 14:22:10.571000', '2022-01-18 14:22:10.511000', 1, 1, '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/gkMOXsY1nDo\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>');
INSERT INTO `portfolios` (`id`, `title`, `featured`, `client`, `year`, `content`, `description`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `embed_code`) VALUES
(6, 'The alienide-verse, an interactive virtual platform', 0, 'Softwind', 2020, '## Here goes the rich text content of the portfolio\n\nNarwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. **Glossier drinking** vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party _XOXO_, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health <u>goth farm-to-table pork belly</u> slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe su', '2022-01-18 14:23:08.815000', '2022-01-18 14:23:17.166000', '2022-01-18 14:23:17.106000', 1, 1, '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/gkMOXsY1nDo\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>'),
(7, 'Ads in the verse', 1, 'Softwind', 2020, '## Here goes the rich text content of the portfolio\n\nNarwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. **Glossier drinking** vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party _XOXO_, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health <u>goth farm-to-table pork belly</u> slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe su', '2022-01-18 14:24:39.604000', '2022-01-18 14:24:58.816000', '2022-01-18 14:24:58.584000', 1, 1, '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/gkMOXsY1nDo\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>'),
(8, 'Hyper casual gaming', 1, 'Softwind', 2020, '## Here goes the rich text content of the portfolio\n\nNarwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. **Glossier drinking** vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party _XOXO_, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health <u>goth farm-to-table pork belly</u> slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe su', '2022-01-19 02:58:17.934000', '2022-01-19 02:58:23.598000', '2022-01-19 02:58:23.534000', 1, 1, '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/gkMOXsY1nDo\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>');

INSERT INTO `portfolios_category_links` (`portfolio_id`, `portfolio_category_id`) VALUES
(1, 1);
INSERT INTO `portfolios_category_links` (`portfolio_id`, `portfolio_category_id`) VALUES
(4, 5);
INSERT INTO `portfolios_category_links` (`portfolio_id`, `portfolio_category_id`) VALUES
(5, 5);
INSERT INTO `portfolios_category_links` (`portfolio_id`, `portfolio_category_id`) VALUES
(6, 4),
(7, 1),
(3, 4),
(8, 5);

INSERT INTO `portfolios_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(29, 1, 2, 'media.gallery', 'gallery', 1);
INSERT INTO `portfolios_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(30, 1, 6, 'text.keyword', 'keywords', 1);
INSERT INTO `portfolios_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(31, 1, 7, 'text.keyword', 'keywords', 2);
INSERT INTO `portfolios_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(32, 1, 8, 'text.keyword', 'keywords', 3),
(45, 4, 8, 'media.gallery', 'gallery', 1),
(46, 4, 30, 'text.keyword', 'keywords', 1),
(47, 4, 29, 'text.keyword', 'keywords', 2),
(48, 4, 31, 'text.keyword', 'keywords', 3),
(81, 5, 9, 'media.gallery', 'gallery', 1),
(82, 5, 33, 'text.keyword', 'keywords', 1),
(83, 5, 32, 'text.keyword', 'keywords', 2),
(84, 5, 34, 'text.keyword', 'keywords', 3),
(85, 6, 10, 'media.gallery', 'gallery', 1),
(86, 6, 36, 'text.keyword', 'keywords', 1),
(87, 6, 35, 'text.keyword', 'keywords', 2),
(88, 6, 37, 'text.keyword', 'keywords', 3),
(89, 7, 11, 'media.gallery', 'gallery', 1),
(90, 7, 38, 'text.keyword', 'keywords', 1),
(91, 7, 39, 'text.keyword', 'keywords', 2),
(92, 7, 40, 'text.keyword', 'keywords', 3),
(93, 3, 7, 'media.gallery', 'gallery', 1),
(94, 3, 26, 'text.keyword', 'keywords', 1),
(95, 3, 27, 'text.keyword', 'keywords', 2),
(96, 3, 28, 'text.keyword', 'keywords', 3),
(97, 8, 12, 'media.gallery', 'gallery', 1),
(98, 8, 71, 'text.keyword', 'keywords', 1),
(99, 8, 72, 'text.keyword', 'keywords', 2),
(100, 8, 73, 'text.keyword', 'keywords', 3);

INSERT INTO `services` (`id`, `title`, `sub_title`, `description`, `featured`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `published_at`) VALUES
(2, 'Narwhal pop-up intelligentsia tbh pinterest', 'MANAGMENT & MARKETING', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health goth farm-to-table pork belly slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 1, '2022-01-19 02:09:01.245000', '2022-01-22 09:24:00.842000', 1, 4, '2022-01-19 02:10:21.525000');
INSERT INTO `services` (`id`, `title`, `sub_title`, `description`, `featured`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `published_at`) VALUES
(3, 'V PUG ETHICAL XOXO UMAMI GODAR COLD-PRESSED BLUE', 'MEDIA PROMOTION', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health goth farm-to-table pork belly slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 1, '2022-01-19 02:10:59.365000', '2022-01-19 02:12:30.747000', 1, 1, '2022-01-19 02:11:02.940000');
INSERT INTO `services` (`id`, `title`, `sub_title`, `description`, `featured`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `published_at`) VALUES
(4, 'RAW DENIM PHOTO BOOTH SEMIOTICS 3 WOLF MOON', 'STRATEGY & BRANDING', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health goth farm-to-table pork belly slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 1, '2022-01-19 02:11:53.812000', '2022-01-19 02:11:57.554000', 1, 1, '2022-01-19 02:11:57.496000');
INSERT INTO `services` (`id`, `title`, `sub_title`, `description`, `featured`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `published_at`) VALUES
(5, 'V PUG ETHICAL XOXO UMAMI GODAR COLD-PRESSED BLUE', 'MEDIA PROMOTION', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health goth farm-to-table pork belly slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 0, '2022-01-19 02:27:48.882000', '2022-01-19 02:27:59.007000', 1, 1, '2022-01-19 02:27:58.948000'),
(6, ' MIXTAPE FANNY PACK MEDITATION PBR&B', 'MANAGMENT & MARKETING', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health goth farm-to-table pork belly slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 0, '2022-01-19 02:28:15.885000', '2022-01-19 02:28:31.182000', 1, 1, '2022-01-19 02:28:31.122000'),
(7, 'PUG ETHICAL XOXO UMAMI GODAR COLD-PRESSED BLUE', 'MEDIA PROMOTION', 'Narwhal pop-up intelligentsia tbh pinterest, microdosing tilde cloud bread gochujang tattooed leggings cornhole 8-bit. Austin fam chia cold-pressed raw denim. Glossier drinking vinegar portland lo-fi, polaroid bespoke lomo. Banjo art party XOXO, fashion axe sustainable retro ethical gentrify. Occupy listicle hoodie viral, cred health goth farm-to-table pork belly slow-carb echo park shaman banjo. Next level brooklyn mumblecore keytar stumptown.', 0, '2022-01-19 02:29:01.653000', '2022-01-19 02:29:06.176000', 1, 1, '2022-01-19 02:29:06.109000');

INSERT INTO `services_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(11, 4, 51, 'text.keyword', 'keywords', 1);
INSERT INTO `services_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(12, 4, 52, 'text.keyword', 'keywords', 2);
INSERT INTO `services_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(13, 4, 54, 'text.keyword', 'keywords', 3);
INSERT INTO `services_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(14, 4, 53, 'text.keyword', 'keywords', 4),
(15, 4, 55, 'text.keyword', 'keywords', 5),
(21, 3, 47, 'text.keyword', 'keywords', 1),
(22, 3, 46, 'text.keyword', 'keywords', 2),
(23, 3, 48, 'text.keyword', 'keywords', 3),
(24, 3, 49, 'text.keyword', 'keywords', 4),
(25, 3, 50, 'text.keyword', 'keywords', 5),
(26, 5, 56, 'text.keyword', 'keywords', 1),
(27, 5, 57, 'text.keyword', 'keywords', 2),
(28, 5, 58, 'text.keyword', 'keywords', 3),
(29, 5, 59, 'text.keyword', 'keywords', 4),
(30, 5, 60, 'text.keyword', 'keywords', 5),
(36, 6, 62, 'text.keyword', 'keywords', 1),
(37, 6, 61, 'text.keyword', 'keywords', 2),
(38, 6, 63, 'text.keyword', 'keywords', 3),
(39, 6, 64, 'text.keyword', 'keywords', 4),
(40, 6, 65, 'text.keyword', 'keywords', 5),
(41, 7, 66, 'text.keyword', 'keywords', 1),
(42, 7, 67, 'text.keyword', 'keywords', 2),
(43, 7, 68, 'text.keyword', 'keywords', 3),
(44, 7, 69, 'text.keyword', 'keywords', 4),
(45, 7, 70, 'text.keyword', 'keywords', 5),
(46, 2, 42, 'text.keyword', 'keywords', 1),
(47, 2, 41, 'text.keyword', 'keywords', 2),
(48, 2, 43, 'text.keyword', 'keywords', 3),
(49, 2, 44, 'text.keyword', 'keywords', 4),
(50, 2, 45, 'text.keyword', 'keywords', 5);

INSERT INTO `site_infos` (`id`, `site_name`, `site_title`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 'Alienide Interactive', 'Game development company', '2022-01-05 04:57:39.622000', '2022-01-18 16:56:29.705000', '2022-01-05 05:04:27.746000', 1, 1);


INSERT INTO `site_infos_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(67, 1, 10, 'text.keyword', 'meta_keywords', 1);
INSERT INTO `site_infos_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(68, 1, 11, 'text.keyword', 'meta_keywords', 2);
INSERT INTO `site_infos_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(69, 1, 1, 'media.logos', 'site_logo', 1);
INSERT INTO `site_infos_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(70, 1, 1, 'elements.contact-info', 'contact_info', 1),
(71, 1, 1, 'elements.menus', 'menus', 1);



INSERT INTO `strapi_core_store_settings` (`id`, `key`, `value`, `type`, `environment`, `tag`) VALUES
(1, 'strapi_content_types_schema', '{\"admin::permission\":{\"collectionName\":\"admin_permissions\",\"info\":{\"name\":\"Permission\",\"description\":\"\",\"singularName\":\"permission\",\"pluralName\":\"permissions\",\"displayName\":\"Permission\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"action\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true},\"subject\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":false},\"properties\":{\"type\":\"json\",\"configurable\":false,\"required\":false,\"default\":{}},\"conditions\":{\"type\":\"json\",\"configurable\":false,\"required\":false,\"default\":[]},\"role\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"manyToOne\",\"inversedBy\":\"permissions\",\"target\":\"admin::role\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"admin_permissions\",\"info\":{\"name\":\"Permission\",\"description\":\"\",\"singularName\":\"permission\",\"pluralName\":\"permissions\",\"displayName\":\"Permission\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"action\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true},\"subject\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":false},\"properties\":{\"type\":\"json\",\"configurable\":false,\"required\":false,\"default\":{}},\"conditions\":{\"type\":\"json\",\"configurable\":false,\"required\":false,\"default\":[]},\"role\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"manyToOne\",\"inversedBy\":\"permissions\",\"target\":\"admin::role\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"permission\",\"connection\":\"default\",\"uid\":\"admin::permission\",\"plugin\":\"admin\",\"globalId\":\"AdminPermission\"},\"admin::user\":{\"collectionName\":\"admin_users\",\"info\":{\"name\":\"User\",\"description\":\"\",\"singularName\":\"user\",\"pluralName\":\"users\",\"displayName\":\"User\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"firstname\":{\"type\":\"string\",\"unique\":false,\"minLength\":1,\"configurable\":false,\"required\":false},\"lastname\":{\"type\":\"string\",\"unique\":false,\"minLength\":1,\"configurable\":false,\"required\":false},\"username\":{\"type\":\"string\",\"unique\":false,\"configurable\":false,\"required\":false},\"email\":{\"type\":\"email\",\"minLength\":6,\"configurable\":false,\"required\":true,\"unique\":true,\"private\":true},\"password\":{\"type\":\"password\",\"minLength\":6,\"configurable\":false,\"required\":false,\"private\":true},\"resetPasswordToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"registrationToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"isActive\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false,\"private\":true},\"roles\":{\"configurable\":false,\"private\":true,\"type\":\"relation\",\"relation\":\"manyToMany\",\"inversedBy\":\"users\",\"target\":\"admin::role\",\"collectionName\":\"strapi_users_roles\"},\"blocked\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false,\"private\":true},\"preferedLanguage\":{\"type\":\"string\",\"configurable\":false,\"required\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"admin_users\",\"info\":{\"name\":\"User\",\"description\":\"\",\"singularName\":\"user\",\"pluralName\":\"users\",\"displayName\":\"User\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"firstname\":{\"type\":\"string\",\"unique\":false,\"minLength\":1,\"configurable\":false,\"required\":false},\"lastname\":{\"type\":\"string\",\"unique\":false,\"minLength\":1,\"configurable\":false,\"required\":false},\"username\":{\"type\":\"string\",\"unique\":false,\"configurable\":false,\"required\":false},\"email\":{\"type\":\"email\",\"minLength\":6,\"configurable\":false,\"required\":true,\"unique\":true,\"private\":true},\"password\":{\"type\":\"password\",\"minLength\":6,\"configurable\":false,\"required\":false,\"private\":true},\"resetPasswordToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"registrationToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"isActive\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false,\"private\":true},\"roles\":{\"configurable\":false,\"private\":true,\"type\":\"relation\",\"relation\":\"manyToMany\",\"inversedBy\":\"users\",\"target\":\"admin::role\",\"collectionName\":\"strapi_users_roles\"},\"blocked\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false,\"private\":true},\"preferedLanguage\":{\"type\":\"string\",\"configurable\":false,\"required\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"user\",\"connection\":\"default\",\"uid\":\"admin::user\",\"plugin\":\"admin\",\"globalId\":\"AdminUser\"},\"admin::role\":{\"collectionName\":\"admin_roles\",\"info\":{\"name\":\"Role\",\"description\":\"\",\"singularName\":\"role\",\"pluralName\":\"roles\",\"displayName\":\"Role\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":1,\"unique\":true,\"configurable\":false,\"required\":true},\"code\":{\"type\":\"string\",\"minLength\":1,\"unique\":true,\"configurable\":false,\"required\":true},\"description\":{\"type\":\"string\",\"configurable\":false},\"users\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"manyToMany\",\"mappedBy\":\"roles\",\"target\":\"admin::user\"},\"permissions\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"oneToMany\",\"mappedBy\":\"role\",\"target\":\"admin::permission\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"admin_roles\",\"info\":{\"name\":\"Role\",\"description\":\"\",\"singularName\":\"role\",\"pluralName\":\"roles\",\"displayName\":\"Role\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":1,\"unique\":true,\"configurable\":false,\"required\":true},\"code\":{\"type\":\"string\",\"minLength\":1,\"unique\":true,\"configurable\":false,\"required\":true},\"description\":{\"type\":\"string\",\"configurable\":false},\"users\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"manyToMany\",\"mappedBy\":\"roles\",\"target\":\"admin::user\"},\"permissions\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"oneToMany\",\"mappedBy\":\"role\",\"target\":\"admin::permission\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"role\",\"connection\":\"default\",\"uid\":\"admin::role\",\"plugin\":\"admin\",\"globalId\":\"AdminRole\"},\"admin::api-token\":{\"collectionName\":\"strapi_api_tokens\",\"info\":{\"name\":\"Api Token\",\"singularName\":\"api-token\",\"pluralName\":\"api-tokens\",\"displayName\":\"Api Token\",\"description\":\"\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true},\"description\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":false,\"default\":\"\"},\"type\":{\"type\":\"enumeration\",\"enum\":[\"read-only\",\"full-access\"],\"configurable\":false,\"required\":false,\"default\":\"read-only\"},\"accessKey\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"strapi_api_tokens\",\"info\":{\"name\":\"Api Token\",\"singularName\":\"api-token\",\"pluralName\":\"api-tokens\",\"displayName\":\"Api Token\",\"description\":\"\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true},\"description\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":false,\"default\":\"\"},\"type\":{\"type\":\"enumeration\",\"enum\":[\"read-only\",\"full-access\"],\"configurable\":false,\"required\":false,\"default\":\"read-only\"},\"accessKey\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"api-token\",\"connection\":\"default\",\"uid\":\"admin::api-token\",\"plugin\":\"admin\",\"globalId\":\"AdminApiToken\"},\"plugin::upload.file\":{\"collectionName\":\"files\",\"info\":{\"singularName\":\"file\",\"pluralName\":\"files\",\"displayName\":\"File\",\"description\":\"\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"alternativeText\":{\"type\":\"string\",\"configurable\":false},\"caption\":{\"type\":\"string\",\"configurable\":false},\"width\":{\"type\":\"integer\",\"configurable\":false},\"height\":{\"type\":\"integer\",\"configurable\":false},\"formats\":{\"type\":\"json\",\"configurable\":false},\"hash\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"ext\":{\"type\":\"string\",\"configurable\":false},\"mime\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"size\":{\"type\":\"decimal\",\"configurable\":false,\"required\":true},\"url\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"previewUrl\":{\"type\":\"string\",\"configurable\":false},\"provider\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"provider_metadata\":{\"type\":\"json\",\"configurable\":false},\"related\":{\"type\":\"relation\",\"relation\":\"morphToMany\",\"configurable\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"plugin\":\"upload\",\"uid\":\"plugin::upload.file\",\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"files\",\"info\":{\"singularName\":\"file\",\"pluralName\":\"files\",\"displayName\":\"File\",\"description\":\"\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"alternativeText\":{\"type\":\"string\",\"configurable\":false},\"caption\":{\"type\":\"string\",\"configurable\":false},\"width\":{\"type\":\"integer\",\"configurable\":false},\"height\":{\"type\":\"integer\",\"configurable\":false},\"formats\":{\"type\":\"json\",\"configurable\":false},\"hash\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"ext\":{\"type\":\"string\",\"configurable\":false},\"mime\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"size\":{\"type\":\"decimal\",\"configurable\":false,\"required\":true},\"url\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"previewUrl\":{\"type\":\"string\",\"configurable\":false},\"provider\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"provider_metadata\":{\"type\":\"json\",\"configurable\":false},\"related\":{\"type\":\"relation\",\"relation\":\"morphToMany\",\"configurable\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"file\",\"connection\":\"default\",\"globalId\":\"UploadFile\"},\"plugin::i18n.locale\":{\"info\":{\"singularName\":\"locale\",\"pluralName\":\"locales\",\"collectionName\":\"locales\",\"displayName\":\"Locale\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"min\":1,\"max\":50,\"configurable\":false},\"code\":{\"type\":\"string\",\"unique\":true,\"configurable\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"plugin\":\"i18n\",\"uid\":\"plugin::i18n.locale\",\"kind\":\"collectionType\",\"__schema__\":{\"info\":{\"singularName\":\"locale\",\"pluralName\":\"locales\",\"collectionName\":\"locales\",\"displayName\":\"Locale\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"min\":1,\"max\":50,\"configurable\":false},\"code\":{\"type\":\"string\",\"unique\":true,\"configurable\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"locale\",\"connection\":\"default\",\"collectionName\":\"i18n_locale\",\"globalId\":\"I18NLocale\"},\"plugin::users-permissions.permission\":{\"collectionName\":\"up_permissions\",\"info\":{\"name\":\"permission\",\"description\":\"\",\"singularName\":\"permission\",\"pluralName\":\"permissions\",\"displayName\":\"Permission\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"action\":{\"type\":\"string\",\"required\":true,\"configurable\":false},\"role\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::users-permissions.role\",\"inversedBy\":\"permissions\",\"configurable\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"plugin\":\"users-permissions\",\"uid\":\"plugin::users-permissions.permission\",\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"up_permissions\",\"info\":{\"name\":\"permission\",\"description\":\"\",\"singularName\":\"permission\",\"pluralName\":\"permissions\",\"displayName\":\"Permission\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"action\":{\"type\":\"string\",\"required\":true,\"configurable\":false},\"role\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::users-permissions.role\",\"inversedBy\":\"permissions\",\"configurable\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"permission\",\"connection\":\"default\",\"globalId\":\"UsersPermissionsPermission\"},\"plugin::users-permissions.role\":{\"collectionName\":\"up_roles\",\"info\":{\"name\":\"role\",\"description\":\"\",\"singularName\":\"role\",\"pluralName\":\"roles\",\"displayName\":\"Role\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":3,\"required\":true,\"configurable\":false},\"description\":{\"type\":\"string\",\"configurable\":false},\"type\":{\"type\":\"string\",\"unique\":true,\"configurable\":false},\"permissions\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::users-permissions.permission\",\"mappedBy\":\"role\",\"configurable\":false},\"users\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::users-permissions.user\",\"mappedBy\":\"role\",\"configurable\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"plugin\":\"users-permissions\",\"uid\":\"plugin::users-permissions.role\",\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"up_roles\",\"info\":{\"name\":\"role\",\"description\":\"\",\"singularName\":\"role\",\"pluralName\":\"roles\",\"displayName\":\"Role\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":3,\"required\":true,\"configurable\":false},\"description\":{\"type\":\"string\",\"configurable\":false},\"type\":{\"type\":\"string\",\"unique\":true,\"configurable\":false},\"permissions\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::users-permissions.permission\",\"mappedBy\":\"role\",\"configurable\":false},\"users\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::users-permissions.user\",\"mappedBy\":\"role\",\"configurable\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"role\",\"connection\":\"default\",\"globalId\":\"UsersPermissionsRole\"},\"plugin::users-permissions.user\":{\"collectionName\":\"up_users\",\"info\":{\"name\":\"user\",\"description\":\"\",\"singularName\":\"user\",\"pluralName\":\"users\",\"displayName\":\"User\"},\"options\":{\"draftAndPublish\":false,\"timestamps\":true},\"attributes\":{\"username\":{\"type\":\"string\",\"minLength\":3,\"unique\":true,\"configurable\":false,\"required\":true},\"email\":{\"type\":\"email\",\"minLength\":6,\"configurable\":false,\"required\":true},\"provider\":{\"type\":\"string\",\"configurable\":false},\"password\":{\"type\":\"password\",\"minLength\":6,\"configurable\":false,\"private\":true},\"resetPasswordToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"confirmationToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"confirmed\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"blocked\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"role\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::users-permissions.role\",\"inversedBy\":\"users\",\"configurable\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"config\":{\"attributes\":{\"resetPasswordToken\":{\"hidden\":true},\"confirmationToken\":{\"hidden\":true},\"provider\":{\"hidden\":true}}},\"plugin\":\"users-permissions\",\"uid\":\"plugin::users-permissions.user\",\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"up_users\",\"info\":{\"name\":\"user\",\"description\":\"\",\"singularName\":\"user\",\"pluralName\":\"users\",\"displayName\":\"User\"},\"options\":{\"draftAndPublish\":false,\"timestamps\":true},\"attributes\":{\"username\":{\"type\":\"string\",\"minLength\":3,\"unique\":true,\"configurable\":false,\"required\":true},\"email\":{\"type\":\"email\",\"minLength\":6,\"configurable\":false,\"required\":true},\"provider\":{\"type\":\"string\",\"configurable\":false},\"password\":{\"type\":\"password\",\"minLength\":6,\"configurable\":false,\"private\":true},\"resetPasswordToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"confirmationToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"confirmed\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"blocked\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"role\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::users-permissions.role\",\"inversedBy\":\"users\",\"configurable\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"user\",\"connection\":\"default\",\"globalId\":\"UsersPermissionsUser\"},\"api::article.article\":{\"kind\":\"collectionType\",\"collectionName\":\"articles\",\"info\":{\"singularName\":\"article\",\"pluralName\":\"articles\",\"displayName\":\"Articles\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\",\"required\":true},\"slug\":{\"type\":\"uid\",\"targetField\":\"title\",\"required\":true},\"excerpt\":{\"type\":\"text\"},\"featured_image\":{\"type\":\"media\",\"multiple\":false,\"required\":true,\"allowedTypes\":[\"images\"]},\"thumbnail\":{\"type\":\"media\",\"multiple\":false,\"required\":false,\"allowedTypes\":[\"images\"]},\"content\":{\"type\":\"richtext\",\"required\":true},\"categories\":{\"type\":\"relation\",\"relation\":\"manyToMany\",\"target\":\"api::blog-category.blog-category\",\"mappedBy\":\"articles\"},\"featured\":{\"type\":\"boolean\",\"default\":false,\"required\":true},\"status\":{\"type\":\"boolean\",\"default\":true,\"required\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"publishedAt\":{\"type\":\"datetime\",\"configurable\":false,\"writable\":true,\"visible\":false},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"articles\",\"info\":{\"singularName\":\"article\",\"pluralName\":\"articles\",\"displayName\":\"Articles\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\",\"required\":true},\"slug\":{\"type\":\"uid\",\"targetField\":\"title\",\"required\":true},\"excerpt\":{\"type\":\"text\"},\"featured_image\":{\"type\":\"media\",\"multiple\":false,\"required\":true,\"allowedTypes\":[\"images\"]},\"thumbnail\":{\"type\":\"media\",\"multiple\":false,\"required\":false,\"allowedTypes\":[\"images\"]},\"content\":{\"type\":\"richtext\",\"required\":true},\"categories\":{\"type\":\"relation\",\"relation\":\"manyToMany\",\"target\":\"api::blog-category.blog-category\",\"mappedBy\":\"articles\"},\"featured\":{\"type\":\"boolean\",\"default\":false,\"required\":true},\"status\":{\"type\":\"boolean\",\"default\":true,\"required\":true}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"article\",\"connection\":\"default\",\"uid\":\"api::article.article\",\"apiName\":\"article\",\"globalId\":\"Article\",\"actions\":{},\"lifecycles\":{}},\"api::blog-category.blog-category\":{\"kind\":\"collectionType\",\"collectionName\":\"blog_categories\",\"info\":{\"singularName\":\"blog-category\",\"pluralName\":\"blog-categories\",\"displayName\":\"Blog Categories\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"required\":true,\"unique\":true},\"status\":{\"type\":\"boolean\",\"required\":true,\"default\":true},\"description\":{\"type\":\"text\"},\"slug\":{\"type\":\"uid\",\"targetField\":\"name\",\"required\":true},\"parent_category\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::blog-category.blog-category\"},\"articles\":{\"type\":\"relation\",\"relation\":\"manyToMany\",\"target\":\"api::article.article\",\"inversedBy\":\"categories\"},\"image\":{\"allowedTypes\":[\"images\"],\"type\":\"media\",\"multiple\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"blog_categories\",\"info\":{\"singularName\":\"blog-category\",\"pluralName\":\"blog-categories\",\"displayName\":\"Blog Categories\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"required\":true,\"unique\":true},\"status\":{\"type\":\"boolean\",\"required\":true,\"default\":true},\"description\":{\"type\":\"text\"},\"slug\":{\"type\":\"uid\",\"targetField\":\"name\",\"required\":true},\"parent_category\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::blog-category.blog-category\"},\"articles\":{\"type\":\"relation\",\"relation\":\"manyToMany\",\"target\":\"api::article.article\",\"inversedBy\":\"categories\"},\"image\":{\"allowedTypes\":[\"images\"],\"type\":\"media\",\"multiple\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"blog-category\",\"connection\":\"default\",\"uid\":\"api::blog-category.blog-category\",\"apiName\":\"blog-category\",\"globalId\":\"BlogCategory\",\"actions\":{},\"lifecycles\":{}},\"api::client.client\":{\"kind\":\"collectionType\",\"collectionName\":\"clients\",\"info\":{\"singularName\":\"client\",\"pluralName\":\"clients\",\"displayName\":\"Clients\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"required\":true,\"maxLength\":100},\"logo\":{\"type\":\"media\",\"multiple\":false,\"required\":true,\"allowedTypes\":[\"images\",\"files\",\"videos\"]},\"website\":{\"type\":\"string\",\"regex\":\"https?:\\\\/\\\\/(www\\\\.)?[-a-zA-Z0-9@:%._\\\\+~#=]{1,256}\\\\.[a-zA-Z0-9()]{1,6}\\\\b([-a-zA-Z0-9()@:%_\\\\+.~#?&//=]*)\"},\"featured\":{\"type\":\"boolean\"},\"order\":{\"type\":\"integer\",\"required\":true,\"default\":0,\"unique\":true,\"min\":0,\"private\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"clients\",\"info\":{\"singularName\":\"client\",\"pluralName\":\"clients\",\"displayName\":\"Clients\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"required\":true,\"maxLength\":100},\"logo\":{\"type\":\"media\",\"multiple\":false,\"required\":true,\"allowedTypes\":[\"images\",\"files\",\"videos\"]},\"website\":{\"type\":\"string\",\"regex\":\"https?:\\\\/\\\\/(www\\\\.)?[-a-zA-Z0-9@:%._\\\\+~#=]{1,256}\\\\.[a-zA-Z0-9()]{1,6}\\\\b([-a-zA-Z0-9()@:%_\\\\+.~#?&//=]*)\"},\"featured\":{\"type\":\"boolean\"},\"order\":{\"type\":\"integer\",\"required\":true,\"default\":0,\"unique\":true,\"min\":0,\"private\":true}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"client\",\"connection\":\"default\",\"uid\":\"api::client.client\",\"apiName\":\"client\",\"globalId\":\"Client\",\"actions\":{},\"lifecycles\":{}},\"api::contact-form-submit.contact-form-submit\":{\"kind\":\"collectionType\",\"collectionName\":\"contact_form_submits\",\"info\":{\"singularName\":\"contact-form-submit\",\"pluralName\":\"contact-form-submits\",\"displayName\":\"Contact form submits\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\"},\"phone\":{\"type\":\"string\"},\"email\":{\"type\":\"string\",\"required\":true},\"message\":{\"type\":\"text\",\"required\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"contact_form_submits\",\"info\":{\"singularName\":\"contact-form-submit\",\"pluralName\":\"contact-form-submits\",\"displayName\":\"Contact form submits\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\"},\"phone\":{\"type\":\"string\"},\"email\":{\"type\":\"string\",\"required\":true},\"message\":{\"type\":\"text\",\"required\":true}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"contact-form-submit\",\"connection\":\"default\",\"uid\":\"api::contact-form-submit.contact-form-submit\",\"apiName\":\"contact-form-submit\",\"globalId\":\"ContactFormSubmit\",\"actions\":{},\"lifecycles\":{}},\"api::homepage-slider.homepage-slider\":{\"kind\":\"singleType\",\"collectionName\":\"homepage_sliders\",\"info\":{\"singularName\":\"homepage-slider\",\"pluralName\":\"homepage-sliders\",\"displayName\":\"Homepage Slider\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"slides\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"elements.slider\",\"required\":true},\"status\":{\"type\":\"boolean\",\"default\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"publishedAt\":{\"type\":\"datetime\",\"configurable\":false,\"writable\":true,\"visible\":false},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"homepage_sliders\",\"info\":{\"singularName\":\"homepage-slider\",\"pluralName\":\"homepage-sliders\",\"displayName\":\"Homepage Slider\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"slides\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"elements.slider\",\"required\":true},\"status\":{\"type\":\"boolean\",\"default\":true}},\"kind\":\"singleType\"},\"modelType\":\"contentType\",\"modelName\":\"homepage-slider\",\"connection\":\"default\",\"uid\":\"api::homepage-slider.homepage-slider\",\"apiName\":\"homepage-slider\",\"globalId\":\"HomepageSlider\",\"actions\":{},\"lifecycles\":{}},\"api::menu.menu\":{\"kind\":\"collectionType\",\"collectionName\":\"menus\",\"info\":{\"singularName\":\"menu\",\"pluralName\":\"menus\",\"displayName\":\"Menus\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"default\":\"Utitled menu\",\"required\":true},\"items\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"elements.menu-item\",\"required\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"publishedAt\":{\"type\":\"datetime\",\"configurable\":false,\"writable\":true,\"visible\":false},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"menus\",\"info\":{\"singularName\":\"menu\",\"pluralName\":\"menus\",\"displayName\":\"Menus\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"default\":\"Utitled menu\",\"required\":true},\"items\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"elements.menu-item\",\"required\":true}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"menu\",\"connection\":\"default\",\"uid\":\"api::menu.menu\",\"apiName\":\"menu\",\"globalId\":\"Menu\",\"actions\":{},\"lifecycles\":{}},\"api::page.page\":{\"kind\":\"collectionType\",\"collectionName\":\"pages\",\"info\":{\"singularName\":\"page\",\"pluralName\":\"pages\",\"displayName\":\"Pages\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\",\"required\":true},\"sub_title\":{\"type\":\"string\",\"required\":false},\"header_image\":{\"type\":\"media\",\"multiple\":false,\"required\":true,\"allowedTypes\":[\"images\"]},\"type\":{\"type\":\"enumeration\",\"enum\":[\"prebuilt\",\"custom\",\"leaf\"],\"required\":true,\"default\":\"leaf\"},\"blocks\":{\"type\":\"dynamiczone\",\"components\":[\"media.gallery\",\"text.keyword\"],\"required\":false},\"leaf_content\":{\"type\":\"richtext\"},\"status\":{\"type\":\"boolean\",\"default\":true,\"required\":true},\"SEO\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"mixed.seo\"},\"slug\":{\"type\":\"uid\",\"targetField\":\"title\",\"required\":true},\"header_size\":{\"type\":\"enumeration\",\"enum\":[\"full\",\"half\"],\"default\":\"full\",\"required\":true},\"Fields\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"crud.field\"},\"Sections\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"crud.section\"},\"Pagedata\":{\"type\":\"dynamiczone\",\"components\":[\"models.clients\",\"models.portfolio\",\"models.services\",\"models.testimonials\"]},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"publishedAt\":{\"type\":\"datetime\",\"configurable\":false,\"writable\":true,\"visible\":false},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"pages\",\"info\":{\"singularName\":\"page\",\"pluralName\":\"pages\",\"displayName\":\"Pages\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\",\"required\":true},\"sub_title\":{\"type\":\"string\",\"required\":false},\"header_image\":{\"type\":\"media\",\"multiple\":false,\"required\":true,\"allowedTypes\":[\"images\"]},\"type\":{\"type\":\"enumeration\",\"enum\":[\"prebuilt\",\"custom\",\"leaf\"],\"required\":true,\"default\":\"leaf\"},\"blocks\":{\"type\":\"dynamiczone\",\"components\":[\"media.gallery\",\"text.keyword\"],\"required\":false},\"leaf_content\":{\"type\":\"richtext\"},\"status\":{\"type\":\"boolean\",\"default\":true,\"required\":true},\"SEO\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"mixed.seo\"},\"slug\":{\"type\":\"uid\",\"targetField\":\"title\",\"required\":true},\"header_size\":{\"type\":\"enumeration\",\"enum\":[\"full\",\"half\"],\"default\":\"full\",\"required\":true},\"Fields\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"crud.field\"},\"Sections\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"crud.section\"},\"Pagedata\":{\"type\":\"dynamiczone\",\"components\":[\"models.clients\",\"models.portfolio\",\"models.services\",\"models.testimonials\"]}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"page\",\"connection\":\"default\",\"uid\":\"api::page.page\",\"apiName\":\"page\",\"globalId\":\"Page\",\"actions\":{},\"lifecycles\":{}},\"api::portfolio.portfolio\":{\"kind\":\"collectionType\",\"collectionName\":\"portfolios\",\"info\":{\"singularName\":\"portfolio\",\"pluralName\":\"portfolios\",\"displayName\":\"Portfolios\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\",\"required\":true,\"unique\":false},\"image\":{\"type\":\"media\",\"multiple\":false,\"required\":true,\"allowedTypes\":[\"images\"]},\"featured\":{\"type\":\"boolean\",\"default\":false},\"category\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::portfolio-category.portfolio-category\"},\"client\":{\"type\":\"string\",\"required\":true},\"year\":{\"type\":\"integer\",\"required\":true},\"content\":{\"type\":\"richtext\",\"required\":true},\"description\":{\"type\":\"text\",\"required\":true},\"gallery\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"media.gallery\"},\"keywords\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"text.keyword\",\"max\":10,\"required\":true},\"embedCode\":{\"type\":\"text\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"publishedAt\":{\"type\":\"datetime\",\"configurable\":false,\"writable\":true,\"visible\":false},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"portfolios\",\"info\":{\"singularName\":\"portfolio\",\"pluralName\":\"portfolios\",\"displayName\":\"Portfolios\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\",\"required\":true,\"unique\":false},\"image\":{\"type\":\"media\",\"multiple\":false,\"required\":true,\"allowedTypes\":[\"images\"]},\"featured\":{\"type\":\"boolean\",\"default\":false},\"category\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::portfolio-category.portfolio-category\"},\"client\":{\"type\":\"string\",\"required\":true},\"year\":{\"type\":\"integer\",\"required\":true},\"content\":{\"type\":\"richtext\",\"required\":true},\"description\":{\"type\":\"text\",\"required\":true},\"gallery\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"media.gallery\"},\"keywords\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"text.keyword\",\"max\":10,\"required\":true},\"embedCode\":{\"type\":\"text\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"portfolio\",\"connection\":\"default\",\"uid\":\"api::portfolio.portfolio\",\"apiName\":\"portfolio\",\"globalId\":\"Portfolio\",\"actions\":{},\"lifecycles\":{}},\"api::portfolio-category.portfolio-category\":{\"kind\":\"collectionType\",\"collectionName\":\"portfolio_categories\",\"info\":{\"singularName\":\"portfolio-category\",\"pluralName\":\"portfolio-categories\",\"displayName\":\"Portfolio categories\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"required\":true,\"unique\":true},\"description\":{\"type\":\"text\"},\"slug\":{\"type\":\"uid\",\"targetField\":\"name\",\"required\":true},\"status\":{\"type\":\"boolean\",\"required\":true,\"default\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"portfolio_categories\",\"info\":{\"singularName\":\"portfolio-category\",\"pluralName\":\"portfolio-categories\",\"displayName\":\"Portfolio categories\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"required\":true,\"unique\":true},\"description\":{\"type\":\"text\"},\"slug\":{\"type\":\"uid\",\"targetField\":\"name\",\"required\":true},\"status\":{\"type\":\"boolean\",\"required\":true,\"default\":true}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"portfolio-category\",\"connection\":\"default\",\"uid\":\"api::portfolio-category.portfolio-category\",\"apiName\":\"portfolio-category\",\"globalId\":\"PortfolioCategory\",\"actions\":{},\"lifecycles\":{}},\"api::service.service\":{\"kind\":\"collectionType\",\"collectionName\":\"services\",\"info\":{\"singularName\":\"service\",\"pluralName\":\"services\",\"displayName\":\"Services\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\",\"required\":true},\"sub_title\":{\"type\":\"string\",\"required\":true},\"image\":{\"type\":\"media\",\"multiple\":false,\"required\":true,\"allowedTypes\":[\"images\"]},\"keywords\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"text.keyword\"},\"description\":{\"type\":\"text\",\"required\":true,\"minLength\":50},\"featured\":{\"type\":\"boolean\",\"default\":false,\"required\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"publishedAt\":{\"type\":\"datetime\",\"configurable\":false,\"writable\":true,\"visible\":false},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"services\",\"info\":{\"singularName\":\"service\",\"pluralName\":\"services\",\"displayName\":\"Services\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\",\"required\":true},\"sub_title\":{\"type\":\"string\",\"required\":true},\"image\":{\"type\":\"media\",\"multiple\":false,\"required\":true,\"allowedTypes\":[\"images\"]},\"keywords\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"text.keyword\"},\"description\":{\"type\":\"text\",\"required\":true,\"minLength\":50},\"featured\":{\"type\":\"boolean\",\"default\":false,\"required\":true}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"service\",\"connection\":\"default\",\"uid\":\"api::service.service\",\"apiName\":\"service\",\"globalId\":\"Service\",\"actions\":{},\"lifecycles\":{}},\"api::site-info.site-info\":{\"kind\":\"singleType\",\"collectionName\":\"site_infos\",\"info\":{\"singularName\":\"site-info\",\"pluralName\":\"site-infos\",\"displayName\":\"Site info\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"site_name\":{\"type\":\"string\",\"required\":true,\"default\":\"My website\"},\"site_title\":{\"type\":\"string\"},\"meta_keywords\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"text.keyword\"},\"site_logo\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"media.logos\",\"required\":true},\"contact_info\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"elements.contact-info\",\"required\":true},\"menus\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"elements.menus\",\"required\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"publishedAt\":{\"type\":\"datetime\",\"configurable\":false,\"writable\":true,\"visible\":false},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"site_infos\",\"info\":{\"singularName\":\"site-info\",\"pluralName\":\"site-infos\",\"displayName\":\"Site info\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"site_name\":{\"type\":\"string\",\"required\":true,\"default\":\"My website\"},\"site_title\":{\"type\":\"string\"},\"meta_keywords\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"text.keyword\"},\"site_logo\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"media.logos\",\"required\":true},\"contact_info\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"elements.contact-info\",\"required\":true},\"menus\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"elements.menus\",\"required\":true}},\"kind\":\"singleType\"},\"modelType\":\"contentType\",\"modelName\":\"site-info\",\"connection\":\"default\",\"uid\":\"api::site-info.site-info\",\"apiName\":\"site-info\",\"globalId\":\"SiteInfo\",\"actions\":{},\"lifecycles\":{}},\"api::team-member.team-member\":{\"kind\":\"collectionType\",\"collectionName\":\"team_members\",\"info\":{\"singularName\":\"team-member\",\"pluralName\":\"team-members\",\"displayName\":\"Team members\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"required\":true},\"designation\":{\"type\":\"string\",\"required\":true},\"photo\":{\"type\":\"media\",\"multiple\":false,\"required\":false,\"allowedTypes\":[\"images\"]},\"bio\":{\"type\":\"text\"},\"links\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"elements.social-info\"},\"status\":{\"type\":\"boolean\",\"default\":true,\"required\":true},\"order\":{\"type\":\"integer\",\"required\":true,\"unique\":true,\"default\":0,\"min\":0},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"publishedAt\":{\"type\":\"datetime\",\"configurable\":false,\"writable\":true,\"visible\":false},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"team_members\",\"info\":{\"singularName\":\"team-member\",\"pluralName\":\"team-members\",\"displayName\":\"Team members\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"required\":true},\"designation\":{\"type\":\"string\",\"required\":true},\"photo\":{\"type\":\"media\",\"multiple\":false,\"required\":false,\"allowedTypes\":[\"images\"]},\"bio\":{\"type\":\"text\"},\"links\":{\"type\":\"component\",\"repeatable\":true,\"component\":\"elements.social-info\"},\"status\":{\"type\":\"boolean\",\"default\":true,\"required\":true},\"order\":{\"type\":\"integer\",\"required\":true,\"unique\":true,\"default\":0,\"min\":0}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"team-member\",\"connection\":\"default\",\"uid\":\"api::team-member.team-member\",\"apiName\":\"team-member\",\"globalId\":\"TeamMember\",\"actions\":{},\"lifecycles\":{}},\"api::testimonial.testimonial\":{\"kind\":\"collectionType\",\"collectionName\":\"testimonials\",\"info\":{\"singularName\":\"testimonial\",\"pluralName\":\"testimonials\",\"displayName\":\"Testimonials\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"required\":true},\"designation\":{\"type\":\"string\",\"required\":false},\"avatar\":{\"type\":\"media\",\"multiple\":false,\"required\":false,\"allowedTypes\":[\"images\"]},\"Review\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"elements.review\",\"required\":true},\"status\":{\"type\":\"boolean\",\"default\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"testimonials\",\"info\":{\"singularName\":\"testimonial\",\"pluralName\":\"testimonials\",\"displayName\":\"Testimonials\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\",\"required\":true},\"designation\":{\"type\":\"string\",\"required\":false},\"avatar\":{\"type\":\"media\",\"multiple\":false,\"required\":false,\"allowedTypes\":[\"images\"]},\"Review\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"elements.review\",\"required\":true},\"status\":{\"type\":\"boolean\",\"default\":true}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"testimonial\",\"connection\":\"default\",\"uid\":\"api::testimonial.testimonial\",\"apiName\":\"testimonial\",\"globalId\":\"Testimonial\",\"actions\":{},\"lifecycles\":{}}}', 'object', NULL, NULL);
INSERT INTO `strapi_core_store_settings` (`id`, `key`, `value`, `type`, `environment`, `tag`) VALUES
(2, 'plugin_content_manager_configuration_content_types::admin::permission', '{\"uid\":\"admin::permission\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"action\",\"defaultSortBy\":\"action\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"action\":{\"edit\":{\"label\":\"Action\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Action\",\"searchable\":true,\"sortable\":true}},\"subject\":{\"edit\":{\"label\":\"Subject\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Subject\",\"searchable\":true,\"sortable\":true}},\"properties\":{\"edit\":{\"label\":\"Properties\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Properties\",\"searchable\":false,\"sortable\":false}},\"conditions\":{\"edit\":{\"label\":\"Conditions\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Conditions\",\"searchable\":false,\"sortable\":false}},\"role\":{\"edit\":{\"label\":\"Role\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"Role\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"action\",\"subject\",\"role\"],\"editRelations\":[\"role\"],\"edit\":[[{\"name\":\"action\",\"size\":6},{\"name\":\"subject\",\"size\":6}],[{\"name\":\"properties\",\"size\":12}],[{\"name\":\"conditions\",\"size\":12}]]}}', 'object', NULL, NULL);
INSERT INTO `strapi_core_store_settings` (`id`, `key`, `value`, `type`, `environment`, `tag`) VALUES
(3, 'plugin_content_manager_configuration_content_types::admin::role', '{\"uid\":\"admin::role\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"code\":{\"edit\":{\"label\":\"Code\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Code\",\"searchable\":true,\"sortable\":true}},\"description\":{\"edit\":{\"label\":\"Description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Description\",\"searchable\":true,\"sortable\":true}},\"users\":{\"edit\":{\"label\":\"Users\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"firstname\"},\"list\":{\"label\":\"Users\",\"searchable\":false,\"sortable\":false}},\"permissions\":{\"edit\":{\"label\":\"Permissions\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"action\"},\"list\":{\"label\":\"Permissions\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"code\",\"description\"],\"editRelations\":[\"users\",\"permissions\"],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"code\",\"size\":6}],[{\"name\":\"description\",\"size\":6}]]}}', 'object', NULL, NULL);
INSERT INTO `strapi_core_store_settings` (`id`, `key`, `value`, `type`, `environment`, `tag`) VALUES
(4, 'plugin_content_manager_configuration_content_types::admin::api-token', '{\"uid\":\"admin::api-token\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"description\":{\"edit\":{\"label\":\"Description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Description\",\"searchable\":true,\"sortable\":true}},\"type\":{\"edit\":{\"label\":\"Type\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Type\",\"searchable\":true,\"sortable\":true}},\"accessKey\":{\"edit\":{\"label\":\"AccessKey\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"AccessKey\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"description\",\"type\"],\"editRelations\":[],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"description\",\"size\":6}],[{\"name\":\"type\",\"size\":6},{\"name\":\"accessKey\",\"size\":6}]]}}', 'object', NULL, NULL),
(5, 'plugin_content_manager_configuration_content_types::plugin::users-permissions.role', '{\"uid\":\"plugin::users-permissions.role\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"description\":{\"edit\":{\"label\":\"Description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Description\",\"searchable\":true,\"sortable\":true}},\"type\":{\"edit\":{\"label\":\"Type\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Type\",\"searchable\":true,\"sortable\":true}},\"permissions\":{\"edit\":{\"label\":\"Permissions\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"action\"},\"list\":{\"label\":\"Permissions\",\"searchable\":false,\"sortable\":false}},\"users\":{\"edit\":{\"label\":\"Users\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"username\"},\"list\":{\"label\":\"Users\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"description\",\"type\"],\"editRelations\":[\"permissions\",\"users\"],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"description\",\"size\":6}],[{\"name\":\"type\",\"size\":6}]]}}', 'object', NULL, NULL),
(6, 'plugin_content_manager_configuration_content_types::admin::user', '{\"uid\":\"admin::user\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"firstname\",\"defaultSortBy\":\"firstname\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"firstname\":{\"edit\":{\"label\":\"Firstname\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Firstname\",\"searchable\":true,\"sortable\":true}},\"lastname\":{\"edit\":{\"label\":\"Lastname\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Lastname\",\"searchable\":true,\"sortable\":true}},\"username\":{\"edit\":{\"label\":\"Username\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Username\",\"searchable\":true,\"sortable\":true}},\"email\":{\"edit\":{\"label\":\"Email\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Email\",\"searchable\":true,\"sortable\":true}},\"password\":{\"edit\":{\"label\":\"Password\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Password\",\"searchable\":true,\"sortable\":true}},\"resetPasswordToken\":{\"edit\":{\"label\":\"ResetPasswordToken\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"ResetPasswordToken\",\"searchable\":true,\"sortable\":true}},\"registrationToken\":{\"edit\":{\"label\":\"RegistrationToken\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"RegistrationToken\",\"searchable\":true,\"sortable\":true}},\"isActive\":{\"edit\":{\"label\":\"IsActive\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"IsActive\",\"searchable\":true,\"sortable\":true}},\"roles\":{\"edit\":{\"label\":\"Roles\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"Roles\",\"searchable\":false,\"sortable\":false}},\"blocked\":{\"edit\":{\"label\":\"Blocked\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Blocked\",\"searchable\":true,\"sortable\":true}},\"preferedLanguage\":{\"edit\":{\"label\":\"PreferedLanguage\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"PreferedLanguage\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"firstname\",\"lastname\",\"username\"],\"editRelations\":[\"roles\"],\"edit\":[[{\"name\":\"firstname\",\"size\":6},{\"name\":\"lastname\",\"size\":6}],[{\"name\":\"username\",\"size\":6},{\"name\":\"email\",\"size\":6}],[{\"name\":\"password\",\"size\":6},{\"name\":\"resetPasswordToken\",\"size\":6}],[{\"name\":\"registrationToken\",\"size\":6},{\"name\":\"isActive\",\"size\":4}],[{\"name\":\"blocked\",\"size\":4},{\"name\":\"preferedLanguage\",\"size\":6}]]}}', 'object', NULL, NULL),
(7, 'plugin_content_manager_configuration_content_types::plugin::upload.file', '{\"uid\":\"plugin::upload.file\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"alternativeText\":{\"edit\":{\"label\":\"AlternativeText\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"AlternativeText\",\"searchable\":true,\"sortable\":true}},\"caption\":{\"edit\":{\"label\":\"Caption\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Caption\",\"searchable\":true,\"sortable\":true}},\"width\":{\"edit\":{\"label\":\"Width\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Width\",\"searchable\":true,\"sortable\":true}},\"height\":{\"edit\":{\"label\":\"Height\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Height\",\"searchable\":true,\"sortable\":true}},\"formats\":{\"edit\":{\"label\":\"Formats\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Formats\",\"searchable\":false,\"sortable\":false}},\"hash\":{\"edit\":{\"label\":\"Hash\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Hash\",\"searchable\":true,\"sortable\":true}},\"ext\":{\"edit\":{\"label\":\"Ext\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Ext\",\"searchable\":true,\"sortable\":true}},\"mime\":{\"edit\":{\"label\":\"Mime\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Mime\",\"searchable\":true,\"sortable\":true}},\"size\":{\"edit\":{\"label\":\"Size\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Size\",\"searchable\":true,\"sortable\":true}},\"url\":{\"edit\":{\"label\":\"Url\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Url\",\"searchable\":true,\"sortable\":true}},\"previewUrl\":{\"edit\":{\"label\":\"PreviewUrl\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"PreviewUrl\",\"searchable\":true,\"sortable\":true}},\"provider\":{\"edit\":{\"label\":\"Provider\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Provider\",\"searchable\":true,\"sortable\":true}},\"provider_metadata\":{\"edit\":{\"label\":\"Provider_metadata\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Provider_metadata\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"alternativeText\",\"caption\"],\"editRelations\":[],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"alternativeText\",\"size\":6}],[{\"name\":\"caption\",\"size\":6},{\"name\":\"width\",\"size\":4}],[{\"name\":\"height\",\"size\":4}],[{\"name\":\"formats\",\"size\":12}],[{\"name\":\"hash\",\"size\":6},{\"name\":\"ext\",\"size\":6}],[{\"name\":\"mime\",\"size\":6},{\"name\":\"size\",\"size\":4}],[{\"name\":\"url\",\"size\":6},{\"name\":\"previewUrl\",\"size\":6}],[{\"name\":\"provider\",\"size\":6}],[{\"name\":\"provider_metadata\",\"size\":12}]]}}', 'object', NULL, NULL),
(8, 'plugin_content_manager_configuration_content_types::plugin::users-permissions.user', '{\"uid\":\"plugin::users-permissions.user\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"username\",\"defaultSortBy\":\"username\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"username\":{\"edit\":{\"label\":\"Username\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Username\",\"searchable\":true,\"sortable\":true}},\"email\":{\"edit\":{\"label\":\"Email\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Email\",\"searchable\":true,\"sortable\":true}},\"provider\":{\"edit\":{\"label\":\"Provider\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"Provider\",\"searchable\":true,\"sortable\":true}},\"password\":{\"edit\":{\"label\":\"Password\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Password\",\"searchable\":true,\"sortable\":true}},\"resetPasswordToken\":{\"edit\":{\"label\":\"ResetPasswordToken\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"ResetPasswordToken\",\"searchable\":true,\"sortable\":true}},\"confirmationToken\":{\"edit\":{\"label\":\"ConfirmationToken\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"ConfirmationToken\",\"searchable\":true,\"sortable\":true}},\"confirmed\":{\"edit\":{\"label\":\"Confirmed\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Confirmed\",\"searchable\":true,\"sortable\":true}},\"blocked\":{\"edit\":{\"label\":\"Blocked\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Blocked\",\"searchable\":true,\"sortable\":true}},\"role\":{\"edit\":{\"label\":\"Role\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"Role\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"username\",\"email\",\"confirmed\"],\"editRelations\":[\"role\"],\"edit\":[[{\"name\":\"username\",\"size\":6},{\"name\":\"email\",\"size\":6}],[{\"name\":\"password\",\"size\":6},{\"name\":\"confirmed\",\"size\":4}],[{\"name\":\"blocked\",\"size\":4}]]}}', 'object', NULL, NULL),
(9, 'plugin_content_manager_configuration_content_types::plugin::users-permissions.permission', '{\"uid\":\"plugin::users-permissions.permission\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"action\",\"defaultSortBy\":\"action\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"action\":{\"edit\":{\"label\":\"Action\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Action\",\"searchable\":true,\"sortable\":true}},\"role\":{\"edit\":{\"label\":\"Role\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"Role\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"action\",\"role\",\"createdAt\"],\"editRelations\":[\"role\"],\"edit\":[[{\"name\":\"action\",\"size\":6}]]}}', 'object', NULL, NULL),
(10, 'plugin_content_manager_configuration_content_types::plugin::i18n.locale', '{\"uid\":\"plugin::i18n.locale\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"code\":{\"edit\":{\"label\":\"Code\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Code\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"code\",\"createdAt\"],\"editRelations\":[],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"code\",\"size\":6}]]}}', 'object', NULL, NULL),
(11, 'plugin_upload_settings', '{\"sizeOptimization\":true,\"responsiveDimensions\":true,\"autoOrientation\":false}', 'object', NULL, NULL),
(12, 'plugin_users-permissions_grant', '{\"email\":{\"enabled\":true,\"icon\":\"envelope\"},\"discord\":{\"enabled\":false,\"icon\":\"discord\",\"key\":\"\",\"secret\":\"\",\"callback\":\"//api/auth/discord/callback\",\"scope\":[\"identify\",\"email\"]},\"facebook\":{\"enabled\":false,\"icon\":\"facebook-square\",\"key\":\"\",\"secret\":\"\",\"callback\":\"//api/auth/facebook/callback\",\"scope\":[\"email\"]},\"google\":{\"enabled\":false,\"icon\":\"google\",\"key\":\"\",\"secret\":\"\",\"callback\":\"//api/auth/google/callback\",\"scope\":[\"email\"]},\"github\":{\"enabled\":false,\"icon\":\"github\",\"key\":\"\",\"secret\":\"\",\"callback\":\"//api/auth/github/callback\",\"scope\":[\"user\",\"user:email\"]},\"microsoft\":{\"enabled\":false,\"icon\":\"windows\",\"key\":\"\",\"secret\":\"\",\"callback\":\"//api/auth/microsoft/callback\",\"scope\":[\"user.read\"]},\"twitter\":{\"enabled\":false,\"icon\":\"twitter\",\"key\":\"\",\"secret\":\"\",\"callback\":\"//api/auth/twitter/callback\"},\"instagram\":{\"enabled\":false,\"icon\":\"instagram\",\"key\":\"\",\"secret\":\"\",\"callback\":\"//api/auth/instagram/callback\",\"scope\":[\"user_profile\"]},\"vk\":{\"enabled\":false,\"icon\":\"vk\",\"key\":\"\",\"secret\":\"\",\"callback\":\"//api/auth/vk/callback\",\"scope\":[\"email\"]},\"twitch\":{\"enabled\":false,\"icon\":\"twitch\",\"key\":\"\",\"secret\":\"\",\"callback\":\"//api/auth/twitch/callback\",\"scope\":[\"user:read:email\"]},\"linkedin\":{\"enabled\":false,\"icon\":\"linkedin\",\"key\":\"\",\"secret\":\"\",\"callback\":\"//api/auth/linkedin/callback\",\"scope\":[\"r_liteprofile\",\"r_emailaddress\"]},\"cognito\":{\"enabled\":false,\"icon\":\"aws\",\"key\":\"\",\"secret\":\"\",\"subdomain\":\"my.subdomain.com\",\"callback\":\"//api/auth/cognito/callback\",\"scope\":[\"email\",\"openid\",\"profile\"]},\"reddit\":{\"enabled\":false,\"icon\":\"reddit\",\"key\":\"\",\"secret\":\"\",\"state\":true,\"callback\":\"//api/auth/reddit/callback\",\"scope\":[\"identity\"]},\"auth0\":{\"enabled\":false,\"icon\":\"\",\"key\":\"\",\"secret\":\"\",\"subdomain\":\"my-tenant.eu\",\"callback\":\"//api/auth/auth0/callback\",\"scope\":[\"openid\",\"email\",\"profile\"]},\"cas\":{\"enabled\":false,\"icon\":\"book\",\"key\":\"\",\"secret\":\"\",\"callback\":\"//api/auth/cas/callback\",\"scope\":[\"openid email\"],\"subdomain\":\"my.subdomain.com/cas\"}}', 'object', NULL, NULL),
(13, 'plugin_users-permissions_email', '{\"reset_password\":{\"display\":\"Email.template.reset_password\",\"icon\":\"sync\",\"options\":{\"from\":{\"name\":\"Administration Panel\",\"email\":\"no-reply@strapi.io\"},\"response_email\":\"\",\"object\":\"Reset password\",\"message\":\"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>\"}},\"email_confirmation\":{\"display\":\"Email.template.email_confirmation\",\"icon\":\"check-square\",\"options\":{\"from\":{\"name\":\"Administration Panel\",\"email\":\"no-reply@strapi.io\"},\"response_email\":\"\",\"object\":\"Account confirmation\",\"message\":\"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>\"}}}', 'object', NULL, NULL),
(14, 'plugin_users-permissions_advanced', '{\"unique_email\":true,\"allow_register\":true,\"email_confirmation\":false,\"email_reset_password\":null,\"email_confirmation_redirection\":null,\"default_role\":\"authenticated\"}', 'object', NULL, NULL),
(15, 'plugin_i18n_default_locale', '\"en\"', 'string', NULL, NULL),
(16, 'core_admin_auth', '{\"providers\":{\"autoRegister\":false,\"defaultRole\":null}}', 'object', NULL, NULL),
(17, 'plugin_content_manager_configuration_content_types::api::client.client', '{\"uid\":\"api::client.client\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"order\",\"defaultSortOrder\":\"DESC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"logo\":{\"edit\":{\"label\":\"Logo\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Logo\",\"searchable\":false,\"sortable\":false}},\"website\":{\"edit\":{\"label\":\"Website\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Website\",\"searchable\":true,\"sortable\":true}},\"featured\":{\"edit\":{\"label\":\"Featured\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Featured\",\"searchable\":true,\"sortable\":true}},\"order\":{\"edit\":{\"label\":\"Order serial\",\"description\":\"Lower value means above\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Order\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"website\",\"size\":6}],[{\"name\":\"logo\",\"size\":6}],[{\"name\":\"order\",\"size\":4},{\"name\":\"featured\",\"size\":4}]],\"editRelations\":[],\"list\":[\"id\",\"name\",\"logo\",\"website\",\"order\"]}}', 'object', NULL, NULL),
(18, 'plugin_documentation_config', '{\"restrictedAccess\":false}', 'object', NULL, NULL),
(23, 'plugin_content_manager_configuration_content_types::api::blog-category.blog-category', '{\"uid\":\"api::blog-category.blog-category\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"status\":{\"edit\":{\"label\":\"Status\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Status\",\"searchable\":true,\"sortable\":true}},\"description\":{\"edit\":{\"label\":\"Description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Description\",\"searchable\":true,\"sortable\":true}},\"slug\":{\"edit\":{\"label\":\"Slug\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Slug\",\"searchable\":true,\"sortable\":true}},\"parent_category\":{\"edit\":{\"label\":\"Parent_category\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"Parent_category\",\"searchable\":false,\"sortable\":false}},\"articles\":{\"edit\":{\"label\":\"Articles\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"title\"},\"list\":{\"label\":\"Articles\",\"searchable\":false,\"sortable\":false}},\"image\":{\"edit\":{\"label\":\"Image\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Image\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"status\",\"description\"],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"status\",\"size\":4}],[{\"name\":\"description\",\"size\":6},{\"name\":\"slug\",\"size\":6}],[{\"name\":\"image\",\"size\":6}]],\"editRelations\":[\"parent_category\",\"articles\"]}}', 'object', NULL, NULL),
(24, 'plugin_content_manager_configuration_content_types::api::portfolio-category.portfolio-category', '{\"uid\":\"api::portfolio-category.portfolio-category\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"description\":{\"edit\":{\"label\":\"Description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Description\",\"searchable\":true,\"sortable\":true}},\"slug\":{\"edit\":{\"label\":\"Slug\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Slug\",\"searchable\":true,\"sortable\":true}},\"status\":{\"edit\":{\"label\":\"Status\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Status\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"description\",\"slug\"],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"description\",\"size\":6}],[{\"name\":\"slug\",\"size\":6},{\"name\":\"status\",\"size\":4}]],\"editRelations\":[]}}', 'object', NULL, NULL),
(25, 'plugin_content_manager_configuration_content_types::api::portfolio.portfolio', '{\"uid\":\"api::portfolio.portfolio\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"title\",\"defaultSortBy\":\"title\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"title\":{\"edit\":{\"label\":\"Title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Title\",\"searchable\":true,\"sortable\":true}},\"image\":{\"edit\":{\"label\":\"Image\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Image\",\"searchable\":false,\"sortable\":false}},\"featured\":{\"edit\":{\"label\":\"Featured\",\"description\":\"(Display portfolio on top)\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Featured\",\"searchable\":true,\"sortable\":true}},\"category\":{\"edit\":{\"label\":\"Category\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"Category\",\"searchable\":true,\"sortable\":true}},\"client\":{\"edit\":{\"label\":\"Client\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Client\",\"searchable\":true,\"sortable\":true}},\"year\":{\"edit\":{\"label\":\"Year\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Year\",\"searchable\":true,\"sortable\":true}},\"content\":{\"edit\":{\"label\":\"Content\",\"description\":\"\",\"placeholder\":\"detailed content for your portfolio\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Content\",\"searchable\":false,\"sortable\":false}},\"description\":{\"edit\":{\"label\":\"Description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Description\",\"searchable\":true,\"sortable\":true}},\"gallery\":{\"edit\":{\"label\":\"Gallery\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Gallery\",\"searchable\":false,\"sortable\":false}},\"keywords\":{\"edit\":{\"label\":\"Keywords\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Keywords\",\"searchable\":false,\"sortable\":false}},\"embedCode\":{\"edit\":{\"label\":\"EmbedCode\",\"description\":\"add iframe code\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"EmbedCode\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"title\",\"size\":6}],[{\"name\":\"description\",\"size\":6},{\"name\":\"image\",\"size\":6}],[{\"name\":\"content\",\"size\":12}],[{\"name\":\"gallery\",\"size\":12}],[{\"name\":\"client\",\"size\":6},{\"name\":\"year\",\"size\":4}],[{\"name\":\"embedCode\",\"size\":6},{\"name\":\"featured\",\"size\":4}],[{\"name\":\"keywords\",\"size\":12}]],\"editRelations\":[\"category\"],\"list\":[\"id\",\"title\",\"image\",\"featured\"]}}', 'object', NULL, NULL),
(26, 'plugin_content_manager_configuration_components::media.gallery', '{\"uid\":\"media.gallery\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"id\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"images\":{\"edit\":{\"label\":\"Images\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Images\",\"searchable\":false,\"sortable\":false}}},\"layouts\":{\"list\":[\"id\",\"images\"],\"edit\":[[{\"name\":\"images\",\"size\":6}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(27, 'plugin_content_manager_configuration_components::text.keyword', '{\"uid\":\"text.keyword\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"keyword\",\"defaultSortBy\":\"keyword\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"keyword\":{\"edit\":{\"label\":\"Keyword\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Keyword\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"keyword\"],\"edit\":[[{\"name\":\"keyword\",\"size\":6}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(29, 'plugin_content_manager_configuration_components::elements.slider', '{\"uid\":\"elements.slider\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"title\",\"defaultSortBy\":\"title\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"image\":{\"edit\":{\"label\":\"Image\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Image\",\"searchable\":false,\"sortable\":false}},\"title\":{\"edit\":{\"label\":\"Title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Title\",\"searchable\":true,\"sortable\":true}},\"subtitle\":{\"edit\":{\"label\":\"Subtitle\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Subtitle\",\"searchable\":true,\"sortable\":true}},\"btnText\":{\"edit\":{\"label\":\"BtnText\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"BtnText\",\"searchable\":true,\"sortable\":true}},\"btnLink\":{\"edit\":{\"label\":\"BtnLink\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"BtnLink\",\"searchable\":true,\"sortable\":true}},\"status\":{\"edit\":{\"label\":\"Status\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Status\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"image\",\"title\",\"subtitle\"],\"edit\":[[{\"name\":\"image\",\"size\":6},{\"name\":\"title\",\"size\":6}],[{\"name\":\"subtitle\",\"size\":6},{\"name\":\"btnText\",\"size\":6}],[{\"name\":\"btnLink\",\"size\":6},{\"name\":\"status\",\"size\":4}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(30, 'plugin_content_manager_configuration_content_types::api::homepage-slider.homepage-slider', '{\"uid\":\"api::homepage-slider.homepage-slider\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"id\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"slides\":{\"edit\":{\"label\":\"Slides\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Slides\",\"searchable\":false,\"sortable\":false}},\"status\":{\"edit\":{\"label\":\"Status\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Status\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"status\",\"createdAt\",\"updatedAt\"],\"editRelations\":[],\"edit\":[[{\"name\":\"slides\",\"size\":12}],[{\"name\":\"status\",\"size\":4}]]}}', 'object', NULL, NULL),
(31, 'plugin_content_manager_configuration_content_types::api::testimonial.testimonial', '{\"uid\":\"api::testimonial.testimonial\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"designation\":{\"edit\":{\"label\":\"Designation\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Designation\",\"searchable\":true,\"sortable\":true}},\"avatar\":{\"edit\":{\"label\":\"Avatar\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Avatar\",\"searchable\":false,\"sortable\":false}},\"Review\":{\"edit\":{\"label\":\"Review\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Review\",\"searchable\":false,\"sortable\":false}},\"status\":{\"edit\":{\"label\":\"Status\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Status\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"designation\",\"size\":6}],[{\"name\":\"avatar\",\"size\":6}],[{\"name\":\"Review\",\"size\":12}],[{\"name\":\"status\",\"size\":4}]],\"editRelations\":[],\"list\":[\"id\",\"name\",\"avatar\",\"designation\",\"status\"]}}', 'object', NULL, NULL),
(32, 'plugin_content_manager_configuration_components::elements.review', '{\"uid\":\"elements.review\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"id\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"rating\":{\"edit\":{\"label\":\"Rating\",\"description\":\"\",\"placeholder\":\"1-5\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Rating\",\"searchable\":true,\"sortable\":true}},\"Type\":{\"edit\":{\"label\":\"Type\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Type\",\"searchable\":true,\"sortable\":true}},\"review\":{\"edit\":{\"label\":\"Review\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Review\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"rating\",\"Type\",\"review\"],\"edit\":[[{\"name\":\"rating\",\"size\":4},{\"name\":\"Type\",\"size\":6}],[{\"name\":\"review\",\"size\":6}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(33, 'plugin_content_manager_configuration_content_types::api::article.article', '{\"uid\":\"api::article.article\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"title\",\"defaultSortBy\":\"title\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"title\":{\"edit\":{\"label\":\"Title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Title\",\"searchable\":true,\"sortable\":true}},\"slug\":{\"edit\":{\"label\":\"Slug\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Slug\",\"searchable\":true,\"sortable\":true}},\"excerpt\":{\"edit\":{\"label\":\"Excerpt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Excerpt\",\"searchable\":true,\"sortable\":true}},\"featured_image\":{\"edit\":{\"label\":\"Featured_image\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Featured_image\",\"searchable\":false,\"sortable\":false}},\"thumbnail\":{\"edit\":{\"label\":\"Thumbnail\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Thumbnail\",\"searchable\":false,\"sortable\":false}},\"content\":{\"edit\":{\"label\":\"Content\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Content\",\"searchable\":false,\"sortable\":false}},\"categories\":{\"edit\":{\"label\":\"Categories\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"Categories\",\"searchable\":false,\"sortable\":false}},\"featured\":{\"edit\":{\"label\":\"Featured\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Featured\",\"searchable\":true,\"sortable\":true}},\"status\":{\"edit\":{\"label\":\"Status\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Status\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"title\",\"thumbnail\",\"excerpt\",\"categories\",\"featured\",\"status\"],\"edit\":[[{\"name\":\"title\",\"size\":6},{\"name\":\"slug\",\"size\":6}],[{\"name\":\"excerpt\",\"size\":6}],[{\"name\":\"featured_image\",\"size\":6},{\"name\":\"thumbnail\",\"size\":6}],[{\"name\":\"content\",\"size\":12}],[{\"name\":\"featured\",\"size\":4},{\"name\":\"status\",\"size\":4}]],\"editRelations\":[\"categories\"]}}', 'object', NULL, NULL);
INSERT INTO `strapi_core_store_settings` (`id`, `key`, `value`, `type`, `environment`, `tag`) VALUES
(34, 'plugin_content_manager_configuration_components::elements.social-info', '{\"uid\":\"elements.social-info\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"link\":{\"edit\":{\"label\":\"Link\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Link\",\"searchable\":true,\"sortable\":true}},\"icon\":{\"edit\":{\"label\":\"Icon\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Icon\",\"searchable\":false,\"sortable\":false}},\"status\":{\"edit\":{\"label\":\"Status\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Status\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"link\",\"icon\"],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"link\",\"size\":6}],[{\"name\":\"icon\",\"size\":6},{\"name\":\"status\",\"size\":4}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(35, 'plugin_content_manager_configuration_components::media.logos', '{\"uid\":\"media.logos\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"id\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"normal\":{\"edit\":{\"label\":\"Normal\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Normal\",\"searchable\":false,\"sortable\":false}},\"light\":{\"edit\":{\"label\":\"Light\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Light\",\"searchable\":false,\"sortable\":false}},\"dark\":{\"edit\":{\"label\":\"Dark\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Dark\",\"searchable\":false,\"sortable\":false}},\"loader\":{\"edit\":{\"label\":\"Loader\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Loader\",\"searchable\":false,\"sortable\":false}}},\"layouts\":{\"list\":[\"id\",\"normal\",\"light\",\"dark\"],\"edit\":[[{\"name\":\"normal\",\"size\":6},{\"name\":\"light\",\"size\":6}],[{\"name\":\"dark\",\"size\":6},{\"name\":\"loader\",\"size\":6}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(36, 'plugin_content_manager_configuration_content_types::api::site-info.site-info', '{\"uid\":\"api::site-info.site-info\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"site_name\",\"defaultSortBy\":\"site_name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"site_name\":{\"edit\":{\"label\":\"Site_name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Site_name\",\"searchable\":true,\"sortable\":true}},\"site_title\":{\"edit\":{\"label\":\"Site_title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Site_title\",\"searchable\":true,\"sortable\":true}},\"meta_keywords\":{\"edit\":{\"label\":\"Meta_keywords\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Meta_keywords\",\"searchable\":false,\"sortable\":false}},\"site_logo\":{\"edit\":{\"label\":\"Site_logo\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Site_logo\",\"searchable\":false,\"sortable\":false}},\"contact_info\":{\"edit\":{\"label\":\"Contact_info\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Contact_info\",\"searchable\":false,\"sortable\":false}},\"menus\":{\"edit\":{\"label\":\"Menus\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Menus\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"site_name\",\"site_title\",\"createdAt\"],\"edit\":[[{\"name\":\"site_name\",\"size\":6},{\"name\":\"site_title\",\"size\":6}],[{\"name\":\"site_logo\",\"size\":12}],[{\"name\":\"contact_info\",\"size\":12}],[{\"name\":\"meta_keywords\",\"size\":12}],[{\"name\":\"menus\",\"size\":12}]],\"editRelations\":[]}}', 'object', NULL, NULL);
INSERT INTO `strapi_core_store_settings` (`id`, `key`, `value`, `type`, `environment`, `tag`) VALUES
(37, 'plugin_content_manager_configuration_components::elements.contact-info', '{\"uid\":\"elements.contact-info\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"email\",\"defaultSortBy\":\"email\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"email\":{\"edit\":{\"label\":\"Email\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Email\",\"searchable\":true,\"sortable\":true}},\"phone\":{\"edit\":{\"label\":\"Phone\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Phone\",\"searchable\":true,\"sortable\":true}},\"Address\":{\"edit\":{\"label\":\"Address\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Address\",\"searchable\":true,\"sortable\":true}},\"socials\":{\"edit\":{\"label\":\"Socials\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Socials\",\"searchable\":false,\"sortable\":false}}},\"layouts\":{\"list\":[\"id\",\"email\",\"phone\",\"Address\"],\"edit\":[[{\"name\":\"email\",\"size\":6},{\"name\":\"phone\",\"size\":6}],[{\"name\":\"Address\",\"size\":6}],[{\"name\":\"socials\",\"size\":12}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(38, 'plugin_content_manager_configuration_content_types::api::team-member.team-member', '{\"uid\":\"api::team-member.team-member\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"order\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"designation\":{\"edit\":{\"label\":\"Designation\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Designation\",\"searchable\":true,\"sortable\":true}},\"photo\":{\"edit\":{\"label\":\"Photo\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Photo\",\"searchable\":false,\"sortable\":false}},\"bio\":{\"edit\":{\"label\":\"Bio\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Bio\",\"searchable\":true,\"sortable\":true}},\"links\":{\"edit\":{\"label\":\"Links\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Links\",\"searchable\":false,\"sortable\":false}},\"status\":{\"edit\":{\"label\":\"Status\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Status\",\"searchable\":true,\"sortable\":true}},\"order\":{\"edit\":{\"label\":\"Order serial\",\"description\":\"Lower value means above\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Order\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"designation\",\"size\":6}],[{\"name\":\"photo\",\"size\":6},{\"name\":\"bio\",\"size\":6}],[{\"name\":\"links\",\"size\":12}],[{\"name\":\"status\",\"size\":4},{\"name\":\"order\",\"size\":4}]],\"editRelations\":[],\"list\":[\"order\",\"name\",\"designation\",\"photo\"]}}', 'object', NULL, NULL),
(39, 'plugin_content_manager_configuration_content_types::api::service.service', '{\"uid\":\"api::service.service\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"title\",\"defaultSortBy\":\"title\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"title\":{\"edit\":{\"label\":\"Title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Title\",\"searchable\":true,\"sortable\":true}},\"sub_title\":{\"edit\":{\"label\":\"Sub_title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Sub_title\",\"searchable\":true,\"sortable\":true}},\"image\":{\"edit\":{\"label\":\"Image\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Image\",\"searchable\":false,\"sortable\":false}},\"keywords\":{\"edit\":{\"label\":\"Keywords\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Keywords\",\"searchable\":false,\"sortable\":false}},\"description\":{\"edit\":{\"label\":\"Description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Description\",\"searchable\":true,\"sortable\":true}},\"featured\":{\"edit\":{\"label\":\"Featured\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Featured\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"title\",\"sub_title\",\"image\"],\"edit\":[[{\"name\":\"title\",\"size\":6},{\"name\":\"sub_title\",\"size\":6}],[{\"name\":\"description\",\"size\":6},{\"name\":\"image\",\"size\":6}],[{\"name\":\"keywords\",\"size\":12}],[{\"name\":\"featured\",\"size\":4}]],\"editRelations\":[]}}', 'object', NULL, NULL),
(41, 'plugin_content_manager_configuration_content_types::api::page.page', '{\"uid\":\"api::page.page\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"title\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"title\":{\"edit\":{\"label\":\"Title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Title\",\"searchable\":true,\"sortable\":true}},\"sub_title\":{\"edit\":{\"label\":\"Sub_title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Sub_title\",\"searchable\":true,\"sortable\":true}},\"header_image\":{\"edit\":{\"label\":\"Header_image\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Header_image\",\"searchable\":false,\"sortable\":false}},\"type\":{\"edit\":{\"label\":\"Type\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Type\",\"searchable\":true,\"sortable\":true}},\"blocks\":{\"edit\":{\"label\":\"UI Blocks\",\"description\":\"You can design your page content with custom UI blocks if the page type is custom.\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Blocks\",\"searchable\":false,\"sortable\":false}},\"leaf_content\":{\"edit\":{\"label\":\"Leaf_content\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Leaf_content\",\"searchable\":false,\"sortable\":false}},\"status\":{\"edit\":{\"label\":\"Status\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Status\",\"searchable\":true,\"sortable\":true}},\"SEO\":{\"edit\":{\"label\":\"SEO\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"SEO\",\"searchable\":false,\"sortable\":false}},\"slug\":{\"edit\":{\"label\":\"Slug\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Slug\",\"searchable\":true,\"sortable\":true}},\"header_size\":{\"edit\":{\"label\":\"Header_size\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Header_size\",\"searchable\":true,\"sortable\":true}},\"Fields\":{\"edit\":{\"label\":\"Fields\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Fields\",\"searchable\":false,\"sortable\":false}},\"Sections\":{\"edit\":{\"label\":\"Sections\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Sections\",\"searchable\":false,\"sortable\":false}},\"Pagedata\":{\"edit\":{\"label\":\"Pagedata\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Pagedata\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"title\",\"size\":6},{\"name\":\"sub_title\",\"size\":6}],[{\"name\":\"header_image\",\"size\":6},{\"name\":\"header_size\",\"size\":6}],[{\"name\":\"type\",\"size\":6},{\"name\":\"slug\",\"size\":6}],[{\"name\":\"leaf_content\",\"size\":12}],[{\"name\":\"blocks\",\"size\":12}],[{\"name\":\"SEO\",\"size\":12}],[{\"name\":\"Fields\",\"size\":12}],[{\"name\":\"Sections\",\"size\":12}],[{\"name\":\"Pagedata\",\"size\":12}],[{\"name\":\"status\",\"size\":4}]],\"editRelations\":[],\"list\":[\"id\",\"title\",\"header_image\",\"slug\",\"type\"]}}', 'object', NULL, NULL),
(42, 'plugin_content_manager_configuration_components::mixed.seo', '{\"uid\":\"mixed.seo\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"meta_title\",\"defaultSortBy\":\"meta_title\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"meta_title\":{\"edit\":{\"label\":\"Meta_title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Meta_title\",\"searchable\":true,\"sortable\":true}},\"meta_description\":{\"edit\":{\"label\":\"Meta_description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Meta_description\",\"searchable\":true,\"sortable\":true}},\"meta_tags\":{\"edit\":{\"label\":\"Meta_tags\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Meta_tags\",\"searchable\":false,\"sortable\":false}},\"share_thumbnail\":{\"edit\":{\"label\":\"Share_thumbnail\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Share_thumbnail\",\"searchable\":false,\"sortable\":false}}},\"layouts\":{\"list\":[\"id\",\"meta_title\",\"meta_description\",\"share_thumbnail\"],\"edit\":[[{\"name\":\"meta_title\",\"size\":6},{\"name\":\"meta_description\",\"size\":6}],[{\"name\":\"meta_tags\",\"size\":12}],[{\"name\":\"share_thumbnail\",\"size\":6}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(44, 'plugin_content_manager_configuration_components::elements.menu-item', '{\"uid\":\"elements.menu-item\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"title\",\"defaultSortBy\":\"title\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"title\":{\"edit\":{\"label\":\"Title\",\"description\":\"Menu name visible to the user\",\"placeholder\":\"Menu name visible to the user\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Title\",\"searchable\":true,\"sortable\":true}},\"type\":{\"edit\":{\"label\":\"Type\",\"description\":\"Should it redirect to a page or custom link?\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Type\",\"searchable\":true,\"sortable\":true}},\"page\":{\"edit\":{\"label\":\"Page\",\"description\":\"\",\"placeholder\":\"Select target page\",\"visible\":true,\"editable\":true,\"mainField\":\"title\"},\"list\":{\"label\":\"Page\",\"searchable\":true,\"sortable\":true}},\"custom_link\":{\"edit\":{\"label\":\"Custom link (optional)\",\"description\":\"enter if the menu type is custom.\",\"placeholder\":\"http://test.com/link\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Custom_link\",\"searchable\":true,\"sortable\":true}},\"hover_image\":{\"edit\":{\"label\":\"Hover image\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Hover_image\",\"searchable\":false,\"sortable\":false}},\"status\":{\"edit\":{\"label\":\"Status\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Status\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"type\",\"title\",\"page\"],\"edit\":[[{\"name\":\"title\",\"size\":6},{\"name\":\"type\",\"size\":6}],[{\"name\":\"page\",\"size\":6},{\"name\":\"custom_link\",\"size\":6}],[{\"name\":\"hover_image\",\"size\":6},{\"name\":\"status\",\"size\":4}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(48, 'plugin_content_manager_configuration_content_types::api::menu.menu', '{\"uid\":\"api::menu.menu\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"items\":{\"edit\":{\"label\":\"Items\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Items\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"name\",\"size\":6}],[{\"name\":\"items\",\"size\":12}]],\"editRelations\":[],\"list\":[\"id\",\"name\",\"createdAt\",\"updatedAt\"]}}', 'object', NULL, NULL),
(49, 'plugin_content_manager_configuration_components::elements.menus', '{\"uid\":\"elements.menus\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"id\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"primary_menu\":{\"edit\":{\"label\":\"Primary_menu\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"Primary_menu\",\"searchable\":true,\"sortable\":true}},\"footer_menu_left\":{\"edit\":{\"label\":\"Footer_menu_left\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"Footer_menu_left\",\"searchable\":true,\"sortable\":true}},\"footer_menu_right\":{\"edit\":{\"label\":\"Footer_menu_right\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"Footer_menu_right\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"primary_menu\",\"footer_menu_left\",\"footer_menu_right\"],\"edit\":[[{\"name\":\"primary_menu\",\"size\":6},{\"name\":\"footer_menu_left\",\"size\":6}],[{\"name\":\"footer_menu_right\",\"size\":6}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(50, 'plugin_content_manager_configuration_content_types::api::contact-form-submit.contact-form-submit', '{\"uid\":\"api::contact-form-submit.contact-form-submit\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":20,\"mainField\":\"name\",\"defaultSortBy\":\"createdAt\",\"defaultSortOrder\":\"DESC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"phone\":{\"edit\":{\"label\":\"Phone\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Phone\",\"searchable\":true,\"sortable\":true}},\"email\":{\"edit\":{\"label\":\"Email\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Email\",\"searchable\":true,\"sortable\":true}},\"message\":{\"edit\":{\"label\":\"Message\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Message\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"CreatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"CreatedAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"UpdatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"UpdatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"phone\",\"size\":6}],[{\"name\":\"email\",\"size\":6},{\"name\":\"message\",\"size\":6}]],\"editRelations\":[],\"list\":[\"name\",\"email\",\"phone\",\"message\"]}}', 'object', NULL, NULL),
(51, 'plugin_content_manager_configuration_components::crud.field', '{\"uid\":\"crud.field\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"No spaces allowed\",\"placeholder\":\"Field name\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"Value\":{\"edit\":{\"label\":\"Value\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Value\",\"searchable\":true,\"sortable\":true}},\"Type\":{\"edit\":{\"label\":\"Type\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Type\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"Value\",\"name\",\"Type\"],\"edit\":[[{\"name\":\"name\",\"size\":6}],[{\"name\":\"Value\",\"size\":6},{\"name\":\"Type\",\"size\":6}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(52, 'plugin_content_manager_configuration_components::crud.section', '{\"uid\":\"crud.section\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}},\"content\":{\"edit\":{\"label\":\"Content\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Content\",\"searchable\":false,\"sortable\":false}},\"status\":{\"edit\":{\"label\":\"Status\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Status\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"status\"],\"edit\":[[{\"name\":\"name\",\"size\":6}],[{\"name\":\"content\",\"size\":12}],[{\"name\":\"status\",\"size\":4}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(53, 'plugin_content_manager_configuration_components::models.portfolio', '{\"uid\":\"models.portfolio\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":false,\"sortable\":false}}},\"layouts\":{\"list\":[\"id\"],\"edit\":[[{\"name\":\"name\",\"size\":6}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(54, 'plugin_content_manager_configuration_components::models.testimonials', '{\"uid\":\"models.testimonials\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\"],\"edit\":[[{\"name\":\"name\",\"size\":6}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(55, 'plugin_content_manager_configuration_components::models.clients', '{\"uid\":\"models.clients\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\"],\"edit\":[[{\"name\":\"name\",\"size\":6}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL),
(56, 'plugin_content_manager_configuration_components::models.services', '{\"uid\":\"models.services\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"Id\",\"searchable\":false,\"sortable\":false}},\"name\":{\"edit\":{\"label\":\"Name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Name\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\"],\"edit\":[[{\"name\":\"name\",\"size\":6}]],\"editRelations\":[]},\"isComponent\":true}', 'object', NULL, NULL);

INSERT INTO `strapi_database_schema` (`id`, `schema`, `time`, `hash`) VALUES
(103, '{\"tables\":[{\"name\":\"strapi_core_store_settings\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"key\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"value\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"environment\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"tag\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"strapi_webhooks\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"url\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"headers\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"events\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"enabled\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"admin_permissions\",\"indexes\":[{\"name\":\"admin_permissions_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"admin_permissions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"admin_permissions_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"admin_permissions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"action\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"subject\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"properties\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"conditions\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"admin_users\",\"indexes\":[{\"name\":\"admin_users_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"admin_users_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"admin_users_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"admin_users_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"firstname\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"lastname\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"username\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"email\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"password\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"reset_password_token\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"registration_token\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"is_active\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"blocked\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"prefered_language\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"admin_roles\",\"indexes\":[{\"name\":\"admin_roles_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"admin_roles_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"admin_roles_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"admin_roles_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"code\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"strapi_api_tokens\",\"indexes\":[{\"name\":\"strapi_api_tokens_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"strapi_api_tokens_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"strapi_api_tokens_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"strapi_api_tokens_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"access_key\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"files\",\"indexes\":[{\"name\":\"files_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"files_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"files_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"files_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"alternative_text\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"caption\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"width\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"height\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"formats\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"hash\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"ext\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"mime\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"size\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"url\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"preview_url\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"provider\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"provider_metadata\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"i18n_locale\",\"indexes\":[{\"name\":\"i18n_locale_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"i18n_locale_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"i18n_locale_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"i18n_locale_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"code\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"up_permissions\",\"indexes\":[{\"name\":\"up_permissions_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"up_permissions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"up_permissions_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"up_permissions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"action\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"up_roles\",\"indexes\":[{\"name\":\"up_roles_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"up_roles_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"up_roles_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"up_roles_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"up_users\",\"indexes\":[{\"name\":\"up_users_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"up_users_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"up_users_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"up_users_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"username\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"email\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"provider\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"password\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"reset_password_token\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"confirmation_token\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"confirmed\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"blocked\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"articles\",\"indexes\":[{\"type\":\"unique\",\"name\":\"articles_slug_unique\",\"columns\":[\"slug\"]},{\"name\":\"articles_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"articles_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"articles_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"articles_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"slug\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false,\"unique\":true},{\"name\":\"excerpt\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"content\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"featured\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"status\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"published_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"blog_categories\",\"indexes\":[{\"type\":\"unique\",\"name\":\"blog_categories_slug_unique\",\"columns\":[\"slug\"]},{\"name\":\"blog_categories_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"blog_categories_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"blog_categories_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"blog_categories_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"status\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"slug\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false,\"unique\":true},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"clients\",\"indexes\":[{\"name\":\"clients_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"clients_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"clients_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"clients_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"website\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"featured\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"contact_form_submits\",\"indexes\":[{\"name\":\"contact_form_submits_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"contact_form_submits_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"contact_form_submits_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"contact_form_submits_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"phone\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"email\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"message\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"homepage_sliders\",\"indexes\":[{\"name\":\"homepage_sliders_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"homepage_sliders_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"homepage_sliders_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"homepage_sliders_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"status\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"published_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"menus\",\"indexes\":[{\"name\":\"menus_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"menus_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"menus_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"menus_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"published_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"pages\",\"indexes\":[{\"type\":\"unique\",\"name\":\"pages_slug_unique\",\"columns\":[\"slug\"]},{\"name\":\"pages_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"pages_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"pages_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"pages_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"sub_title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"leaf_content\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"status\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"slug\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false,\"unique\":true},{\"name\":\"header_size\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"published_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"portfolios\",\"indexes\":[{\"name\":\"portfolios_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"portfolios_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"portfolios_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"portfolios_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"featured\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"client\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"year\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"content\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"embed_code\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"published_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"portfolio_categories\",\"indexes\":[{\"type\":\"unique\",\"name\":\"portfolio_categories_slug_unique\",\"columns\":[\"slug\"]},{\"name\":\"portfolio_categories_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"portfolio_categories_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"portfolio_categories_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"portfolio_categories_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"slug\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false,\"unique\":true},{\"name\":\"status\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"services\",\"indexes\":[{\"name\":\"services_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"services_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"services_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"services_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"sub_title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"featured\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"published_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"site_infos\",\"indexes\":[{\"name\":\"site_infos_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"site_infos_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"site_infos_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"site_infos_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"site_name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"site_title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"published_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"team_members\",\"indexes\":[{\"name\":\"team_members_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"team_members_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"team_members_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"team_members_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"designation\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"bio\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"status\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"published_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"testimonials\",\"indexes\":[{\"name\":\"testimonials_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"testimonials_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"testimonials_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"testimonials_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"designation\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"status\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"components_crud_fields\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"value\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_crud_sections\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"content\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"status\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_elements_contact_infos\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"email\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"phone\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"address\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_elements_menu_items\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"custom_link\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"status\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_elements_menus\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false}]},{\"name\":\"components_elements_reviews\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"rating\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"review\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_elements_sliders\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"subtitle\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"btn_text\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"btn_link\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"status\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_elements_social_infos\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"link\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"status\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_media_galleries\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false}]},{\"name\":\"components_media_logos\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false}]},{\"name\":\"components_mixed_seos\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"meta_title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"meta_description\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_models_clients\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_models_portfolios\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_models_services\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_models_testimonials\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_text_keywords\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"keyword\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"admin_permissions_role_links\",\"indexes\":[{\"name\":\"admin_permissions_role_links_fk\",\"columns\":[\"permission_id\"]},{\"name\":\"admin_permissions_role_links_inv_fk\",\"columns\":[\"role_id\"]}],\"foreignKeys\":[{\"name\":\"admin_permissions_role_links_fk\",\"columns\":[\"permission_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"admin_permissions\",\"onDelete\":\"CASCADE\"},{\"name\":\"admin_permissions_role_links_inv_fk\",\"columns\":[\"role_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"admin_roles\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"permission_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"role_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"admin_users_roles_links\",\"indexes\":[{\"name\":\"admin_users_roles_links_fk\",\"columns\":[\"user_id\"]},{\"name\":\"admin_users_roles_links_inv_fk\",\"columns\":[\"role_id\"]}],\"foreignKeys\":[{\"name\":\"admin_users_roles_links_fk\",\"columns\":[\"user_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"admin_users\",\"onDelete\":\"CASCADE\"},{\"name\":\"admin_users_roles_links_inv_fk\",\"columns\":[\"role_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"admin_roles\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"user_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"role_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"files_related_morphs\",\"indexes\":[{\"name\":\"files_related_morphs_fk\",\"columns\":[\"file_id\"]}],\"foreignKeys\":[{\"name\":\"files_related_morphs_fk\",\"columns\":[\"file_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"files\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"file_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"related_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"related_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"up_permissions_role_links\",\"indexes\":[{\"name\":\"up_permissions_role_links_fk\",\"columns\":[\"permission_id\"]},{\"name\":\"up_permissions_role_links_inv_fk\",\"columns\":[\"role_id\"]}],\"foreignKeys\":[{\"name\":\"up_permissions_role_links_fk\",\"columns\":[\"permission_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"up_permissions\",\"onDelete\":\"CASCADE\"},{\"name\":\"up_permissions_role_links_inv_fk\",\"columns\":[\"role_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"up_roles\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"permission_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"role_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"up_users_role_links\",\"indexes\":[{\"name\":\"up_users_role_links_fk\",\"columns\":[\"user_id\"]},{\"name\":\"up_users_role_links_inv_fk\",\"columns\":[\"role_id\"]}],\"foreignKeys\":[{\"name\":\"up_users_role_links_fk\",\"columns\":[\"user_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"up_users\",\"onDelete\":\"CASCADE\"},{\"name\":\"up_users_role_links_inv_fk\",\"columns\":[\"role_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"up_roles\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"user_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"role_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"blog_categories_parent_category_links\",\"indexes\":[{\"name\":\"blog_categories_parent_category_links_fk\",\"columns\":[\"blog_category_id\"]},{\"name\":\"blog_categories_parent_category_links_inv_fk\",\"columns\":[\"inv_blog_category_id\"]}],\"foreignKeys\":[{\"name\":\"blog_categories_parent_category_links_fk\",\"columns\":[\"blog_category_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"blog_categories\",\"onDelete\":\"CASCADE\"},{\"name\":\"blog_categories_parent_category_links_inv_fk\",\"columns\":[\"inv_blog_category_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"blog_categories\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"blog_category_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"inv_blog_category_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"blog_categories_articles_links\",\"indexes\":[{\"name\":\"blog_categories_articles_links_fk\",\"columns\":[\"blog_category_id\"]},{\"name\":\"blog_categories_articles_links_inv_fk\",\"columns\":[\"article_id\"]}],\"foreignKeys\":[{\"name\":\"blog_categories_articles_links_fk\",\"columns\":[\"blog_category_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"blog_categories\",\"onDelete\":\"CASCADE\"},{\"name\":\"blog_categories_articles_links_inv_fk\",\"columns\":[\"article_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"articles\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"blog_category_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"article_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"homepage_sliders_components\",\"indexes\":[{\"name\":\"homepage_sliders_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"homepage_sliders_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"homepage_sliders_entity_fk\",\"columns\":[\"entity_id\"]}],\"foreignKeys\":[{\"name\":\"homepage_sliders_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"homepage_sliders\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":0,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"menus_components\",\"indexes\":[{\"name\":\"menus_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"menus_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"menus_entity_fk\",\"columns\":[\"entity_id\"]}],\"foreignKeys\":[{\"name\":\"menus_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"menus\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":0,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"pages_components\",\"indexes\":[{\"name\":\"pages_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"pages_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"pages_entity_fk\",\"columns\":[\"entity_id\"]}],\"foreignKeys\":[{\"name\":\"pages_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"pages\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":0,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"portfolios_components\",\"indexes\":[{\"name\":\"portfolios_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"portfolios_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"portfolios_entity_fk\",\"columns\":[\"entity_id\"]}],\"foreignKeys\":[{\"name\":\"portfolios_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"portfolios\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":0,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"portfolios_category_links\",\"indexes\":[{\"name\":\"portfolios_category_links_fk\",\"columns\":[\"portfolio_id\"]},{\"name\":\"portfolios_category_links_inv_fk\",\"columns\":[\"portfolio_category_id\"]}],\"foreignKeys\":[{\"name\":\"portfolios_category_links_fk\",\"columns\":[\"portfolio_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"portfolios\",\"onDelete\":\"CASCADE\"},{\"name\":\"portfolios_category_links_inv_fk\",\"columns\":[\"portfolio_category_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"portfolio_categories\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"portfolio_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"portfolio_category_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"services_components\",\"indexes\":[{\"name\":\"services_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"services_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"services_entity_fk\",\"columns\":[\"entity_id\"]}],\"foreignKeys\":[{\"name\":\"services_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"services\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":0,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"site_infos_components\",\"indexes\":[{\"name\":\"site_infos_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"site_infos_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"site_infos_entity_fk\",\"columns\":[\"entity_id\"]}],\"foreignKeys\":[{\"name\":\"site_infos_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"site_infos\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":0,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"team_members_components\",\"indexes\":[{\"name\":\"team_members_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"team_members_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"team_members_entity_fk\",\"columns\":[\"entity_id\"]}],\"foreignKeys\":[{\"name\":\"team_members_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"team_members\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":0,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"testimonials_components\",\"indexes\":[{\"name\":\"testimonials_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"testimonials_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"testimonials_entity_fk\",\"columns\":[\"entity_id\"]}],\"foreignKeys\":[{\"name\":\"testimonials_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"testimonials\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":0,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"components_elements_contact_infos_components\",\"indexes\":[{\"name\":\"components_elements_contact_infos_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"components_elements_contact_infos_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"components_elements_contact_infos_entity_fk\",\"columns\":[\"entity_id\"]}],\"foreignKeys\":[{\"name\":\"components_elements_contact_infos_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"components_elements_contact_infos\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":0,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"components_elements_menu_items_page_links\",\"indexes\":[{\"name\":\"components_elements_menu_items_page_links_fk\",\"columns\":[\"menu_item_id\"]},{\"name\":\"components_elements_menu_items_page_links_inv_fk\",\"columns\":[\"page_id\"]}],\"foreignKeys\":[{\"name\":\"components_elements_menu_items_page_links_fk\",\"columns\":[\"menu_item_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"components_elements_menu_items\",\"onDelete\":\"CASCADE\"},{\"name\":\"components_elements_menu_items_page_links_inv_fk\",\"columns\":[\"page_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"pages\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"menu_item_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"page_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"components_elements_menus_primary_menu_links\",\"indexes\":[{\"name\":\"components_elements_menus_primary_menu_links_fk\",\"columns\":[\"menus_id\"]},{\"name\":\"components_elements_menus_primary_menu_links_inv_fk\",\"columns\":[\"menu_id\"]}],\"foreignKeys\":[{\"name\":\"components_elements_menus_primary_menu_links_fk\",\"columns\":[\"menus_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"components_elements_menus\",\"onDelete\":\"CASCADE\"},{\"name\":\"components_elements_menus_primary_menu_links_inv_fk\",\"columns\":[\"menu_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"menus\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"menus_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"menu_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"components_elements_menus_footer_menu_left_links\",\"indexes\":[{\"name\":\"components_elements_menus_footer_menu_left_links_fk\",\"columns\":[\"menus_id\"]},{\"name\":\"components_elements_menus_footer_menu_left_links_inv_fk\",\"columns\":[\"menu_id\"]}],\"foreignKeys\":[{\"name\":\"components_elements_menus_footer_menu_left_links_fk\",\"columns\":[\"menus_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"components_elements_menus\",\"onDelete\":\"CASCADE\"},{\"name\":\"components_elements_menus_footer_menu_left_links_inv_fk\",\"columns\":[\"menu_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"menus\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"menus_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"menu_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"components_elements_menus_footer_menu_right_links\",\"indexes\":[{\"name\":\"components_elements_menus_footer_menu_right_links_fk\",\"columns\":[\"menus_id\"]},{\"name\":\"components_elements_menus_footer_menu_right_links_inv_fk\",\"columns\":[\"menu_id\"]}],\"foreignKeys\":[{\"name\":\"components_elements_menus_footer_menu_right_links_fk\",\"columns\":[\"menus_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"components_elements_menus\",\"onDelete\":\"CASCADE\"},{\"name\":\"components_elements_menus_footer_menu_right_links_inv_fk\",\"columns\":[\"menu_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"menus\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"menus_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"menu_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"components_mixed_seos_components\",\"indexes\":[{\"name\":\"components_mixed_seos_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"components_mixed_seos_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"components_mixed_seos_entity_fk\",\"columns\":[\"entity_id\"]}],\"foreignKeys\":[{\"name\":\"components_mixed_seos_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"components_mixed_seos\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"integer\",\"args\":[],\"defaultTo\":0,\"notNullable\":false,\"unsigned\":true}]}]}', '2022-02-24 11:13:58', '5f9379c37b4e3f71a355e19778921d06');






INSERT INTO `team_members` (`id`, `name`, `designation`, `bio`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `order`) VALUES
(1, 'Mr. Ginger', 'ENV. ARTIST', '', 1, '2022-01-18 13:37:08.993000', '2022-01-19 01:23:05.511000', '2022-01-18 13:38:11.540000', 1, 1, 0);
INSERT INTO `team_members` (`id`, `name`, `designation`, `bio`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `order`) VALUES
(2, 'Mr. Underspin', 'Under-Engineer', '', 1, '2022-01-19 01:21:06.466000', '2022-01-19 16:23:41.479000', '2022-01-19 01:21:15.773000', 1, 1, 1);
INSERT INTO `team_members` (`id`, `name`, `designation`, `bio`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `order`) VALUES
(3, 'Mr. Upspin', 'Game programmer', '', 1, '2022-01-19 01:22:02.858000', '2022-01-19 01:22:06.663000', '2022-01-19 01:22:06.604000', 1, 1, 3);
INSERT INTO `team_members` (`id`, `name`, `designation`, `bio`, `status`, `created_at`, `updated_at`, `published_at`, `created_by_id`, `updated_by_id`, `order`) VALUES
(4, 'Mr. dodger', 'Game programmer', 'Phoenix is a Radiant from the UK who utilizes self-made flames in a variety of ways. Hailing from the U.K., Phoenix\'s star power shines through in his fighting style, igniting the battlefield with flash and flare. Whether he\'s got backup or not, he\'ll rush into a fight .', 1, '2022-01-19 01:24:20.250000', '2022-01-19 16:39:52.531000', '2022-01-19 01:24:29.981000', 1, 1, 2),
(5, 'Mr. SlowMaster', 'Over-engineer', '', 1, '2022-01-19 01:48:30.997000', '2022-01-19 16:22:51.316000', '2022-01-19 01:48:35.508000', 1, 1, 4);

INSERT INTO `team_members_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(5, 3, 7, 'elements.social-info', 'links', 1);
INSERT INTO `team_members_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(6, 3, 8, 'elements.social-info', 'links', 2);
INSERT INTO `team_members_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(7, 1, 3, 'elements.social-info', 'links', 1);
INSERT INTO `team_members_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(8, 1, 4, 'elements.social-info', 'links', 2),
(13, 5, 12, 'elements.social-info', 'links', 1),
(14, 5, 11, 'elements.social-info', 'links', 2),
(15, 2, 5, 'elements.social-info', 'links', 1),
(16, 2, 6, 'elements.social-info', 'links', 2),
(19, 4, 10, 'elements.social-info', 'links', 1),
(20, 4, 9, 'elements.social-info', 'links', 2);

INSERT INTO `testimonials` (`id`, `name`, `designation`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `status`) VALUES
(1, 'FRED KINNEY', 'DEVELOPER', '2022-01-05 03:37:17.433000', '2022-01-18 15:09:21.658000', 1, 1, 1);
INSERT INTO `testimonials` (`id`, `name`, `designation`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `status`) VALUES
(2, 'Mr Client', 'CEO, Battery low', '2022-01-05 03:39:52.468000', '2022-01-05 03:39:52.468000', 1, 1, 1);
INSERT INTO `testimonials` (`id`, `name`, `designation`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `status`) VALUES
(3, 'FRED KIDNEY', 'TEAM Member', '2022-01-18 15:14:23.550000', '2022-01-19 00:57:58.704000', 1, 1, 1);
INSERT INTO `testimonials` (`id`, `name`, `designation`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`, `status`) VALUES
(4, 'FRED KIDNEYS', 'DEV', '2022-01-19 00:46:43.378000', '2022-01-19 00:46:56.806000', 1, 1, 1),
(5, 'MR. GINGER', 'Lead Developer', '2022-01-19 00:56:53.171000', '2022-01-19 00:57:35.650000', 1, 1, 1);

INSERT INTO `testimonials_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(4, 2, 2, 'elements.review', 'Review', 1);
INSERT INTO `testimonials_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(5, 1, 1, 'elements.review', 'Review', 1);
INSERT INTO `testimonials_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(8, 4, 4, 'elements.review', 'Review', 1);
INSERT INTO `testimonials_components` (`id`, `entity_id`, `component_id`, `component_type`, `field`, `order`) VALUES
(10, 5, 5, 'elements.review', 'Review', 1),
(11, 3, 3, 'elements.review', 'Review', 1);

INSERT INTO `up_permissions` (`id`, `action`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 'plugin::users-permissions.auth.connect', '2022-01-02 21:36:53.683000', '2022-01-02 21:36:53.683000', NULL, NULL);
INSERT INTO `up_permissions` (`id`, `action`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(2, 'plugin::users-permissions.user.me', '2022-01-02 21:36:53.683000', '2022-01-02 21:36:53.683000', NULL, NULL);
INSERT INTO `up_permissions` (`id`, `action`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(7, 'plugin::users-permissions.auth.callback', '2022-01-02 21:36:53.695000', '2022-01-02 21:36:53.695000', NULL, NULL);
INSERT INTO `up_permissions` (`id`, `action`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(9, 'plugin::users-permissions.auth.connect', '2022-01-02 21:36:53.695000', '2022-01-02 21:36:53.695000', NULL, NULL),
(10, 'plugin::users-permissions.user.me', '2022-01-02 21:36:53.695000', '2022-01-02 21:36:53.695000', NULL, NULL),
(11, 'plugin::users-permissions.auth.register', '2022-01-02 21:36:53.695000', '2022-01-02 21:36:53.695000', NULL, NULL),
(12, 'api::client.client.find', '2022-01-03 01:50:14.782000', '2022-01-03 01:50:14.782000', NULL, NULL),
(13, 'api::client.client.findOne', '2022-01-03 01:50:14.782000', '2022-01-03 01:50:14.782000', NULL, NULL),
(14, 'api::client.client.findOne', '2022-01-03 02:23:29.148000', '2022-01-03 02:23:29.148000', NULL, NULL),
(15, 'api::client.client.find', '2022-01-03 02:23:29.148000', '2022-01-03 02:23:29.148000', NULL, NULL),
(16, 'api::client.client.create', '2022-01-03 02:23:29.148000', '2022-01-03 02:23:29.148000', NULL, NULL),
(17, 'plugin::upload.content-api.find', '2022-01-03 02:23:29.148000', '2022-01-03 02:23:29.148000', NULL, NULL),
(18, 'plugin::upload.content-api.findOne', '2022-01-03 02:23:29.148000', '2022-01-03 02:23:29.148000', NULL, NULL),
(19, 'api::client.client.delete', '2022-01-03 02:23:29.148000', '2022-01-03 02:23:29.148000', NULL, NULL),
(20, 'api::client.client.update', '2022-01-03 02:23:29.148000', '2022-01-03 02:23:29.148000', NULL, NULL),
(21, 'plugin::upload.content-api.count', '2022-01-03 02:23:29.148000', '2022-01-03 02:23:29.148000', NULL, NULL),
(22, 'plugin::upload.content-api.destroy', '2022-01-03 02:23:29.148000', '2022-01-03 02:23:29.148000', NULL, NULL),
(23, 'plugin::upload.content-api.upload', '2022-01-03 02:23:29.148000', '2022-01-03 02:23:29.148000', NULL, NULL),
(24, 'plugin::content-type-builder.components.getComponents', '2022-01-03 02:31:26.302000', '2022-01-03 02:31:26.302000', NULL, NULL),
(25, 'plugin::content-type-builder.components.getComponent', '2022-01-03 02:31:26.302000', '2022-01-03 02:31:26.302000', NULL, NULL),
(26, 'plugin::content-type-builder.content-types.getContentTypes', '2022-01-03 02:31:26.302000', '2022-01-03 02:31:26.302000', NULL, NULL),
(27, 'plugin::content-type-builder.content-types.getContentType', '2022-01-03 02:31:26.302000', '2022-01-03 02:31:26.302000', NULL, NULL),
(33, 'api::portfolio.portfolio.find', '2022-01-04 19:56:58.825000', '2022-01-04 19:56:58.825000', NULL, NULL),
(34, 'api::portfolio.portfolio.findOne', '2022-01-04 19:56:58.825000', '2022-01-04 19:56:58.825000', NULL, NULL),
(35, 'api::portfolio-category.portfolio-category.find', '2022-01-04 20:06:10.605000', '2022-01-04 20:06:10.605000', NULL, NULL),
(36, 'api::portfolio-category.portfolio-category.findOne', '2022-01-04 20:06:10.605000', '2022-01-04 20:06:10.605000', NULL, NULL),
(37, 'plugin::content-type-builder.components.getComponents', '2022-01-04 20:23:04.014000', '2022-01-04 20:23:04.014000', NULL, NULL),
(38, 'plugin::content-type-builder.components.getComponent', '2022-01-04 20:23:04.014000', '2022-01-04 20:23:04.014000', NULL, NULL),
(40, 'api::site-info.site-info.find', '2022-01-05 05:00:47.512000', '2022-01-05 05:00:47.512000', NULL, NULL),
(43, 'api::homepage-slider.homepage-slider.find', '2022-01-05 05:01:35.254000', '2022-01-05 05:01:35.254000', NULL, NULL),
(47, 'api::page.page.findOne', '2022-01-12 13:02:27.271000', '2022-01-12 13:02:27.271000', NULL, NULL),
(48, 'api::page.page.find', '2022-01-12 13:02:27.271000', '2022-01-12 13:02:27.271000', NULL, NULL),
(53, 'api::menu.menu.findOne', '2022-01-17 13:08:31.468000', '2022-01-17 13:08:31.468000', NULL, NULL),
(54, 'api::menu.menu.find', '2022-01-17 13:08:31.468000', '2022-01-17 13:08:31.468000', NULL, NULL),
(55, 'api::article.article.find', '2022-01-18 04:18:44.707000', '2022-01-18 04:18:44.707000', NULL, NULL),
(56, 'api::article.article.findOne', '2022-01-18 04:18:44.707000', '2022-01-18 04:18:44.707000', NULL, NULL),
(57, 'api::testimonial.testimonial.find', '2022-01-18 15:06:24.519000', '2022-01-18 15:06:24.519000', NULL, NULL),
(58, 'api::team-member.team-member.find', '2022-01-19 01:02:43.173000', '2022-01-19 01:02:43.173000', NULL, NULL),
(59, 'api::service.service.find', '2022-01-19 02:13:08.900000', '2022-01-19 02:13:08.900000', NULL, NULL),
(60, 'api::blog-category.blog-category.find', '2022-01-19 03:30:06.683000', '2022-01-19 03:30:06.683000', NULL, NULL),
(62, 'api::blog-category.blog-category.findOne', '2022-01-19 03:30:39.665000', '2022-01-19 03:30:39.665000', NULL, NULL),
(64, 'api::contact-form-submit.contact-form-submit.create', '2022-01-24 13:02:22.008000', '2022-01-24 13:02:22.008000', NULL, NULL);

INSERT INTO `up_permissions_role_links` (`permission_id`, `role_id`) VALUES
(1, 1);
INSERT INTO `up_permissions_role_links` (`permission_id`, `role_id`) VALUES
(2, 1);
INSERT INTO `up_permissions_role_links` (`permission_id`, `role_id`) VALUES
(7, 2);
INSERT INTO `up_permissions_role_links` (`permission_id`, `role_id`) VALUES
(10, 2),
(9, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 3),
(15, 3),
(19, 3),
(18, 3),
(17, 3),
(20, 3),
(16, 3),
(21, 3),
(23, 3),
(22, 3),
(24, 3),
(27, 3),
(26, 3),
(25, 3),
(33, 2),
(34, 2),
(36, 2),
(35, 2),
(37, 2),
(38, 2),
(40, 2),
(43, 2),
(47, 2),
(48, 2),
(53, 2),
(54, 2),
(56, 2),
(55, 2),
(57, 2),
(58, 2),
(59, 2),
(60, 2),
(62, 2),
(64, 2);

INSERT INTO `up_roles` (`id`, `name`, `description`, `type`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(1, 'Authenticated', 'Default role given to authenticated user.', 'authenticated', '2022-01-02 21:36:53.666000', '2022-01-02 21:36:53.666000', NULL, NULL);
INSERT INTO `up_roles` (`id`, `name`, `description`, `type`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(2, 'Public', 'Default role given to unauthenticated user.', 'public', '2022-01-02 21:36:53.672000', '2022-01-24 13:07:52.806000', NULL, NULL);
INSERT INTO `up_roles` (`id`, `name`, `description`, `type`, `created_at`, `updated_at`, `created_by_id`, `updated_by_id`) VALUES
(3, 'Tester', 'can see options except content type builder', 'tester', '2022-01-03 02:23:29.139000', '2022-01-03 02:31:26.295000', NULL, NULL);






/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;