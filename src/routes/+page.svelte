<script lang="ts">
	import Seo from '$lib/components/Seo/Seo.svelte';
	import LogoFull from '$lib/components/Logos/LogoFull.svelte';
	import Fa from 'svelte-fa';
	import ExternalLink from '$lib/components/Link/ExternalLink.svelte';
	import {
		faCircleNodes,
		faPeopleGroup,
		faAddressBook,
		faComments
	} from '@fortawesome/free-solid-svg-icons';
	import { offers, realisations } from '$lib/content/offers';

	/**
	 * The homepage routes visitors by audience. The cards are navigation to
	 * the landing pages that will actually rank — they do not try to sell the
	 * offers themselves, or they would compete with those pages.
	 */
	const icons: Record<string, typeof faCircleNodes> = {
		'/annuaire-cpts': faAddressBook,
		'/site-internet-cpts': faCircleNodes,
		'/site-internet-msp': faPeopleGroup,
		'/teleexpertise': faComments
	};
</script>

<Seo
	title="Médecine Libre"
	description="Sites web et applications pour les MSP, les CPTS et les organisations professionnelles du secteur de la santé: annuaires, sites internet, outils collaboratifs. Accompagnement sur le long terme."
/>

<div class="container mx-auto p-4 space-y-12">
	<header class="space-y-6 text-center flex flex-col items-center">
		<figure>
			<section class="img-bg" />
			<LogoFull />
		</figure>
		<h1 class="h1">Le numérique en santé, l'esprit libre</h1>
		<p class="text-lg max-w-2xl">
			Nous créons les sites web et les applications des maisons de santé, des CPTS et des
			organisations professionnelles du secteur de la santé — syndicats, unions, fédérations —
			pour leurs besoins internes comme pour leur communication externe. Et nous les faisons
			vivre ensuite.
		</p>
	</header>

	<section class="space-y-6">
		<h2 class="h2 text-center">Que cherchez-vous?</h2>
		<div class="grid gap-4 md:grid-cols-2">
			{#each offers as offer}
				<a
					class="card card-hover variant-ghost p-6 space-y-3 block"
					href={offer.href}
					title={offer.heading}
				>
					<div class="flex items-center gap-3">
						<span class="text-primary-500 text-2xl"><Fa icon={icons[offer.href]} /></span>
						<h3 class="h3">{offer.label}</h3>
					</div>
					<p class="text-sm opacity-75">{offer.audience}</p>
					<p>{offer.pitch}</p>
				</a>
			{/each}
		</div>
	</section>

	<section class="space-y-6">
		<h2 class="h2 text-center">Ils nous font confiance</h2>
		<div class="grid gap-4 md:grid-cols-2">
			{#each realisations as r}
				<div class="card variant-ghost p-4 space-y-2">
					<h3 class="h4">{r.name}</h3>
					<p class="text-sm opacity-75">{r.kind}</p>
					<ExternalLink href={r.url} class="anchor text-sm" />
				</div>
			{/each}
		</div>
		<p class="text-center">
			<a class="anchor" href="/realisations">Voir toutes nos réalisations</a>
		</p>
	</section>

	<section class="card variant-ghost p-6 space-y-4 text-center">
		<h2 class="h2">Une entreprise dirigée par un médecin généraliste</h2>
		<p class="max-w-2xl mx-auto">
			Médecine Libre crée depuis 2012 des solutions numériques pour les professionnels de
			santé. Nous connaissons le terrain: missions socles, ACI, interpro — pas besoin de
			traduire. Nous concevons et codons nos outils de A à Z, donc nous les adaptons vite.
		</p>
		<p><a class="anchor" href="/a-propos">Notre parcours</a></p>
	</section>

	<section class="text-center space-y-4">
		<h2 class="h2">Parlons de votre projet</h2>
		<p>Devis gratuit, sans engagement.</p>
		<a class="btn btn-lg variant-filled-primary" href="/contact">Nous contacter</a>
	</section>
</div>

<style lang="postcss">
	figure {
		@apply flex relative flex-col;
	}
	figure svg,
	.img-bg {
		@apply w-48 h-48 md:w-64 md:h-64;
	}
	.img-bg {
		@apply absolute z-[-1] rounded-full blur-[50px] transition-all;
		animation: pulse 5s cubic-bezier(0, 0, 0, 0.5) infinite, glow 5s linear infinite;
	}
	@keyframes glow {
		0% {
			@apply bg-primary-400/50;
		}
		33% {
			@apply bg-secondary-400/50;
		}
		66% {
			@apply bg-tertiary-400/50;
		}
		100% {
			@apply bg-primary-400/50;
		}
	}
	@keyframes pulse {
		50% {
			transform: scale(1.5);
		}
	}
</style>
