import type { LayoutServerLoad } from './$types';
//import { VERCEL_ENV } from '$env/static/private';
const VERCEL_ENV = ""
import skeleton from '$lib/themes/theme-skeleton.css?inline';
//import crimson from '@skeletonlabs/skeleton/dist/themes/theme-crimson.css?inline';

export const load: LayoutServerLoad = async ({ cookies }) => {
	let theme = cookies.get('theme');
	// If no theme, set theme to skeleton
	if (!theme) {
		cookies.set('theme', 'skeleton', { path: '/' });
		theme = 'gold-nouveau';
	}
	// Imports theme as a string
	const modules = import.meta.glob(`/src/../node_modules/@skeletonlabs/skeleton/dist/themes/*.css`, { as: 'raw', eager: true});
	//const files = import.meta.glob('/src/lib/themes/*.css', { as: 'raw', eager: true});

	/*const styles = import.meta.glob(
        '$lib/themes/*.css',
        { query: 'inline', eager: true },
    );*/
	//return { currentTheme: files[`/src/lib/themes/theme-${theme}.css`], vercelEnv: VERCEL_ENV };
	return { currentTheme: modules[`/node_modules/@skeletonlabs/skeleton/dist/themes/theme-${theme}.css`], vercelEnv: VERCEL_ENV };
};
