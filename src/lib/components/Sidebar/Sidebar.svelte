<script lang="ts">
	import { page } from '$app/stores';

	import Icon from '$lib/components/Icon/Icon.svelte';
	import { AppRail, AppRailTile, AppRailAnchor } from '@skeletonlabs/skeleton';
	import { drawerStore } from '@skeletonlabs/skeleton';
	import { menuNavLinks } from '$lib/links';
	import Fa from 'svelte-fa';
	import {
		faTwitter,
		faFacebook,
		faLinkedin,
		faInstagram,
		faYoutube,
		faSkype,
		faGithub,
		faMastodon
	} from '@fortawesome/free-brands-svg-icons';
	import {
		faCircleNodes,
		faBars,
		faCaretDown,
		faHome,
		faBook,
		faBullhorn,
		faPalette,
		faMagnifyingGlass,
		faEnvelope,
		faPeopleGroup,
		faGlobe,
		faClipboardQuestion
	} from '@fortawesome/free-solid-svg-icons';

	// Local
	let currentRailCategory: keyof typeof menuNavLinks | undefined = undefined;

	function onClickAnchor(): void {
		currentRailCategory = undefined;
		drawerStore.close();
	}

	// Lifecycle
	page.subscribe((page) => {
		// ex: /basePath/...
		let basePath: string = page.url.pathname.split('/')[1];
		if (!basePath) return;
		// Translate base path to link section
		if (['pluripro', 'msp', 'cpts'].includes(basePath)) currentRailCategory = '/pluripro';
		if (['tele-expertise'].includes(basePath)) currentRailCategory = '/tele-expertise';
	});

	// Reactive
	$: submenu = menuNavLinks[currentRailCategory ?? '/pluripro'];
	$: listboxItemActive = (href: string) =>
		$page.url.pathname?.includes(href) ? 'bg-primary-active-token' : '';
</script>

<div
	class="grid grid-cols-[auto_1fr] h-full bg-surface-50-900-token border-r border-surface-500/30 {$$props.class ??
		''}"
>
	<!-- App Rail -->
	<AppRail background="bg-transparent" border="border-r border-surface-500/30">
		<!-- Mobile Only -->
		<!-- prettier-ignore -->
		<AppRailAnchor href="/" class="lg:hidden" on:click={() => { onClickAnchor() }}>
			<svelte:fragment slot="lead"><Fa icon={faHome} size="lg" class="inline-block outline-none" /></svelte:fragment>
			<span>Accueil</span>
		</AppRailAnchor>
		<!-- prettier-ignore -->
		<AppRailTile bind:group={currentRailCategory} name="pluripro" value={'/pluripro'}>
			<svelte:fragment slot="lead"><Fa icon={faGlobe} size="lg" class="inline-block outline-none" /></svelte:fragment>
			<span>Pluripro</span>
		</AppRailTile>
		<hr class="opacity-30" />
		<AppRailTile bind:group={currentRailCategory} name="tele-expertise" value={'/tele-expertise'}>
			<svelte:fragment slot="lead"
				><Fa
					icon={faClipboardQuestion}
					size="lg"
					class="inline-block outline-none"
				/></svelte:fragment
			>
			<span>Télé-expertise</span>
		</AppRailTile>
		<AppRailAnchor
			href="/contact"
			class="lg:hidden"
			on:click={() => {
				onClickAnchor();
			}}
		>
			<svelte:fragment slot="lead"><Fa icon={faEnvelope} size="lg" class="inline-block outline-none" /></svelte:fragment>
			<span>Contact</span>
		</AppRailAnchor>
	</AppRail>
	<!-- Nav Links -->
	<section class="p-4 pb-20 space-y-4 overflow-y-auto">
		{#each submenu as segment, i}
			<!-- Title -->
			<p class="font-bold pl-4 text-2xl">{segment.title}</p>
			<!-- Nav List -->
			<nav class="list-nav">
				<ul>
					{#each segment.list as { href, label, badge }}
						<li on:keypress on:click={drawerStore.close}>
							<a {href} class={listboxItemActive(href)} data-sveltekit-preload-data="hover">
								<span class="flex-auto">{@html label}</span>
								{#if badge}<span class="badge variant-filled-secondary">{badge}</span>{/if}
							</a>
						</li>
					{/each}
				</ul>
			</nav>
			<!-- Divider -->
			{#if i + 1 < submenu.length}<hr class="!my-6 opacity-50" />{/if}
		{/each}
	</section>
</div>
