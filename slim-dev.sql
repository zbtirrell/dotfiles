#==================================================
# Process for setting up a limited dev data set
#==================================================

# get dev site export:
#  cd dev.theeventscalendar.com/current; wp db export
#  mv acc[whatever].sql ~

# import that into dev2:
# cd ~/dev2.theeventscalendar.com/current; wp db import ~/acc[whatever].sql

# rename from dev to dev2
# wp search-replace 'http://dev.theeventscalendar.com' 'http://dev’2.theeventscalendar.com'
# wp search-replace 'https://dev.theeventscalendar.com' 'https://dev’2.theeventscalendar.com'

# Keep only a subset of customers, for the list of customer to keep, see:
# https://docs.google.com/spreadsheets/d/1uFNaBRf-IDjV_NHSgQ_BgqOyWYfHHQKYq-K8l0D5lBw/edit#gid=0 
DELETE FROM wp_users 
WHERE id NOT IN(
	104984, 94875, 93848, 102860, 97998, 98770, 98763, 98771, 23313, 88490, 57364, 80129,103261, 106216, 53032, 32394, 30928, 98347, 105093, 81996, 98508, 99474, 55130, 9837,105941, 68911, 92891
)
AND id NOT IN(
	SELECT DISTINCT post_author 
	FROM wp_posts 
	WHERE post_type NOT IN(
		'revision', 
		'shop_order', 
		'payment_retry', 
		'shop_subscription',
		'attachment'
	)
);
# should leave around fewer than 100 users

# clean their email addresses for extra safety
UPDATE wp_users 
SET user_email = CONCAT(LEFT(user_email, INSTR(user_email, '@')), 'example.com') 
WHERE user_email NOT LIKE '%@theeventscalendar.com' 
  AND user_email <> 'zbtirrell@gmail.com'

UPDATE wp_usermeta
SET meta_value = CONCAT(LEFT(meta_value, INSTR(meta_value, '@')), 'example.com') 
WHERE meta_key='billing_email'
  AND meta_value NOT LIKE '%@theeventscalendar.com';

# purge orphaned usermeta, this will take awhile to run - 4 minutes on dev
DELETE FROM wp_usermeta 
WHERE user_id NOT IN(SELECT ID FROM wp_users);

#purge all order records and post revisions
DELETE FROM wp_posts 
WHERE post_author NOT IN(SELECT ID FROM wp_users) 
  AND post_author <> 1
  AND post_author <> 0;

# remove all the orphaned orders
DELETE FROM wp_posts
WHERE ID IN(
	SELECT post_id 
	FROM wp_postmeta
	WHERE meta_key='_customer_user'
	AND meta_value NOT IN(
		SELECT ID FROM wp_users
	)
);

#cleanup postmeta, again, this is a long one
DELETE FROM wp_postmeta
WHERE post_id NOT IN( SELECT ID FROM wp_posts);

# cleanup the order lookup tables
DELETE FROM wp_wc_customer_lookup 
WHERE user_id NOT IN(SELECT ID FROM wp_users);

DELETE FROM wp_wc_order_product_lookup 
WHERE customer_id NOT IN(SELECT DISTINCT customer_id FROM wp_wc_customer_lookup);

DELETE FROM wp_wc_order_product_lookup 
WHERE customer_id NOT IN(SELECT DISTINCT customer_id FROM wp_wc_customer_lookup);

DELETE FROM wp_woocommerce_downloadable_product_permissions
WHERE order_id NOT IN(SELECT ID FROM wp_posts);

DELETE FROM wp_wc_order_stats
WHERE order_id NOT IN(SELECT ID FROM wp_posts);

# remove all the woocommerce item records
DELETE FROM wp_woocommerce_order_items 
WHERE order_id NOT IN(SELECT ID FROM wp_posts);

DELETE FROM wp_woocommerce_order_itemmeta 
WHERE order_item_id NOT IN(SELECT order_item_id FROM wp_woocommerce_order_items);

DELETE FROM mv_unique_purchase_type
WHERE order_item_id NOT IN(SELECT order_item_id FROM wp_woocommerce_order_items);

# empty some tables with unnecessary data
TRUNCATE cha_ching_send_logs;
TRUNCATE wp_comments;
TRUNCATE wp_commentmeta;
TRUNCATE wp_subscription_audit_log;
TRUNCATE wp_zaius_migration;
TRUNCATE wp_taxjar_record_queue;

# get rid of the old PUE tables
DROP TABLE wp_pu_installs;
DROP TABLE wp_pu_levels;
DROP TABLE wp_pu_licenses;
DROP TABLE wp_pu_plugins;

DROP TABLE wp_pu_installs_old;
DROP TABLE wp_pu_levels_old;
DROP TABLE wp_pu_licenses_old;
DROP TABLE wp_pu_plugins_old;

# Ideally at this point we should also optimize all the tables. This is easy to do in PHPMyAdmin, or just run this:
OPTIMIZE TABLE `wp_posts`, `wp_gf_entry_meta`, `wp_postmeta`, `wp_gf_entry`, `wp_wcs_payment_retries`, `wp_rg_lead_detail`, `wp_wc_order_stats`, `wp_wc_order_product_lookup`, `wp_options`, `wp_woocommerce_order_itemmeta`, `wp_yoast_indexable`, `wp_actionscheduler_actions`, `wp_yoast_seo_meta`, `wp_term_relationships`, `wp_rg_form_view`, `wp_gf_form_view`, `wp_rg_lead_detail_long`, `wp_yoast_seo_links`, `wp_actionscheduler_logs`, `wp_yoast_indexable_hierarchy`, `wp_rg_lead`, `wp_rg_lead_meta`, `wp_terms`, `wp_wc_order_tax_lookup`, `wp_term_taxonomy`, `mv_unique_purchase_type`, `wp_pue_glue_sync_log`, `wp_lhr_log`, `wp_gf_entry_notes`, `wp_usermeta`, `wp_wpf_logging`, `wp_wc_order_coupon_lookup`, `wp_woocommerce_order_items`, `wp_affiliate_wp_visits`, `wp_gf_form_meta`, `wp_redirection_items`, `wp_rg_form_meta`, `wp_wc_product_meta_lookup`, `wp_affiliate_wp_referrals`, `wp_actionscheduler_claims`, `wp_redirection_404`, `wp_comments`, `wp_imagify_files`, `wp_wfhits`, `wp_p2p`, `wp_woocommerce_downloadable_product_permissions`, `wp_wfpendingissues`, `wp_woocommerce_tax_rates`, `wp_wfissues`, `wp_termmeta`, `wp_wfblocks7`, `wp_wc_admin_notes`, `wp_wfsnipcache`, `wp_woocommerce_tax_rate_locations`, `wp_woocommerce_shipping_zone_locations`, `wp_redirection_logs`, `wp_users`, `wp_gf_addon_feed`, `wp_yoast_prominent_words`, `wp_wc_customer_lookup`, `wp_wflogins`, `wp_wc_download_log`, `wp_woocommerce_sessions`, `wp_wfstatus`, `wp_affiliate_wp_referralmeta`, `wp_affiliate_wp_customermeta`, `wp_gf_form_revisions`, `wp_activecampaign_for_woocommerce_abandoned_cart`, `wp_imagify_folders`, `wp_affiliate_wp_affiliatemeta`, `wp_p2pmeta`, `wp_redirection_groups`, `wp_woocommerce_payment_tokenmeta`, `wp_yoast_primary_term`, `wp_woocommerce_api_keys`, `wp_blogs`, `wp_rg_lead_notes`, `wp_affiliate_wp_customers`, `wp_signups`, `wp_commentmeta`, `wp_affiliate_wp_payouts`, `wp_affiliate_wp_sales`, `wp_wfls_2fa_secrets`, `wp_bbp_support_logger`, `wp_affiliate_wp_creatives`, `wp_woocommerce_log`, `wp_affiliate_wp_rest_consumers`, `wp_rg_incomplete_submissions`, `wp_wfhoover`, `wp_wc_webhooks`, `wp_actionscheduler_groups`, `wp_gf_draft_submissions`, `wp_wflivetraffichuman`, `wp_woocommerce_payment_tokens`, `wp_links`, `wp_yoast_migrations`, `wp_woocommerce_attribute_taxonomies`, `wp_blog_versions`, `wp_wc_tax_rate_classes`, `wp_rg_campaignmonitor`, `wp_wc_admin_note_actions`, `wp_affiliate_wp_affiliates`, `wp_taxjar_record_queue`, `cha_ching_send_logs`, `wp_rg_form`, `wp_ms_snippets`, `wp_wffilechanges`, `wp_snippets`, `wp_wftrafficrates`, `wp_wfcrawlers`, `wp_wfblockediplog`, `wp_wfls_settings`, `wp_wfknownfilelist`, `wp_wflocs`, `wp_wc_reserved_stock`, `wp_subscription_audit_log`, `wp_woocommerce_shipping_zones`, `wp_wfconfig`, `wp_zaius_migration`, `wp_wpmm_subscribers`, `wp_zaius_integration`, `wp_woocommerce_shipping_zone_methods`, `wp_wc_category_lookup`, `wp_wfreversecache`, `wp_gf_form`, `wp_wfnotifications`, `wp_wffilemods`, `v_sales2`, `v_sales`, `wp_affiliate_wp_campaigns`
