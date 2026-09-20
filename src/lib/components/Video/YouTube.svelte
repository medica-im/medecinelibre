<script lang="ts">
	import Fa from 'svelte-fa';
	import { faCirclePlay } from '@fortawesome/free-solid-svg-icons';

	/**
	 * A click-to-load YouTube embed.
	 *
	 * The iframe is only inserted once the visitor asks for it. Embedding it
	 * on load would pull ~1MB of YouTube player JS into every visit to the
	 * page and let Google set cookies before anyone chose to watch — a
	 * consent problem under GDPR for a site whose audience is French health
	 * organisations. Until then this is a thumbnail and a button.
	 *
	 * youtube-nocookie.com is used for the same reason. autoplay=1 is set
	 * because the click already expressed the intent to watch.
	 */
	interface Props {
		/** The video id, e.g. "WWhcxm2aEdk". */
		id: string;
		/** Accessible title, also shown as the caption. */
		title: string;
		/** Description for VideoObject structured data. Omit to emit none. */
		description?: string;
		/** ISO 8601 upload date (e.g. "2026-09-20") for structured data. */
		uploadDate?: string;
	}
	let { id, title, description = '', uploadDate = '' }: Props = $props();

	let playing = $state(false);

	// VideoObject tells Google there is a video here even though the player is
	// not in the initial HTML — without it, a click-to-load facade is invisible
	// to video search. Only emitted when a description is supplied.
	const schema = $derived(
		description
			? JSON.stringify({
					'@context': 'https://schema.org',
					'@type': 'VideoObject',
					name: title,
					description,
					thumbnailUrl: `https://i.ytimg.com/vi/${id}/hqdefault.jpg`,
					embedUrl: `https://www.youtube-nocookie.com/embed/${id}`,
					...(uploadDate ? { uploadDate } : {})
				})
			: ''
	);
	// hqdefault always exists; maxresdefault 404s on some videos.
	const thumb = `https://i.ytimg.com/vi/${id}/hqdefault.jpg`;
</script>

<svelte:head>
	{#if schema}
		{@html `<script type="application/ld+json">${schema}</script>`}
	{/if}
</svelte:head>

<figure class="space-y-2">
	<div class="relative aspect-video overflow-hidden rounded-container-token bg-surface-900">
		{#if playing}
			<iframe
				class="absolute inset-0 h-full w-full"
				src="https://www.youtube-nocookie.com/embed/{id}?autoplay=1&rel=0"
				{title}
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
				allowfullscreen
				referrerpolicy="strict-origin-when-cross-origin"
			></iframe>
		{:else}
			<button
				type="button"
				class="group absolute inset-0 h-full w-full cursor-pointer"
				onclick={() => (playing = true)}
			>
				<img
					class="h-full w-full object-cover"
					src={thumb}
					width="480"
					height="360"
					alt=""
					loading="lazy"
				/>
				<span
					class="absolute inset-0 flex items-center justify-center bg-surface-900/30 transition-colors group-hover:bg-surface-900/10"
				>
					<span class="text-white text-6xl drop-shadow-lg"><Fa icon={faCirclePlay} /></span>
				</span>
				<span class="sr-only">Lire la vidéo: {title}</span>
			</button>
		{/if}
	</div>
	<figcaption class="text-center text-sm opacity-75">{title}</figcaption>
</figure>
