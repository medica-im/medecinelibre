<script lang="ts">
	import Fa from 'svelte-fa';
	import { faArrowUpRightFromSquare } from '@fortawesome/free-solid-svg-icons';

	/**
	 * An outbound link with its "leaves the site" icon.
	 *
	 * Two things keep the icon on the same line as the text:
	 *
	 * 1. Tailwind's preflight sets `svg { display: block }`, which turns every
	 *    icon into a block-level box that takes a line of its own. The icon
	 *    must be forced back to inline-block — nowrap cannot save a block.
	 * 2. Even inline, the newlines around it inside the <a> are break
	 *    opportunities. The label's last word and the icon are wrapped in a
	 *    nowrap span joined by a non-breaking space, so only that pair is
	 *    glued; the rest of the label still wraps normally.
	 */
	interface Props {
		href: string;
		/** Link text. Defaults to the bare hostname + path, which reads well for
		 *  "see it in production" links. */
		label?: string;
		class?: string;
	}
	let { href, label = '', class: klass = 'anchor' }: Props = $props();

	const text = $derived(label || href.replace(/^https?:\/\//, '').replace(/\/$/, ''));
	// Split off the last word so only it is glued to the icon.
	const head = $derived(text.slice(0, text.lastIndexOf(' ') + 1));
	const tail = $derived(head ? text.slice(head.length) : text);
</script>

<!-- The label is wrapped in one span so the <a> has a single child. Buttons
     (.btn) are inline-flex, which turns loose text into its own flex item and
     drops the space at its edge: "Voir le site de la CPTS" + "Lyon 3ème" would
     render as "CPTSLyon". Inside one inline span, whitespace behaves normally. -->
<a class={klass} {href} target="_blank" rel="noopener noreferrer"
	><span>{head}<span class="external-tail"
			>{tail}&nbsp;<Fa icon={faArrowUpRightFromSquare} class="external-icon" /></span
		></span
	></a
>

<style lang="postcss">
	.external-tail {
		white-space: nowrap;
	}
	/* Undo Tailwind preflight's `svg { display: block }` for this icon only. */
	.external-tail :global(svg.external-icon) {
		display: inline-block;
		font-size: 0.75em;
		vertical-align: baseline;
	}
</style>
