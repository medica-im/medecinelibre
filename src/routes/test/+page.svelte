<script>
	import NetworkGraph from './NetworkGraphCanvas.svelte';
	import data from './data.js';
</script>

<style>
	
</style>
<div class="container mx-auto">
<div class="p-4 object-contain">
	<NetworkGraph graph={data}/>
</div>
</div>