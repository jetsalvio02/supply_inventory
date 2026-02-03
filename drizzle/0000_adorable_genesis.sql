CREATE TYPE "public"."item_status" AS ENUM('IN_STOCK', 'OUT_OF_STOCK');--> statement-breakpoint
CREATE TYPE "public"."transaction_type" AS ENUM('IN', 'OUT', 'FORWARD');--> statement-breakpoint
CREATE TABLE "categories" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" varchar(100) NOT NULL,
	"description" text,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "categories_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE "inventory_summary" (
	"id" serial PRIMARY KEY NOT NULL,
	"item_id" integer NOT NULL,
	"beginning_stock" integer DEFAULT 0,
	"forwarded_balance" integer DEFAULT 0,
	"total_in" integer DEFAULT 0,
	"total_out" integer DEFAULT 0,
	"actual_balance" integer DEFAULT 0,
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "inventory_summary_item_id_unique" UNIQUE("item_id")
);
--> statement-breakpoint
CREATE TABLE "inventory_transactions" (
	"id" serial PRIMARY KEY NOT NULL,
	"item_id" integer NOT NULL,
	"type" "transaction_type" NOT NULL,
	"quantity" integer NOT NULL,
	"remarks" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "items" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" varchar(255) NOT NULL,
	"category_id" integer NOT NULL,
	"status" "item_status" DEFAULT 'IN_STOCK',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
ALTER TABLE "inventory_summary" ADD CONSTRAINT "inventory_summary_item_id_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "inventory_transactions" ADD CONSTRAINT "inventory_transactions_item_id_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "items" ADD CONSTRAINT "items_category_id_categories_id_fk" FOREIGN KEY ("category_id") REFERENCES "public"."categories"("id") ON DELETE cascade ON UPDATE no action;