<script lang="ts">
	import { page } from '$app/stores';
	import { Avatar, CodeBlock } from '@skeletonlabs/skeleton';
	import homepage1Src from '$lib/assets/images/homepage1.png';
</script>

<svelte:head>
	<title
		>Communautés professionnelles territoriales de santé (CPTS) - {import.meta.env.VITE_SITE_TITLE}</title
	>
</svelte:head>
<div>
	<section class="bg-surface-100-800-token">
		<div class="section-container">
			<div class="container mx-auto flex justify-center p-2">
				<div class="space-y-10 text-center flex flex-col items-center">
					<h1 class="h1">Communautés professionnelles territoriales de santé (CPTS)</h1>
				</div>
			</div>
		</div>
	</section>

	<section class="bg-surface-100-800-token">
		<div class="section-container">
			<div class="container mx-auto p-2">
				<p>Nous créons un site web pour une CPTS du sud de la France.</p>
				<p>Nous allons également mettre en ligne une application de gestion du parcours de soins des personnes âgées en lien avec une CPTS de la Côte d'Opale.</p>
				<p>Les liens vers ces projets seront ajoutés à cette page prochainement.</p>
			</div>
		</div>
	</section>
</div>