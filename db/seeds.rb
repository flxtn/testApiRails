User.create!(
  email: 'user@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  first_name: 'Ilya',
  last_name: 'Bogomolov'
)
Item.create!(
  [
    {
      name: "Laptop",
      description: "A high-performance laptop with 16GB RAM and 512GB SSD.",
      price: 1200.99
    },
    {
      name: "Smartphone",
      description: "Latest model with a 6.5-inch display and 128GB storage.",
      price: 899.49
    },
    {
      name: "Headphones",
      description: "Noise-canceling over-ear headphones with excellent sound quality.",
      price: 199.99
    },
    {
      name: "Coffee Maker",
      description: "Automatic drip coffee maker with a 12-cup capacity.",
      price: 79.99
    },
    {
      name: "Backpack",
      description: "Stylish and durable backpack for everyday use, with multiple compartments.",
      price: 49.99
    }
  ]
)