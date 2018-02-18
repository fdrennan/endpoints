library(rollbar)

rollbar.configure(access_token="d1ed4487e4d7403b82c992448f3c5602", env="production")
rollbar.error
rollbar.warning('No frequency data for x')