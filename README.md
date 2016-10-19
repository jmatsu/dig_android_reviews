
## Sample

./main.sh q 'SELECT app_version_name,star_rating,review_title,review_text,developer_reply_text,review_submit_date_and_time from %%f WHERE star_rating < 4 order by review_submit_millis_since_epoch'|uniq
