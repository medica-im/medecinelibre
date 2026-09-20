import { NOINDEX } from '$lib/noindex';

/**
 * robots.txt, generated from the environment rather than shipped as a file.
 *
 * dev.medecinelibre.com and staging.medecinelibre.com are publicly resolvable
 * and hold real certificates, so crawlers reach them like any other site —
 * Certificate Transparency logs are routinely scraped for hostnames.
 * `<meta name="robots" content="noindex">` in the root layout keeps those pages
 * out of search results, but only for HTML a crawler has already fetched: it
 * does not reduce the crawl itself, and does not apply to the raw `/src/*.ts`
 * modules Vite serves in dev. Hence both layers, driven by one flag.
 *
 * A route, not `static/robots.txt`: everything in static/ is copied verbatim
 * into every build, so a `Disallow: /` there would silently deindex production
 * on the next deploy. Reading VITE_NOINDEX — the same flag the layout's meta
 * tag uses — keeps the two in step by construction.
 *
 * Mirrors clinic-cms/skcms, deliberately: same flag name, same shape.
 */
export function GET() {
	const body = NOINDEX
		? // dev / staging: stay out entirely.
			'User-agent: *\nDisallow: /\n'
		: // production: an empty Disallow is the explicit "crawl everything".
			'User-agent: *\nDisallow:\n';

	return new Response(body, {
		headers: {
			'content-type': 'text/plain; charset=utf-8',
			// Short: flipping an environment should not leave a stale rule
			// cached at the edge for a day.
			'cache-control': 'public, max-age=300'
		}
	});
}

// Nothing here depends on the request, so it can be prerendered in a build.
export const prerender = true;
