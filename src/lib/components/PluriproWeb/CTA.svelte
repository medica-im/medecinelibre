<script lang="ts">
	import Fa from 'svelte-fa';
	import { faCircleNodes, faPeopleGroup, faAddressBook } from '@fortawesome/free-solid-svg-icons';

	export let showTitle = true;
</script>

{#if showTitle}
	<h2 class="h2 text-center">Nos offres</h2>
{/if}
<div class="flex flex-wrap justify-center gap-4">
	<a
		class="btn btn-lg variant-ghost"
		href="/site-internet-msp"
		title="Site internet pour maison de santé pluriprofessionnelle"
	>
		<span class="w-6 text-center"><Fa icon={faPeopleGroup} /></span>
		<span>Site pour MSP</span>
	</a>
	<a
		class="btn btn-lg variant-ghost"
		href="/site-internet-cpts"
		title="Site internet pour communauté professionnelle territoriale de santé"
	>
		<span class="w-6 text-center"><Fa icon={faCircleNodes} /></span>
		<span>Site pour CPTS</span>
	</a>
	<a class="btn btn-lg variant-ghost" href="/annuaire-cpts" title="Annuaire et intranet pour CPTS">
		<span class="w-6 text-center"><Fa icon={faAddressBook} /></span>
		<span>Annuaire CPTS</span>
	</a>
</div>
