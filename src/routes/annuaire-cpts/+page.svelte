<script lang="ts">
	import Seo from '$lib/components/Seo/Seo.svelte';
	import Fa from 'svelte-fa';
	import { faSquareCheck, faArrowUpRightFromSquare } from '@fortawesome/free-solid-svg-icons';

	/**
	 * Sells the annuaire as a standalone app. Deliberately does NOT describe
	 * the full website offer: /site-internet-cpts covers that, and two pages
	 * repeating each other would compete for the same queries and rank for
	 * neither. The link between them is one sentence each way.
	 */
	const liste = '/images/offres/annuaire_cpts_liste_1.png';
	const carte = '/images/offres/annuaire_cpts_carte_2.jpg';
	const entree = '/images/offres/annuaire_cpts_entree_6.jpg';
	const creation = '/images/offres/annuaire_cpts_creation_fiche_4.png';
	const situation = '/images/offres/annuaire_cpts_situation_3.png';
</script>

<Seo
	title="Annuaire CPTS: logiciel annuaire et intranet pour votre territoire"
	description="Logiciel d'annuaire pour CPTS: fiches des professionnels de santé du territoire, cartographie, accès intranet réservé aux membres et aide aux parcours de soins. Démo gratuite."
	image="/images/offres/annuaire_cpts_liste_1.png"
/>

<div class="container max-w-3xl mx-auto p-4 space-y-10">
	<header class="space-y-4 text-center">
		<h1 class="h1">Annuaire et intranet pour CPTS</h1>
		<p class="text-lg">
			Un annuaire deux en un: public pour les habitants, intranet pour vos membres. La CPTS
			et les professionnels créent et mettent à jour les fiches eux-mêmes.
		</p>
		<div class="flex flex-wrap justify-center gap-4">
			<a class="btn variant-filled-primary" href="/annuaire-cpts/demo">
				Tester l'annuaire gratuitement
			</a>
			<a class="btn variant-ghost" href="/contact">Demander un devis</a>
		</div>
	</header>

	<section class="space-y-4">
		<h2 class="h2">Annuaire deux en un: public et intranet</h2>
		<img
			class="rounded-container-token mx-auto max-w-sm w-full"
			src={liste}
			width="600"
			height="1299"
			alt="Liste des entrées de l'annuaire de la CPTS Opale Sud"
			loading="lazy"
		/>
		<p>
			La CPTS et les membres créent et mettent à jour les fiches. L'accès à certaines données
			(téléphone, mail, site web, réseaux sociaux) peut être réservé aux membres de la CPTS ou
			aux administrateurs: un même annuaire sert le grand public et vos échanges internes.
		</p>
		<p>
			La page d'accueil liste toutes les fiches synthétiques. De nombreux sélecteurs permettent
			d'affiner la recherche: catégorie, commune, établissement, situation, recherche par nom.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Cartographie des ressources du territoire</h2>
		<img
			class="rounded-container-token mx-auto max-w-sm w-full"
			src={carte}
			width="600"
			height="1299"
			alt="Cartographie des infirmières d'une CPTS"
			loading="lazy"
		/>
		<p>
			Les entrées sélectionnées peuvent être visualisées sous forme de carte. Tous les
			sélecteurs restent actifs et mettent à jour les ressources affichées automatiquement. Un
			clic ouvre une description de l'entrée avec un lien vers la fiche complète.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Les professionnels de votre communauté sous les projecteurs</h2>
		<img
			class="rounded-container-token mx-auto max-w-sm w-full"
			src={entree}
			width="600"
			height="1300"
			alt="Une entrée de l'annuaire en version mobile, mode sombre"
			loading="lazy"
		/>
		<p>
			Notre annuaire met en valeur chaque membre de la CPTS. Les professionnels ou les
			structures qui n'ont pas de site web apprécieront d'avoir une présence en ligne grâce à
			l'annuaire. Chaque entrée a sa propre adresse web et chaque fiche est optimisée pour les
			moteurs de recherche.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Créer et mettre à jour vous-même votre annuaire</h2>
		<img
			class="rounded-container-token mx-auto max-w-sm w-full"
			src={creation}
			width="600"
			height="1299"
			alt="Création d'une personne lors de la création d'une entrée"
			loading="lazy"
		/>
		<p>
			Vous connaissez le territoire, ses professionnels de santé et ses structures
			médico-sociales mieux que personne. L'annuaire vous permet de créer un établissement et
			une personne pour faire apparaître immédiatement une nouvelle entrée.
		</p>
		<p>
			Si vous ajoutez le mail de la personne (qui peut rester privé, visible seulement par les
			administrateurs), elle pourra accéder directement à sa propre fiche, la compléter et la
			mettre à jour elle-même. Chaque professionnel devient acteur de la communauté.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Un outil pour les parcours de soins: les situations</h2>
		<img
			class="rounded-container-token mx-auto max-w-sm w-full"
			src={situation}
			width="600"
			height="1299"
			alt="Situation « chute à domicile » avec l'adresse de l'usager"
			loading="lazy"
		/>
		<p>
			L'annuaire peut devenir une solution d'aide aux parcours de soins si vous activez le
			sélecteur de situation. Chaque situation fait apparaître la liste des professionnels et
			structures utiles à la prise en charge, les plus proches du domicile du patient, avec la
			distance et une carte des ressources disponibles.
		</p>
		<p>
			Cette application est née d'une commande: en 2023, une CPTS nous a choisis pour créer un
			outil au service du parcours de soins des personnes âgées. Nous pouvons effectuer des
			modifications sur mesure pour répondre à vos besoins.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Ce que comprend l'annuaire</h2>
		<ul class="list space-y-2">
			{#each [
				'annuaire des membres modifiable par le coordinateur ou par les membres eux-mêmes',
				'cartographie des membres, de leurs sites et de leurs établissements',
				'page détaillée dédiée à chaque membre, avec sa propre adresse web',
				'accès intranet: certaines données réservées aux membres ou aux administrateurs',
				'sélecteurs par catégorie, commune, établissement, situation et nom',
				"sélecteur de situations pour l'aide aux parcours de soins",
				'hébergement, sauvegardes et mises à jour assurés par nos soins'
			] as item}
				<li>
					<span class="text-primary-500"><Fa icon={faSquareCheck} /></span>
					<span>{item}</span>
				</li>
			{/each}
		</ul>
	</section>

	<section class="card variant-ghost p-6 space-y-4">
		<h2 class="h2">Déjà un site web? L'annuaire s'y branche</h2>
		<p>
			L'annuaire fonctionne seul, sur un sous-domaine de votre CPTS — comme
			<a
				class="anchor"
				href="https://annuaire.cptsopalesud.fr"
				target="_blank"
				rel="noopener noreferrer"
			>
				annuaire.cptsopalesud.fr
				<span class="text-xs"><Fa icon={faArrowUpRightFromSquare} /></span>
			</a>. Vous gardez votre site existant.
		</p>
		<p>
			Si vous cherchez plutôt le site web complet de votre CPTS, avec une page par mission
			socle et par groupe de travail, voyez
			<a class="anchor" href="/site-internet-cpts">notre offre de site internet pour CPTS</a>:
			l'annuaire y est intégré.
		</p>
	</section>

	<section class="text-center space-y-4">
		<h2 class="h2">Testez l'annuaire, gratuitement et sans engagement</h2>
		<a class="btn btn-lg variant-filled-primary" href="/annuaire-cpts/demo">
			Accéder au bac à sable
		</a>
	</section>
</div>
