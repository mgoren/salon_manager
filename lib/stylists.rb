class Stylist

  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  define_method(:==) do |another_stylist|
    self.id() == another_stylist.id()
  end

  define_singleton_method(:all) do
    stylists = []
    returned_stylists = DB.exec("SELECT * FROM stylists ORDER BY name;")
    returned_stylists.each() do |stylist|
      name = stylist.fetch("name")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({ :name => name, :id => id }))
    end
    stylists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes[:name] || @name
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{self.id()};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end








end
