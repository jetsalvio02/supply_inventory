// import postgres from "postgres";
// import { drizzle } from "drizzle-orm/postgres-js";

// const client = postgres(process.env.DATABASE_URL_DIRECT!, {
//   prepare: false,
// });

// export const db = drizzle(client);

import { neon } from "@neondatabase/serverless";
import { drizzle } from "drizzle-orm/neon-http";

const sql = neon(process.env.DATABASE_URL!);
export const database = drizzle(sql);
