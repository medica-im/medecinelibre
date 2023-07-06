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
	'/pluripro': [
		{
			title: 'Pluripro web',
			list: [
				{ href: '/pluripro/web', label: 'Introduction', keywords: 'pluripro, msp, cpts' },
                { href: '/pluripro/msp', label: 'MSP', keywords: 'theme, customize, fonts, gradient, background' },
                { href: '/pluripro/cpts', label: 'CPTS', keywords: 'create, custom, style, css, design' }
			]
		}
	],
	'/tele-expertise': [
		{
			title: 'Télé-expertise',
			list: [
				{ href: '/tele-expertise/doctoctoc', label: 'DocTocToc', keywords: 'TLE, télé-expertise' }
			]
		}
	]
};
