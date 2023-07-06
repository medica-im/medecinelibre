<script lang='ts'>
	// The ordering of these imports is critical to your app working properly
	import '@skeletonlabs/skeleton/themes/theme-gold-nouveau.css';
	// If you have source.organizeImports set to true in VSCode, then it will auto change this ordering
	import '@skeletonlabs/skeleton/styles/skeleton.css';
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
