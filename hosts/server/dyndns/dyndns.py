from nc_dnsapi import Client
import os, urllib3

CUSTOMER = os.environ["NC_CUSTOMER"]
API_PASSWORD = os.environ["NC_API_PASSWORD"]
API_KEY = os.environ["NC_API_KEY"]
DOMAIN = os.environ["NC_DOMAIN"]

ip = urllib3.request("GET", "https://api.ipify.org").data.decode()

with Client(CUSTOMER, API_KEY, API_PASSWORD) as api:
    to_be_updated = []
    records = api.dns_records(DOMAIN)

    for record in records:
        if record.type in ["A", "AAAA"] and record.destination != ip:
            record.destination = ip
            to_be_updated.append(record)


    if to_be_updated:
        api.update_dns_records(DOMAIN, to_be_updated)

    zone = api.dns_zone(DOMAIN)
    if zone.ttl != '300':
        zone.ttl = '300'
        api.update_dns_zone(DOMAIN, zone)
