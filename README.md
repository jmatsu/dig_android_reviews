## Required

[q](https://github.com/harelba/q) : Run SQL directly on CSV or TSV

## Column

package_name,app_version_name,device,review_submit_date_and_time,review_submit_millis_since_epoch,review_last_update_date_and_time,review_last_update_millis_since_epoch,star_rating,review_title,review_text,developer_reply_date_and_time,developer_reply_millis_since_epoch,developer_reply_text,review_link


## Sample

./main.sh q 'SELECT app_version_name,star_rating,review_title,review_text,developer_reply_text,review_submit_date_and_time,review_last_update_date_and_time from %%f WHERE star_rating < 4 order by review_last_update_millis_since_epoch'|uniq
