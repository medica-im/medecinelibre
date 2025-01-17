<script lang="ts">
	import { onMount } from 'svelte';
	import { scaleLinear, scaleOrdinal } from 'd3-scale';
	import { zoom, zoomIdentity } from 'd3-zoom';
	import { schemeCategory10 } from 'd3-scale-chromatic';
	import { select, selectAll, pointer } from 'd3-selection';
	import { drag } from 'd3-drag';
	import { forceSimulation, forceLink, forceManyBody, forceCenter, forceCollide } from 'd3-force';
	import { modeCurrent } from '@skeletonlabs/skeleton';

	let tooltip = false;
	let tooltipEvent;
	let nodes;
	let selectedNode;
	//import { event as currentEvent } from "d3-selection"; // Needed to get drag working, see: https://github.com/d3/d3/issues/2733
	let d3 = {
		zoom,
		zoomIdentity,
		scaleLinear,
		scaleOrdinal,
		schemeCategory10,
		select,
		selectAll,
		pointer,
		drag,
		forceSimulation,
		forceLink,
		forceManyBody,
		forceCenter,
		forceCollide
	};

	let graph={
    "nodes": [
        { "id": "website", "label": "Site", "title": "Site web", "icon": 0xf0ac, "size": 200, "group": 1, "tooltip": "test" },
        { "id": "members", "label": "Membres", "title": "Membres de l'équipe soignante", "icon": 0xf7f2, "size": 100, "group": 2, "tooltip": "test" },
        { "id": "regional_health_agency", "label": "ARS", "icon": 0xf508, "size": 100, "group": 2, "tooltip": "test" },
        { "id": "health_insurance_fund", "label": "CPAM", "icon": 0xf153, "size": 100, "group": 2, "tooltip": "test" },
        { "id": "people", "label": "Usagers", "icon": 0xf0c0, "size": 100, "group": 2, "tooltip": "test" },
        { "id": "health_professional", "label": "PDS", "title": "Professionnels de santé", "icon": 0xf0f0, "size": 100, "group": 2, "tooltip": "test" }
    ],
    "links": [
        { "source": "website", "target": "members", "value": 1 },
        { "source": "website", "target": "regional_health_agency", "value": 1 },
        { "source": "website", "target": "health_insurance_fund", "value": 1 },
        { "source": "website", "target": "people", "value": 1 },
        { "source": "website", "target": "health_professional", "value": 1 }
    ]
};

	let canvas;
	let width = 356;
	let height = 356;
	let max = 100;
	const nodeRadius = 100;
	let activeNode = false;
	const padding = { top: 20, right: 40, bottom: 40, left: 25 };

	$: xScale = scaleLinear()
		.domain([0, 20])
		.range([padding.left, width - padding.right]);

	$: yScale = scaleLinear()
		.domain([0, 12])
		.range([height - padding.bottom, padding.top]);

	$: xTicks = width > 180 ? [0, 4, 8, 12, 16, 20] : [0, 10, 20];

	$: yTicks = height > 180 ? [0, 2, 4, 6, 8, 10, 12] : [0, 4, 8, 12];

	$: d3yScale = scaleLinear().domain([0, height]).range([height, 0]);

	$: links = graph.links.map((d) => Object.create(d));
	//$: nodes = graph.nodes.map((d) => Object.create(d));
	$: nodes = graph.nodes.map((d) => {
		//d.text=d.id;
		//append("text").attr("x", 8).attr("y", 0).attr("stroke", "blue").attr("font-weight", 100).attr("font-size", '9px');
		d.size = 10;
		/*d.size = Math.pow(graph.links
        .filter((link) => link.source == d.id || link.target == d.id)
        .map((link) => link.value)
        .reduce((a, b) => a + b), 2);*/
		/*if (d.id == "You") {
        max = d.size;
        d.details.messages = max;
      }*/
		return Object.create(d);
	});
	$: if (context) {
		simulationUpdate($modeCurrent, activeNode);
	}

	function groupColour(context, d) {
		let nodesize = 2 + Math.sqrt(d.size) / 5;
		let radgrad = context.createRadialGradient(d.x, d.y, nodesize / 3, d.x, d.y, nodesize);
		radgrad.addColorStop(0, '#01abfc');
		radgrad.addColorStop(0.1, '#01abfc');
		radgrad.addColorStop(1, '#01abfc00');

		let radgrad2 = context.createRadialGradient(d.x, d.y, nodesize / 3, d.x, d.y, nodesize);
		radgrad2.addColorStop(0, '#7A17F6');
		radgrad2.addColorStop(0.1, '#7A17F6');
		radgrad2.addColorStop(1, '#7A17F600');

		let radgrad3 = context.createRadialGradient(d.x, d.y, nodesize / 3, d.x, d.y, nodesize);
		radgrad3.addColorStop(0, '#B635E3');
		radgrad3.addColorStop(0.1, '#B635E3');
		radgrad3.addColorStop(1, '#B635E300');

		let radgrad4 = context.createRadialGradient(d.x, d.y, nodesize / 3, d.x, d.y, nodesize);
		radgrad4.addColorStop(0, '#E4158B');
		radgrad4.addColorStop(0.1, '#E4158B');
		radgrad4.addColorStop(1, '#E4158B00');

		let radgrad5 = context.createRadialGradient(d.x, d.y, nodesize / 3, d.x, d.y, nodesize);
		radgrad4.addColorStop(0, '#F9123B');
		radgrad4.addColorStop(0.1, '#F9123B');
		radgrad4.addColorStop(1, '#F9123B00');
		let radgrads = [radgrad, radgrad2, radgrad3, radgrad4, radgrad5];
		return radgrads[d.group % 5];
	}
	let showCard;
	let transform = d3.zoomIdentity;
	let simulation, context;
	let dpi = 1;

	onMount(() => {
		dpi = window.devicePixelRatio || 1;
		context = canvas.getContext('2d');
		resize();

		simulation = d3
			.forceSimulation(nodes)
			.force(
				'link',
				d3
					.forceLink(links)
					.id((d) => d.id)
					.distance((d) => 2 + Math.sqrt(max) / 4 + 130 * Math.pow(2, -d.value / 1000))
			)
			.force('charge', d3.forceManyBody().strength(-500))
			.force('center', d3.forceCenter(width / 2, height / 2))
			.force(
				'collision',
				d3.forceCollide().radius((d) => Math.sqrt(d.size) / 4)
			)
			.on('tick', simulationUpdate);

		// title
		d3.select(context.canvas).on('mousemove', (event) => {
			const d = simulation.find(
				transform.invertX(event.offsetX * dpi),
				transform.invertY(event.offsetY * dpi),
				60
			);

			if (d && d.id != 'website') activeNode = d;
			else activeNode = false;
		});

		d3.select(context.canvas).on('mousemove', (event) => {
			const d = simulation.find(
				transform.invertX(event.offsetX * dpi),
				transform.invertY(event.offsetY * dpi),
				60
			);
			if (d && d.id != 'website') {
				d3.select(context.canvas).style('cursor', 'pointer');
			} else {
				d3.select(context.canvas).style('cursor', 'default');
			}
		});

		d3.select(context.canvas).on('click', (event) => {
			const d = simulation.find(
				transform.invertX(event.offsetX * dpi),
				transform.invertY(event.offsetY * dpi),
				60
			);
			if (d && d.id != 'website') {
				activeNode = d;
				simulationUpdate();
			} else {
			}
		});

		d3.select(canvas)
			.call(
				d3
					.drag()
					.container(canvas)
					.subject(dragsubject)
					.on('start', dragstarted)
					.on('drag', dragged)
					.on('end', dragended)
			)
			.call(
				d3
					.zoom()
					.scaleExtent([1 / 10, 8])
					.on('zoom', zoomed)
			);
	});

	function simulationUpdate() {
		context.save();
		context.clearRect(0, 0, context.canvas.width, context.canvas.height);
		context.translate(transform.x, transform.y);
		context.scale(transform.k, transform.k);

		links.forEach((d) => {
			context.beginPath();
			context.moveTo(d.source.x, d.source.y);
			context.lineTo(d.target.x, d.target.y);
			context.globalAlpha = 0.3;
			context.strokeStyle = $modeCurrent ? 'grey' : 'white';
			context.lineWidth = 10;
			context.stroke();
			context.globalAlpha = 1;
		});

		nodes.forEach((d, i) => {
			context.beginPath();
			context.arc(d.x, d.y, 2 + Math.sqrt(d.size), 0, 2 * Math.PI);
			context.strokeStyle = 'transparent';
			context.lineWidth = 1;
			context.stroke();
			context.fill();
			if (activeNode && d == activeNode && d.id != 'website') {
				context.fillStyle = $modeCurrent ? 'DarkBlue' : 'LightBlue';
			} else {
				context.fillStyle = $modeCurrent ? 'black' : 'white';
			}
			//context.fillStyle = "transparent"
			//context.fillText("\uf508", d.x + 5, d.y + 5);
			context.font = '20px FontAwesome11';
			context.fillText(String.fromCharCode(d.icon) + ' ' + d.label, d.x - 20, d.y - 20);
		});
		context.restore();
	}

	function zoomed(currentEvent) {
		transform = currentEvent.transform;
		simulationUpdate();
	}

	// Use the d3-force simulation to locate the node
	function dragsubject(currentEvent) {
		const node = simulation.find(
			transform.invertX(currentEvent.x * dpi),
			transform.invertY(currentEvent.y * dpi),
			50
		);
		if (node) {
			node.x = transform.applyX(node.x);
			node.y = transform.applyY(node.y);
		}
		return node;
	}

	function dragstarted(currentEvent) {
		if (!currentEvent.active) simulation.alphaTarget(0.3).restart();
		currentEvent.subject.fx = transform.invertX(currentEvent.subject.x);
		currentEvent.subject.fy = transform.invertY(currentEvent.subject.y);
	}

	function dragged(currentEvent) {
		currentEvent.subject.fx = transform.invertX(currentEvent.x);
		currentEvent.subject.fy = transform.invertY(currentEvent.y);
	}

	function dragended(currentEvent) {
		if (!currentEvent.active) simulation.alphaTarget(0);
		currentEvent.subject.fx = null;
		currentEvent.subject.fy = null;
	}

	function resize() {
		({ width, height } = canvas);
	}
	function fitToContainer(node) {
		dpi = window.devicePixelRatio || 1;
		// Make it visually fill the positioned parent
		node.style.width = '100%';
		node.style.height = '100%';
		// ...then set the internal size to match
		node.width = node.offsetWidth * dpi;
		node.height = node.offsetHeight * dpi;
		width = node.offsetWidth * dpi;
		height = node.offsetHeight * dpi;
	}
</script>

<svelte:head>
	<link href="/fontawesome-free-5.15.4-web/css/all.min.css" rel="stylesheet" />
</svelte:head>

<svelte:window on:resize={resize} />
<div class="container text-center w-fit p-4 space-y-4 border-0">
	<h2 class="h2">Un site web, plusieurs publics</h2>
	<div class="flex flex-wrap justify-start w-fit gap-2 border-0">
		<div on:resize={resize} class="graphContainer mx-auto w-fit">
			<canvas use:fitToContainer bind:this={canvas} class="border-0" />
		</div>

		<div class="card p-2 space-y-2 w-96 shadow-xl mx-auto border-0">
			{#if activeNode.id}
				<div class=".card-header"><h1 class="h1">{activeNode.title || activeNode.label}</h1></div>
			{/if}
			<div class="text-left">
				{#if activeNode.id == 'people'}
					<p>
						Le contenu destiné aux usagers est élaboré en collaboration avec votre équipe. Il
						s'adapte aux réalités locales, sans jargon médical ou technique excessif. Il est
						systématiquement relu par un médecin. Nous mettons en valeur chaque membre de votre
						équipe dans une page dédiée au sein de l'annuaire. Vos actions de santé publique sont
						listées en première page puis détaillées dans leurs rubriques.
					</p>
				{:else if activeNode.id == 'members'}
					<p>
						Après connexion sécurisée, accès à des données protégées
						et des outils collaboratifs supplémentaires.
					</p>
					<div class="pl-5">
						<ul class="list-disc">
							<li>Annuaire version pro</li>
							<li>Agenda pro</li>
							<li>Nextcloud Office: suite bureautique en ligne avec édition collaborative</li>
							<li>Nextcloud Files: stockage et partage de fichiers & images</li>
							<li>Nextcloud Talk: partage d’écran, réunions en ligne
								et conférences web sans fuite de données.</li>
						</ul>
					</div>
				{:else if activeNode.id == 'regional_health_agency'}
					<p>
						Si votre MSP a signé l’Accord Conventionnel Interprofessionnel (ACI), un site web
						professionnel permet de rendre compte auprès de l'ARS de l'attente des objectifs de la
						convention.
					</p>
				{:else if activeNode.id == 'health_insurance_fund'}
					<p>
						Si votre MSP a signé l’Accord Conventionnel Interprofessionnel (ACI), un site web
						professionnel permet de rendre compte auprès de la CPAM de l'attente des objectifs de la
						convention.
					</p>
					<p>
						Les pages consacrées aux actions de prévention en santé, d'éducation thérapeutique du
						patient (ETP) et d'éducation en santé illustreront la hauteur et la qualité de votre
						engagement pour la santé publique.
					</p>
				{:else if activeNode.id == 'health_professional'}
					Les professionnels de santé à la recherche d'un lieu d'installation trouveront votre site
					web en première page sur les moteurs de recherche. Leur première impression sur votre
					établissement dépend de la qualité du design et du contenu du site. Elle se doit d'être
					excellente. Un site web impeccable est un gage de sérieux et un atout qui leur donnera
					envie de vous contacter.
				{:else}
					Veuillez sélectionner une catégorie de public en cliquant sur l'îcone correspondante.
				{/if}
			</div>
		</div>
	</div>
</div>

<style lang="postcss">
	/*:global(body){background-color: #000}*/
	canvas {
		position: absolute;
		max-width: 100%;
		height: auto;
	}
	.graphContainer {
		width: 360px;
		height: 360px;
		position: relative;
		border: 0px solid grey;
	}
	.text-base-token {
		color: rgba(var(--theme-font-color-base));
	}
	.text-dark-token {
		color: rgba(var(--theme-font-color-dark));
	}
	.text-token {
		@apply text-primary-500 dark:text-dark-token;
	}
	/*#nodeDetails {
      position: absolute;
      top: 1%;
      left: 1%;
      width: unset;
      //color: rgba(var(--color-secondary-900) / 1);
      color: green
    }
    @media (prefers-color-scheme: dark) {
    #nodeDetails {
      position: absolute;
      top: 1%;
      left: 1%;
      width: unset;
      //color: rgba(var(--color-secondary-50) / 1);
      color: blue
    }*/
	.nodeDetails {
		position: absolute;
		top: 1%;
		left: 1%;
		width: unset;
		@apply text-primary-500;
	}
	@font-face {
		font-family: 'FontAwesome11';
		src: url('/fonts/fa-solid-900.eot');
		src: local(''), url('/fonts/fa-solid-900.eot?#iefix'),
			url('/fonts/fa-solid-900.woff') format('woff'),
			url('/fonts/fa-solid-900.woff2') format('woff2'),
			url('/fonts/fa-solid-900.ttf') format('truetype'),
			url('/fonts/fa-solid-900.svg') format('svg');
		font-weight: normal;
		font-style: normal;
	}
	.mytooltip {
		fill: white;
		font-family: sans-serif;
		padding: 5px;
		border-radius: 5px;
		border: 1px solid grey;
		z-index: 2;
	}
</style>
