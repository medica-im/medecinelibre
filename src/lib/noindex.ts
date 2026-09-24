/**
 * Whether this build should ask search engines to stay away.
 *
 * Read via import.meta.env, matching VITE_NOINDEX in clinic-cms/skcms — one
 * mechanism across both projects.
 *
 * Compiled in at build time, so which .env the image was built against
 * decides it. See the ENV_FILE note in the Dockerfile: a production image
 * built against a dev .env would carry Disallow: / into production.
 *
 * Any value other than the exact string "false" (and the unset case, which
 * is production) counts as "stay out", so a typo fails safe toward hidden
 * rather than indexed.
 */
const raw = import.meta.env.VITE_NOINDEX;

export const NOINDEX: boolean = raw !== undefined && raw !== '' && raw !== 'false';
