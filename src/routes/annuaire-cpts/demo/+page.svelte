<script lang="ts">
	import Seo from '$lib/components/Seo/Seo.svelte';
	import Fa from 'svelte-fa';
	import { faArrowUpRightFromSquare } from '@fortawesome/free-solid-svg-icons';
</script>

<Seo
	title="Démo annuaire CPTS: testez gratuitement le bac à sable"
	description="Testez l'annuaire CPTS sur le site de la CPTS Virtuelle: ajoutez, modifiez et supprimez des entrées. Connexion avec un compte Google existant, gratuit et sans engagement."
	image="/images/offres/annuaire_cpts_liste_1.png"
/>

<div class="container max-w-3xl mx-auto p-4 space-y-8">
	<header class="space-y-4 text-center">
		<h1 class="h1">Tester l'annuaire CPTS</h1>
		<p class="text-lg">
			Pour tester l'annuaire, rendez-vous sur le site de la CPTS Virtuelle.
		</p>
	</header>

	<section class="card variant-ghost p-6 space-y-4">
		<p>
			Cette page est un « bac à sable » ou banc d'essai: vous pouvez ajouter des entrées, les
			modifier et les supprimer. Vous pouvez vous connecter avec un compte Google existant, il
			n'est pas nécessaire de créer un compte. Le test est gratuit et sans engagement.
		</p>
		<div class="flex flex-wrap gap-4">
			<a
				class="btn variant-filled-primary"
				href="https://annuaire.medica.im"
				target="_blank"
				rel="noopener noreferrer"
			>
				<span>Ouvrir la CPTS Virtuelle</span>
				<span class="text-xs"><Fa icon={faArrowUpRightFromSquare} /></span>
			</a>
			<a class="btn variant-ghost" href="/annuaire-cpts">Revoir l'offre annuaire</a>
		</div>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Un annuaire réel, en production</h2>
		<p>
			Le bac à sable est une copie libre de l'annuaire utilisé par de vraies CPTS. Pour voir
			l'application en usage réel, avec les données d'un territoire, consultez
			<a
				class="anchor"
				href="https://annuaire.cptsopalesud.fr"
				target="_blank"
				rel="noopener noreferrer"
			>
				l'annuaire de la CPTS Opale Sud
				<span class="text-xs"><Fa icon={faArrowUpRightFromSquare} /></span>
			</a>.
		</p>
		<p>
			Une question sur une fonctionnalité, ou un besoin spécifique à votre territoire?
			<a class="anchor" href="/contact">Écrivez-nous</a>: nous adaptons l'outil.
		</p>
	</section>
</div>
