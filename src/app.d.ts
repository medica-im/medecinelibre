// See https://kit.svelte.dev/docs/types#app
// for information about these interfaces
// and what to do when importing types
declare namespace App {
	interface Locals {
		/** The request comes from LinkedIn's link-preview crawler. */
		linkedinBot: boolean;
	}
	interface PageData {
		linkedinBot?: boolean;
	}
	// interface Error {}
	// interface Platform {}
}
