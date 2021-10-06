green_tea = Product.create(name: 'Green Tea', product_code: 'GR1', price: 311.0)
strawberries = Product.create(name: 'Strawberries', product_code: 'SR1', price: 500.0)
coffee = Product.create(name: 'Coffee', product_code: 'CF1', price: 1123.0)

Offer.create(offerable: Offer::BuyOneGetOneFree.create, product: green_tea)
Offer.create(offerable: Offer::FixedBulkDiscount.create(price: 450.0), product: strawberries)
Offer.create(offerable: Offer::VariableBulkDiscount.create, product: coffee)
