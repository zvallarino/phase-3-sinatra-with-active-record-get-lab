describe ApplicationController do
  let(:bakery1) { Bakery.first }
  let(:bakery2) { Bakery.second }

  before do
    bakery1 = Bakery.create(name: "Northside")
    bakery2 = Bakery.create(name: "Southside")
    BakedGood.create(name: "Croissant", price: 5, bakery_id: bakery1.id)
    BakedGood.create(name: "Bagel", price: 2, bakery_id: bakery1.id)
    BakedGood.create(name: "Banana Bread", price: 3, bakery_id: bakery2.id)
  end

  describe 'GET /bakeries' do
    it 'sets the Content-Type header in the response to application/json' do
      get '/bakeries'

      expect(last_response.headers['Content-Type']).to eq('application/json')
    end

    it 'returns an array of JSON objects for all bakeries in the database' do
      get '/games'
      expect(last_response.body).to include_json([
        { name: "Northside" },
        { name: "Southside" }
      ])
    end
  end

  describe 'GET /bakeries/:id' do
    it 'sets the Content-Type header in the response to application/json' do
      get "/bakeries/#{bakeries1.id}"

      expect(last_response.headers['Content-Type']).to eq('application/json')
    end

    it 'returns a single bakery as JSON with its baked goods nested' do
      get "/bakeries/#{bakeries1.id}"

      expect(last_response.body).to include_json({ 
        name: "Northside",
        baked_goods: [
          { name: "Croissant", price: 5 },
          { name: "Bagel", price: 2 }
        ]
      })
    end
  end

  describe 'GET /baked_goods/by_price' do
    it 'returns an array of baked goods as JSON, sorted by price in descending order  (HINT: how can you sort the baked goods in a particular order?)' do
      get "/baked_goods/most_expensive"

      expect(last_response.body).to include_json([
        { name: "Croissant", price: 5 },
        { name: "Banana Bread", price: 3 },
        { name: "Bagel", price: 2 }
      ])
    end
  end

  describe 'GET /baked_goods/most_expensive' do
    it 'returns the single most expensive baked good as JSON (HINT: how can you sort the baked goods in a particular order?)' do
      get "/baked_goods/most_expensive"

      expect(last_response.body).to include_json({ name: "Croissant", price: 5 })
    end
  end

end
