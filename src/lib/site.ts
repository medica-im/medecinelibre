/**
 * Canonical origin for absolute URLs (canonical tags, og:url, sitemap).
 *
 * ORIGIN is set in every environment's .env because adapter-node needs it,
 * so it is the one value guaranteed to be right per environment — no new
 * variable to forget. Read at runtime via $env/dynamic/public so the same
 * image serves any origin; the production fallback keeps absolute URLs
 * pointing somewhere real if it is ever missing, since a canonical aimed at
 * dev would be worse than one aimed at production.
 */
import { env } from '$env/dynamic/public';

export const PUBLIC_SITE_URL = env.PUBLIC_ORIGIN || 'https://medecinelibre.com';

/** Brand name, appended to page titles and used as og:site_name. */
export const SITE_NAME = 'Médecine Libre';
