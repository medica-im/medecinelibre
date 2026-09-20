/**
 * Permanent redirects from the old /pluripro/* URLs.
 *
 * The old paths carry whatever ranking and inbound links the site has
 * accumulated, so they must 301 rather than 404 — a 404 discards that, and
 * the prospection emails already in inboxes link to some of them.
 *
 * "pluripro" was our internal name for the product line. Nobody searches
 * for it, so it earned no place in a URL; the new paths lead with the words
 * a CPTS or MSP would actually type.
 */
export const legacyRedirects: Record<string, string> = {
	'/pluripro/cpts': '/site-internet-cpts',
	'/pluripro/msp': '/site-internet-msp',
	// /pluripro/web was the company-history page; that content now lives on
	// /a-propos rather than being dropped.
	'/pluripro/web': '/a-propos',
	'/pluripro': '/',
	'/pluripro/introduction': '/',
	'/tele-expertise/doctoctoc': '/teleexpertise',
	'/tele-expertise/introduction': '/teleexpertise',
	'/tele-expertise': '/teleexpertise'
};
