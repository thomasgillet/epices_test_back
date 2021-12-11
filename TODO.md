# TODO

Write tests!

No check for CSV content.
Should we prevent CSV with more than one day of data? Or not all 24 hours of data?
If more than one day is allowed, redirect to index will be kind of clumsy.

UPSERT used to import data to ease development.
Probably better to at least warn the user before overwriting data.

Kept `created_at` and `updated_at` fields from model generator.
Not sure its really usefull, especially with upsert also updating `created_at` (but seems to be an "update_only" option coming soon)

Timezones not handled. See if it is necessary.
If it is, beware of DateTime to Date transformation /!\

