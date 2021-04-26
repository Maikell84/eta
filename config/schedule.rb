# http://github.com/javan/whenever

env :PATH, ENV['PATH']
set :bundle_command, "/home/michael/.rbenv/shims/bundle exec"


every(:day, at: "22:00") do
  runner 'StorageSyncService.run'
end

every 1.hour do
  runner "ConsumptionSyncService.run"
  runner "AshSyncService.run"
end

