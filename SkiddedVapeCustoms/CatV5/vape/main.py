import hashlib

hashuserid = hashlib.sha512(b'3789128947')   # with a user id for example this is my current user id of unspecialization

hashuserid_hex = hashuserid.hexdigest()

print(hashuserid_hex)


#20e17e544f4454b8d7045cd985de837c46351bb4141aad712b2a8948473f14fd3fca22f031c4fa75ddcf9be094506445cfc9e70d032d445fc54caa4fa9db279c    my id
#7b286c8e4d753f089214a9d0ec3251c0a9c213572c88fe0ebe2bc3cf661f276b3f169515c2907c734381c0f9f9ca9d29b6a9f3b8f16df0cb89498337b76cdc02    xylex whitelist
