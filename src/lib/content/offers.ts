/**
 * Shared facts about the offers, so the landing pages, the homepage cards
 * and the sitemap cannot disagree about what exists or what it is called.
 */

export interface Offer {
	/** Route path, without trailing slash. */
	href: string;
	/** Short label for nav and homepage cards. */
	label: string;
	/** H1 / card heading. */
	heading: string;
	/** One-sentence pitch, also used as the meta description seed. */
	pitch: string;
	/** Who this is for, shown on the homepage card. */
	audience: string;
}

export const offers: Offer[] = [
	{
		href: '/annuaire-cpts',
		label: 'Annuaire CPTS',
		heading: 'Annuaire et intranet pour CPTS',
		pitch:
			"Un annuaire des professionnels de santé du territoire, public et intranet, avec cartographie, fiches détaillées et aide aux parcours de soins.",
		audience: 'CPTS qui veulent un annuaire, avec ou sans site web'
	},
	{
		href: '/site-internet-cpts',
		label: 'Site internet CPTS',
		heading: 'Site internet pour CPTS',
		pitch:
			"Le site web complet de votre CPTS: une page par mission socle, une page par groupe de travail, annuaire intégré et espace membres.",
		audience: 'CPTS qui veulent un site web complet'
	},
	{
		href: '/site-internet-msp',
		label: 'Site internet MSP',
		heading: 'Site internet pour maison de santé pluriprofessionnelle',
		pitch:
			"Un site professionnel pour votre MSP, centre de santé ou cabinet de groupe: annuaire de l'équipe, multi-sites, prévention et éducation thérapeutique.",
		audience: 'MSP, centres de santé, cabinets de groupe'
	},
	{
		href: '/teleexpertise',
		label: 'Télé-expertise',
		heading: 'Télé-expertise interprofessionnelle',
		pitch:
			"SantéTocToc, le réseau d'entraide interprofessionnelle qui rassemble près de 10 000 professionnels de santé francophones.",
		audience: 'Professionnels de santé, à titre individuel'
	}
];

/** Client work, shown on /realisations and linked from the landing pages. */
export interface Realisation {
	slug: string;
	name: string;
	kind: string;
	url: string;
	summary: string;
}

export const realisations: Realisation[] = [
	{
		slug: 'cpts-opale-sud',
		name: 'CPTS Opale Sud',
		kind: 'Annuaire et parcours de soins',
		url: 'https://annuaire.cptsopalesud.fr',
		summary:
			"Annuaire des professionnels du territoire avec cartographie, accès intranet et sélecteur de situations pour orienter les parcours de soins."
	},
	{
		slug: 'cpts-lyon-3',
		name: 'CPTS Lyon 3ème',
		kind: 'Site internet complet',
		url: 'https://santelyon3.fr',
		summary:
			"Site complet avec une page par mission socle et par groupe de travail: un tableau de bord vivant plutôt qu'une vitrine figée."
	},
	{
		slug: 'unipa',
		name: 'UNIPA',
		kind: 'Annuaire intégré à un site WordPress',
		url: 'https://unipa.fr/annuaire',
		summary:
			"Union Nationale des Infirmiers en Pratique Avancée: l'annuaire des adhérents est servi comme une rubrique de leur site WordPress existant, sous le même nom de domaine. Le site reste en place, l'annuaire s'ajoute à /annuaire."
	},
	{
		slug: 'msp-gadagne',
		name: 'MSP de Gadagne',
		kind: 'Site internet MSP multi-sites',
		url: 'https://sante-gadagne.fr',
		summary:
			"Site multi-sites avec annuaire de l'équipe, pages établissements, prévention et éducation thérapeutique, actualisé en continu."
	},
	{
		slug: 'msp-vedene',
		name: 'MSP de Vedène',
		kind: 'Site internet MSP multi-sites',
		url: 'https://msp-vedene.fr',
		summary:
			"Site multi-sites d'une MSP de plus de 40 professionnels: annuaire de l'équipe, pages établissements, prévention et éducation thérapeutique."
	}
];
