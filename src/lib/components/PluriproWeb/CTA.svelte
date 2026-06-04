<script lang="ts">
	import Fa from 'svelte-fa';
	import { faCircleNodes, faPeopleGroup } from '@fortawesome/free-solid-svg-icons';

	export let showTitle = true;
</script>

{#if showTitle}
	<a href="/pluripro/web"><h2 class="h2 text-center">Pluripro Web</h2></a>
{/if}
<div class="flex flex-wrap justify-center gap-4">
	<a
		class="btn btn-lg variant-ghost"
		href="/pluripro/msp"
		title="Site web pour maison de santé pluriprofessionnelle"
	>
		<span class="w-6 text-center"><Fa icon={faPeopleGroup} /></span>
		<span>Site pour MSP</span>
	</a>
	<a
		class="btn btn-lg variant-ghost"
		href="/pluripro/cpts"
		title="Site web pour communauté professionnelle territoriale de santé"
	>
		<span class="w-6 text-center"><Fa icon={faCircleNodes} /></span>
		<span>Site & annuaire pour CPTS</span>
	</a>
</div>