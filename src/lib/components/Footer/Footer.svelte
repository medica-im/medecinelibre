<script lang="ts">
	// Logo
	import LogoIcon from '$lib/components/Logos/LogoIcon.svelte';
	import Fa from 'svelte-fa';
	import {
		faTwitter,
		faFacebook,
		faLinkedin,
		faInstagram,
		faYoutube,
		faSkype,
		faGithub,
		faMastodon,
		faBluesky
	} from '@fortawesome/free-brands-svg-icons';
	import { faPhone } from '@fortawesome/free-solid-svg-icons';
	// Base Classes
	const cBase =
		'bg-surface border-t border-surface-500/10 text-xs md:text-base';
	const cRowOne =
		'flex flex-col md:flex-row justify-between items-center md:items-start space-y-5 md:space-y-0';
	/*const cRowTwo =
		'flex flex-col md:flex-row justify-between items-center md:items-start space-y-4 md:space-y-0';*/
	const cRowTwo =
		'flex flex-col md:flex-row justify-between items-center md:items-end space-y-4 md:space-y-0';
</script>

<div class="page-footer {cBase}">
	<div class="w-full max-w-7xl mx-auto p-4 py-16 md:py-24 space-y-10">
		<!-- Row 1 -->
		<section class={cRowOne}>
			<div class="flex flex-col space-y-2">
				<div class="flex space-x-2 items-center">
					<LogoIcon />
					<h3 class="h3">Médecine Libre</h3>
				</div>
				<div>
					<p class="!text-sm opacity-80">Applications & sites web pour la santé pluripro.</p>
				</div>
				<a href="tel:+33977215435"><div class="flex space-x-2 items-center"><span><Fa icon={faPhone} size="xs"/></span><span>0977215435</span></div></a>
				
			</div>
			<div class="hidden md:grid grid-cols-3 gap-8">
				<div class="space-y-6">
					<h6 class="h6">Services</h6>
					<ul class="space-y-3">
						<li><a class="anchor" href="/pluripro/web">Pluripro web</a></li>
						<li><a class="anchor" href="/pluripro/msp">MSP</a></li>
						<li><a class="anchor" href="/pluripro/cpts">CPTS</a></li>
						<li><a class="anchor" href="/tele-expertise/doctoctoc">Télé-expertise</a></li>
					</ul>
				</div>
				<div class="space-y-6">
					<h6 class="h6">Navigation</h6>
					<ul class="space-y-3">
						<li><a class="anchor" href="/">Accueil</a></li>
						<li><a class="anchor" href="/contact">Contact</a></li>
						<li><a class="anchor" href="/mentions-legales">Mentions légales</a></li>
					</ul>
				</div>
				<!--div class="space-y-6">
					<h6 class="h6">Project</h6>
					<ul class="space-y-3">
						<li>
							<a
								class="anchor"
								href="https://github.com/skeletonlabs"
								target="_blank"
								rel="noreferrer">Github Organization</a
							>
						</li>
						<li>
							<a
								class="anchor"
								href="https://www.npmjs.com/org/skeletonlabs"
								target="_blank"
								rel="noreferrer">NPM Organization</a
							>
						</li>
						<li>
							<a
								class="anchor"
								href="https://www.npmjs.com/package/@skeletonlabs/skeleton"
								target="_blank"
								rel="noreferrer">NPM Package</a
							>
						</li>
					</ul>
				</div-->
			</div>
		</section>

		<hr class="opacity-20" />

		<!-- Row 2 -->
		<section class={cRowTwo}>
			<p>
				<!--
				<a
					class="anchor"
					href="https://github.com/skeletonlabs/skeleton/blob/master/LICENSE"
					target="_blank"
					rel="noreferrer"
				>
					MIT License
				</a>
				<span class="opacity-10 mx-2">|</span>
				<a class="anchor" href="https://skeletonlabs.co/" target="_blank" rel="noreferrer"
					>Skeleton Labs
				</a>
				-->
			</p>
			<div class="flex space-x-4">
				<a
					class="btn variant-soft"
					href="https://github.com/jeromecc"
					target="_blank"
					rel="noreferrer"
				>
					<span><Fa icon={faGithub} /></span>
					<span class="hidden md:inline-block ml-2">Github</span>
				</a>
				<a
					class="btn variant-soft"
					href="https://mastodon.medica.im/@medecinelibre"
					target="_blank"
					rel="noreferrer"
				>
					<span><Fa icon={faMastodon} /></span>
					<span class="hidden md:inline-block ml-2">Mastodon</span>
				</a>
				<a
					class="btn variant-soft"
					href="https://bsky.app/profile/medecinelibre.bsky.social"
					target="_blank"
					rel="noreferrer"
				>
					<span><Fa icon={faBluesky} /></span>
					<span class="hidden md:inline-block ml-2">Bluesky</span>
				</a>
				<a
					class="btn variant-soft"
					href="https://twitter.com/MedecineLibre"
					target="_blank"
					rel="noreferrer"
				>
					<span><Fa icon={faTwitter} /></span>
					<span class="hidden md:inline-block ml-2">Twitter</span>
				</a>
				<a
					class="btn variant-soft"
					href="https://www.linkedin.com/in/j%C3%A9r%C3%B4me-pinguet-177454b0/"
					target="_blank"
					rel="noreferrer"
				>
					<span><Fa icon={faLinkedin} /></span>
					<span class="hidden md:inline-block ml-2">LinkedIn</span>
				</a>
			</div>
		</section>
	</div>
</div>
