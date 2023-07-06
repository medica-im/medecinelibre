<script lang="ts">
	import { page } from '$app/stores';

const mastodonUrlRoot = "https://mastodon.medica.im/@";
const twitterUrlRoot = "https://twitter.com/"

	const twitterArr = [
		{
			position: 1,
			account: 'doctoctocbot',
			hashtag: '#doctoctoc',
			followers: 3968
		},
		{
			position: 2,
			account: 'PharmaTocTocBot',
			hashtag: '#pharmatoctoc',
			followers: 2132
		},
		{
			position: 3,
			account: 'idetoctoc',
			hashtag: '#idetoctoc',
			followers: 1163
		},
		{
			position: 4,
			account: 'kinetoctoc',
			hashtag: '#kinetoctoc',
			followers: 881
		},
		{
			position: 5,
			account: 'sagefemmebot',
			hashtag: '#sftoctoc',
			followers: 468
		},
		{
			position: 6,
			account: 'ecnitoctoc',
			hashtag: '#ecnitoctoc',
			followers: 789
		}
	];

	const mastodonArr = [
		{
			position: 1,
			account: 'doctoctocbot',
			hashtag: '#doctoctoc',
			followers: 178
		},
		{
			position: 2,
			account: 'PharmaTocTocBot',
			hashtag: '#pharmatoctoc',
			followers: 54
		},
		{
			position: 3,
			account: 'infirmierebot',
			hashtag: '#infirmieretoctoc, #idetoctoc',
			followers: 57
		},
		{
			position: 4,
			account: 'kinetoctoc',
			hashtag: '#kinetoctoc',
			followers: 30
		},
		{
			position: 5,
			account: 'sagefemmebot',
			hashtag: '#sftoctoc',
			followers: 27
		}
	];

	function totalFollowers(arr: Array<any>) {
		let totalFollowers: number = 0;
		for (let row of arr) {
			totalFollowers += row.followers;
		}
		return totalFollowers;
	}
</script>

<div class="container mx-auto space-y-8 p-4">
	<div class="text-center">
		<h1 class="h1">Télé-expertise avec #doctoctoc</h1>
	</div>
    <div>
		<p>La communauté d'entraide #doctoctoc s'est formée spontanément en 2012 parmi des médecins et d'autres professionnels de santé présents sur Twitter. Le hashtag lui-même a été inventé en juin 2012 par le médecin <a href="https://twitter.com/DrKoibo" rel="external">@DrKoibo</a>.</p>
		<p>En 2017 nous avons eu l'idée de créer un compte Twitter automatisé ("bot") pour diffuser les questions des professionnels de santé. @doctoctocbot ne retweete que les questions de professionnels de santé vérifiés, évitant ainsi beaucoup de spam à ses abonnés. Son succès a rapidement attiré de nombreux followers. Ainsi, un médecin qui a peu d'abonnés bénéficie de l'effet porte-voix du bot qui diffuse sa question à ses milliers d'abonnés. Chaque compte, très petit ou très gros, a donc les mêmes chances d'obtenir des réponses nombreuses et pertinentes à ses questions!</p>
		<p>@doctoctocbot a ensuite été rejoint par les bots d'autres communautés: pharmaciens, infirmières, kinésithérapeutes, sages-femmes et étudiants en médecine. Chaque membre vérifié d'une communauté a accès à toutes les autres, faisant du réseau SantéTocToc la plus vaste communauté francophone d'entraide interprofessionnelle en santé avec près de 10000 membres!</p>
	</div>
	<div class="columns-1 xl:columns-2 space-y-8 gap-8">
		<div class="table-container space-y-6">
			<h2 class="h2">Twitter</h2>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Compte</th>
						<th>Hashtag</th>
						<th>Abonnés</th>
					</tr>
				</thead>
				<tbody>
					{#each twitterArr as row, i}
						<tr>
							<td><a href="{twitterUrlRoot}{row.account}" rel="external">@{row.account}</a></td>
							<td>{row.hashtag}</td>
							<td>{row.followers}</td>
						</tr>
					{/each}
				</tbody>
				<tfoot>
					<tr>
						<th colspan="2">Total abonnés</th>
						<td>{totalFollowers(twitterArr)}</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="table-container space-y-6">
			<h2 class="h2">Mastodon</h2>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Compte</th>
						<th>Hashtag</th>
						<th>Abonnés</th>
					</tr>
				</thead>
				<tbody>
					{#each mastodonArr as row, i}
						<tr>
							<td><a href="{mastodonUrlRoot}{row.account}" rel="external">@{row.account}</a></td>
							<td>{row.hashtag}</td>
							<td>{row.followers}</td>
						</tr>
					{/each}
				</tbody>
				<tfoot>
					<tr>
						<th colspan="2">Total abonnés</th>
						<td>{totalFollowers(mastodonArr)}</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>
