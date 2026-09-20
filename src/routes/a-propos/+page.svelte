<script lang="ts">
	import Seo from '$lib/components/Seo/Seo.svelte';
	import Fa from 'svelte-fa';
	import { faArrowUpRightFromSquare } from '@fortawesome/free-solid-svg-icons';

	/**
	 * The company history here came from /pluripro/web, which this structure
	 * retires. It is the strongest credibility material on the site — a real
	 * track record from 2012 onward — and would have been lost if that page
	 * had simply been deleted.
	 */
</script>

<Seo
	title="À propos: une entreprise dirigée par un médecin généraliste"
	description="Médecine Libre crée depuis 2012 des applications et des sites web pour les professionnels de santé, les MSP et les CPTS. Dirigée par Jérôme Pinguet, médecin généraliste."
/>

<div class="container max-w-3xl mx-auto p-4 space-y-10">
	<header class="space-y-4 text-center">
		<h1 class="h1">Une entreprise du numérique en santé, dirigée par un médecin</h1>
		<p class="text-lg">
			Je suis Jérôme Pinguet, médecin généraliste et dirigeant de Médecine Libre. Nous créons
			depuis plus de dix ans des applications et des sites web pour les professionnels de
			santé, les MSP et les CPTS.
		</p>
	</header>

	<section class="space-y-4">
		<h2 class="h2">Notre parcours</h2>
		<p>
			Depuis 2012, Médecine Libre est spécialisée dans la création de solutions numériques pour
			les professionnels de santé libéraux. Nous avons participé au développement des logiciels
			de gestion de cabinet médical et de prescription FreeMedForms, puis FreeHealth EHR.
		</p>
		<p>
			En 2017, nous avons créé le robot @doctoctocbot, un compte automatisé qui facilite les
			échanges — questions et réponses — entre professionnels de santé. Nous avons étendu cette
			télé-expertise communautaire aux pharmaciens, aux infirmières, aux kinésithérapeutes puis
			aux sages-femmes, en créant quatre robots supplémentaires. Ce réseau collaboratif
			interprofessionnel, baptisé SantéTocToc, rassemble aujourd'hui près de 10 000
			professionnels de santé.
		</p>
		<p>
			En 2022, reconnaissant notre expertise du numérique en santé et notre expérience de
			l'interpro, une maison de santé pluriprofessionnelle multisite regroupant plus de 40
			professionnels nous a confié la création de son site web et d'un outil de gestion des
			ateliers d'éducation en santé, d'éducation thérapeutique et de prévention.
		</p>
		<p>
			En 2023, une communauté professionnelle territoriale de santé nous a choisis pour la
			création d'un outil innovant au service du parcours de soins des personnes âgées: un
			annuaire intelligent qui guide les professionnels du territoire vers les ressources les
			plus pertinentes et les plus proches selon le problème médico-social rencontré par la
			personne prise en soin à domicile.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Pourquoi cela change la collaboration</h2>
		<p>
			J'ai remplacé pendant des années dans des structures pluriprofessionnelles. Cette
			connaissance du terrain nous permet de comprendre vos contraintes sans traduction: nous
			savons ce qu'est une mission socle, un ACI, une réunion de concertation
			pluriprofessionnelle. Nous mettons rapidement en ligne un site de qualité sans accaparer
			votre temps et sans vous solliciter pour le moindre détail.
		</p>
		<p>
			Nous avons conçu et codé nos outils de A à Z: nous pouvons donc corriger d'éventuels bugs
			immédiatement et les adapter rapidement à vos besoins.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Un accompagnement sur le long terme</h2>
		<p>
			Nous ne livrons pas un site pour disparaître ensuite. Chaque mois, nous rédigeons un
			billet de blog, mettons à jour les pages existantes et créons de nouvelles pages pour
			accompagner vos nouveaux projets. Nous vous conseillons aussi sur votre communication
			interne et externe: ce qu'il vaut la peine de publier, pour quel public, et à quel
			rythme.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Nos réalisations</h2>
		<p>
			Le plus simple est de regarder ce que nous avons livré:
			<a class="anchor" href="/realisations">voir nos réalisations</a>.
		</p>
	</section>

	<section class="space-y-4">
		<h2 class="h2">Nous suivre</h2>
		<ul class="list space-y-2">
			<li>
				<a
					class="anchor"
					href="https://www.linkedin.com/in/jerome-pinguet/"
					target="_blank"
					rel="noopener noreferrer"
				>
					LinkedIn <span class="text-xs"><Fa icon={faArrowUpRightFromSquare} /></span>
				</a>
			</li>
			<li>
				<a
					class="anchor"
					href="https://bsky.app/profile/medecinelibre.bsky.social"
					target="_blank"
					rel="noopener noreferrer"
				>
					Bluesky <span class="text-xs"><Fa icon={faArrowUpRightFromSquare} /></span>
				</a>
			</li>
			<li>
				<a
					class="anchor"
					href="https://www.youtube.com/@medecinelibre"
					target="_blank"
					rel="noopener noreferrer"
				>
					YouTube <span class="text-xs"><Fa icon={faArrowUpRightFromSquare} /></span>
				</a>
			</li>
		</ul>
	</section>

	<section class="text-center space-y-4">
		<h2 class="h2">Parlons de votre projet</h2>
		<a class="btn btn-lg variant-filled-primary" href="/contact">Nous contacter</a>
	</section>
</div>
