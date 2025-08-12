<script lang="ts">
	import { page } from '$app/stores';
	import { Avatar, CodeBlock } from '@skeletonlabs/skeleton';
	import parcours from '$lib/assets/images/parcours-de-soins.png';
	import Fa from 'svelte-fa';
	import { faSquareCheck } from '@fortawesome/free-solid-svg-icons';
</script>

<svelte:head>
	<title
		>Communautés professionnelles territoriales de santé (CPTS) - {import.meta.env
			.VITE_SITE_TITLE}</title
	>
</svelte:head>
<div class="p-4 space-y-4">
	<div class="container mx-auto flex justify-center p-2 background-initial">
		<div class="space-y-10 text-center flex flex-col items-center">
			<h1 class="h1">Communautés professionnelles territoriales de santé (CPTS)</h1>
		</div>
	</div>

	<section class="bg-surface-100-800-token">
		<div class="card p-2 variant-ghost">
			<div class="card-header">
				<h2 class="h2">Annuaire & parcours de soins coordonnés</h2>
			</div>
			<div class="p-4 space-y-4">
				<img
					src={parcours}
					alt="capture d'écran de l'application annuaire parcours de soins coordonnés sur le site web lié"
				/>
				<p>
					Nous avons créé une application de gestion du parcours de soins coordonnés des personnes
					âgées, qui peut également être utilisée pour d'autres parcours de soins ou comme annuaire
					des membres d'une CPTS. Nous pouvons effectuer des modifications sur mesure pour répondre
					parfaitement à vos besoins.
				</p>
				<p>Vous pouvez tester cette application web sur le site de la CPTS Côte d'Opale Sud.</p>
				<a href="https://annuaire.cptsopalesud.fr" class="btn btn-lg variant-filled"
					>annuaire.cptsopalesud.fr</a
				>
			</div>
		</div>
	</section>

	<section class="bg-surface-100-800-token">
		<div class="card p-2 variant-ghost">
			<div class="card-header">
				<h2 class="h2">Site web pour CPTS</h2>
			</div>
			<div class="p-4">
				<p>Nous construirons rapidement un site web de haute qualité pour votre CPTS.</p>
				<ul class="list">
					<li>
						<span><Fa icon={faSquareCheck} /></span>
						<span class="flex flex-wrap whitespace-normal text-left"
							>annuaire des membres modifiable par le coordinateur ou par les membres eux-mêmes
							après connexion</span
						>
					</li>
					<li>
						<span><Fa icon={faSquareCheck} /></span>

						<span class="flex flex-wrap whitespace-normal text-left"
							>cartographie des membres et de leurs sites et établissements</span
						>
					</li>
					<li>
						<span><Fa icon={faSquareCheck} /></span>

						<span class="flex flex-wrap whitespace-normal text-left"
							>page détaillée dédiée à chaque membre</span
						>
					</li>
					<li>
						<span><Fa icon={faSquareCheck} /></span>

						<span class="flex flex-wrap whitespace-normal text-left">blog</span>
					</li>
					<li>
						<span><Fa icon={faSquareCheck} /></span>

						<span class="flex flex-wrap whitespace-normal text-left">calendrier des évènements</span
						>
					</li>
				</ul>
			</div>
		</div>
	</section>
</div>
