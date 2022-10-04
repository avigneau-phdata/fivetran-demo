import json
import logging
import time
import urllib3

# TODO: Handle rate limiting - https://api.slack.com/docs/rate-limits#tier_t2

logging.getLogger().setLevel(logging.INFO)
# logging.getLogger("urllib3").setLevel(logging.DEBUG)

# Set the global configurations
http = urllib3.PoolManager(
    retries=urllib3.Retry(10)
)
base_url = "https://slack.com/api/"
page_size = 100

# https://api.slack.com/methods/users.list
def getUsers(headers):
    requests_since_wait = 0
    hasMore = True
    cursor = ""
    users = []
    while hasMore:
        request_url = "{base_url}/users.list?limit={page_size}".format(base_url = base_url, page_size = page_size)
        if cursor:
            request_url += "&cursor={cursor}".format(cursor = cursor)
        logging.info("Request URL: " + request_url)
        response = http.request('GET', request_url, headers = headers)
        data = json.loads(response.data.decode('utf-8'))
        for value in data['members']:
            profile = value.get("profile", [])
            users.append({
                "id": value["id"],
                "name": value["name"],
                "deleted": value["deleted"],
                "tz": value.get("tz", ""),
                "tz_label": value.get("tz_label", ""),
                "tz_offset":value.get("tz_offset", ""),
                # Profile fields
                # TODO: Get custom location field via https://api.slack.com/methods/users.profile.get
                "title": profile.get("title", ""),
                "phone": profile.get("phone", ""),
                "real_name": profile.get("real_name", ""),
                "real_name_normalized": profile.get("real_name_normalized", ""),
                "display_name": profile.get("display_name", ""),
                "display_name_normalized": profile.get("display_name_normalized", ""),
                "email": profile.get("email", ""),
                "pronouns": profile.get("pronouns", ""),
                "last_name": profile.get("last_name", ""),
                "first_name": profile.get("first_name", ""),
                # Misc fields
                "is_admin": value.get("is_admin", ""),
                "is_owner": value.get("is_owner", ""),
                "is_primary_owner": value.get("is_primary_owner", ""),
                "is_restricted": value.get("is_restricted", ""),
                "is_ultra_restricted": value.get("is_ultra_restricted", ""),
                "is_bot": value.get("is_bot", ""),
                "updated": value.get("updated", ""),
                "is_email_confirmed": value.get("is_email_confirmed", ""),
                "who_can_share_contact_card": value.get("who_can_share_contact_card", "")
            })
        metadata = data['response_metadata']
        cursor = metadata['next_cursor']
        hasMore = bool(cursor and not cursor.isspace())
        
    return users;

# TODO: Handle bad response codes
def lambda_handler(request, context):
    headers = {'Authorization': "Bearer " + request['secrets']['apiKey']}  

    slack_users = getUsers(headers)

    # Send JSON response back to Fivetran
    ans = {
        "state": {},
        "schema" : {
            "users" : {
                "primary_key" : ["id"]
            }
        },
        "insert": {
            "users": slack_users
        },
        "hasMore" : False
    }
    return ans;

if __name__ == "__main__":
    print(lambda_handler("", ""))