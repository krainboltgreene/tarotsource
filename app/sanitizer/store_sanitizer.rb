class StoreSanitizer
  def initialize(parameters)
    @parameters = parameters[:store]
    @name = @parameters[:name]
    @description = @parameters[:description]

    raise ArgumentError unless @name
    raise ArgumentError unless @description
  end

  def to_hash
    {
      name: @parameters["name"],
      description: @parameters[:description]
    }
  end
end
