<script lang="ts">
	import LogoFull from '$lib/components/Logos/LogoFull.svelte';
	import CTA from '$lib/components/PluriproWeb/CTA.svelte';
</script>

<div class="container h-full mx-auto justify-center items-center p-4 m-4 space-y-10">
	<div class="space-y-4 lg:space-y-10 text-center flex flex-col items-center">
		<h1 class="h1">Bienvenue chez Médecine Libre!</h1>
		<p>Le numérique en santé, l'esprit libre.</p>
		<!-- Animated Logo -->
		<figure>
			<section class="img-bg" />
			<LogoFull />
		</figure>
	</div>
	<div class="space-y-4 lg:space-y-10 mx-auto text-center items-center w-fit p-4">
		<CTA/>
	</div>
</div>

<style lang="postcss">
	figure {
		@apply flex relative flex-col;
	}
	figure svg,
	.img-bg {
		@apply w-64 h-64 md:w-80 md:h-80;
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
