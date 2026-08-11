class AddCoffeeFieldsToStorefrontProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :storefront_products, :roast_level, :string
    add_column :storefront_products, :origin, :string
    add_column :storefront_products, :tasting_notes, :string
    add_check_constraint :storefront_products,
      "roast_level IS NULL OR roast_level IN ('light', 'medium', 'dark')",
      name: "storefront_products_roast_level_allowed"
  end
end
