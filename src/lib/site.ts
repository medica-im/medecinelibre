/**
 * Canonical origin for absolute URLs (canonical tags, og:url, sitemap).
 *
 * Read from $env/static/public — i.e. baked in at build time — because
 * robots.txt and the sitemap are prerendered, and a prerendered route cannot
 * read $env/dynamic/public at all (SvelteKit throws). Which .env the build
 * used therefore decides these absolute URLs: see the ENV_FILE note in the
 * Dockerfile, and note that images.yml pins one env file per environment.
 *
 * The fallback keeps absolute URLs pointing somewhere real if PUBLIC_ORIGIN
 * is ever missing, since a canonical aimed at dev would be worse than one
 * aimed at production.
 */
import { PUBLIC_ORIGIN } from '$env/static/public';

export const PUBLIC_SITE_URL = PUBLIC_ORIGIN || 'https://medecinelibre.com';

/** Brand name, appended to page titles and used as og:site_name. */
export const SITE_NAME = 'Médecine Libre';
