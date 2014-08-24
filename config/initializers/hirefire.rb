if Rails.env.production?

  HireFire::Resource.configure do |config|
    config.dyno(:resque) do
      HireFire::Macro::Resque.queue
    end
  end

end