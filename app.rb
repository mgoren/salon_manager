require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/stylists")
require("./lib/clients")
require("pg")
require("pry")

DB = PG.connect({:dbname => "salon"})

get("/") do
  erb(:index)
end

post("/stylists") do
  stylist_name = params.fetch('stylist_name').strip()
  if stylist_name != ""
    Stylist.new({ :name => stylist_name }).save()
  end
  redirect("/")
end

post("/clients") do
  client_name = params.fetch('client_name').strip()
  if client_name != ""
    Client.new({ :name => client_name }).save()
  end
  redirect("/")
end

delete("/stylists") do
  returned_stylist_id = params['stylist_id']
  if returned_stylist_id != nil
    stylist_id = returned_stylist_id.to_i()
    Stylist.find(stylist_id).delete()
  end
  redirect("/")
end

delete("/clients") do
  returned_client_id = params['client_id']
  if returned_client_id != nil
    client_id = returned_client_id.to_i()
    Client.find(client_id).delete()
  end
  redirect("/")
end

get("/stylists/:id") do
  @stylist_id = params.fetch('id').to_i()
  erb(:stylist)
end

get("/clients/:id") do
  @client_id = params.fetch('id').to_i()
  erb(:client)
end

post("/stylists/:id") do
  stylist_id = params.fetch('id').to_i()
  returned_client_id = params['client_id']
  if returned_client_id != nil
    client = Client.find(returned_client_id.to_i())
    client.update({ :stylist_id => stylist_id })
  end
  url = "/stylists/" + stylist_id.to_s()
   redirect(url)
end

post("/clients/:id") do
  client_id = params.fetch('id').to_i()
  returned_stylist_id = params['stylist_id']
  if returned_stylist_id != nil
    client = Client.find(client_id)
    client.update({ :stylist_id => returned_stylist_id.to_i() })
  end
  url = "/clients/" + client_id.to_s()
  redirect(url)
end

patch("/clients/:id") do
  client_id = params.fetch('id').to_i()
  new_name = params['new_name']
  new_name.strip!()
  if new_name != ""
    Client.find(client_id).update({ :name => new_name })
  end
  url = "/clients/" + client_id.to_s()
  redirect(url)
end

patch("/stylists/:id") do
  stylist_id = params.fetch('id').to_i()
  new_name = params['new_name']
  new_name.strip!()
  if new_name != ""
    Stylist.find(stylist_id).update({ :name => new_name })
  end
  url = "/stylists/" + stylist_id.to_s()
  redirect(url)
end


