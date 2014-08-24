if Rails.env.production?

  HireFire::Resource.configure do |config|
    config.dyno(:resque_worker) do
      HireFire::Macro::Delayed::Resque.queue
    end
  end

end