namespace :batch do
  desc "Gets current store value"
  task get_store_value: :environment do
    Storage.create(value: 0)
  end

end
