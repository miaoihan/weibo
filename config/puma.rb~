workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Rails 4.1+ 专用的职程设置
  # 详情参见: https://devcenter.heroku.com/articles/
  ActiveRecord::Base.establish_connection
end
