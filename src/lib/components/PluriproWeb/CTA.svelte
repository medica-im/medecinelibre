<script lang="ts">
	import Fa from 'svelte-fa';
	import { faCircleNodes, faPeopleGroup } from '@fortawesome/free-solid-svg-icons';
</script>

<a href="/pluripro/web"><h2 class="h2">Pluripro Web</h2></a>
<div class="grid-cols-1 lg:!grid-cols-2 gap-2 space-y-2">
	<a
		class="btn btn-lg variant-ghost w-48"
		href="/pluripro/msp"
		title="Site web pour maison de santé pluriprofessionnelle"
	>
		<span class="w-6 text-center"><Fa icon={faPeopleGroup} /></span>
		<span>Site pour MSP</span>
	</a>
	<a
		class="btn btn-lg variant-ghost w-48"
		href="/pluripro/cpts"
		title="Site web pour communauté professionnelle territoriale de santé"
	>
		<span class="w-6 text-center"><Fa icon={faCircleNodes} /></span>
		<span>Site pour CPTS</span>
	</a>
</div>