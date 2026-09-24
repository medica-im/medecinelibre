<script lang="ts">
	import Seo from '$lib/components/Seo/Seo.svelte';
	import Fa from 'svelte-fa';
	import ExternalLink from '$lib/components/Link/ExternalLink.svelte';
	import YouTube from '$lib/components/Video/YouTube.svelte';
	import { faSquareCheck } from '@fortawesome/free-solid-svg-icons';

	/**
	 * Sells the annuaire as a standalone app. Deliberately does NOT describe
	 * the full website offer: /site-internet-cpts covers that, and two pages
	 * repeating each other would compete for the same queries and rank for
	 * neither. The link between them is one sentence each way.
	 */
	const liste = '/images/offres/annuaire_cpts_liste_1.webp';
	const carte = '/images/offres/annuaire_cpts_carte_2.webp';
	const entree = '/images/offres/annuaire_cpts_entree_6.webp';
	const creation = '/images/offres/annuaire_cpts_creation_fiche_4.webp';
	const situation = '/images/offres/annuaire_cpts_situation_3.webp';
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
			Toutes les données sont hébergées dans l'Union européenne.
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
			Deux façons de faire, selon ce qui vous arrange. La coordinatrice peut envoyer une
			invitation à un membre: celui-ci crée alors lui-même son entrée de A à Z.
		</p>
		<p>
			Elle peut aussi créer l'entrée et y ajouter l'adresse mail du propriétaire de l'entrée,
			qui reste toujours confidentielle. Le propriétaire est alors reconnu quand il se
			connecte, et peut compléter ou modifier sa fiche. Chaque professionnel devient acteur de
			la communauté.
		</p>
		<p>
			Voici ce que voit un professionnel qui met sa fiche à jour — photo, coordonnées,
			horaires — sans intervention de notre part:
		</p>
		<YouTube
			id="WWhcxm2aEdk"
			title="Annuaire CPTS/MSP: comment éditer votre fiche, ajouter une photo et vos coordonnées"
			description="Tutoriel: comment un professionnel de santé met à jour sa propre fiche dans l'annuaire d'une CPTS ou d'une MSP — photo, coordonnées et informations pratiques."
		/>
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
				'annuaire des membres modifiable par la coordinatrice ou par les membres eux-mêmes',
				'cartographie des membres et de leurs établissements',
				'page détaillée dédiée à chaque membre, avec sa propre adresse web',
				'accès intranet: certaines données réservées aux membres ou aux administrateurs',
				'sélecteurs par catégorie, commune, établissement, situation et nom',
				"sélecteur de situations pour l'aide aux parcours de soins",
				'hébergement dans l’Union européenne, sauvegardes et mises à jour assurés par nos soins',
				'un annuaire qui évolue: corrections rapides et nouvelles fonctionnalités selon vos besoins'
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
			L'annuaire n'impose pas de refaire votre site. Il fonctionne seul et s'intègre à ce que
			vous avez déjà, de deux façons.
		</p>
		<h3 class="h4">Sur un sous-domaine</h3>
		<p>
			L'annuaire vit sur son propre sous-domaine, comme
			<ExternalLink href="https://annuaire.cptsopalesud.fr" />. Votre site actuel n'est pas
			touché: vous ajoutez simplement un lien vers l'annuaire.
		</p>
		<h3 class="h4">Intégré dans un site existant, y compris WordPress</h3>
		<p>
			L'annuaire peut aussi apparaître comme une rubrique de votre site actuel, à une adresse
			du type <code class="code">votresite.fr/annuaire</code>. Pour les visiteurs comme pour
			les moteurs de recherche, c'est une page de votre site: même domaine, même navigation.
		</p>
		<p>
			C'est ce que nous avons mis en place pour l'UNIPA — l'Union Nationale des Infirmiers en
			Pratique Avancée — sur son site WordPress:
			<ExternalLink href="https://unipa.fr/annuaire" />. Le WordPress continue de vivre
			normalement, et l'annuaire est servi sous le même nom de domaine.
		</p>
		<p>
			Si vous cherchez plutôt le site web complet de votre CPTS, avec une page par mission
			socle et par groupe de travail, voyez
			<a class="anchor" href="/site-internet-cpts">notre offre de site internet pour CPTS</a>:
			l'annuaire y est intégré.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Pas seulement pour les CPTS</h2>
		<p>
			Le même annuaire sert d'annuaire des adhérents aux syndicats, unions et fédérations du
			secteur de la santé, comme celui de l'UNIPA:
			<a class="anchor" href="/annuaire-adherents">annuaire des adhérents pour organisations
				professionnelles</a>.
		</p>
	</section>

	<section class="text-center space-y-4">
		<h2 class="h2">Testez l'annuaire, gratuitement et sans engagement</h2>
		<a class="btn btn-lg variant-filled-primary" href="/annuaire-cpts/demo">
			Accéder au bac à sable
		</a>
	</section>
</div>
