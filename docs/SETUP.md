# ByteHaven — Internet Café Management System

A Next.js and Cloudflare D1 internet café operations application. It tracks stations, registered customers and walk-ins, hourly plans, live timed sessions, session billing, snack/print sales, product stock and payments. The interface uses Philippine pesos; amounts are stored as integer centavos.

## Run locally

1. Install Node.js 22.13 or newer.
2. Extract this ZIP and enter `bytehaven-cafe`.
3. Run `npm ci`.
4. Run `npm run dev`, then open the displayed local URL.
5. On **Overview**, click **Load sample setup**. This creates 12 stations, three hourly plans, and five counter products in an empty database.
6. Click **Start a session**, choose an available station and active plan, and select a registered customer or enter a walk-in name. The server stores the plan rate at the moment the session starts. The live timer updates in the UI.
7. Click **End session** to bill actual elapsed time. Billing rounds up to the minute with a 15-minute minimum. Select Cash, GCash or Card to record the offline collection. Sessions can be exported to CSV.
8. Use **Shop & Sales** to record a product sale or adjust stock. Station maintenance and rate plan availability are managed from their respective screens.

The D1 binding is `DB` in `.openai/hosting.json`. The initial migration is `drizzle/0000_sloppy_mandarin.sql`, including a unique partial index that prevents two active sessions on the same station. The starter's local Workers runtime uses local D1. For schema changes, run `npm run db:generate` and apply migrations. For deployment outside Sites, configure Cloudflare D1 with the same binding and adapt the included build scripts.

## Verification

Run `npx tsc --noEmit` for type checking and `npm run build` for the Workers-compatible production build.

## Before public or production use

This is a working operational demo. Add staff authentication, role permissions, audit trails, receipt printing, payment reconciliation, tax rules, persistent shift tracking, backup/restore and operational alerts before public use. Cash/GCash/Card are recorded as offline collection; the app does not charge a payment provider. For high-volume concurrent sales, make stock deduction and sale logging one transaction. Actual PC locking, client agents and network/device control are not integrated. Pricing is illustrative.
