require 'sinatra/base'
require 'yaml'

class Apism::Application < Sinatra::Base

  set :root, Bundler.root
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
