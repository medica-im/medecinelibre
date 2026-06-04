<script lang="ts">
	import { page } from '$app/stores';
	import { Avatar, CodeBlock } from '@skeletonlabs/skeleton';
	import parcours from '$lib/assets/images/parcours-de-soins.png';
	import Fa from 'svelte-fa';
	import { faSquareCheck, faArrowUpRightFromSquare, faGlobe } from '@fortawesome/free-solid-svg-icons';
</script>

<svelte:head>
	<title
		>Site & annuaire pour CPTS - {import.meta.env
			.VITE_SITE_TITLE}</title
	>
</svelte:head>
<div class="container max-w-3xl mx-auto p-4 space-y-6 lg:space-y-10">
	<div class="flex justify-center p-2 background-initial">
		<div class="space-y-10 text-center flex flex-col items-center">
			<h2 class="h2">Communautés professionnelles territoriales de santé (CPTS)</h2>
		</div>
	</div>

	<section class="bg-surface-100-800-token">
		<div class="card p-2 variant-ghost">
			<div class="card-header text-center">
				<h3 class="h3">Annuaire CPTS & parcours de soins coordonnés</h3>
			</div>
			<div class="p-4 space-y-4 text-center">
				<img
					class="p-2"
					src={parcours}
					alt="capture d'écran de l'application annuaire parcours de soins coordonnés sur le site web lié"
				/>
				<p>
					Nous avons créé une application de gestion du parcours de soins coordonnés des personnes
					âgées, qui peut également être utilisée pour d'autres parcours de soins ou comme annuaire
					des membres d'une CPTS. Nous pouvons effectuer des modifications sur mesure pour répondre
					parfaitement à vos besoins.
				</p>
				<p>Vous pouvez voir un exemple d'utilisation de cette application web sur le site de la CPTS Opale Sud.</p>
				<a href="https://annuaire.cptsopalesud.fr" class="btn btn-lg variant-filled"
					><span class="w-6 text-center"><Fa icon={faGlobe} /></span>
					<span>annuaire.cptsopalesud.fr</span></a
				>
				<p>Pour tester l'annuaire, rendez-vous sur le site de la CPTS Virtuelle! Cette page est un "bac à sable" ou banc d'essai: vous pouvez ajouter des entrées, les modifier et les supprimer. Vous pouvez vous connecter avec un compte Google existant, il n'est pas nécessaire de créer un compte. Le test est gratuit et sans engagement.</p>
				<a href="https://annuaire.medica.im" class="btn btn-lg variant-filled">
					<span class="w-6 text-center"><Fa icon={faArrowUpRightFromSquare} /></span>
					<span>Je teste l'annuaire!</span>
				</a>
			</div>
		</div>
	</section>

	<section class="bg-surface-100-800-token">
		<div class="card p-2 variant-ghost">
			<div class="card-header text-center">
				<h3 class="h3">Site web pour CPTS</h3>
			</div>
			<div class="p-4 text-center space-y-4">
				<p>Nous construirons rapidement un site web de haute qualité pour votre CPTS.</p>
				<ul class="list [&>li]:items-start [&>li>span:first-child]:mt-1">
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
					<li>
						<span><Fa icon={faSquareCheck} /></span>

						<span class="flex flex-wrap whitespace-normal text-left">page bureau et conseil d'administration éditable par l'équipe de coordination</span
						>
					</li>
				</ul>
				<a href="https://santelyon3.fr" class="btn btn-lg variant-filled">
					<span class="w-6 text-center"><Fa icon={faGlobe} /></span>
					<span>CPTS Lyon 3</span>
				</a>
			</div>
		</div>
	</section>
</div>
