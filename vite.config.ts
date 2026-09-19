import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';
import * as path from 'path';

export default defineConfig({
	plugins: [sveltekit()],
	server: {
		// Vite rejects requests whose Host header it does not recognise, so
		// the dev server behind nginx on the dev VPS needs the public name
		// listed here. Without it dev.medecinelibre.com answers "Blocked
		// request. This host is not allowed."
		allowedHosts: ['dev.medecinelibre.com', 'localhost', '127.0.0.1'],
		proxy: {
			// Ghost lives on the production host; dev and staging read the
			// live blog rather than running their own copy.
			'/blog': {
				target: 'https://medecinelibre.com',
				changeOrigin: true,
				secure: true
			}
		}
	},
	resolve: {
		alias: {
			$: path.resolve(__dirname, 'src')
		}
	}
});
