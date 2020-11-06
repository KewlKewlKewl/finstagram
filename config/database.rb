configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end
# NEW CODE FOR DEPLOYMENT?
  if Sinatra::Application.development?
    set :database, {
      adapter: "sqlite3",
      database: "db/db.sqlite3"
    }
  else
    db_url = 'postgres://fluwvwyvzfklax:7fdfe13dab4e606ad778b71b5a1201f9c510a5c79acf9b87dac5d3ff87fe101d@ec2-54-146-4-66.compute-1.amazonaws.com:5432/d5dvpv6m09uvlf
'
    db = URI.parse(ENV['DATABASE_URL'] || db_url)
    set :database, {
      adapter: "postgresql",
      host: db.host,
      username: db.user,
      password: db.password,
      database: db.path[1..-1],
      encoding: 'utf8'
    }
  end

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end
