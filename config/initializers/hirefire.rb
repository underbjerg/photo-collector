if Rails.env.production?

  HireFire::Resource.configure do |config|
    config.dyno(:resque_worker) do
      HireFire::Macro::Resque.queue
    end
  end

end