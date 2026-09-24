<script lang="ts">
	import Seo from '$lib/components/Seo/Seo.svelte';
	import Fa from 'svelte-fa';
	import ExternalLink from '$lib/components/Link/ExternalLink.svelte';
	import { faSquareCheck } from '@fortawesome/free-solid-svg-icons';

	const accueil = '/images/offres/accueil_msp_v2.webp';
	const annuaireMobile = '/images/offres/annuaire_mobile_msp.webp';
	const multiSites = '/images/offres/msp_multi_sites_v2.webp';
	const siteDetail = '/images/offres/msp_site_v2.webp';

	const preventionLinks = [
		{ href: 'https://sante-gadagne.fr/prevention/vaccins', label: 'Vaccination' },
		{
			href: 'https://sante-gadagne.fr/prevention/depistage-cancer-colorectal',
			label: 'Dépistage du cancer colo-rectal'
		},
		{
			href: 'https://sante-gadagne.fr/education-therapeutique/polypathologie',
			label: 'ETP polypathologie'
		},
		{
			href: 'https://msp-vedene.fr/education-therapeutique/cancer',
			label: 'HOPE: accompagnement pendant un cancer'
		},
		{
			href: 'https://msp-vedene.fr/education-therapeutique/ecole-du-dos',
			label: 'École du dos'
		}
	];
</script>

<Seo
	title="Site internet pour MSP, centre de santé et cabinet de groupe"
	description="Création du site internet de votre maison de santé pluriprofessionnelle: annuaire de l'équipe, pages établissements multi-sites, prévention et éducation thérapeutique, mises à jour mensuelles."
	image="/images/offres/accueil_msp_v2.jpg"
/>

<div class="container max-w-3xl mx-auto p-4 space-y-10">
	<header class="space-y-4 text-center">
		<h1 class="h1">Site internet pour maison de santé pluriprofessionnelle</h1>
		<p class="text-lg">
			Un site professionnel pour votre MSP, votre centre de santé ou votre cabinet de groupe —
			actualisé en continu, pas livré puis oublié.
		</p>
		<div class="flex flex-wrap justify-center gap-4">
			<a class="btn variant-filled-primary" href="/contact">Demander un devis gratuit</a>
			<ExternalLink
				href="https://sante-gadagne.fr"
				label="Voir un site en production"
				class="btn variant-ghost"
			/>
		</div>
	</header>

	<section class="space-y-4">
		<h2 class="h2">Un site actualisé en continu</h2>
		<img
			class="rounded-container-token w-full"
			src={accueil}
			width="1215"
			height="892"
			alt="Page d'accueil du site de la MSP de Gadagne"
			loading="lazy"
		/>
		<p>
			Nous mettons l'accent sur les mises à jour: chaque mois, nous rédigeons un nouveau billet
			de blog, nous mettons à jour les pages existantes et nous créons de nouvelles pages pour
			accompagner vos nouveaux projets.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Votre équipe sous les projecteurs</h2>
		<img
			class="rounded-container-token mx-auto max-w-sm w-full"
			src={annuaireMobile}
			width="600"
			height="1300"
			alt="Annuaire de l'équipe en version mobile"
			loading="lazy"
		/>
		<p>
			Notre annuaire met en valeur chaque membre de votre équipe. Les mises à jour sont rapides
			et efficaces: elles peuvent être effectuées par nos soins, par le professionnel
			lui-même ou par la coordinatrice via l'interface d'administration.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Multi-sites</h2>
		<img
			class="rounded-container-token w-full"
			src={multiSites}
			width="1217"
			height="869"
			alt="Liste des établissements d'une MSP multi-sites"
			loading="lazy"
		/>
		<img
			class="rounded-container-token w-full"
			src={siteDetail}
			width="1216"
			height="812"
			alt="Page de détail d'un établissement"
			loading="lazy"
		/>
		<p>
			Notre framework est adapté aux MSP multisites. Chaque établissement dispose d'une page de
			présentation incluant la liste des professionnels qui y exercent.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Prévention, éducation en santé, éducation thérapeutique</h2>
		<p>
			Nous rédigeons ensemble les pages qui présentent vos actions et vos programmes en faveur
			de la santé des habitants. Quelques exemples en production:
		</p>
		<ul class="list space-y-2">
			{#each preventionLinks as link}
				<li>
					<span class="text-primary-500"><Fa icon={faSquareCheck} /></span>
					<ExternalLink href={link.href} label={link.label} />
				</li>
			{/each}
		</ul>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Ce que comprend le site</h2>
		<ul class="list space-y-2">
			{#each [
				"annuaire de l'équipe, éditable par les professionnels ou la coordinatrice",
				'pages établissements pour les MSP multi-sites',
				'pages prévention, éducation en santé et éducation thérapeutique',
				'blog et actualités, rédigés avec vous chaque mois',
				'outils collaboratifs accessibles aux membres après connexion',
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

	<section class="space-y-4">
		<h2 class="h2">Nous connaissons le terrain</h2>
		<p>
			Jérôme Pinguet, qui dirige Médecine Libre, est médecin généraliste et a remplacé pendant
			des années dans des structures pluriprofessionnelles. Cette expérience de l'interpro nous
			permet de collaborer efficacement avec votre équipe et de mettre rapidement en ligne un
			site de qualité, sans accaparer votre temps.
		</p>
		<p><a class="anchor" href="/a-propos">En savoir plus sur nous</a>.</p>
	</section>

	<section class="text-center space-y-4">
		<h2 class="h2">Discutons du futur site de votre MSP</h2>
		<p>Devis gratuit, sans engagement.</p>
		<a class="btn btn-lg variant-filled-primary" href="/contact">Nous contacter</a>
	</section>
</div>
