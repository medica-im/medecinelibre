<script lang="ts">
	import { browser } from '$app/environment';
	import { enhance, type SubmitFunction } from '$app/forms';

	// Types
	import type { ModalSettings, DrawerSettings } from '@skeletonlabs/skeleton';

	// Docs
	import LogoFull from '$lib/components/Logos/LogoFull.svelte';
	import Icon from '$lib/components/Icon/Icon.svelte';
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
	// Components & Utilities
	import { AppBar, LightSwitch, popup, modalStore } from '@skeletonlabs/skeleton';

	// Stores
	import { storeTheme } from '$lib/stores/stores';
	import { drawerStore } from '@skeletonlabs/skeleton';

	// Local
	let isOsMac = false;

	// Set Search Keyboard Shortcut
	if (browser) {
		let os = navigator.userAgent;
		isOsMac = os.search('Mac') !== -1;
	}

	// Drawer Handler
	function drawerOpen(): void {
		const s: DrawerSettings = { id: 'doc-sidenav' };
		drawerStore.open(s);
	}

	// Search
	function triggerSearch(): void {
		const modal: ModalSettings = {
			type: 'component',
			component: 'modalSearch',
			position: 'item-start'
		};
		modalStore.trigger(modal);
	}

	// Keyboard Shortcut (CTRL/⌘+K) to Focus Search
	function onWindowKeydown(e: KeyboardEvent): void {
		if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
			// Prevent default browser behavior of focusing URL bar
			e.preventDefault();
			// If modal currently open, close modal (allows to open/close search with CTRL/⌘+K)
			$modalStore.length ? modalStore.close() : triggerSearch();
		}
	}

	const themes = [
		{ type: 'skeleton', name: 'Skeleton', icon: '💀' },
		{ type: 'modern', name: 'Modern', icon: '🤖' },
		{ type: 'rocket', name: 'Rocket', icon: '🚀' },
		{ type: 'seafoam', name: 'Seafoam', icon: '🧜‍♀️' },
		{ type: 'vintage', name: 'Vintage', icon: '📺' },
		{ type: 'sahara', name: 'Sahara', icon: '🏜️' },
		{ type: 'hamlindigo', name: 'Hamlindigo', icon: '👔' },
		{ type: 'gold-nouveau', name: 'Gold Nouveau', icon: '💫' },
		{ type: 'crimson', name: 'Crimson', icon: '⭕' }
		// { type: 'seasonal', name: 'Seasonal', icon: '🎆' }
		// { type: 'test', name: 'Test', icon: '🚧' },
	];

	const setTheme: SubmitFunction = () => {
		return async ({ result, update }) => {
			await update();
			if (result.type === 'success') {
				const theme = result.data?.theme as string;
				storeTheme.set(theme);
			}
		};
	};
</script>

<!-- NOTE: using stopPropagation to override Chrome for Windows search shortcut -->
<svelte:window on:keydown|stopPropagation={onWindowKeydown} />

<AppBar shadow="shadow-xl">
	<svelte:fragment slot="lead">
		<div class="flex items-center space-x-4">
			<!-- Hamburger Menu -->
			<button on:click={drawerOpen} class="btn-icon btn-icon-sm lg:!hidden">
				<Fa icon={faBars} />
			</button>
			<!-- Logo -->
			<a class="" href="/" title="Aller à l'accueil">
				<span><h3>Médecine Libre</h3></span>
			</a>
		</div>
	</svelte:fragment>
	<svelte:fragment slot="trail">
		<!-- Services -->
		<div class="relative hidden lg:block">
			<!-- trigger -->
			<button
				class="btn hover:variant-soft-primary"
				use:popup={{ event: 'click', target: 'services' }}
			>
				<span>Services</span>
				<Fa icon={faCaretDown} />
			</button>
			<!-- popup -->
			<div class="card p-4 w-60 shadow-xl" data-popup="services">
				<nav class="list-nav">
					<ul>
						<li>
							<a href="/pluripro/web">
								<span class="w-6 text-center"><Fa icon={faGlobe} /></span>
								<span>Pluripro</span>
							</a>
						</li>
						<li>
							<a href="/pluripro/msp">
								<span class="w-6 text-center"><Fa icon={faPeopleGroup} /></span>
								<span>MSP</span>
							</a>
						</li>
						<li>
							<a href="/pluripro/cpts">
								<span class="w-6 text-center"><Fa icon={faCircleNodes} /></span>
								<span>CPTS</span>
							</a>
						</li>
						<li>
							<a href="/tele-expertise/doctoctoc">
								<span class="w-6 text-center"><Fa icon={faClipboardQuestion} /></span>
								<span>Télé-expertise</span>
							</a>
						</li>

						<!--hr class="!my-4" /-->
					</ul>
				</nav>
				<div class="arrow bg-surface-100-800-token" />
			</div>
		</div>

		<!-- Navigation -->
		<div class="relative hidden lg:block">
			<!-- trigger -->
			<button
				class="btn hover:variant-soft-primary"
				use:popup={{ event: 'click', target: 'navigation' }}
			>
				<span>Navigation</span>
				<Fa icon={faCaretDown} />
			</button>
			<!-- popup -->
			<div class="card p-4 w-60 shadow-xl" data-popup="navigation">
				<nav class="list-nav">
					<ul>
						<li>
							<a href="/">
								<span class="w-6 text-center"><Fa icon={faHome} /></span>
								<span>Accueil</span>
							</a>
						</li>
						<li>
							<a href="/contact">
								<span class="w-6 text-center"><Fa icon={faEnvelope} /></span>
								<span>Contact</span>
							</a>
						</li>
						<!--hr class="!my-4" /-->
					</ul>
				</nav>
				<div class="arrow bg-surface-100-800-token" />
			</div>
		</div>

		<!-- Theme -->
		<div>
			<button
				class="btn hover:variant-soft-primary"
				use:popup={{ event: 'click', target: 'theme' }}
			>
				<div class="text-lg md:!hidden">
					<Fa icon={faPalette} />
				</div>
				<span class="hidden md:inline-block">Thème</span>
				<div class="opacity-50"><Fa icon={faCaretDown} /></div>
			</button>
			<div class="card p-4 w-60 shadow-xl" data-popup="theme">
				<div class="space-y-4">
					<section class="flex justify-between items-center">
						<h6 class="h6">Mode</h6>
						<LightSwitch />
					</section>
					<nav class="list-nav p-4 -m-4 max-h-64 lg:max-h-[500px] overflow-y-auto">
						<form action="/?/setTheme" method="POST" use:enhance={setTheme}>
							<ul>
								{#each themes as { icon, name, type }}
									<li>
										<button
											class="option w-full h-full"
											type="submit"
											name="theme"
											value={type}
											class:bg-primary-active-token={$storeTheme === type}
										>
											<span>{icon}</span>
											<span>{name}</span>
										</button>
									</li>
								{/each}
							</ul>
						</form>
					</nav>
				</div>
				<div class="arrow bg-surface-100-800-token" />
			</div>
		</div>

		<!-- Social -->
		<!-- prettier-ignore -->
		<section class="hidden sm:inline-flex space-x-4">
			<a class="btn-icon btn-icon-sm hover:variant-soft-primary" href="https://twitter.com/MedecineLibre" target="_blank" rel="noreferrer">
				<Fa icon={faTwitter} />
			</a>
			<a class="btn-icon btn-icon-sm hover:variant-soft-primary" href="https://www.linkedin.com/in/j%C3%A9r%C3%B4me-pinguet-177454b0/" target="_blank" rel="noreferrer">
				<Fa icon={faLinkedin} />
			</a>
		</section>

		<!-- Search -->
		<div class="md:inline md:ml-4">
			<button
				class="btn p-2 px-4 space-x-4 variant-soft hover:variant-soft-primary"
				on:click={triggerSearch}
			>
				<Fa icon={faMagnifyingGlass} />
				<span class="hidden md:inline-block badge variant-soft">{isOsMac ? '⌘' : 'Ctrl'}+K</span>
			</button>
		</div>
	</svelte:fragment>
</AppBar>
