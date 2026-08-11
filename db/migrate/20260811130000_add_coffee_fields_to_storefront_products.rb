class AddCoffeeFieldsToStorefrontProducts < ActiveRecord::Migration[8.1]
  def change
    unless column_exists?(:storefront_products, :roast_level)
      add_column :storefront_products, :roast_level, :string
    end
    add_column :storefront_products, :origin, :string unless column_exists?(:storefront_products, :origin)
    add_column :storefront_products, :tasting_notes, :string unless column_exists?(:storefront_products, :tasting_notes)
    unless check_constraint_exists?(:storefront_products, "storefront_products_roast_level_allowed")
      add_check_constraint :storefront_products,
        "roast_level IS NULL OR roast_level IN ('light', 'medium', 'dark')",
        name: "storefront_products_roast_level_allowed"
    end
  end
end
