<script lang="ts">
	import Seo from '$lib/components/Seo/Seo.svelte';
	import ExternalLink from '$lib/components/Link/ExternalLink.svelte';
	import Fa from 'svelte-fa';
	import { faSquareCheck } from '@fortawesome/free-solid-svg-icons';

	/**
	 * For professional organisations of the health sector — syndicats, unions,
	 * fédérations — as opposed to care teams (MSP) or territories (CPTS).
	 *
	 * The engine is the same annuaire as /annuaire-cpts; what differs is the
	 * buyer and the query: a membership directory, national rather than
	 * territorial, usually added to a site the organisation already has. The
	 * feature detail lives on /annuaire-cpts and is linked, not repeated, so
	 * the two pages do not compete.
	 */
	const carte = '/images/offres/unipa_annuaire_carte.webp';
</script>

<Seo
	title="Annuaire des adhérents pour syndicats et organisations professionnelles de santé"
	description="Un annuaire de vos adhérents intégré à votre site, même sous WordPress: fiches mises à jour par les membres, données réservées aux adhérents, carte nationale. Hébergé dans l'Union européenne."
	image="/images/offres/unipa_annuaire_carte.jpg"
/>

<div class="container max-w-3xl mx-auto p-4 space-y-10">
	<header class="space-y-4 text-center">
		<h1 class="h1">Annuaire des adhérents pour organisations professionnelles de santé</h1>
		<p class="text-lg">
			Syndicats, unions, fédérations: publiez l'annuaire de vos adhérents sur votre propre
			site, et réservez à vos membres les informations qui ne regardent qu'eux.
		</p>
		<div class="flex flex-wrap justify-center gap-4">
			<a class="btn variant-filled-primary" href="/contact">Demander un devis gratuit</a>
			<ExternalLink
				href="https://unipa.fr/annuaire"
				label="Voir l'annuaire de l'UNIPA"
				class="btn variant-ghost"
			/>
		</div>
	</header>

	<section class="space-y-4">
		<h2 class="h2">Intégré à votre site, même sous WordPress</h2>
		<figure class="space-y-2">
			<img
				class="rounded-container-token w-full border border-surface-500/20"
				src={carte}
				width="1600"
				height="1000"
				alt="Annuaire des adhérents de l'UNIPA, vue carte, servi à l'adresse unipa.fr/annuaire sous le menu du site de l'union"
				loading="lazy"
			/>
			<figcaption class="text-center text-sm opacity-75">
				L'annuaire de l'UNIPA en vue carte, à l'adresse unipa.fr/annuaire, sous le menu du
				site de l'union.
			</figcaption>
		</figure>
		<p>
			Vous n'avez pas à refaire votre site. L'annuaire s'ajoute comme une rubrique, à une
			adresse du type <code class="code">votresite.fr/annuaire</code>: même nom de domaine,
			même menu. Pour vos adhérents comme pour les moteurs de recherche, c'est une page de
			votre site.
		</p>
		<p>
			C'est ce que nous avons mis en place pour l'UNIPA, l'Union Nationale des Infirmiers en
			Pratique Avancée: leur site WordPress continue de vivre normalement, et l'annuaire des
			adhérents est servi sous <ExternalLink href="https://unipa.fr/annuaire" />.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Des fiches tenues à jour par vos adhérents</h2>
		<p>
			Votre équipe peut inviter un adhérent, qui crée alors lui-même sa fiche. Elle peut aussi
			créer la fiche et y associer l'adresse mail de l'adhérent, qui reste toujours
			confidentielle: il est reconnu quand il se connecte et complète ou corrige sa fiche.
			L'annuaire reste juste sans que votre équipe ait à tout ressaisir.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Public pour certains champs, réservé aux adhérents pour d'autres</h2>
		<p>
			Le même annuaire sert à la fois de vitrine et d'outil interne. Le public trouve un
			professionnel par département, commune, catégorie ou nom, sur une liste ou sur une carte
			nationale. Les coordonnées que vous choisissez — téléphone, mail, réseaux sociaux —
			peuvent être réservées aux adhérents connectés ou aux administrateurs.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Ce que comprend l'annuaire</h2>
		<ul class="list space-y-2">
			{#each [
				'annuaire intégré à votre site existant, WordPress compris, sous votre nom de domaine',
				'fiches créées et mises à jour par les adhérents eux-mêmes, sur invitation',
				'données réservées aux adhérents connectés ou aux administrateurs',
				'recherche par département, commune, catégorie, établissement et nom',
				'vue liste et vue carte',
				'une adresse web par fiche, optimisée pour les moteurs de recherche',
				'hébergement dans l’Union européenne, sauvegardes et mises à jour assurés par nos soins',
				'un annuaire qui évolue: corrections rapides et nouvelles fonctionnalités selon vos besoins'
			] as item}
				<li>
					<span class="text-primary-500"><Fa icon={faSquareCheck} /></span>
					<span>{item}</span>
				</li>
			{/each}
		</ul>
		<p>
			C'est la même application que l'annuaire que nous réalisons pour les CPTS:
			<a class="anchor" href="/annuaire-cpts">voir le détail de ses fonctionnalités</a>.
		</p>
	</section>

	<section class="card variant-ghost p-6 space-y-4">
		<h2 class="h2">Et votre communication</h2>
		<p>
			Au-delà de l'annuaire, nous réalisons le site complet de votre organisation et vous
			accompagnons dans la durée: contenus mis à jour, communication interne avec vos
			adhérents, communication externe vers vos partenaires. Nous vous aidons à choisir quoi
			publier, pour qui et à quel rythme.
		</p>
		<p><a class="anchor" href="/a-propos">Qui sommes-nous</a></p>
	</section>

	<section class="text-center space-y-4">
		<h2 class="h2">Parlons de votre annuaire</h2>
		<p>Devis gratuit, sans engagement.</p>
		<div class="flex flex-wrap justify-center gap-4">
			<a class="btn btn-lg variant-filled-primary" href="/contact">Nous contacter</a>
			<a class="btn btn-lg variant-ghost" href="/annuaire-cpts/demo">Tester l'annuaire</a>
		</div>
	</section>
</div>
