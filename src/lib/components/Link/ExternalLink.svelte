<script lang="ts">
	import Fa from 'svelte-fa';
	import { faArrowUpRightFromSquare } from '@fortawesome/free-solid-svg-icons';

	/**
	 * An outbound link with its "leaves the site" icon.
	 *
	 * The icon is glued to the last word rather than left as a separate inline
	 * element: written out longhand, the newlines inside the <a> become break
	 * opportunities, so the icon would wrap onto a line of its own whenever the
	 * link fell near the end of a line. The nowrap span keeps the final word and
	 * the icon together while still letting the rest of the label wrap normally.
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

<a class={klass} {href} target="_blank" rel="noopener noreferrer">{head}<span
		class="whitespace-nowrap">{tail}&nbsp;<Fa
			icon={faArrowUpRightFromSquare}
			class="text-xs align-baseline"
		/></span></a>
