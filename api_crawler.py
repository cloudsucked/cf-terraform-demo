import httpx
import time
import uuid
import random
import tfvars

tfv = tfvars.LoadSecrets()
zone = tfv["cloudflare_zone"]
print(f"Crawling petstore.{zone} to generate data for Api Shield")

def crawl_endpoints(run_number):
    usernames = ["tommy", "johnny", "jane", "carl", "nick", "hannah", "beth"]
    passwords = ["password", "p@55w0rd", "noname", "SECRET"]
    pet_status = ["available", "available", "available", "available", "pending", "pending", "pending", "sold", "dead"]
    order_status = ["placed", "placed", "placed", "placed", "approved", "approved", "delivered", "delivered", "lost", "unknown"]
    auth_headers = {
        "Authorization": str(uuid.uuid4()),
        "Accept": "application/json",
        "Content-Type": "application/json"
    }
    api_url=f"https://petstore.{zone}/api/v3/"
    api_payload = {}
    api_payload["id"] = random.randint(3, 7)
    api_payload["petId"] = random.randint(1, 12)
    api_payload["quantity"] = random.randint(1, 12)
    api_payload["shipDate"] = "2024-02-08T12:14:38.198Z"
    api_payload["status"] = random.choice(order_status)
    api_payload["complete"] = True
    api_endpoints = [
                    {"path": "/user/login", "method": "GET", "query": f"?username={random.choice(usernames)}&password={random.choice(passwords)}"},
                    {"path": "/pet/findByStatus", "method": "GET", "query": f"?status={random.choice(pet_status)}&age={str(random.randint(16, 99))}"},
                    {"path": "/pet/findByStatus", "method": "GET", "query": f"?status={random.choice(pet_status)}&age={str(random.randint(16, 99))}"},
                    {"path": "/pet/findByStatus", "method": "GET", "query": f"?status={random.choice(pet_status)}&age={str(random.randint(16, 99))}"},
                    {"path": "/pet/findByTags", "method": "GET", "query": "?tags=tag1"},
                    {"path": "/pet/" + str(random.randint(1, 12)), "method": "GET", "query": ""},
                    {"path": "/pet/123", "method": "DELETE", "query": ""},
                    {"path": "/store/order", "method": "POST", "query": "", "json": api_payload},
                    {"path": "/store/order/" + str(api_payload["id"]), "method": "GET", "query": ""},
                    {"path": "/store/order/" + str(api_payload["id"]), "method": "DELETE", "query": ""},
                    {"path": "/store/inventory", "method": "GET", "query": ""},
                    {"path": "/user/logout", "method": "GET", "query": ""},
                    ]

    print(f"\nRun:{run_number}\n{auth_headers}")
    iterations = [1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 5]
    number_of_blocks = 0
    for i in range(random.choice(iterations)):
        for api_endpoint in api_endpoints:
            api_path = api_endpoint["path"] + api_endpoint["query"]
            api_method = api_endpoint["method"]
            try:
                with httpx.Client(headers=auth_headers, base_url=api_url) as client:
                    if api_method in ["POST", "PUT"]:
                        request = client.build_request(api_method, api_path, json=api_endpoint["json"])
                    else:
                        request = client.build_request(api_method, api_path)
                    response = client.send(request)

                print(f"{response.status_code}: {api_method} \t-> {api_path}")
                if response.status_code == 403:
                    number_of_blocks += 1
                # print(f"Message: {response.text}")
                # result = json.loads(response.text)
            except httpx.ConnectError:
                print("Could not connect to the API host")
            time.sleep(random.uniform(0, 1))

    return number_of_blocks

total_number_of_blocks = 0
for i in range(10000):
    total_number_of_blocks += crawl_endpoints(i+1)

    print(f"Total number of blocks: {total_number_of_blocks}")
    time.sleep(random.randint(1, 3))
