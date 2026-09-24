<script lang="ts">
	import { page } from '$app/state';
	import { PUBLIC_SITE_URL, SITE_NAME } from '$lib/site';

	/**
	 * Per-page metadata. Before this existed, +layout.svelte emitted one
	 * hardcoded description and one og:url for every route, so as far as
	 * Google could tell every page was the same page — and social shares of
	 * a landing page rendered the homepage's card.
	 *
	 * Each page passes its own title/description; canonical and og:url are
	 * derived from the current path so they cannot drift out of step.
	 */
	interface Props {
		title: string;
		description: string;
		/** Social preview image under /images/, or omitted for the default. */
		image?: string;
		/** True on pages that must not be indexed (thin or duplicate). */
		noindex?: boolean;
	}
	let { title, description, image = '', noindex = false }: Props = $props();

	const canonical = $derived(new URL(page.url.pathname, PUBLIC_SITE_URL).href);
	const ogImage = $derived(
		new URL(image || '/images/og-default.jpg', PUBLIC_SITE_URL).href
	);
	// The tab shows the page's own name; the brand is appended once. The old
	// pages appended an undefined VITE_SITE_TITLE, rendering a bare "- ".
	const fullTitle = $derived(title === SITE_NAME ? title : `${title} | ${SITE_NAME}`);
</script>

<svelte:head>
	<title>{fullTitle}</title>
	<meta name="description" content={description} />
	<link rel="canonical" href={canonical} />
	{#if noindex}
		<meta name="robots" content="noindex, follow" />
	{/if}

	<meta property="og:type" content="website" />
	<meta property="og:site_name" content={SITE_NAME} />
	<meta property="og:title" content={fullTitle} />
	<meta property="og:description" content={description} />
	<meta property="og:url" content={canonical} />
	<meta property="og:image" content={ogImage} />
	<meta property="og:locale" content="fr_FR" />

	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:title" content={fullTitle} />
	<meta name="twitter:description" content={description} />
	<meta name="twitter:image" content={ogImage} />
</svelte:head>
