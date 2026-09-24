<script lang="ts">
	import Seo from '$lib/components/Seo/Seo.svelte';
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
		faIdCard,
		faServer,
		faLocationDot,
		faIndustry,
		faCircleNodes,
		faBars,
		faCaretDown,
		faHome,
		faBook,
		faBullhorn,
		faPalette,
		faMagnifyingGlass,
		faArrowRight,
		faPhone,
		faEnvelope
	} from '@fortawesome/free-solid-svg-icons';
	import { page } from '$app/stores';
</script>

<Seo
	title="Mentions légales"
	description="Mentions légales du site medecinelibre.com: éditeur, coordonnées et hébergeur."
/>

<div class="container mx-auto p-4 space-y-8">
	<header>
		<h1 class="h1">Mentions légales</h1>
	</header>
	<div class="grid grid-cols-1 gap-2">
		<div class="flex gap-3">
			<div class="badge variant-filled-primary w-6"><Fa icon={faIdCard} /></div>
			<div>Jérôme Pinguet EI</div>
		</div>
		<div class="flex gap-3">
			<div class="badge variant-filled-primary w-6"><Fa icon={faPhone} /></div>

			<div><a class="anchor" href="tel:+33356894550">03 56 89 45 50</a></div>
		</div>
		<div class="flex gap-3">
			<div class="badge variant-filled-primary w-6"><Fa icon={faEnvelope} /></div>
			<div>jerome@medecinelibre.com</div>
		</div>
		<div class="flex gap-3">
			<div class="badge variant-filled-primary w-6"><Fa icon={faLocationDot} /></div>
			<div class="grid grid-cols-1">
				<div>66 rue de Dunkerque</div>
				<div>59280 Armentières</div>
				<div>France</div>
			</div>
		</div>
		<div class="flex gap-3">
			<div class="
			badge variant-filled-primary w-6"><Fa icon={faIndustry} /></div>

			<div>SIRET 52945571900060</div>
		</div>
	</div>
	<div class="basis-auto w-full xl:w-6/12">
		<div class="flex align-start">
			<div class="shrink-0">
				<div
					class="variant-filled-primary p-1"
				>
					<Fa icon={faServer} size="2x" />
				</div>
			</div>
			<div class="grow ml-6">
				<p class="font-bold mb-1">Hébergeur</p>
				<p>DigitalOcean, LLC</p>
				<p>
					105 Edgeview Drive, Suite 425<br />
					Broomfield, CO 80021<br />
					United States of America
				</p>
				<p>
					<a class="anchor" href="https://www.digitalocean.com/company/contact"
						>www.digitalocean.com/company/contact</a
					>
				</p>
			</div>
		</div>
	</div>
</div>
