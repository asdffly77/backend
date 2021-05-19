json.success true
json.merge! JSON.parse(yield)
json.upgrade @mobile_app.upgrade_info
