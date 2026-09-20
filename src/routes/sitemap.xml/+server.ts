import { PUBLIC_SITE_URL } from '$lib/site';
import { offers } from '$lib/content/offers';
import { NOINDEX } from '$lib/noindex';

/**
 * sitemap.xml, generated from $lib/content/offers.ts so it cannot list a
 * page that no longer exists or miss one that was added — the failure mode
 * of a hand-maintained sitemap.
 *
 * Only canonical URLs belong here. The retired /pluripro/* paths 301 and are
 * deliberately absent: listing a redirect asks Google to crawl a hop.
 */
const staticPaths = ['/', '/realisations', '/a-propos', '/contact', '/mentions-legales'];

export function GET() {
	// On dev and staging robots.txt already says Disallow: /, so a sitemap
	// would be contradictory. Serve an empty one rather than advertising
	// non-production URLs.
	const paths = NOINDEX ? [] : [...staticPaths, ...offers.map((o) => o.href), '/annuaire-cpts/demo'];

	const urls = paths
		.map((p) => `\t<url><loc>${new URL(p, PUBLIC_SITE_URL).href}</loc></url>`)
		.join('\n');

	return new Response(
		`<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${urls}\n</urlset>\n`,
		{
			headers: {
				'content-type': 'application/xml; charset=utf-8',
				'cache-control': 'public, max-age=3600'
			}
		}
	);
}
