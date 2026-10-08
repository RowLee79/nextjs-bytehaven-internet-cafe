CREATE TABLE `customers` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`phone` text NOT NULL,
	`email` text DEFAULT '' NOT NULL,
	`created_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `customers_phone_uq` ON `customers` (`phone`);--> statement-breakpoint
CREATE TABLE `plans` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`hourly_cents` integer NOT NULL,
	`description` text NOT NULL,
	`active` integer DEFAULT 1 NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `plans_name_uq` ON `plans` (`name`);--> statement-breakpoint
CREATE TABLE `products` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`category` text NOT NULL,
	`price_cents` integer NOT NULL,
	`stock` integer NOT NULL,
	`active` integer DEFAULT 1 NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `products_name_uq` ON `products` (`name`);--> statement-breakpoint
CREATE TABLE `sales` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`reference` text NOT NULL,
	`product_id` integer NOT NULL,
	`product_name` text NOT NULL,
	`quantity` integer NOT NULL,
	`unit_cents` integer NOT NULL,
	`total_cents` integer NOT NULL,
	`payment_method` text NOT NULL,
	`created_at` text NOT NULL,
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `sales_reference_uq` ON `sales` (`reference`);--> statement-breakpoint
CREATE TABLE `sessions` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`reference` text NOT NULL,
	`station_id` integer NOT NULL,
	`customer_id` integer,
	`customer_name` text NOT NULL,
	`plan_id` integer NOT NULL,
	`rate_cents` integer NOT NULL,
	`status` text DEFAULT 'Active' NOT NULL,
	`started_at` text NOT NULL,
	`ended_at` text,
	`minutes` integer DEFAULT 0 NOT NULL,
	`amount_cents` integer DEFAULT 0 NOT NULL,
	`payment_method` text DEFAULT '' NOT NULL,
	FOREIGN KEY (`station_id`) REFERENCES `stations`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`plan_id`) REFERENCES `plans`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `sessions_reference_uq` ON `sessions` (`reference`);--> statement-breakpoint
CREATE INDEX `sessions_station_idx` ON `sessions` (`station_id`);--> statement-breakpoint
CREATE INDEX `sessions_status_idx` ON `sessions` (`status`);--> statement-breakpoint
CREATE TABLE `stations` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`code` text NOT NULL,
	`zone` text NOT NULL,
	`specs` text NOT NULL,
	`status` text DEFAULT 'Available' NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `stations_code_uq` ON `stations` (`code`);--> statement-breakpoint
CREATE UNIQUE INDEX `sessions_one_active_per_station` ON `sessions` (`station_id`) WHERE `status` = 'Active';
