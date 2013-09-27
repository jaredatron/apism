class Apism::Pathname < Pathname

  def require!
    Dir[expand_path].map do |path|
      require path
      self.class.new path
    end
  end

  def join(*args)
    self.class.new super
  end

end
