import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';
import * as path from 'path';

export default defineConfig({
	plugins: [sveltekit()],
	server: {
		proxy: {
			'/blog': 'https://medecinelibre.com'
		}
	},
	resolve: {
		alias: {
			'$': path.resolve(__dirname, 'src'),
		}
	}
});
