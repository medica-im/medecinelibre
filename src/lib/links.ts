// Navigation Sitemap
// Navigation Links & Sitemap
import {
	faBars,
	faCaretDown,
	faInfo,
	faTimeline,
	faBookMedical,
	faHouse,
	faMapLocationDot,
	faAddressBook,
	faEnvelope,
	faBlog,
	faRightToBracket,
	faRightFromBracket,
	faUserPlus,
	faUser,
	faPersonChalkboard,
	faPills,
	faShieldHeart
} from '@fortawesome/free-solid-svg-icons';

export type List = Array<{ href: string; label: string; keywords: string; badge?: string }>;
export const menuNavLinks: Record<string, Array<{ title: string; list: List }>> = {
	'/cpts': [
		{
			title: 'CPTS',
			list: [
				{
					href: '/annuaire-cpts',
					label: 'Annuaire',
					keywords: 'annuaire, cpts, intranet, cartographie, parcours de soins'
				},
				{
					href: '/site-internet-cpts',
					label: 'Site internet',
					keywords: 'site, web, cpts, mission socle, groupe de travail'
				}
			]
		}
	],
	'/msp': [
		{
			title: 'MSP & centres de santé',
			list: [
				{
					href: '/site-internet-msp',
					label: 'Site internet',
					keywords: 'site, web, msp, maison de santé, centre de santé, cabinet de groupe'
				}
			]
		}
	],
	'/organisations': [
		{
			title: 'Organisations professionnelles',
			list: [
				{
					href: '/annuaire-adherents',
					label: 'Annuaire des adhérents',
					keywords: 'annuaire, adhérents, syndicat, union, fédération, wordpress'
				}
			]
		}
	],
	'/teleexpertise': [
		{
			title: 'Télé-expertise',
			list: [
				{
					href: '/teleexpertise',
					label: 'SantéTocToc',
					keywords: 'TLE, télé-expertise, doctoctoc'
				}
			]
		}
	],
	'/entreprise': [
		{
			title: 'Médecine Libre',
			list: [
				{ href: '/realisations', label: 'Réalisations', keywords: 'clients, exemples, références' },
				{ href: '/a-propos', label: 'À propos', keywords: 'entreprise, parcours, équipe' },
				{ href: '/contact', label: 'Contact', keywords: 'devis, téléphone, mail' }
			]
		}
	]
};
