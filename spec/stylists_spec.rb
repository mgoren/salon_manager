require('spec_buddy')

describe(Stylist) do
  
  describe('#==') do
    it("returns as equal when stylist IDs match") do
      stylist1 = Stylist.new({ :name => "Mike" })
      stylist1.save()
      stylist1_from_db = Stylist.all.first()
      expect(stylist1).to(eq(stylist1_from_db))
    end
  end

  describe('.all') do
    it("returns empty at first") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("saves stylist into db") do
      stylist1 = Stylist.new({ :name => "Mike" })
      stylist1.save()
      expect(Stylist.all()).to(eq([stylist1]))
    end
  end

  describe('#update') do
    it("will update the name of a stylist") do
      test_stylist = Stylist.new({ :name => "Mike" })
      test_stylist.save()
      test_stylist.update( {:name => "Clay"} )
      expect(test_stylist.name()).to(eq("Clay"))
    end
  end

  describe("#delete") do
    it("lets you delete a stylist from the database") do
      test_stylist = Stylist.new({ :name => "Mike" })
      test_stylist.save()
      test_stylist2 = Stylist.new({ :name => "Clay" })
      test_stylist2.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([test_stylist2]))
    end
  end

  describe('.find') do
    it("returns a stylist object given an id") do
      stylist1 = Stylist.new({ :name => "Mike" })
      stylist1.save()
      expect(Stylist.find(stylist1.id())).to(eq(stylist1))
    end
  end

  describe('#clients') do
    it("returns array of all clients (objects) belong to this stylist") do
      stylist1 = Stylist.new({ :name => "Mike" })
      stylist1.save()
      client1 = Client.new({ :name => "Marion", :stylist_id => stylist1.id() })
      client1.save()
      client2 = Client.new({ :name => "James" })
      client2.save()
      expect(stylist1.clients()).to(eq([client1]))
    end
  end











end