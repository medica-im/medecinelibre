import { redirect } from '@sveltejs/kit';
import type { Handle } from '@sveltejs/kit';
import { legacyRedirects } from '$lib/redirects';

/**
 * Serve the old URLs as 301s to their new homes.
 *
 * Done in a hook rather than with a +page.server.ts per old route: the table
 * in $lib/redirects.ts is then the single place the mapping lives, it covers
 * paths whose route directories no longer exist, and adding a future rename
 * means one line rather than a new directory.
 */
export const handle: Handle = async ({ event, resolve }) => {
	// Trailing slashes are stripped so /pluripro/cpts/ matches /pluripro/cpts.
	const path = event.url.pathname.replace(/\/+$/, '') || '/';
	const target = legacyRedirects[path];
	if (target) {
		redirect(301, target);
	}

	// LinkedIn shows organic link posts as a ~160px thumbnail, so it gets a
	// logo-and-name preview image readable at that size (see Seo.svelte and
	// scripts/og-image.sh). Every other client gets the detailed one.
	event.locals.linkedinBot = /LinkedInBot/i.test(event.request.headers.get('user-agent') ?? '');

	const response = await resolve(event);
	// The HTML differs by User-Agent (og:image), so say so to any cache.
	if (response.headers.get('content-type')?.startsWith('text/html')) {
		response.headers.append('vary', 'User-Agent');
	}
	return response;
};
