<script lang="ts">
	import { page } from '$app/stores';
	import WebsiteGraph from '$lib/components/WebsiteGraph/WebsiteGraph.svelte';
	import { Avatar, CodeBlock } from '@skeletonlabs/skeleton';
	import homepage1Src from '$lib/assets/images/homepage1.png';
</script>

<svelte:head>
	<title
		>Maison de santé, centre de santé, cabinet de groupe - {import.meta.env.VITE_SITE_TITLE}</title
	>
</svelte:head>
<div>
	<section class="bg-surface-100-800-token">
		<div class="section-container">
			<div class="container mx-auto flex justify-center p-2">
				<div class="space-y-10 text-center flex flex-col items-center">
					<h1 class="h1">Maison de santé, centre de santé, cabinet de groupe</h1>
				</div>
			</div>
		</div>
	</section>

	<section class="bg-surface-100-800-token">
		<div class="section-container">
			<div class="container mx-auto flex justify-center p-2">
				<WebsiteGraph />
			</div>
		</div>
	</section>

	<section class="bg-surface-100-800-token">
		<div class="section-container mx-auto flex justify-center p-2">
					<div class="card block max-w-xl variant-ghost space-y-6 p-1">
						<header class="card-header text-center">
							<h2 class="h2">Testez Pluripro Web MSP!</h2>
						</header>
						<div class="flex justify-center">

								<a href="https://msp.medica.im" rel="external" title="Testez Pluripro Web MSP!">
									<img src={homepage1Src} alt="capture d'écran du site de démonstration" />
								</a>
							</div>

							<h3 class="h3 text-center">Site web de démonstration</h3>
								<p class="text-center">
									Mieux que de longs discours, cliquez sur le bouton ci-dessous pour tester Pluripro
									Web MSP! Vous pourrez parcourir le site web de démonstration de la maison de santé
									fictive de Saint-Saturnin.
								</p>
								
						
						<footer class="card-footer flex justify-center">
								<a
									href="https://msp.medica.im"
									class="btn variant-ghost"
									title="Testez Pluripro Web MSP!"
									rel="external">https://msp.medica.im</a
								>
						</footer>
					</div>
				</div>
	</section>
</div>

<style lang="postcss">
	.section-container {
		@apply w-full max-w-7xl mx-auto p-4 py-4 md:py-8 space-y-2 md:space-y-4;
	}
	/* Hero Gradient */
	/* prettier-ignore */
	.hero-gradient {
		background-image:
			radial-gradient(at 0% 0%, rgba(var(--color-secondary-500) / 0.33) 0px, transparent 50%),
			radial-gradient(at 98% 1%, rgba(var(--color-error-500) / 0.33) 0px, transparent 50%);
	}
</style>
