# frozen_string_literal: true

module Foundation
  # Demo catalog rows for the Kilnwood Roast coffee storefront.
  #
  # The application boots and serves every page with an empty database, so no
  # seed is ever required. These rows exist only to make the storefront and
  # checkout walkable on a developer machine or in a hosted preview, and they
  # are refused everywhere else — a production deployment must never find
  # invented products in its catalog.
  module DemoSeeds
    PRODUCTS = [
      {
        slug: "kilnwood-single-origin", sku: "KW-ORIGIN-001", name: "Kilnwood Single Origin",
        description: "Our signature roast: a washed Ethiopian heirloom with a clean, syrupy body. This is the coffee we built the roaster for — bright, sweet, and hard to put down.",
        roast_level: "light", origin: "Yirgacheffe, Ethiopia",
        tasting_notes: "Blueberry · Bergamot · Honey",
        price_cents: 1_650, position: 0, inventory_quantity: 48,
        image_url: "https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "firedawn-blend", sku: "KW-BLEND-002", name: "Firedawn Blend",
        description: "A morning blend built for milk drinkers and slow Saturdays: Colombian and Brazilian beans roasted together until the acidity settles into cocoa and toast.",
        roast_level: "medium", origin: "Colombia · Brazil",
        tasting_notes: "Dark chocolate · Hazelnut · Caramel",
        price_cents: 1_450, position: 1, inventory_quantity: 60,
        image_url: "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "ember-dark-roast", sku: "KW-DARK-003", name: "Ember Dark Roast",
        description: "Our darkest offering, roasted slow to keep the sweetness ahead of the smoke. Full-bodied and low-acid, for the pour-over you don't want to end.",
        roast_level: "dark", origin: "Sumatra, Indonesia",
        tasting_notes: "Molasses · Cedar · Smoked maple",
        price_cents: 1_550, position: 2, inventory_quantity: 36,
        image_url: "https://images.unsplash.com/photo-1531590878845-12627191e687?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "greenwood-decaf", sku: "KW-DECAF-004", name: "Greenwood Decaf",
        description: "Swiss-water processed so the flavor survives and the caffeine doesn't. The evening cup that tastes like a morning one.",
        roast_level: "medium", origin: "Huila, Colombia",
        tasting_notes: "Toffee · Red apple · Almond",
        price_cents: 1_400, position: 3, inventory_quantity: 45,
        image_url: "https://images.unsplash.com/photo-1447933601403-0c6688de566e?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "honey-process-espresso", sku: "KW-ESPR-005", name: "Honey Process Espresso",
        description: "Pulped-natural Costa Rican beans that pull shots with a heavy crema and a sugar-cane sweetness. Built for the machine, happy in a moka pot.",
        roast_level: "medium", origin: "Tarrazú, Costa Rica",
        tasting_notes: "Brown sugar · Tangerine · Cacao nib",
        price_cents: 1_700, position: 4, inventory_quantity: 40,
        image_url: "https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "blue-ridge-finca", sku: "KW-FINCA-006", name: "Blue Ridge Finca",
        description: "A delicate Kenyan AA lot from the highlands around Nyeri — floral, juicy, and unapologetically bright. The one we argue about at cupping.",
        roast_level: "light", origin: "Nyeri, Kenya",
        tasting_notes: "Blackcurrant · Jasmine · Lime",
        price_cents: 1_800, position: 5, inventory_quantity: 32,
        image_url: "https://images.unsplash.com/photo-1521302080334-4bebac2763a6?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "cinder-cold-brew", sku: "KW-COLD-007", name: "Cinder Cold Brew",
        description: "A coarse-ground dark roast blended for 18-hour cold extraction: chocolate-forward, almost creamy, no bitterness in sight. Bag it, brew it cold, thank us later.",
        roast_level: "dark", origin: "Brazil · Guatemala",
        tasting_notes: "Bittersweet cocoa · Cherry · Walnut",
        price_cents: 1_600, position: 6, inventory_quantity: 50,
        image_url: "https://images.unsplash.com/photo-1524350876685-274059332603?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "kilnwood-espresso-blend", sku: "KW-ESPR-008", name: "Kilnwood Espresso Blend",
        description: "Our house espresso: an even split of washed and natural lots that reads as dark chocolate with a sticky, jammy finish. What we pull behind the bar.",
        roast_level: "dark", origin: "Ethiopia · Brazil",
        tasting_notes: "Dark chocolate · Plum · Walnut",
        price_cents: 1_750, position: 7, inventory_quantity: 55,
        image_url: "https://images.unsplash.com/photo-1559056199-641a0ac8b55e?auto=format&fit=crop&w=900&q=80"
      }
    ].freeze

    # Development or a hosted preview only. Preview runs in the production
    # Rails environment, so the preview flag — not RAILS_ENV alone — is what
    # separates a disposable demo from a real deployment.
    def self.permitted?(rails_env: Rails.env, preview: Foundation.preview?)
      rails_env.development? || preview
    end

    def self.run!(io: $stdout)
      unless permitted?
        io.puts("Skipping demo seeds: they are limited to development and hosted previews.")
        return 0
      end

      unless Foundation.storefront_enabled?
        io.puts("Skipping demo seeds: the storefront is disabled in config/foundation.yml.")
        return 0
      end

      created = seed_products!
      io.puts("Demo catalog ready: #{PRODUCTS.length} products (#{created} created).")
      created
    end

    # Upserts by slug so repeated runs converge on the same catalog instead of
    # duplicating rows.
    def self.seed_products!
      created = 0

      PRODUCTS.each do |attributes|
        product = Foundation::Storefront::Product.find_or_initialize_by(slug: attributes[:slug])
        created += 1 if product.new_record?
        product.update!(**attributes, currency: "USD", active: true)
      end

      created
    end
  end
end
