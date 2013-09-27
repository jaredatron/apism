require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/string/inflections'
require 'active_support/descendants_tracker'
require 'json'

class Apism::Resource

  extend ActiveSupport::DescendantsTracker

  def self.register_routes(app)
    resource = self
    routes.each do |method, paths|
      paths.each do |path, (options, block)|
        app.send :route, method, path, options do |*args|
          resource.call(self, *args, &block)
        end
      end
    end
  end

  def self.call(app, *args, &block)
    instance = new(app)
    args = block.arity == 0 ? [] : args
    object = instance.instance_eval(*args, &block)
    object ? object.to_json : ""
  end

  def self.routes
    @routes ||= {}
  end

  def self.path_prefix path_prefix=nil
    if path_prefix
      @path_prefix = path_prefix
      @path_prefix = '/'+@path_prefix if @path_prefix[0] != '/'
    end
    @path_prefix || '/'+name.underscore.sub(/_resource$/,'')
  end

  %w{head get post put patch delete}.each do |method|
    define_singleton_method method do |path, options={}, &block|
      path = File.join(path_prefix, path)
      path.sub! %r{/*$}, ''
      routes[method.upcase] ||= {}
      routes[method.upcase][path] = [options, block]
    end
  end

  def self.create(&block)
    post "/", &block
  end

  def self.read(&block)
    get "/:id", &block
  end

  def self.update(&block)
    patch "/:id", &block
  end

  def self.destroy(&block)
    delete "/:id", &block
  end

  def self.all(&block)
    get "/", &block
  end





  def initialize(app)
    @app = app
  end

  delegate :params, :status, to: :@app

end
