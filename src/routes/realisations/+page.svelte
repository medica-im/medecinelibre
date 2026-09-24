<script lang="ts">
	import Seo from '$lib/components/Seo/Seo.svelte';
	import ExternalLink from '$lib/components/Link/ExternalLink.svelte';
	import { realisations } from '$lib/content/offers';
</script>

<Seo
	title="Réalisations: sites et annuaires pour CPTS et MSP"
	description="Nos réalisations pour des CPTS et des maisons de santé: annuaires de territoire, annuaires d'adhérents, sites web complets. Sites en production, visitables."
/>

<div class="container max-w-3xl mx-auto p-4 space-y-10">
	<header class="space-y-4 text-center">
		<h1 class="h1">Nos réalisations</h1>
		<p class="text-lg">
			Des sites et des applications en production, que vous pouvez visiter.
		</p>
	</header>

	<div class="space-y-6">
		{#each realisations as r}
			<section class="card variant-ghost p-6 space-y-3">
				<h2 class="h3">{r.name}</h2>
				<p class="text-sm opacity-75">{r.kind}</p>
				<p>{r.summary}</p>
				<ExternalLink href={r.url} />
			</section>
		{/each}
	</div>

	<section class="text-center space-y-4">
		<h2 class="h2">Un projet similaire?</h2>
		<p>Devis gratuit, sans engagement.</p>
		<a class="btn btn-lg variant-filled-primary" href="/contact">Nous contacter</a>
	</section>
</div>
