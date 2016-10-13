class Application

  @@items = Item.all

  def call(env)

    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_searched = req.path.split("/items/").last
      item = @@items.find{ |i| item_searched == i.name }
      if item
        resp.write item.price
      elsif !item
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
