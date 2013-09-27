require 'sinatra/base'

class Apism::Application < Sinatra::Base

  autoload :Cli, 'apism/application/cli'

  def self.resource name, &block
    resource = Class.new(Apism::Resource)
    resource.path_prefix "/#{name}"
    resource.instance_eval(&block)
    resource.register_routes(self)
    resource
  end

end
