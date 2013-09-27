class Apism::Application::Configuration

  def initialize app
    @app = app
  end

  def load_paths
    @load_paths ||= Set[]
  end

  def load_path(*paths)
    paths.each do |path|
      path = Pathname(path.to_s)
      path = @app.root + path unless path.absolute?
      load_paths.add path
    end
  end

end
