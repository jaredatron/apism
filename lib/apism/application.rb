require 'sinatra/base'
require 'yaml'

class Apism::Application < Sinatra::Base

  def self.inherited(subclass)
    subclass.const_set :Resource, Class.new(Apism::Resource)
    super
  end

  # def self.initialize!
  #   binding.pry
  # end

  def self.load_paths
    @load_paths ||= Set[]
  end

  def self.load_path(*paths)
    paths.each do |path|
      path = Pathname(path.to_s)
      path = root + path unless path.absolute?
      load_paths.add path
    end
  end

  set :root, ->{ Bundler.root }
  autoload :Cli, 'apism/application/cli'

  def self.resource name, &block
    resource = Class.new(Apism::Resource)
    resource.path_prefix "/#{name}"
    resource.instance_eval(&block)
    resource.register_routes(self)
    resource
  end

  def self.config name
    @config ||= {}
    @config[name.to_sym] ||= begin
      config = Pathname(root) + 'config' + "#{name}.yml"
      config = ERB.new(config.read).result
      config = YAML.load(config)
      config.has_key?(environment.to_s) ? config[environment.to_s] : config
    end
  end

end
