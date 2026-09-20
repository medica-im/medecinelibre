<script lang="ts">
	import Seo from '$lib/components/Seo/Seo.svelte';
	import Fa from 'svelte-fa';
	import { faSquareCheck, faArrowUpRightFromSquare } from '@fortawesome/free-solid-svg-icons';

	/**
	 * Sells the full website package. The annuaire is part of it, but gets two
	 * sentences and a link to /annuaire-cpts rather than a repeat of its
	 * feature list — otherwise the two pages compete for the same queries.
	 */
</script>

<Seo
	title="Site internet pour CPTS: site web complet et outil de pilotage"
	description="Création du site internet de votre CPTS: une page par mission socle, une page par groupe de travail, espace membres, annuaire intégré et mises à jour en continu."
/>

<div class="container max-w-3xl mx-auto p-4 space-y-10">
	<header class="space-y-4 text-center">
		<h1 class="h1">Site internet pour CPTS</h1>
		<p class="text-lg">
			Bien plus qu'une vitrine: un véritable outil de pilotage pour votre communauté
			professionnelle territoriale de santé.
		</p>
		<div class="flex flex-wrap justify-center gap-4">
			<a class="btn variant-filled-primary" href="/contact">Demander un devis gratuit</a>
			<a
				class="btn variant-ghost"
				href="https://santelyon3.fr"
				target="_blank"
				rel="noopener noreferrer"
			>
				<span>Voir le site de la CPTS Lyon 3ème</span>
				<span class="text-xs"><Fa icon={faArrowUpRightFromSquare} /></span>
			</a>
		</div>
	</header>

	<section class="space-y-4">
		<h2 class="h2">Une page par mission socle, une page par groupe de travail</h2>
		<p>
			Nous créons une page dédiée à chacune des quatre missions socles — accès aux soins,
			parcours pluriprofessionnels, prévention, qualité et pertinence des soins — ainsi qu'une
			page par groupe de travail.
		</p>
		<p>
			Vos référents et vos groupes disposent ainsi d'un espace pour suivre l'avancement des
			projets, partager les comptes rendus et les documents, et coordonner les actions de la
			communauté. Le site devient le tableau de bord vivant de l'organisation, et non une
			simple présentation figée.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Un site actualisé en continu</h2>
		<p>
			Nous mettons l'accent sur les mises à jour: chaque mois, nous rédigeons un nouveau billet
			de blog, nous mettons à jour les pages existantes et nous créons de nouvelles pages pour
			accompagner vos nouveaux projets. Vous n'avez pas à nous solliciter pour le moindre
			détail.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Ce que comprend le site</h2>
		<ul class="list space-y-2">
			{#each [
				'page par mission socle et par groupe de travail',
				'espace membres accessible après connexion',
				'page bureau et conseil d’administration éditable par l’équipe de coordination',
				'blog et actualités, rédigés avec vous chaque mois',
				'agenda des réunions et des actions',
				'annuaire des membres intégré',
				'hébergement, nom de domaine, sauvegardes et mises à jour',
				'conseil et accompagnement sur votre communication interne et externe'
			] as item}
				<li>
					<span class="text-primary-500"><Fa icon={faSquareCheck} /></span>
					<span>{item}</span>
				</li>
			{/each}
		</ul>
	</section>

	<section class="card variant-ghost p-6 space-y-4">
		<h2 class="h2">Annuaire intégré</h2>
		<p>
			Le site inclut l'annuaire des professionnels du territoire, avec cartographie et accès
			intranet. C'est la même application que celle que nous vendons séparément.
		</p>
		<p>
			<a class="anchor" href="/annuaire-cpts">Voir le détail de l'annuaire CPTS</a> — ses
			fonctionnalités, ses captures d'écran et sa démo gratuite.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Nous connaissons le terrain</h2>
		<p>
			Notre expérience et notre connaissance du domaine nous permettent de collaborer
			efficacement avec votre équipe: Jérôme Pinguet, qui dirige Médecine Libre, est médecin
			généraliste et a remplacé pendant des années dans des structures pluriprofessionnelles.
		</p>
		<p>
			Nous mettrons rapidement en ligne un site de qualité, sans accaparer votre temps.
			<a class="anchor" href="/a-propos">En savoir plus sur nous</a>.
		</p>
	</section>

	<section class="text-center space-y-4">
		<h2 class="h2">Discutons du futur site de votre CPTS</h2>
		<p>Devis gratuit, sans engagement.</p>
		<a class="btn btn-lg variant-filled-primary" href="/contact">Nous contacter</a>
	</section>
</div>
