<script lang='ts'>
	import { initializeStores } from '@skeletonlabs/skeleton';
	import { env } from '$env/dynamic/public';
	import { PUBLIC_PLAUSIBLE_SCRIPT_SRC } from '$env/static/public';
	// The ordering of these imports is critical to your app working properly
	// If you have source.organizeImports set to true in VSCode, then it will auto change this ordering
	// Most of your app wide CSS should be put in this file
	import '../app.postcss';

// Dependency: Floating UI
import { storePopup } from '@skeletonlabs/skeleton';
	import { computePosition, autoUpdate, offset, shift, flip, arrow } from '@floating-ui/dom';
	storePopup.set({ computePosition, autoUpdate, offset, shift, flip, arrow });

	// SvelteKit Imports
	import { browser } from '$app/environment';
	import { page } from '$app/stores';
	import { afterNavigate } from '$app/navigation';

	// Types
	import type { ModalComponent } from '@skeletonlabs/skeleton';

	// Stores
	import { storeTheme } from '$lib/stores/stores';
	import { storePreview } from '$lib/layouts/Themer/stores';

	// Components & Utilities
	import { AppShell, Modal, Toast } from '@skeletonlabs/skeleton';

	// Components
	import MyAppBar from '$lib/components/AppBar/MyAppBar.svelte';
	import Footer from '$lib/components/Footer/Footer.svelte';
	import Sidebar from '$lib/components/Sidebar/Sidebar.svelte';
	import Drawer from '$lib/components/Drawer/Drawer.svelte';

	// Modal Components
	import Search from '$lib/modals/Search/Search.svelte';

	export let data: LayoutServerData;
	import type { LayoutServerData } from './$types';
	initializeStores();
	let isBlogArticle = false;
	// Registered list of Components for Modals
	const modalComponentRegistry: Record<string, ModalComponent> = {
		modalSearch: { ref: Search }
	};

	function matchPathWhitelist(pageUrlPath: string): boolean {
		// If homepage route
		if (pageUrlPath === '/') return true;
		// If contact route
		if (pageUrlPath === '/contact') return true;
		if (pageUrlPath === '/mentions-legales') return true;
		// If any blog route
		if (pageUrlPath.includes('/blog')) return true;
		return false;
	}

		// Set body `data-theme` based on current theme status
		storeTheme.subscribe(setBodyThemeAttribute);
	storePreview.subscribe(setBodyThemeAttribute);
	function setBodyThemeAttribute(): void {
		if (!browser) return;
		document.body.setAttribute('data-theme', $storePreview ? 'generator' : $storeTheme);
	}


	// Scroll heading into view
	function scrollHeadingIntoView(): void {
		if (!window.location.hash) return;
		const elemTarget: HTMLElement | null = document.querySelector(window.location.hash);
		if (elemTarget) elemTarget.scrollIntoView({ behavior: 'smooth' });
	}
	// Lifecycle
	afterNavigate((params: any) => {
		// Scroll to top
		const isNewPage: boolean = params.from && params.to && params.from.route.id !== params.to.route.id;
		const elemPage = document.querySelector('#page');
		if (isNewPage && elemPage !== null) {
			elemPage.scrollTop = 0;
		}
		// Scroll heading into view
		scrollHeadingIntoView();
	});
	// Reactive
	// Current Theme Data
	$: ({ currentTheme } = data);
	// Disable left sidebar on homepage
	$: slotSidebarLeft = matchPathWhitelist($page.url.pathname) ? 'w-0' : 'bg-surface-50-900-token lg:w-auto';
</script>

<svelte:head>
	<!-- Select Preset Theme CSS DO NOT REMOVE ESCAPES-->
	{@html `\<style\>${currentTheme}}\</style\>`}
	<meta name="theme-color" content="#ffffff">
<link rel="icon" href="/favicon.svg">
<link rel="mask-icon" href="/favicon.svg" color="#000000">
<link rel="apple-touch-icon" href="/apple-touch-icon.png">
<link rel="manifest" href="/manifest.json">
{#if PUBLIC_PLAUSIBLE_SCRIPT_SRC}
<script defer data-domain="medecinelibre.com" src={PUBLIC_PLAUSIBLE_SCRIPT_SRC}></script>
{/if}

<!-- HTML Meta Tags -->
<title>Médecine Libre</title>
<meta name="description" content="Applications web mobiles, sites web et communication pour MSP (maison de santé pluriprofessionnelle), centre de santé, clinique et CPTS.">

<meta name="google-site-verification" content="{env.PUBLIC_GOOGLE_SITE_VERIFICATION}" />

<!-- Facebook Meta Tags -->
<meta property="og:url" content="https://medecinelibre.com/">
<meta property="og:type" content="website">
<meta property="og:title" content="Médecine Libre: le numérique en santé, l'esprit libre.">
<meta property="og:description" content="Applications web mobiles, sites web et communication pour MSP (maison de santé pluriprofessionnelle), centre de santé, clinique et CPTS.">
<meta property="og:image" content="https://medecinelibre.com/google-touch-icon.png">

<!-- Twitter Meta Tags -->
<meta name="twitter:card" content="summary_large_image">
<meta property="twitter:domain" content="medecinelibre.com">
<meta property="twitter:url" content="https://medecinelibre.com/">
<meta name="twitter:title" content="Médecine Libre: le numérique en santé, l'esprit libre.">
<meta name="twitter:description" content="Applications web mobiles, sites web et communication pour MSP (maison de santé pluriprofessionnelle), centre de santé, clinique et CPTS.">
<meta name="twitter:image" content="https://medecinelibre.com/google-touch-icon.png">
</svelte:head>

<!-- Overlays -->
<Modal components={modalComponentRegistry} />
<Toast />
<Drawer />

<!-- App Shell -->
<AppShell {slotSidebarLeft} regionPage="overflow-y-scroll" slotFooter="bg-black p-4">

		<!-- Header -->
		<svelte:fragment slot="header">
			<MyAppBar />
		</svelte:fragment>

	<!-- Sidebar (Left) -->
	<svelte:fragment slot="sidebarLeft">
		<Sidebar class="hidden lg:grid w-[360px] overflow-hidden" />
	</svelte:fragment>

	<!-- Page Route Content -->
	<slot />
	<!-- Page Footer -->
	<svelte:fragment slot="pageFooter">
		<Footer />
	</svelte:fragment>
</AppShell>
