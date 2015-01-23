require('spec_buddy')

describe(Client) do
	
  describe('#==') do
    it("returns as equal when client IDs match") do
      stylist1 = Stylist.new({ :name => "Mike" })
      stylist1.save()
      client1 = Client.new({ :name => "Marion", :stylist_id => stylist1.id() })
      client1.save()
      client1_from_db = Client.all.first()
      expect(client1).to(eq(client1_from_db))
    end
  end

  describe('.all') do
    it("returns empty at first") do
      expect(Client.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("saves client into db") do
      stylist1 = Stylist.new({ :name => "Mike" })
      stylist1.save()
      client1 = Client.new({ :name => "Marion", :stylist_id => stylist1.id() })
      client1.save()
      expect(Client.all()).to(eq([client1]))
    end
  end

  describe('#update') do
    it("will update the name of a client") do
      stylist1 = Stylist.new({ :name => "Mike" })
      stylist1.save()
      test_client = Client.new({ :name => "Marion", :stylist_id => stylist1.id() })
      test_client.save()
      test_client.update( {:name => "Risa"} )
      expect(test_client.name()).to(eq("Risa"))
    end
    it("will add id correctly later, not during object creation") do
      client1 = Client.new({ :name => "Marion" })
      client1.save()
      stylist1 = Stylist.new({ :name => "Mike" })
      stylist1.save()
      client1.update({ :stylist_id => stylist1.id() })
      expect(client1.stylist_id()).to(eq(stylist1.id()))
    end
  end

  describe("#delete") do
    it("lets you delete a client from the database") do
      stylist1 = Stylist.new({ :name => "Mike" })
      stylist1.save()
      test_client = Client.new({ :name => "Marion", :stylist_id => stylist1.id() })
      test_client.save()
      test_client2 = Client.new({ :name => "James", :stylist_id => stylist1.id() })
      test_client2.save()
      test_client.delete()
      expect(Client.all()).to(eq([test_client2]))
    end
  end

  describe('.find') do
    it("returns a client object given an id") do
      stylist1 = Stylist.new({ :name => "Mike" })
      stylist1.save()
      client1 = Client.new({ :name => "Marion", :stylist_id => stylist1.id() })
      client1.save()
      expect(Client.find(client1.id())).to(eq(client1))
    end
  end

  describe('#stylist') do
    it("returns stylist (object) associated with this client") do
      stylist1 = Stylist.new({ :name => "Mike" })
      stylist1.save()
      client1 = Client.new({ :name => "Marion", :stylist_id => stylist1.id() })
      client1.save()
      expect(client1.stylist()).to(eq(stylist1))
    end
  end










end