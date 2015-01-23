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
    DB.exec("UPDATE clients SET stylist_id = NULL WHERE stylist_id = #{self.id()};")
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end

  define_singleton_method(:find) do |id|
    Stylist.all().each() do |stylist|
      if stylist.id() == id
        return stylist
      end
    end
  end

  define_method(:clients) do
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id()} ORDER BY name;")
    returned_clients.each() do |client|
      name = client.fetch("name")
      id = client.fetch("id").to_i()
      stylist_id = client.fetch("stylist_id").to_i()
      clients.push(Client.new({ :name => name, :stylist_id => stylist_id, :id => id }))
    end
    clients
  end





end
