<!-- foundation:identity -->
# Kilnwood Roast

Online storefront for a small coffee roaster: sell whole-bean coffee with photos and prices, guest-first cart and checkout, and an order history page customers can reach with an email access link or t

- Site: https://kilnwood-roast-789b.demo.holode.xyz
- Support: support@kilnwood-roast.api.holode.xyz
<!-- /foundation:identity -->
The demo at the Site URL is a throwaway that wipes daily at 3AM Mexico City — this repository is the durable artifact.

## What this is

Online storefront for a small coffee roaster: sell whole-bean coffee with photos and prices, guest-first cart and checkout, and an order history page customers can reach with an email access link or their account.

## Who it is for

- visitor (browse, cart, guest checkout)
- signed-in customer (account, order history)
- shop admin (manage products and orders via Madmin)

## Main features

- **Browse catalog** — Visitors see roast products with photos, prices, and descriptions; filter by roast level
- **Cart and checkout** — Add items to cart, adjust quantities, checkout with just an email (no account required); server-authoritative pricing; Stripe-ready with local test simulator in preview
- **View past orders** — Customer sees order history via signed expiring access link from receipt, or from their account when signed in
- **Admin manage shop** — Madmin dashboard to add/edit products (name, price, photo, active flag) and view orders

## Core entities

- Product
- Cart
- CartItem
- Order
- OrderItem
- Customer

## Included foundation modules

- storefront

## Run locally

```bash
bundle install
bin/rails db:prepare
bin/dev
```

Requires Ruby, PostgreSQL, and the usual Rails toolchain. See `bin/setup` if present.

## Demo

6-8 whole-bean coffees across roast levels (light/medium/dark) with photos, prices, origins and tasting notes; a couple of sample past orders to demonstrate order history.

## Deploy notes

Production `config.hosts` is derived from `domain` in `config/foundation.yml`. Keep that value aligned with the real host or every request will 403.
